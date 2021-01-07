#!/bin/bash

balance_threshold=$1

echo "mobile_number,balance,valid_until,asset_code,account_name,device_model_id"
while read line; do
	balance_float=$(echo "$line" | cut -d',' -f2)
	balance=$(echo "$balance_float" | cut -d'.' -f1)
	if [[ "$balance" == "balance" ]]; then
		continue	
	fi
	if [ "$balance" -lt "$balance_threshold" ]; then 
		echo $line	
	fi
done < $2

