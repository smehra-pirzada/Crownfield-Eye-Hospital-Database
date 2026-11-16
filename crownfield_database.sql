CREATE DATABASE  IF NOT EXISTS `smehra_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `smehra_database`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: smehra_database
-- ------------------------------------------------------
-- Server version	26.10.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '19714316-cc79-11f1-b3f8-acf23cd1a200:1-54';

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(10) NOT NULL,
  `clinician_id` int NOT NULL,
  `clinic_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `clinician_id` (`clinician_id`),
  KEY `clinic_id` (`clinic_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`clinician_id`) REFERENCES `clinician` (`clinician_id`),
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`clinic_id`) REFERENCES `clinic` (`clinic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'OP001',1,1,'2026-11-09','09:00:00','Routine eye examination'),(2,'OP002',2,2,'2026-11-09','10:00:00','Glaucoma assessment'),(3,'OP003',3,3,'2026-11-10','11:00:00','Retinal examination'),(4,'OP004',4,4,'2026-11-10','12:00:00','Vision check'),(5,'OP005',5,5,'2026-11-11','09:30:00','Follow-up consultation'),(6,'OP006',6,6,'2026-11-11','10:30:00','Cataract assessment'),(7,'OP007',7,7,'2026-11-12','11:30:00','Dry eye consultation'),(8,'OP008',8,8,'2026-11-12','13:00:00','Eye pressure check'),(9,'OP009',9,9,'2026-11-13','14:00:00','Retinal screening'),(10,'OP010',10,10,'2026-11-13','15:00:00','General eye examination');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `CheckAppointmentDate` BEFORE INSERT ON `appointment` FOR EACH ROW BEGIN
IF NEW.appointment_date < CURDATE() THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Appointment date cannot be in the past';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `appointment_diagnosis`
--

