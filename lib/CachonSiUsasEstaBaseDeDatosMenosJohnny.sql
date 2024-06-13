CREATE DATABASE  IF NOT EXISTS `vqz518dddao7thbt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vqz518dddao7thbt`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: veterinarioelcachon
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `IDCargo` int NOT NULL AUTO_INCREMENT,
  `NombreCargo` varchar(80) NOT NULL,
  PRIMARY KEY (`IDCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,'ADMINISTRADOR'),(2,'RECEPCIONISTA'),(3,'DOCTOR'),(4,'CLIENTE');
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita`
--

DROP TABLE IF EXISTS `cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cita` (
  `IDCita` int NOT NULL AUTO_INCREMENT,
  `IDMascota` int NOT NULL,
  `FechaCita` varchar(10) DEFAULT NULL,
  `HoraCita` varchar(5) NOT NULL,
  `ProceProgramado` varchar(80) NOT NULL,
  `Observaciones` varchar(140) NOT NULL,
  `CedulaDoctor` int NOT NULL,
  PRIMARY KEY (`IDCita`),
  KEY `IDMascota` (`IDMascota`),
  KEY `CedulaDoctor` (`CedulaDoctor`),
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`IDMascota`) REFERENCES `mascota` (`IDMascota`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`CedulaDoctor`) REFERENCES `doctor` (`CedulaDoctor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `IDDepto` int NOT NULL AUTO_INCREMENT,
  `NombreDepto` varchar(40) NOT NULL,
  PRIMARY KEY (`IDDepto`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'ANTIOQUIA'),(2,'AMAZONAS'),(3,'ARAUCA'),(4,'ATLANTICO'),(5,'BOGOTA'),(6,'BOLIVAR'),(7,'BOYACA'),(8,'CALDAS'),(9,'CAQUETA'),(10,'CASANARE'),(11,'CAUCA'),(12,'CESAR'),(13,'CHOCO'),(14,'CORDOBA'),(15,'CUNDINAMARCA'),(16,'GUAINIA'),(17,'GUAVIARE'),(18,'HUILA'),(19,'LA GUAJIRA'),(20,'MAGDALENA'),(21,'META'),(22,'NARINO'),(23,'NORTE DE SANTANDER'),(24,'PUTUMAYO'),(25,'QUINDIO'),(26,'RISARALDA'),(27,'SAN ANDRES Y PROVIDENCIA'),(28,'SANTANDER'),(29,'SUCRE'),(30,'TOLIMA'),(31,'VALLE DEL CAUCA'),(32,'VAUPES'),(33,'VICHADA');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `CedulaDoctor` int NOT NULL,
  `CedulaEmpleado` int NOT NULL,
  PRIMARY KEY (`CedulaDoctor`),
  KEY `CedulaEmpleado` (`CedulaEmpleado`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`CedulaEmpleado`) REFERENCES `empleado` (`CedulaEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `Cedula` varchar(20) NOT NULL,
  `Contrasena` varchar(20) NOT NULL,
  `PrimNombre` varchar(20),
  `SegNombre` varchar(20) DEFAULT '',
  `PrimApellido` varchar(40),
  `SegApellido` varchar(40) DEFAULT '',
  `IDSexo` int DEFAULT 1,
  `IDCargo` int NOT NULL,
  `Direccion` varchar(100) DEFAULT '',
  `IDMunicipio` int DEFAULT '1',
  `IDDepto` int DEFAULT '1',
  `TelCel` varchar(10) DEFAULT '',
  `CorreoE` varchar(80) DEFAULT '',
  PRIMARY KEY (`Cedula`),
  KEY `IDCargo` (`IDCargo`),
  KEY `IDDepto` (`IDDepto`),
  KEY `IDMunicipio` (`IDMunicipio`),
  KEY `IDSexo` (`IDSexo`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`IDCargo`) REFERENCES `cargo` (`IDCargo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`IDDepto`) REFERENCES `departamento` (`IDDepto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`IDMunicipio`) REFERENCES `municipio` (`IDMunicipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuario_ibfk_4` FOREIGN KEY (`IDSexo`) REFERENCES `sexo` (`IDSexo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('1','123','Jhonnnnnn','Kevin','Murillo','Martinez',1,1,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('2','123','Kehiber','Kevin','Mosquera','Mosquera',1,2,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('3','123','Lucho','Kevin','Murillo','Martinez',1,3,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('4','123','Tomas','Kevin','Murillo','Martinez',1,2,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('5','123','Mauricio','Kevin','Murillo','Martinez',1,4,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('6','123','Jhon','Kevin','Murillo','Martinez',1,4,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('7','123','Jhon','Kevin','Murillo','Martinez',1,4,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');
INSERT INTO `usuario` VALUES ('8','123','Jhon','Kevin','Murillo','Martinez',1,4,'Cll 99 B',1,1,'3217153608','jhonkevinmurillom@gmail.com');

/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

-- Table structure for table `especie`
--

DROP TABLE IF EXISTS `especie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especie` (
  `IDEspecie` int NOT NULL AUTO_INCREMENT,
  `NombreEsp` varchar(50) NOT NULL,
  PRIMARY KEY (`IDEspecie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especie`
--

LOCK TABLES `especie` WRITE;
/*!40000 ALTER TABLE `especie` DISABLE KEYS */;
INSERT INTO `especie` VALUES (1,'MAMIFEROS'),(2,'AVES'),(3,'REPTILES');
/*!40000 ALTER TABLE `especie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadomascota`
--

DROP TABLE IF EXISTS `estadomascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadomascota` (
  `IDEstadoMasc` int NOT NULL AUTO_INCREMENT,
  `NombreEstMasc` varchar(20) NOT NULL,
  PRIMARY KEY (`IDEstadoMasc`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadomascota`
--

LOCK TABLES `estadomascota` WRITE;
/*!40000 ALTER TABLE `estadomascota` DISABLE KEYS */;
INSERT INTO `estadomascota` VALUES (1,'SANO'),(2,'ENFERMO'),(3,'FALLECIDO');
/*!40000 ALTER TABLE `estadomascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familia`
--

DROP TABLE IF EXISTS `familia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `familia` (
  `IDFamilia` int NOT NULL AUTO_INCREMENT,
  `IDEspecie` int NOT NULL,
  `NombreFamilia` varchar(50) NOT NULL,
  PRIMARY KEY (`IDFamilia`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familia`
--

LOCK TABLES `familia` WRITE;
/*!40000 ALTER TABLE `familia` DISABLE KEYS */;
INSERT INTO `familia` VALUES (1,3,'SERPIENTES'),(2,3,'LAGARTOS'),(3,3,'TORTUGAS'),(4,1,'PERROS'),(5,1,'GATOS'),(6,1,'ARDILLAS'),(7,2,'LOROS'),(8,2,'PERICOS'),(9,2,'PATOS');
/*!40000 ALTER TABLE `familia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genero`
--

DROP TABLE IF EXISTS `genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genero` (
  `IDGenero` int NOT NULL AUTO_INCREMENT,
  `IDFamilia` int NOT NULL,
  `NombreGenero` varchar(50) NOT NULL,
  PRIMARY KEY (`IDGenero`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genero`
--

LOCK TABLES `genero` WRITE;
/*!40000 ALTER TABLE `genero` DISABLE KEYS */;
INSERT INTO `genero` VALUES (1,1,'VIBORAS'),(2,2,'TARENTOLA'),(3,3,'GEOCHELONE'),(4,4,'CANIS'),(5,5,'FELIS'),(6,6,'SCIURUS VULGARIS'),(7,7,'PSITTACOIDEA'),(8,8,'MELOPSITTACUS UNDULATUS'),(9,9,'ANAS');
/*!40000 ALTER TABLE `genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota`
--

DROP TABLE IF EXISTS `mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascota` (
  `IDMascota` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(20) NOT NULL,
  `CedulaPropietario` int NOT NULL,
  `IDEspecie` int,
  `IDFamilia` int,
  `IDGenero` int,
  `Fnacimiento` date,
  `IDSexo` int,
  `FIngreso` date NOT NULL,
  `CedulaDoctor` int,
  `IDEstadoMasc` int,
  `FSalida` date,
  `IDTipoSalidaMasc` int,
  PRIMARY KEY (`IDMascota`),
  KEY `CedulaPropietario` (`CedulaPropietario`),
  KEY `IDEspecie` (`IDEspecie`),
  KEY `IDFamilia` (`IDFamilia`),
  KEY `IDGenero` (`IDGenero`),
  KEY `IDSexo` (`IDSexo`),
  KEY `CedulaDoctor` (`CedulaDoctor`),
  KEY `IDEstadoMasc` (`IDEstadoMasc`),
  KEY `IDTipoSalidaMasc` (`IDTipoSalidaMasc`),
  CONSTRAINT `mascota_ibfk_1` FOREIGN KEY (`CedulaPropietario`) REFERENCES `propietario` (`CedulaPropietario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_2` FOREIGN KEY (`IDEspecie`) REFERENCES `especie` (`IDEspecie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_3` FOREIGN KEY (`IDFamilia`) REFERENCES `familia` (`IDFamilia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_4` FOREIGN KEY (`IDGenero`) REFERENCES `genero` (`IDGenero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_5` FOREIGN KEY (`IDSexo`) REFERENCES `sexo` (`IDSexo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_6` FOREIGN KEY (`CedulaDoctor`) REFERENCES `doctor` (`CedulaDoctor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_7` FOREIGN KEY (`IDEstadoMasc`) REFERENCES `estadomascota` (`IDEstadoMasc`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mascota_ibfk_8` FOREIGN KEY (`IDTipoSalidaMasc`) REFERENCES `tiposalidamascota` (`IDTSalidaMasc`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota`
--

LOCK TABLES `mascota` WRITE;
/*!40000 ALTER TABLE `mascota` DISABLE KEYS */;
/*!40000 ALTER TABLE `mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipio`
--

DROP TABLE IF EXISTS `municipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `municipio` (
  `IDMunicipio` int NOT NULL AUTO_INCREMENT,
  `NombreMuni` varchar(40) NOT NULL,
  `IDDepto` int NOT NULL,
  PRIMARY KEY (`IDMunicipio`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipio`
--

LOCK TABLES `municipio` WRITE;
/*!40000 ALTER TABLE `municipio` DISABLE KEYS */;
INSERT INTO `municipio` VALUES (1,'MEDELLIN',1),(2,'LETICIA',2),(3,'ARAUCA',3),(4,'BARRANQUILLA',4),(5,'BOGOTA',5),(6,'CARTAGENA DE INDIAS',6),(7,'TUNJA',7),(8,'MANIZALES',8),(9,'FLORENCIA',9),(10,'YOPAL',10),(11,'POPAYAN',11),(12,'VALLEDUPAR',12),(13,'QUIBDO',13),(14,'MONTERIA',14),(15,'BOGOTA',15),(16,'INIRIDA',16),(17,'SAN JOSE DEL GUAVIARE',17),(18,'NEIVA',18),(19,'RIOHACHA',19),(20,'SANTA MARTA',20),(21,'VILLAVICENCIO',21),(22,'PASTO',22),(23,'SAN JOSE DE CUCUTA',23),(24,'MOCOA',24),(25,'ARMENIA',25),(26,'PEREIRA',26),(27,'SAN ANDRES',27),(28,'BUCARAMANGA',28),(29,'SINCELEJO',29),(30,'IBAGUE',30),(31,'CALI',31),(32,'MITU',32),(33,'PUERTO CARRENO',33);
/*!40000 ALTER TABLE `municipio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propietario`
--

DROP TABLE IF EXISTS `propietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propietario` (
  `CedulaPropietario` int NOT NULL,
  `PrimNombre` varchar(20) NOT NULL,
  `SegNombre` varchar(20) NOT NULL,
  `PrimApellido` varchar(40) NOT NULL,
  `SegApellido` varchar(40) NOT NULL,
  `IDSexo` int NOT NULL,
  `fnacimiento` varchar(10) NOT NULL,
  `Direccion` varchar(100) NOT NULL,
  `IDMunicipio` int NOT NULL,
  `IDDepto` int NOT NULL,
  `TelCel` varchar(10) NOT NULL,
  `CorreoE` varchar(80) NOT NULL,
  PRIMARY KEY (`CedulaPropietario`),
  KEY `IDDepto` (`IDDepto`),
  KEY `IDMunicipio` (`IDMunicipio`),
  KEY `IDSexo` (`IDSexo`),
  CONSTRAINT `propietario_ibfk_1` FOREIGN KEY (`IDDepto`) REFERENCES `departamento` (`IDDepto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `propietario_ibfk_2` FOREIGN KEY (`IDMunicipio`) REFERENCES `municipio` (`IDMunicipio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `propietario_ibfk_3` FOREIGN KEY (`IDSexo`) REFERENCES `sexo` (`IDSexo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propietario`
--

LOCK TABLES `propietario` WRITE;
/*!40000 ALTER TABLE `propietario` DISABLE KEYS */;
/*!40000 ALTER TABLE `propietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sexo`
--

DROP TABLE IF EXISTS `sexo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sexo` (
  `IDSexo` int NOT NULL AUTO_INCREMENT,
  `LetraSexo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`IDSexo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sexo`
--

LOCK TABLES `sexo` WRITE;
/*!40000 ALTER TABLE `sexo` DISABLE KEYS */;
INSERT INTO `sexo` VALUES (1,'M'),(2,'F');
/*!40000 ALTER TABLE `sexo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiposalidamascota`
--

DROP TABLE IF EXISTS `tiposalidamascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiposalidamascota` (
  `IDTSalidaMasc` int NOT NULL AUTO_INCREMENT,
  `DescripTSMasc` varchar(60) NOT NULL,
  PRIMARY KEY (`IDTSalidaMasc`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiposalidamascota`
--

LOCK TABLES `tiposalidamascota` WRITE;
/*!40000 ALTER TABLE `tiposalidamascota` DISABLE KEYS */;
INSERT INTO `tiposalidamascota` VALUES (1,'TRATAMIENTO'),(2,'ALTA'),(3,'CUIDADO INTENSIVO'),(4,'CONTROL');
/*!40000 ALTER TABLE `tiposalidamascota` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Dumping events for database 'veterinarioelcachon'
--

--
-- Dumping routines for database 'veterinarioelcachon'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-04 12:53:29
