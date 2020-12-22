#!/usr/bin/bash
modem_index=$1
mobile_number=$2
ussd_number="*143#"
balance_threshold=1000

mmcli -m "$modem_index" --3gpp-ussd-cancel 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-initiate="$ussd_number" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="0" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="5" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="1" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="1" 1>/dev/null
mmcli -m "$modem_index" --3gpp-ussd-respond="$mobile_number" 1>/dev/null
final_response=$(mmcli -m "$modem_index" --3gpp-ussd-respond="1")
float_balance=$(echo $final_response | cut -d" " -f 20)
valid_until=$(echo $final_response | cut -d" " -f 23)
mmcli -m "$modem_index" --3gpp-ussd-cancel 1>/dev/null

balance=${float_balance:1}
balance=$(echo $balance | cut -d"." -f 1)

if [ "$balance" -lt "$balance_threshold" ]; then
    echo "$mobile_number,${float_balance:1},${valid_until}"
fi
