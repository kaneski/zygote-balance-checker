PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE device_model(
id INTEGER PRIMARY KEY,
name TEXT);
INSERT INTO device_model VALUES(1,'AVL5');
INSERT INTO device_model VALUES(2,'Totemtek');
CREATE TABLE devices(
id INTEGER PRIMARY KEY,
mobile_number TEXT UNIQUE,
asset_code TEXT,
account_name TEXT,
device_model_id INTEGER,
FOREIGN KEY(device_model_id) REFERENCES device_model(id));
COMMIT;
