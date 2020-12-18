#!/usr/bin/bash
modem_index=$1
database=$2

echo "mobile_number,balance,valid_until,asset_code"
for line in $(sqlite3 $database "SELECT mobile_number, asset_code FROM devices WHERE device_model_id=1"); do
    mobile_number=$(echo $line | cut -d"|" -f 1)
    asset_code=$(echo $line | cut -d"|" -f 2)
    result=$(./get_balance.sh $modem_index $mobile_number)
    echo "$result,$asset_code"
done 
