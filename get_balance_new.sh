#!/usr/bin/bash
modem_index=$(mmcli -L | cut -d'/' -f6 | cut -d' ' -f1)
mobile_number=$1
ussd_number="*143#"
balance_threshold=1000

mmcli -m "$modem_index" -e 1>/dev/null 2>&1
mmcli -m "$modem_index" --3gpp-ussd-cancel 1>/dev/null 2>&1
mmcli -m "$modem_index" --3gpp-ussd-initiate="$ussd_number" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="0" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="5" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="1" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="1" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="$mobile_number" 1>/dev/null
final_response=$(mmcli -m "$modem_index" --3gpp-ussd-respond="1")
float_balance=$(echo $final_response | cut -d" " -f 20)
valid_until=$(echo $final_response | cut -d" " -f 23)
mmcli -m "$modem_index" --3gpp-ussd-cancel 1>/dev/null 2>&1

balance=${float_balance:1}
balance=$(echo $balance | cut -d"." -f 1)
re='^[0-9]+([.][0-9]+)?$'

# if $balance is not a number
if ! [[ $balance =~ $re ]] ; then
    echo "$mobile_number,error,error"
    exit 1
fi

if [ "$balance" -lt "$balance_threshold" ]; then
    echo "$mobile_number,${float_balance:1},${valid_until}"
    exit 0
fi

