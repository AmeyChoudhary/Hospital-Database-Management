-- MySQL dump 10.13  Distrib 8.0.29, for macos12.2 (arm64)
--
-- Host: localhost    Database: dnaProject4
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `DepartmentID` int NOT NULL,
  `FoundedOn` date NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (99010,'1990-01-20','Paediatrics'),(99020,'1995-07-25','Othopaedic'),(99030,'2000-12-01','Cardiology'),(99040,'2001-06-14','Gynaecology'),(99050,'2001-02-14','Neurology');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor`
--

DROP TABLE IF EXISTS `Doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctor` (
  `DoctorID` int NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Qualification` varchar(20) NOT NULL,
  `Practising_since` year NOT NULL,
  `Supervisor_DoctorID` int DEFAULT NULL,
  PRIMARY KEY (`DoctorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor`
--

LOCK TABLES `Doctor` WRITE;
/*!40000 ALTER TABLE `Doctor` DISABLE KEYS */;
INSERT INTO `Doctor` VALUES (10022,'Ramesh','Khanna','MD',2000,NULL),(10075,'Priyanka','Rastogi','MBBS',2010,10022),(10149,'Mayank','Sharma','MBBS',2011,10022),(20012,'Kaveri','Reddy','MBBS',2007,20889),(20614,'Parth','Dev','MBBS',2003,20889),(20889,'Lavanya','Nair','MS',1990,NULL),(30127,'Kartik','Gandhi','DM',1997,NULL),(30265,'Anushka','Kumar','MBBS',2004,30127),(30311,'Ihit','Mishra','MBBS',2008,30127),(40123,'Manya','Kapur','MD',1999,NULL),(40356,'Hrithik','Agrawal','MBBS',2005,40123),(40954,'Kriti','Ghosh','MBBS',2006,40123),(50312,'Ryan','Simon','DM',1998,NULL),(50734,'Mahika','Bansal','MBBS',2000,50312),(50812,'Rohan','Singh','MBBS',2004,50312);
/*!40000 ALTER TABLE `Doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor_Is_Under_Department`
--

DROP TABLE IF EXISTS `Doctor_Is_Under_Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctor_Is_Under_Department` (
  `DoctorID` int NOT NULL,
  `DepartmentID` int NOT NULL,
  KEY `DoctorID` (`DoctorID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `doctor_is_under_department_ibfk_1` FOREIGN KEY (`DoctorID`) REFERENCES `Doctor` (`DoctorID`) ON DELETE CASCADE,
  CONSTRAINT `doctor_is_under_department_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor_Is_Under_Department`
--

LOCK TABLES `Doctor_Is_Under_Department` WRITE;
/*!40000 ALTER TABLE `Doctor_Is_Under_Department` DISABLE KEYS */;
INSERT INTO `Doctor_Is_Under_Department` VALUES (10022,99010),(10075,99010),(10149,99010),(20889,99020),(20614,99020),(20012,99020),(30127,99030),(30265,99030),(30311,99030),(40123,99040),(40356,99040),(40954,99040),(50312,99050),(50734,99050),(50812,99050);
/*!40000 ALTER TABLE `Doctor_Is_Under_Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor_PhoneNumber`
--

DROP TABLE IF EXISTS `Doctor_PhoneNumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctor_PhoneNumber` (
  `DoctorID` int NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  PRIMARY KEY (`Phone_Number`),
  KEY `DoctorID` (`DoctorID`),
  CONSTRAINT `doctor_phonenumber_ibfk_1` FOREIGN KEY (`DoctorID`) REFERENCES `Doctor` (`DoctorID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor_PhoneNumber`
--

LOCK TABLES `Doctor_PhoneNumber` WRITE;
/*!40000 ALTER TABLE `Doctor_PhoneNumber` DISABLE KEYS */;
INSERT INTO `Doctor_PhoneNumber` VALUES (10022,'9924141538'),(10075,'9292414086'),(10149,'9832905382'),(20012,'9956332022'),(20614,'9128526294'),(20889,'9728773451'),(30127,'9025156871'),(30265,'8824100272'),(30311,'8922829118'),(40123,'9426191836'),(40356,'8922294153'),(40954,'9624932133'),(50312,'9528511787'),(50734,'8222828611'),(50812,'9945169696');
/*!40000 ALTER TABLE `Doctor_PhoneNumber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Past_Record`
--

DROP TABLE IF EXISTS `Past_Record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Past_Record` (
  `PatientID` int NOT NULL,
  `Operation_Type` varchar(50) NOT NULL,
  `Operation_Report` varchar(20) NOT NULL,
  `Doctor_Last_Name` varchar(20) NOT NULL,
  `Last_Operation_Date` date NOT NULL,
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `past_record_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Past_Record`
--

LOCK TABLES `Past_Record` WRITE;
/*!40000 ALTER TABLE `Past_Record` DISABLE KEYS */;
INSERT INTO `Past_Record` VALUES (102341,'Fracture Repair','SUCCESSFUL','Dev','2009-09-23'),(106757,'Fracture Repair','SUCCESSFUL','Nair','1995-01-29'),(107294,'Bronchial Thermoplasty','UNSUCCESSFUL','Sharma','2018-07-30'),(104826,'Carpel Tunnel Release','SUCCESSFUL','Nair','2017-02-14'),(111903,'Fracture Repair','SUCCESSFUL','Reddy','2015-06-25'),(101184,'ACL','UNSUCCESSFUL','Dev','2011-11-25'),(110019,'Lesionectomy','SUCCESSFUL','Bansal','2000-01-22'),(110346,'Craniotomy','UNSUCCESSFUL','Simon','2004-12-26'),(110378,'Fracture Repair','SUCCESSFUL','Rastogi','2003-09-24');
/*!40000 ALTER TABLE `Past_Record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Disease`
--

DROP TABLE IF EXISTS `Patient_Disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_Disease` (
  `PatientID` int NOT NULL,
  `Disease` varchar(50) NOT NULL,
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `patient_disease_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Disease`
--

LOCK TABLES `Patient_Disease` WRITE;
/*!40000 ALTER TABLE `Patient_Disease` DISABLE KEYS */;
INSERT INTO `Patient_Disease` VALUES (101526,'Anemia'),(102341,'Carpel Tunnel'),(104522,'Fracture'),(106757,'Asthma'),(118563,'Dislocation'),(104573,'Chickenpox'),(110347,'Bacterial Vaginosis'),(110468,'Coronary Heart Disease'),(107294,'Stroke'),(104826,'Bacterial Vaginosis'),(104725,'Ligament Tear'),(110184,'Candidiasis'),(101099,'Anemia'),(112234,'Measles'),(107257,'Epilepsy'),(108759,'Fracture'),(111903,'Brain Tumor'),(101184,'Coronary Heart Disease'),(110346,'Bacterial Vaginosis'),(110467,'Chickenpox'),(110019,'Brain Tumor'),(199879,'Measles'),(109478,'Bacterial Vaginosis'),(101375,'Candidiasis'),(189638,'Anemia'),(110378,'Dislocation'),(110011,'Adenomyosis'),(118427,'Stroke'),(119482,'Adenomyosis');
/*!40000 ALTER TABLE `Patient_Disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Is_Under_Department`
--

DROP TABLE IF EXISTS `Patient_Is_Under_Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_Is_Under_Department` (
  `PatientID` int NOT NULL,
  `DepartmentID` int NOT NULL,
  KEY `PatientID` (`PatientID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `patient_is_under_department_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE,
  CONSTRAINT `patient_is_under_department_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Is_Under_Department`
--

LOCK TABLES `Patient_Is_Under_Department` WRITE;
/*!40000 ALTER TABLE `Patient_Is_Under_Department` DISABLE KEYS */;
INSERT INTO `Patient_Is_Under_Department` VALUES (101526,99010),(102341,99020),(104522,99020),(106757,99010),(118563,99020),(104573,99010),(110347,99040),(110468,99030),(107294,99030),(104826,99040),(104725,99020),(110184,99040),(101099,99010),(112234,99010),(107257,99050),(108759,99020),(111903,99050),(101184,99030),(110346,99040),(110467,99010),(110019,99050),(199879,99010),(109478,99040),(101375,99040),(189638,99010),(110378,99020),(110011,99040),(118427,99030),(119482,99040);
/*!40000 ALTER TABLE `Patient_Is_Under_Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_PhoneNumber`
--

DROP TABLE IF EXISTS `Patient_PhoneNumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patient_PhoneNumber` (
  `PatientID` int NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  PRIMARY KEY (`Phone_Number`),
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `patient_phonenumber_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_PhoneNumber`
--

LOCK TABLES `Patient_PhoneNumber` WRITE;
/*!40000 ALTER TABLE `Patient_PhoneNumber` DISABLE KEYS */;
INSERT INTO `Patient_PhoneNumber` VALUES (101099,'9238267882'),(101184,'7340922530'),(101375,'9238626822'),(101526,'8025322633'),(102341,'8020548377'),(104522,'8026305701'),(104573,'8022134512'),(104725,'7340528163'),(104826,'9347836439'),(106757,'8029576741'),(107257,'8026267542'),(107294,'8029786213'),(108759,'8182830691'),(109478,'9238273293'),(110011,'9238726783'),(110019,'7340562934'),(110184,'7340825046'),(110346,'8029780653'),(110347,'9634527842'),(110378,'7340238474'),(110467,'9238727892'),(110468,'8023290682'),(111903,'9273562736'),(112234,'9248264823'),(118427,'9239827389'),(118563,'8024154671'),(119482,'7340288248'),(189638,'7340800185'),(199879,'9264582517');
/*!40000 ALTER TABLE `Patient_PhoneNumber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patients`
--

DROP TABLE IF EXISTS `Patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patients` (
  `PatientID` int NOT NULL,
  `AADHAR_Number` int NOT NULL,
  `Room_Number` int NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Date_of_Birth` date NOT NULL,
  `Gender` varchar(20) NOT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `Room_Number` (`Room_Number`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`Room_Number`) REFERENCES `Rooms` (`Room_Number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patients`
--

LOCK TABLES `Patients` WRITE;
/*!40000 ALTER TABLE `Patients` DISABLE KEYS */;
INSERT INTO `Patients` VALUES (101099,10166008,304,'Sid','Bahl','1980-12-15','Male'),(101184,47376104,301,'Radheshyam','Varghese','1990-06-02','Male'),(101375,11720618,204,'Amolika','Doshi','2010-05-25','Female'),(101526,16775933,101,'Nayan','Brar','1950-08-09','Male'),(102341,79058825,305,'Deepesh','Pillay','1956-03-30','Male'),(104522,14547213,301,'Krishna','Kala','1958-08-19','Male'),(104573,97232960,101,'Dhiraj','Loyal','1969-03-24','Male'),(104725,70690278,202,'Govind','Patla','1976-12-07','Male'),(104826,87951943,303,'Ankita','Ratta','1976-03-02','Female'),(106757,56841856,202,'Naresh','Anand','1962-01-31','Male'),(107257,26063328,203,'Vivek','Sabharwal','1986-04-19','Male'),(107294,54075537,102,'Faraz','Varkey','1974-03-23','Male'),(108759,98138512,301,'Shanti','Vohra','1986-11-13','Female'),(109478,33975637,105,'Shobha','Mallick','2010-04-10','Female'),(110011,86599574,204,'Kunti','Chohan','1988-07-16','Female'),(110019,66010047,106,'Akanksha','Dass','1994-11-14','Female'),(110184,12034833,205,'Runjhun','Jacob','1977-10-13','Female'),(110346,59925306,101,'Urmila','Seth','1994-03-03','Female'),(110347,23822646,101,'Yamini','Somani','1973-01-12','Female'),(110378,80353596,203,'Nawab','Lal','1985-11-25','Male'),(110467,89606947,303,'Aayushman','Palan','1994-06-26','Male'),(110468,41607620,104,'Ishat','Kothari','1974-01-06','Male'),(111903,25822027,203,'Himanshu','Thaker','1988-12-13','Male'),(112234,91088374,104,'Akhila','Khosla','1983-10-20','Female'),(118427,63904981,105,'Pranay','Chawla','1993-07-28','Male'),(118563,24980835,102,'Tanay','George','1968-10-26','Male'),(119482,27690523,103,'Ritika','Viswanathan','1995-02-06','Female'),(189638,51830181,102,'Manpreet','Kapadia','2010-10-05','Male'),(199879,4378607,202,'Sabina','Varghese','1997-10-10','Female');
/*!40000 ALTER TABLE `Patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room_Is_Under_Department`
--

DROP TABLE IF EXISTS `Room_Is_Under_Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Room_Is_Under_Department` (
  `Room_Number` int NOT NULL,
  `DepartmentID` int NOT NULL,
  KEY `Room_Number` (`Room_Number`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `room_is_under_department_ibfk_1` FOREIGN KEY (`Room_Number`) REFERENCES `Rooms` (`Room_Number`),
  CONSTRAINT `room_is_under_department_ibfk_2` FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room_Is_Under_Department`
--

LOCK TABLES `Room_Is_Under_Department` WRITE;
/*!40000 ALTER TABLE `Room_Is_Under_Department` DISABLE KEYS */;
INSERT INTO `Room_Is_Under_Department` VALUES (101,99010),(102,99010),(103,99010),(104,99010),(105,99010),(106,99010),(201,99020),(202,99020),(203,99020),(204,99020),(205,99020),(301,99030),(302,99030),(303,99030),(304,99030),(305,99030),(401,99040),(402,99040),(403,99040),(405,99040),(406,99040),(501,99050),(502,99050),(503,99050),(504,99050);
/*!40000 ALTER TABLE `Room_Is_Under_Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rooms`
--

DROP TABLE IF EXISTS `Rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rooms` (
  `Room_Number` int NOT NULL,
  `Room_Type` varchar(20) NOT NULL,
  `Cost` int NOT NULL,
  `Duration` int NOT NULL,
  `Capacity` int NOT NULL,
  PRIMARY KEY (`Room_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rooms`
--

LOCK TABLES `Rooms` WRITE;
/*!40000 ALTER TABLE `Rooms` DISABLE KEYS */;
INSERT INTO `Rooms` VALUES (101,'Multibed Ward',1000,3,4),(102,'Multibed Ward',1000,3,4),(103,'Multibed Ward',1000,3,4),(104,'Twin Sharing Room',1500,2,2),(105,'Twin Sharing Room',1500,2,2),(106,'Single Room',2000,1,1),(201,'Multibed Ward',1000,3,4),(202,'Multibed Ward',1000,3,4),(203,'Multibed Ward',1000,3,4),(204,'Multibed Ward',1000,3,4),(205,'Deluxe Room',3000,1,1),(301,'Single Room',2000,1,1),(302,'Single Room',2000,1,1),(303,'Twin Sharing Room',1500,2,2),(304,'Deluxe Room',3000,1,1),(305,'Deluxe Room',3000,1,1),(401,'Single Room',2000,1,1),(402,'Deluxe Room',3000,1,1),(403,'Deluxe Room',3000,1,1),(405,'Single Room',2000,1,1),(406,'Single Room',2000,1,1),(501,'Single Room',2000,1,1),(502,'Multibed Ward',1000,3,4),(503,'Deluxe Room',3000,1,1),(504,'Deluxe Room',3000,1,1);
/*!40000 ALTER TABLE `Rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Treated_By`
--

DROP TABLE IF EXISTS `Treated_By`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Treated_By` (
  `PatientID` int NOT NULL,
  `DoctorID` int NOT NULL,
  KEY `PatientID` (`PatientID`),
  KEY `DoctorID` (`DoctorID`),
  CONSTRAINT `treated_by_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE,
  CONSTRAINT `treated_by_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `Doctor` (`DoctorID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Treated_By`
--

LOCK TABLES `Treated_By` WRITE;
/*!40000 ALTER TABLE `Treated_By` DISABLE KEYS */;
INSERT INTO `Treated_By` VALUES (101526,10022),(102341,20012),(104522,20889),(106757,10075),(118563,20614),(104573,10075),(110347,40123),(110468,30311),(107294,30311),(104826,40123),(104725,20889),(110184,40356),(101099,10075),(112234,10075),(107257,50312),(108759,20012),(111903,50734),(101184,30127),(110346,40356),(110467,10149),(110019,50812),(199879,10149),(109478,40356),(101375,40954),(189638,10149),(110378,20614),(110011,40954),(118427,30265),(119482,40954);
/*!40000 ALTER TABLE `Treated_By` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Visitors`
--

DROP TABLE IF EXISTS `Visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Visitors` (
  `PatientID` int NOT NULL,
  `First_Name` varchar(20) NOT NULL,
  `Last_Name` varchar(20) NOT NULL,
  `Relationship_with_Patient` varchar(20) NOT NULL,
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `visitors_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Visitors`
--

LOCK TABLES `Visitors` WRITE;
/*!40000 ALTER TABLE `Visitors` DISABLE KEYS */;
INSERT INTO `Visitors` VALUES (102341,'Sharad','Chaudhry','Father'),(104522,'Umesh ','Keer','Brother'),(106757,'Pranab','Khan','Son'),(118563,'Vijay','Gupta','Brother'),(104725,'Mala','Kumar','Mother'),(110467,'Karan','Joshi','Father'),(110378,'Virat','Agarwal','Father'),(110011,'Sita','Gambhir','Mother'),(118427,'Om','Sharma','Son'),(119482,'Ram','Kalra','Son');
/*!40000 ALTER TABLE `Visitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Visitors_PhoneNumber`
--

DROP TABLE IF EXISTS `Visitors_PhoneNumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Visitors_PhoneNumber` (
  `PatientID` int NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  KEY `PatientID` (`PatientID`),
  CONSTRAINT `visitors_phonenumber_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Visitors_PhoneNumber`
--

LOCK TABLES `Visitors_PhoneNumber` WRITE;
/*!40000 ALTER TABLE `Visitors_PhoneNumber` DISABLE KEYS */;
INSERT INTO `Visitors_PhoneNumber` VALUES (102341,'8723672723'),(104522,'9346736283'),(106757,'8935783949'),(118563,'9239247903'),(104725,'9923238724'),(110467,'8782492845'),(110378,'8809242786'),(110011,'9238927348'),(118427,'8923288235'),(119482,'9237827983');
/*!40000 ALTER TABLE `Visitors_PhoneNumber` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-27 18:35:43
