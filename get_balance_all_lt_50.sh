#!/usr/bin/bash
modem_index=$1
database=$2

echo "mobile_number,balance,valid_until,asset_code,account_name,device_model"
for line in $(sqlite3 $database "SELECT devices.mobile_number, devices.asset_code, devices.account_name, device_model.name AS device_model from devices, device_model WHERE devices.device_model_id=device_model.id"); do
    mobile_number=$(echo $line | cut -d"|" -f 1)
    asset_code=$(echo $line | cut -d"|" -f 2)
    account_name=$(echo $line | cut -d"|" -f 3)
    device_model=$(echo $line | cut -d"|" -f 4)
    result=$(./get_balance_lt_50.sh $modem_index $mobile_number)
    echo "$result,$asset_code,$account_name,$device_model"
done 
