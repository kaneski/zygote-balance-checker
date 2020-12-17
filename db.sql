PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE devices(
id INTEGER PRIMARY KEY,
mobile_number TEXT UNIQUE,
asset_code TEXT,
account_name TEXT,
last_load_date TEXT);
COMMIT;
