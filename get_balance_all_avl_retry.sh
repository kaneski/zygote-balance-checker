#!/usr/bin/bash
database=$1
re='^[0-9]+[,]'

echo "mobile_number,balance,valid_until,asset_code,account_name,device_model"
for line in $(sqlite3 $database "SELECT devices.mobile_number, devices.asset_code, devices.account_name, device_model.name AS device_model from devices, device_model WHERE devices.device_model_id=device_model.id AND devices.device_model_id=1"); do
    while :
    do

        mobile_number=$(echo $line | cut -d"|" -f 1)
        asset_code=$(echo $line | cut -d"|" -f 2)
        account_name=$(echo $line | cut -d"|" -f 3)
        device_model=$(echo $line | cut -d"|" -f 4)
        result=$(./get_balance.sh $mobile_number)
    
        if [[ $result =~ $re ]]; then
            echo "$result,$asset_code,$account_name,$device_model"
	    break
        fi

    done
    
done 
