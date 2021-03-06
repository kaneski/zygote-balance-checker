#!/usr/bin/bash

database=$2
account_name=$3
device_model_id=$4

while IFS="" read -r l || [ -n "$l" ]; do
    line=$(printf '%s\n' "$l")
    mobile_number=$(echo $line | cut -d "-" -f 1)
    asset_code=$(echo $line | cut -d "-" -f 2-3)
    sqlite3 $2 "INSERT INTO devices (mobile_number, asset_code, account_name, device_model_id) VALUES (\"$mobile_number\", \"$asset_code\", \"$account_name\", \"$device_model_id\")"
done < $1

echo "Insert done"
