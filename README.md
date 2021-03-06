﻿# Zygote SIM Balance Check
Easily check your device(s) SIM balance.
## Install dependencies

    $ sudo apt install modemmanager
    $ sudo apt install sqlite3
    $ sudo apt install usb-modeswitch
    $ sudo systemctl enable ModemManager.service

### Get modem index

    $ mmcli -L

### Enable modem

    $ mmcli -m <modem_index> -e

## Usage

### Get balance per device
Default `get_balance.sh` balance threshold is 1000

    $ ./get_balance.sh <mobile_number>

### Get balance of all device in sqlite database

    $ ./get_balance_all.sh <sqlite.db> 1>balance-report-$(date +"%Y-%m-%d").csv 2>/dev/null

### Filter output file
Only show lines that has a balance less than the `input_balance`

    $ ./filter.sh <input_balance> <path_to_file>

### Insert data to database
#### Input File Format
Input file should contain lines in `mobile_number-asset_code` format separated by a Linux new line character.  Use only 10 digits for mobile numbers.

Example:

      9171234567-ABC-123
      9177654321-CBA-321

#### Batch Insert
`device_model_id` could either be:

      1 - AVL5
      2 - Totemtek

See `db.sql`

    $ ./batch_insert.sh <input_file> <database_file> <account_name> <device_model_id>

### Sort Output File
    $ sort -g -t ',' -k2 output_file.csv
    $ sort -g -t ',' -k2 report/today.csv | uniq | grep '^[0-9]\{10\}'

## Troubleshooting

### Use modemmanager without root
Create/modify `/etc/polkit-1/localauthority/50-local.d/ModemManager.pkla`

      [ModemManager]
      Identity=unix-user:*
      Action=org.freedesktop.ModemManager1.*
      ResultAny=yes
      ResultActive=yes
      ResultInactive=yes