DROP TABLE IF EXISTS `appointment_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_diagnosis` (
  `appointment_id` int NOT NULL,
  `diagnosis_id` int NOT NULL,
  PRIMARY KEY (`appointment_id`,`diagnosis_id`),
  KEY `diagnosis_id` (`diagnosis_id`),
  CONSTRAINT `appointment_diagnosis_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `appointment_diagnosis_ibfk_2` FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnosis` (`diagnosis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_diagnosis`
--

LOCK TABLES `appointment_diagnosis` WRITE;
/*!40000 ALTER TABLE `appointment_diagnosis` DISABLE KEYS */;
INSERT INTO `appointment_diagnosis` VALUES (1,1),(6,1),(2,2),(8,2),(3,3),(9,3),(4,4),(10,4),(5,5),(7,5);
/*!40000 ALTER TABLE `appointment_diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic`
--

DROP TABLE IF EXISTS `clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic` (
  `clinic_id` int NOT NULL AUTO_INCREMENT,
  `clinic_name` varchar(100) NOT NULL,
  PRIMARY KEY (`clinic_id`),
  UNIQUE KEY `clinic_name` (`clinic_name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic`
--

LOCK TABLES `clinic` WRITE;
/*!40000 ALTER TABLE `clinic` DISABLE KEYS */;
INSERT INTO `clinic` VALUES (2,'Bedford'),(5,'Birmingham Eye Clinic'),(10,'Bristol Eye Clinic'),(12,'Cambridge Eye Clinic'),(1,'City Road'),(3,'Croydon'),(6,'Leeds Eye Clinic'),(7,'Liverpool Eye Clinic'),(4,'Manchester Eye Clinic'),(13,'Newcastle Eye Clinic'),(9,'Nottingham Eye Clinic'),(11,'Oxford Eye Clinic'),(8,'Sheffield Eye Clinic');
/*!40000 ALTER TABLE `clinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinician`
--

DROP TABLE IF EXISTS `clinician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinician` (
  `clinician_id` int NOT NULL AUTO_INCREMENT,
  `clinician_name` varchar(100) NOT NULL,
  `specialty_id` int NOT NULL,
  PRIMARY KEY (`clinician_id`),
  KEY `specialty_id` (`specialty_id`),
  CONSTRAINT `clinician_ibfk_1` FOREIGN KEY (`specialty_id`) REFERENCES `specialty` (`specialty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinician`
--

LOCK TABLES `clinician` WRITE;
/*!40000 ALTER TABLE `clinician` DISABLE KEYS */;
INSERT INTO `clinician` VALUES (1,'Dr Maya Shah',1),(2,'Dr Leo Grant',2),(3,'Dr Priya Nair',3),(4,'Dr Aisha Khan',1),(5,'Dr Daniel Smith',2),(6,'Dr Sarah Patel',3),(7,'Dr Adam Hussain',1),(8,'Dr Emily Wilson',2),(9,'Dr Omar Ali',3),(10,'Dr Sophia Brown',1);
/*!40000 ALTER TABLE `clinician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosis` (
  `diagnosis_id` int NOT NULL AUTO_INCREMENT,
  `diagnosis_name` varchar(150) NOT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `diagnosis_name` (`diagnosis_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosis`
--

LOCK TABLES `diagnosis` WRITE;
/*!40000 ALTER TABLE `diagnosis` DISABLE KEYS */;
INSERT INTO `diagnosis` VALUES (9,'Blepharitis'),(1,'Cataract'),(6,'Conjunctivitis'),(3,'Diabetic Retinopathy'),(5,'Dry Eye Syndrome'),(2,'Glaucoma'),(8,'Keratitis'),(4,'Macular Degeneration'),(7,'Retinal Detachment'),(10,'Uveitis');
/*!40000 ALTER TABLE `diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow_up_plan`
--

DROP TABLE IF EXISTS `follow_up_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow_up_plan` (
  `follow_up_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  `due_date` date NOT NULL,
  `priority` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Planned',
  PRIMARY KEY (`follow_up_id`),
  UNIQUE KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `follow_up_plan_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `chk_follow_up_status` CHECK ((`status` in (_utf8mb4'Planned',_utf8mb4'Completed',_utf8mb4'Cancelled',_utf8mb4'Overdue')))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_up_plan`
--

LOCK TABLES `follow_up_plan` WRITE;
/*!40000 ALTER TABLE `follow_up_plan` DISABLE KEYS */;
INSERT INTO `follow_up_plan` VALUES (1,1,'2026-11-16','High','Planned'),(2,2,'2026-11-23','High','Planned'),(3,3,'2026-11-24','Medium','Planned'),(4,4,'2026-11-25','Low','Planned'),(5,5,'2026-11-26','Medium','Planned'),(6,6,'2026-11-27','High','Planned'),(7,7,'2026-11-30','Medium','Planned'),(8,8,'2026-12-01','Low','Planned'),(9,9,'2026-12-02','High','Planned'),(10,10,'2026-12-03','Medium','Planned');
/*!40000 ALTER TABLE `follow_up_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine` (
  `medicine_id` int NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(150) NOT NULL,
  PRIMARY KEY (`medicine_id`),
  UNIQUE KEY `medicine_name` (`medicine_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` VALUES (10,'Artificial Tears'),(6,'Bimatoprost'),(3,'Brimonidine'),(7,'Cyclopentolate'),(4,'Dorzolamide'),(1,'Latanoprost'),(9,'Prednisolone Eye Drops'),(2,'Timolol'),(5,'Travoprost'),(8,'Tropicamide');
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` varchar(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `postcode` varchar(15) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES ('OP001','Amina','Yusuf','NE1 4AB'),('OP002','Daniel','Reed','N16 7QP'),('OP003','Sofia','Bennett','E8 2LD'),('OP004','Michael','Okoro','SE6 3RT'),('OP005','Jaria','Ahmed','BB1 2AB'),('OP006','Zeshan','Malik','BB2 3CD'),('OP007','Sohail','Khan','BB3 4EF'),('OP008','Natasha','Williams','BB4 5GH'),('OP009','Nimra','Hussain','BB5 6JK'),('OP010','Asad','Ali','BB6 1AB'),('OP011','Saleha','Khan','BB7 2CD'),('OP012','Hassan','Malik','BB8 3EF'),('OP013','Alia','Hussain','BB9 4GH'),('OP014','Mohsin','Ahmed','BB10 5JK');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_security_demo`
--

DROP TABLE IF EXISTS `patient_security_demo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_security_demo` (
  `patient_id` varchar(10) NOT NULL,
  `password_hash` char(64) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_security_demo`
--

LOCK TABLES `patient_security_demo` WRITE;
/*!40000 ALTER TABLE `patient_security_demo` DISABLE KEYS */;
INSERT INTO `patient_security_demo` VALUES ('OP001','9a635303eafc8dd53b1adbfea7629ea5343f979b623aac7421c51cce3e3edc14');
/*!40000 ALTER TABLE `patient_security_demo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `prescription_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription_item`
--

DROP TABLE IF EXISTS `prescription_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription_item` (
  `prescription_item_id` int NOT NULL AUTO_INCREMENT,
  `prescription_id` int NOT NULL,
  `medicine_id` int NOT NULL,
  `dose` varchar(100) NOT NULL,
  `route` varchar(50) NOT NULL,
  `frequency` varchar(100) NOT NULL,
  `duration` varchar(100) NOT NULL,
  PRIMARY KEY (`prescription_item_id`),
  KEY `prescription_id` (`prescription_id`),
  KEY `medicine_id` (`medicine_id`),
  CONSTRAINT `prescription_item_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescription` (`prescription_id`),
  CONSTRAINT `prescription_item_ibfk_2` FOREIGN KEY (`medicine_id`) REFERENCES `medicine` (`medicine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_item`
--

LOCK TABLES `prescription_item` WRITE;
/*!40000 ALTER TABLE `prescription_item` DISABLE KEYS */;
INSERT INTO `prescription_item` VALUES (1,1,10,'1 drop','Eye','4 times daily','7 days'),(2,2,1,'1 drop','Eye','Once daily','30 days'),(3,3,9,'1 drop','Eye','4 times daily','7 days'),(4,4,10,'1 drop','Eye','3 times daily','14 days'),(5,5,10,'1 drop','Eye','As needed','14 days'),(6,6,9,'1 drop','Eye','4 times daily','7 days'),(7,7,10,'1 drop','Eye','4 times daily','14 days'),(8,8,2,'1 drop','Eye','Twice daily','30 days'),(9,9,10,'1 drop','Eye','3 times daily','7 days'),(10,10,10,'1 drop','Eye','As needed','14 days');
/*!40000 ALTER TABLE `prescription_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialty`
--

DROP TABLE IF EXISTS `specialty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialty` (
  `specialty_id` int NOT NULL AUTO_INCREMENT,
  `specialty_name` varchar(100) NOT NULL,
  PRIMARY KEY (`specialty_id`),
  UNIQUE KEY `speciality_name` (`specialty_name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialty`
--

LOCK TABLES `specialty` WRITE;
/*!40000 ALTER TABLE `specialty` DISABLE KEYS */;
INSERT INTO `specialty` VALUES (7,'Cataract Surgery'),(3,'Cornea'),(1,'Glaucoma'),(10,'Medical Retina'),(5,'Neuro-Ophthalmology'),(13,'Ocular Genetics'),(12,'Ocular Oncology'),(6,'Oculoplastics'),(4,'Paediatric Ophthalmology'),(8,'Refractive Surgery'),(2,'Retina'),(11,'Surgical Retina'),(9,'Uveitis');
/*!40000 ALTER TABLE `specialty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'smehra_database'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientDetails`(IN p_patient_id VARCHAR(10))
BEGIN 
SELECT patient_id, first_name, last_name
FROM patient
WHERE patient_id = p_patient_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-16 18:25:10
