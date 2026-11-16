CREATE ROLE IF NOT EXISTS
'db_admin',
'db_doctor',
'db_receptionist';

GRANT ALL PRIVILEGES
ON smehra_database.*
TO 'db_admin';

GRANT SELECT, UPDATE
ON smehra_database.appointment
TO 'db_doctor';

GRANT SELECT 
ON smehra_database.appointment
TO 'db_patient';

GRANT SELECT, INSERT, UPDATE
ON smehra_database.appointment
TO 'db_receptionist';
CREATE ROLE IF NOT EXISTS 'db_patient';

GRANT SELECT
ON smehra_database.appointment
TO 'db_patient';

GRANT SELECT, INSERT, UPDATE
ON smehra_database.appointment
TO 'db_receptionist';

SHOW GRANTS FOR 'db_admin';
SHOW GRANTS FOR 'db_doctor';
SHOW GRANTS FOR 'db_patient';
SHOW GRANTS FOR 'db_receptionist';

GRANT SELECT
ON smehra_database.patient
TO 'db_doctor';

GRANT SELECT
ON smehra_database.diagnosis
TO 'db_doctor';

GRANT SELECT
ON smehra_database.patient
TO 'db_receptionist';

GRANT SELECT
ON smehra_database.clinic
TO 'db_receptionist';

SELECT SHA2('DemoPassword123!', 256) AS hashed_password;

CREATE TABLE IF NOT EXISTS smehra_database.patient_security_demo (
patient_id VARCHAR(10) PRIMARY KEY,
password_hash CHAR(64) NOT NULL
);

INSERT INTO smehra_database.patient_security_demo
VALUES ('OP001', SHA2('DemoPassword123!', 256));

SELECT * FROM smehra_database.patient_security_demo;