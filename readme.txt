# install dependencies
  $ sudo apt install modemmanager
  $ sudo apt install sqlite3
  $ sudo mmcli -m <modem index> -e

# Usage
# get balance per device
# check for modem index `mmcli -L`
  $ ./get_balance <modem_index> <mobile_number>

# get balance for all device 
  $ ./get_balance_all.sh <modem_index> <sqlite.db> 1>balance-report-$(date +"%Y-%m-%d").csv 2>/dev/null

# Batch Insert
# input file should have <mobile_number-asset-code> format
# e.g (9171234567-ABC-1234)
# device_model_id (1 for AVL, 2 for Totemtek)
  $ ./batch_insert.sh <input_file> <database_file> <account_name> <device_model_id>


# Troubleshooting
# from web:
# if you want to use mmcli without superuser rights, you need to create the following file
# (you will also need to create intermediate directories in their absence)
# /etc/polkit-1/localauthority/50-local.d/ModemManager.pkla

  ```
  [ModemManager]
  Identity=unix-user:*
  Action=org.freedesktop.ModemManager1.*
  ResultAny=yes
  ResultActive=yes
  ResultInactive=yes
  ```

