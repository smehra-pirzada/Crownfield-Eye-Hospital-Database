USE smehra_database;

SELECT appointment_id, COUNT(*) AS diagnosis_count
FROM appointment_diagnosis
GROUP BY appointment_id
HAVING COUNT(*) >= 1;

SELECT 
	a.appointment_id,
    p.first_name,
    p.last_name,
    c.clinician_name
FROM appointment AS a
INNER JOIN patient AS p ON a.patient_id = p.patient_id
INNER JOIN clinician AS c ON a.clinician_id = c.clinician_id;

DESCRIBE appointment;

SELECT
	p.patient_id,
    p.first_name,
    p.last_name,
    a.appointment_id
FROM patient AS p
LEFT JOIN appointment AS a
ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

SELECT patient_id, first_name, last_name
FROM patient
WHERE patient_id IN (
SELECT patient_id
FROM appointment
);


DELIMITER //
CREATE PROCEDURE GetPatientDetails(IN p_patient_id VARCHAR(10))
BEGIN 
SELECT patient_id, first_name, last_name
FROM patient
WHERE patient_id = p_patient_id;
END //
DELIMITER ;
CALL GetPatientDetails('OP001');

DESCRIBE appointment;

DELIMITER //
CREATE TRIGGER CheckAppointmentDate
BEFORE INSERT ON appointment
FOR EACH ROW
BEGIN
IF NEW.appointment_date < CURDATE() THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Appointment date cannot be in the past';
END IF;
END //
DELIMITER ;

INSERT INTO appointment
(patient_id, clinician_id, clinic_id, appointment_date, appointment_time)
VALUES ('OP001', 1, 1, '2020-01-01', '10:00:00');