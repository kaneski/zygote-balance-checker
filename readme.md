# Zygote SIM Balance Check
Easily check your device(s) SIM balance.
## Install dependencies

    $ sudo apt install modemmanager
    $ sudo apt install sqlite3

### Get modem index

    $ mmcli -L

### Enable modem

    $ mmcli -m <modem_index> -e

## Usage

### Get balance per device

    $ ./get_balance <modem_index> <mobile_number>

### Get balance of all device in sqlite database

    $ ./get_balance_all.sh <modem_index> <sqlite.db> 1>balance-report-$(date +"%Y-%m-%d").csv 2>/dev/null

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

    ./batch_insert.sh <input_file> <database_file> <account_name> <device_model_id>

## Troubleshooting

### Use modemmanager without root
Create/modify `/etc/polkit-1/localauthority/50-local.d/ModemManager.pkla`

      [ModemManager]
      Identity=unix-user:*
      Action=org.freedesktop.ModemManager1.*
      ResultAny=yes
      ResultActive=yes
      ResultInactive=yes

