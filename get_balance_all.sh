#!/usr/bin/bash
modem_index=$1
database=$2

echo "mobile_number,balance,valid_until"
for line in $(sqlite3 $database "SELECT mobile_number, asset_code FROM devices"); do
    mobile_number=$(echo $line | cut -d"|" -f 1)
    ./get_balance.sh $modem_index $mobile_number
done 
