-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: itsc_academico_v3
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `itsc_academico_v3`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `itsc_academico_v3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `itsc_academico_v3`;

--
-- Table structure for table `app_auditoria`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_auditoria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `accion` varchar(60) NOT NULL,
  `entidad` varchar(80) NOT NULL,
  `registro_id` varchar(50) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `app_auditoria_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `app_usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_auditoria`
--

LOCK TABLES `app_auditoria` WRITE;
/*!40000 ALTER TABLE `app_auditoria` DISABLE KEYS */;

/*!40000 ALTER TABLE `app_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_intentos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_intentos` (
  `clave` char(64) NOT NULL,
  `fallos` int(11) NOT NULL DEFAULT 0,
  `ultimo` datetime NOT NULL,
  PRIMARY KEY (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_intentos`
--

LOCK TABLES `app_intentos` WRITE;
/*!40000 ALTER TABLE `app_intentos` DISABLE KEYS */;

/*!40000 ALTER TABLE `app_intentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_usuarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario` varchar(60) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('ADMIN','DOCENTE','CAJA') NOT NULL,
  `docente_id` int(10) unsigned DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `app_usuarios_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`rol` <> 'DOCENTE' or `docente_id` is not null)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_usuarios`
--

LOCK TABLES `app_usuarios` WRITE;
/*!40000 ALTER TABLE `app_usuarios` DISABLE KEYS */;

/*!40000 ALTER TABLE `app_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencias_demo_historicas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asistencias_demo_historicas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inscripcion_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('PRESENTE','FALTA','ATRASO','JUSTIFICADA') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inscripcion_id` (`inscripcion_id`,`fecha`),
  CONSTRAINT `asistencias_demo_historicas_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias_demo_historicas`
--

LOCK TABLES `asistencias_demo_historicas` WRITE;
/*!40000 ALTER TABLE `asistencias_demo_historicas` DISABLE KEYS */;
INSERT INTO `asistencias_demo_historicas` VALUES (1,1,'2026-07-20','PRESENTE'),(2,3,'2026-07-20','PRESENTE'),(3,4,'2026-07-20','JUSTIFICADA');
/*!40000 ALTER TABLE `asistencias_demo_historicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencias_sesion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asistencias_sesion` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `sesion_id` int(10) unsigned NOT NULL,
  `oferta_id` int(10) unsigned NOT NULL,
  `minutos_presentes` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`inscripcion_id`,`sesion_id`),
  KEY `inscripcion_id` (`inscripcion_id`,`oferta_id`),
  KEY `sesion_id` (`sesion_id`,`oferta_id`),
  CONSTRAINT `asistencias_sesion_ibfk_1` FOREIGN KEY (`inscripcion_id`, `oferta_id`) REFERENCES `inscripciones` (`id`, `oferta_id`),
  CONSTRAINT `asistencias_sesion_ibfk_2` FOREIGN KEY (`sesion_id`, `oferta_id`) REFERENCES `sesiones` (`id`, `oferta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias_sesion`
--

LOCK TABLES `asistencias_sesion` WRITE;
/*!40000 ALTER TABLE `asistencias_sesion` DISABLE KEYS */;
INSERT INTO `asistencias_sesion` VALUES (1,1,1,120),(5,2,6,80);
/*!40000 ALTER TABLE `asistencias_sesion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER validar_asistencia_insert BEFORE INSERT ON asistencias_sesion FOR EACH ROW
BEGIN
 IF NEW.minutos_presentes>(SELECT TIMESTAMPDIFF(MINUTE,inicio,fin) FROM sesiones WHERE id=NEW.sesion_id) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Asistencia mayor a la duración de la sesión'; END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER validar_asistencia_update BEFORE UPDATE ON asistencias_sesion FOR EACH ROW
BEGIN
 IF NEW.minutos_presentes>(SELECT TIMESTAMPDIFF(MINUTE,inicio,fin) FROM sesiones WHERE id=NEW.sesion_id) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Asistencia mayor a la duración de la sesión'; END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `aulas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aulas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `capacidad` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aulas`
--

LOCK TABLES `aulas` WRITE;
/*!40000 ALTER TABLE `aulas` DISABLE KEYS */;
INSERT INTO `aulas` VALUES (1,'LAB-01',30),(2,'AULA-02',35),(3,'TALLER-01',25);
/*!40000 ALTER TABLE `aulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificaciones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calificaciones` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `evaluacion_id` int(10) unsigned NOT NULL,
  `oferta_id` int(10) unsigned NOT NULL,
  `nota` decimal(5,2) NOT NULL CHECK (`nota` between 1 and 100),
  PRIMARY KEY (`inscripcion_id`,`evaluacion_id`),
  KEY `inscripcion_id` (`inscripcion_id`,`oferta_id`),
  KEY `evaluacion_id` (`evaluacion_id`,`oferta_id`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`inscripcion_id`, `oferta_id`) REFERENCES `inscripciones` (`id`, `oferta_id`),
  CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`evaluacion_id`, `oferta_id`) REFERENCES `evaluaciones` (`id`, `oferta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (1,1,1,50.00),(1,2,1,60.00),(5,3,6,50.00),(5,4,6,50.00);
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `concepto` varchar(120) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `vencimiento` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  CONSTRAINT `cargos_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`monto` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,1,'Matrícula de ejemplo',100.00,'2026-07-20'),(2,2,'Matrícula de ejemplo',100.00,'2026-07-20'),(3,3,'Matrícula de ejemplo',100.00,'2026-07-20'),(4,5,'Aporte ficticio DEMO',100.00,'2026-10-30');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carreras`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carreras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `nivel` varchar(50) NOT NULL DEFAULT 'Técnico Superior',
  `duracion_anios` tinyint(3) unsigned NOT NULL DEFAULT 3,
  `regimen` enum('ANUAL','SEMESTRAL') NOT NULL,
  `fuente_url` varchar(500) NOT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carreras`
--

LOCK TABLES `carreras` WRITE;
/*!40000 ALTER TABLE `carreras` DISABLE KEYS */;
INSERT INTO `carreras` VALUES (1,'SIS','Sistemas Informáticos','Técnico Superior',3,'ANUAL','https://www.itsc.edu.bo/index.php?Itemid=155',1),(2,'CON','Contaduría General','Técnico Superior',3,'ANUAL','https://www.itsc.edu.bo/index.php?Itemid=156',1),(3,'ELE','Electricidad Industrial','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=160',1),(4,'QUI','Química Industrial','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=157',1),(5,'MIN','Mecánica Industrial','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=158',1),(6,'MAU','Mecánica Automotriz','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=159',1),(7,'ELN','Electrónica','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=161',1),(8,'CCV','Construcción Civil','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=162',1);
/*!40000 ALTER TABLE `carreras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cierres_oferta`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cierres_oferta` (
  `oferta_id` int(10) unsigned NOT NULL,
  `minutos_carga` int(10) unsigned NOT NULL CHECK (`minutos_carga` > 0),
  `cerrado_por` varchar(120) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`oferta_id`),
  CONSTRAINT `cierres_oferta_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cierres_oferta`
--

LOCK TABLES `cierres_oferta` WRITE;
/*!40000 ALTER TABLE `cierres_oferta` DISABLE KEYS */;
INSERT INTO `cierres_oferta` VALUES (1,120,'Responsable ficticio DEMO','2026-10-16 20:37:33'),(6,100,'Administrador de práctica','2026-10-16 20:47:56');
/*!40000 ALTER TABLE `cierres_oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `defensas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `defensas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proyecto_id` int(10) unsigned NOT NULL,
  `fecha` datetime NOT NULL,
  `aula_id` int(10) unsigned DEFAULT NULL,
  `nota` decimal(5,2) DEFAULT NULL CHECK (`nota` between 0 and 100),
  `acta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acta` (`acta`),
  KEY `proyecto_id` (`proyecto_id`),
  KEY `aula_id` (`aula_id`),
  CONSTRAINT `defensas_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos_graduacion` (`id`),
  CONSTRAINT `defensas_ibfk_2` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `defensas`
--

LOCK TABLES `defensas` WRITE;
/*!40000 ALTER TABLE `defensas` DISABLE KEYS */;
/*!40000 ALTER TABLE `defensas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docentes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docentes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documento` varchar(25) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `especialidad` varchar(120) NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `documento` (`documento`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docentes`
--

LOCK TABLES `docentes` WRITE;
/*!40000 ALTER TABLE `docentes` DISABLE KEYS */;
INSERT INTO `docentes` VALUES (1,'FICT-D01','Lucía','Vargas Molina','Informática','71000001','lucia@example.com'),(2,'FICT-D02','Andrés','Paredes Lima','Contabilidad','71000002','andres@example.com'),(3,'FICT-D03','Camila','Ortiz Rivas','Electricidad','71000003','camila@example.com');
/*!40000 ALTER TABLE `docentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_matricula`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentos_matricula` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `tipo_documento_id` int(10) unsigned NOT NULL,
  `estado` enum('PENDIENTE','RECIBIDO','OBSERVADO') NOT NULL DEFAULT 'PENDIENTE',
  `fecha_recepcion` date DEFAULT NULL,
  `observacion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricula_id` (`matricula_id`,`tipo_documento_id`),
  KEY `tipo_documento_id` (`tipo_documento_id`),
  CONSTRAINT `documentos_matricula_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `documentos_matricula_ibfk_2` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipos_documento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_matricula`
--

LOCK TABLES `documentos_matricula` WRITE;
/*!40000 ALTER TABLE `documentos_matricula` DISABLE KEYS */;
INSERT INTO `documentos_matricula` VALUES (1,1,1,'RECIBIDO','2026-07-15',NULL),(2,1,2,'RECIBIDO','2026-07-15',NULL),(3,1,3,'PENDIENTE',NULL,NULL),(4,1,4,'PENDIENTE',NULL,NULL),(5,5,1,'RECIBIDO','2026-10-16','Ejemplo ficticio');
/*!40000 ALTER TABLE `documentos_matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiantes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `registro` varchar(20) NOT NULL,
  `documento` varchar(25) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `registro` (`registro`),
  UNIQUE KEY `documento` (`documento`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` VALUES (1,'EST-001','FICT-1001','Mateo','Rojas Salvatierra','2005-03-12','70000001','mateo@example.com','Calle Ficticia 10','2026-10-16 20:37:32'),(2,'EST-002','FICT-1002','Valeria','Méndez Suárez','2004-08-21','70000002','valeria@example.com','Calle Ficticia 20','2026-10-16 20:37:32'),(3,'EST-003','FICT-1003','Bruno','Castro Aguilar','2005-11-04','70000003','bruno@example.com','Calle Ficticia 30','2026-10-16 20:37:32'),(5,'DEMO-fbc571','FICT-fbc571','Elena','Salvatierra Demo','2005-02-15','70000009',NULL,NULL,'2026-10-16 20:47:53');
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluaciones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluaciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oferta_id` int(10) unsigned NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `componente` enum('PRACTICA','TEORIA') NOT NULL,
  `peso` decimal(6,3) NOT NULL CHECK (`peso` > 0 and `peso` <= 100),
  PRIMARY KEY (`id`),
  UNIQUE KEY `oferta_id` (`oferta_id`,`nombre`),
  UNIQUE KEY `id` (`id`,`oferta_id`),
  CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluaciones`
--

LOCK TABLES `evaluaciones` WRITE;
/*!40000 ALTER TABLE `evaluaciones` DISABLE KEYS */;
INSERT INTO `evaluaciones` VALUES (1,1,'Práctica final DEMO','PRACTICA',100.000),(2,1,'Teoría final DEMO','TEORIA',100.000),(3,6,'Evaluación demo PRACTICA','PRACTICA',100.000),(4,6,'Evaluación demo TEORIA','TEORIA',100.000);
/*!40000 ALTER TABLE `evaluaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `excepciones_asistencia`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `excepciones_asistencia` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `documento` varchar(250) NOT NULL,
  `resolucion` varchar(100) NOT NULL,
  `aprobada_por` varchar(120) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`inscripcion_id`),
  CONSTRAINT `excepciones_asistencia_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (octet_length(trim(`documento`)) > 0 and octet_length(trim(`resolucion`)) > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `excepciones_asistencia`
--

LOCK TABLES `excepciones_asistencia` WRITE;
/*!40000 ALTER TABLE `excepciones_asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `excepciones_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oferta_id` int(10) unsigned NOT NULL,
  `aula_id` int(10) unsigned NOT NULL,
  `dia` tinyint(3) unsigned NOT NULL COMMENT '1=lunes, 7=domingo',
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `oferta_id` (`oferta_id`),
  KEY `aula_id` (`aula_id`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`),
  CONSTRAINT `horarios_ibfk_2` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`dia` between 1 and 7),
  CONSTRAINT `CONSTRAINT_2` CHECK (`hora_fin` > `hora_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES (1,1,1,1,'08:00:00','10:00:00'),(2,2,1,2,'08:00:00','10:00:00'),(3,3,2,1,'19:00:00','21:00:00'),(4,4,3,1,'14:00:00','16:00:00');
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inscripciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `oferta_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  `periodo_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('ACTIVA','RETIRADA','CONCLUIDA') NOT NULL DEFAULT 'ACTIVA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricula_id` (`matricula_id`,`oferta_id`),
  UNIQUE KEY `id` (`id`,`oferta_id`),
  KEY `matricula_id_2` (`matricula_id`,`carrera_id`,`periodo_id`),
  KEY `oferta_id` (`oferta_id`,`carrera_id`,`periodo_id`),
  CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`matricula_id`, `carrera_id`, `periodo_id`) REFERENCES `matriculas` (`id`, `carrera_id`, `periodo_id`),
  CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`oferta_id`, `carrera_id`, `periodo_id`) REFERENCES `ofertas` (`id`, `carrera_id`, `periodo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
INSERT INTO `inscripciones` VALUES (1,1,1,1,1,'2026-07-17','ACTIVA'),(2,1,2,1,1,'2026-07-17','ACTIVA'),(3,2,3,2,1,'2026-07-17','ACTIVA'),(4,3,4,3,1,'2026-07-17','ACTIVA'),(5,5,6,1,1,'2026-10-16','ACTIVA');
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrera_id` int(10) unsigned NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `nivel_curso` tinyint(3) unsigned NOT NULL,
  `horas_semanales` tinyint(3) unsigned DEFAULT NULL,
  `fuente_url` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carrera_id` (`carrera_id`,`codigo`),
  UNIQUE KEY `id` (`id`,`carrera_id`),
  CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,1,'MPI-101','MATEMÁTICA PARA LA INFORMÁTICA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(2,1,'PRG-102','PROGRAMACIÓN I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(3,1,'INT-103','INGLES TÉCNICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(4,1,'HDC-104','HARDWARE DE COMPUTADORAS',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(5,1,'TSO-105','TALLLER DE SISTEMAS OPERATIVOS',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(6,1,'OTM-106','OFIMATICA Y TECNOLOGÍA MULTIMEDIA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(7,1,'DPW-107','DISEÑO Y PROGRAMACIÓN WEB I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(8,1,'ETD-201','ESTADÍSTICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(9,1,'PRG-202','PROGRAMACIÓN II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(10,1,'EDD-203','ESTRUCTURA DE DATOS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(11,1,'RDC-204','REDES DE COMPUTADORAS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(12,1,'PDM-205','PROGRAMACIÓN PARA DISPOSITIVOS MÓVILES I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(13,1,'ADS-206','ANÁLISIS Y DISEÑO DE SISTEMAS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(14,1,'DPW-207','DISEÑO Y PROGRAMACIÓN WEB II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(15,1,'BDD-208','BASE DE DATOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(16,1,'EMP-301','EMPRENDIMIENTO PRODUCTIVO',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(17,1,'DPW-302','DISEÑO Y PROGRAMACIÓN WEB III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(18,1,'GMC-303','GESTIÓN Y MEJORAMIENTO DE LA CALIDAD DEL SOFTWARE',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(19,1,'RDC-304','REDES DE COMPUTADORAS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(20,1,'TMG-305','TALLER MODALIDAD DE GRADUACIÓN',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(21,1,'ADS-306','ANÁLISIS Y DISEÑO DE SISTEMAS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(22,1,'PDM-307','PROGRAMACIÓN PARA DISPOSITIVOS MÓVILES II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(23,1,'BDD-308','BASE DE DATOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(24,2,'CON-101','CONTABILIDAD I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(25,2,'MAF-102','MATEMÁTICA FINANCIERA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(26,2,'ICO-103','INFORMÁTICA CONTABLE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(27,2,'ADG-104','ADMINISTRACION GENERAL',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(28,2,'LSA-105','LEGISLACION LABORAL Y SEGURIDAD SOCIAL APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(29,2,'EGA-106','ECONOMIA GENERAL APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(30,2,'DCM-107','DOCUMENTOS COMERCIALES Y MERCANTILES',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(31,2,'ESA-108','ESTADISTICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(32,2,'INT-109','INGLES TECNICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(33,2,'CON-201','CONTABILIDAD II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(34,2,'COC-202','CONTABILIDAD DE COSTOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(35,2,'COS-203','CONTABILIDAD DE SOCIEDADES',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(36,2,'CDS-204','CONTABILIDAD DE SEGUROS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(37,2,'CBC-205','CONTABILIDAD BANCARIA Y COOPERATIVAS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(38,2,'EMP-206','EMPRENDIMIENTO PRODUCTIVO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(39,2,'SIT-207','SISTEMA TRIBUTARIO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(40,2,'COA-301','CONTABILIDAD AGROPECUARIA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(41,2,'COC-302','CONTABILIDAD DE COSTOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(42,2,'COG-303','CONTABILIAD GUBERNAMENTAL',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(43,2,'CEP-304','CONTABILIDAD EXTRACTIVA (MINERA, PETROLERA Y FORESTAL)',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(44,2,'CHS-305','CONTABILIDAD DE SERVICIOS (CONSTRUCCION, HOTELERIA Y TRANSPORTE)',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(45,2,'GCI-306','GABINETE CONTABLE INFORMATICO',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(46,2,'AEF-307','ANALISIS E INTERPRETACIONES DE ESTADOS FINANCIEROS',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(47,2,'TMG-308','TALLER DE MODALIDAD DE GRADUACION',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(48,3,'SIM-100','SEGURIDAD OCUPACIONAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(49,3,'CEL-100','CIRCUITOS ELECTRICOS Y LABORATORIO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(50,3,'IET-100','INSTALACIONES ELECTRICAS Y TALLER I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(51,3,'DIE-100','DIBUJO DE ESPECIALIDAD',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(52,3,'TEM-100','TALLER ELECTROMECANICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(53,3,'MAA-100','MATEMATICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(54,3,'CEL-200','CIRCUITOS ELECTRICOS Y LABORATORIO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(55,3,'IET-200','INSTALACIONES ELECTRICAS Y TALLER II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(56,3,'MLT-200','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(57,3,'FIA-200','FISICA APLICADA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(58,3,'INT-200','INGLES TECNICO I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(59,3,'AUE-300','AUTOMATISMOS ELECTRICOS I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(60,3,'INM-300','INSTRUMENTACION Y MEDIDAS',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(61,3,'MLT-300','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(62,3,'ELA-300','ELECTRONICA ANALOGICA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(63,3,'ENA-300','ENERGIAS ALTERNATIVAS I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(64,3,'EDA-300','ELECTRICIDAD DEL AUTOMOVIL',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(65,3,'EMP-300','EMPRENDIMIENTO PRODUCTIVO I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(66,3,'AUE-400','AUTOMATISMOS ELECTRICOS II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(67,3,'CEE-400','CENTRALES ELECTRICAS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(68,3,'MLT-400','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER III',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(69,3,'ELD-400','ELECTRONICA DIGITAL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(70,3,'ENA-400','ENERGIAS ALTERNATIVAS II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(71,3,'SIR-400','SISTEMAS DE REFRIGERACION',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(72,3,'EMP-400','EMPRENDIMIENTO PRODUCTIVO II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(73,3,'CLP-500','CONTROLADORES LOGICOS PROGRAMABLES',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(74,3,'RED-500','REDES DE DISTRIBUCION',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(75,3,'MLT-500','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER IV',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(76,3,'ELP-500','ELECTRONICA DE POTENCIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(77,3,'REI-500','REFRIGERACION INDUSTRIAL',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(78,3,'TMG-500','TALLER DE MODADLIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(79,3,'SIS-600','SISTEMAS SCADA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(80,3,'ELN-600','ELECTRONEUMATICA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(81,3,'LIT-600','LINEAS DE TRANSMISION',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(82,3,'SUP-600','SUBESTACIONES DE POTENCIA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(83,3,'MCC-600','MICROCONTROLADORES',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(84,3,'TMG-600','TALLER DE MODADLIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(85,4,'QCG-100','QUÍMICA GENERAL I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(86,4,'QCO-100','QUÍMICA ORGÁNICA I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(87,4,'EPQ-100','ELABORACIÓN DE PRODUCTOS QUÍMICOS I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(88,4,'FIA-100','FÍSICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(89,4,'MAA-100','MATEMÁTICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(90,4,'INT-100','INGLÉS TÉCNCIO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(91,4,'HSI-200','HIGIENE, SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(92,4,'QCG-200','QUÍMICA GENERAL II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(93,4,'QCO-200','QUÍMICA ORGÁNICA II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(94,4,'QCI-200','QUÍMICA INORGÁNICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(95,4,'EDE-200','ESTADISTICA APLICADA Y DISEÑO DE EXPERIMENTOS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(96,4,'INT-200','INGLÉS TÉCNCIO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(97,4,'ANQ-300','ANÁLISIS QUÍMICO I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(98,4,'EPQ-300','ELABORACIÓN DE PRODUCTOS QUÍMICOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(99,4,'BMI-300','BROMATOLOGÍA Y MICROBIOLOGÍA INDUSTRIAL I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(100,4,'ELQ-300','ELECTROQUÍMICA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(101,4,'FIQ-300','FISICOQUÍMICA APLICADA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(102,4,'EMP-300','EMPRENDIMIENTO PRODUCTIVO I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(103,4,'ANQ-400','ANÁLISIS QUÍMICO II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(104,4,'BMI-400','BROMATOLOGÍA Y MICROBIOLOGÍA INDUSTRIAL II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(105,4,'OPU-400','OPERACIONES UNITARIAS I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(106,4,'TDI-400','TERMODINÁMICA INDUSTRIAL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(107,4,'INC-400','INSTRUMENTACION Y CONTROL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(108,4,'EMP-400','EMPRENDIMIENTO PRODUCTIVO II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(109,4,'AAI-500','ANÁLISIS APLICADO INORGÁNICO',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(110,4,'ANI-500','ANALISIS INSTRUMENTAL I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(111,4,'CCI-500','CONTROL DE CALIDAD EN LA INDUSTRIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(112,4,'OPU-500','OPERACIONES UNITARIAS II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(113,4,'PQI-500','PROCESOS QUÍMICOS ORGANICOS E INORGÁNICOS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(114,4,'AAO-600','ANALISIS APLICADO ORGÁNICO',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(115,4,'ANI-600','ANALISIS INSTRUMENTAL II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(116,4,'TPG-600','TECNOLOGÍA DEL PETROLEO Y GAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(117,4,'OPU-600','OPERACIONES UNITARIAS III',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(118,4,'TMG-600','TALLER DE MODALIDAD DE GRADUCIÓN',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(119,5,'SMA-100','SEGURIDAD OCUPACIONAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(120,5,'FAL-100','FISICA APLICADA Y LABORATORIO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(121,5,'DIC-100','DIBUJO TECNICO Y CAD',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(122,5,'MAM-100','MATEMATICA APLICADA A LA MECANICA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(123,5,'MEI-100','METROLOGIA INDUSTRIAL',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(124,5,'TTM-100','TECNOLOGIA Y TALLER MECANICO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(125,5,'ELE-200','ELECTROTECNIA Y ELECTRONICA BASICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(126,5,'DCM-200','DIBUJO MECANICO EN CAD',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(127,5,'SOL-200','SOLDADURA INDUSTRIAL I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(128,5,'TTM-200','TECNOLOGIA Y TALLER MECANICO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(129,5,'TTT-200','TRATAMIENTO TERMICO Y TECNOLOGIA DE LOS MATERIALES',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(130,5,'AEC-300','AUTOMATISMOS ELECTRICOS Y CONTROL',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(131,5,'REM-300','RESISTENCIA DE MATERIALES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(132,5,'TTM-300','TECNOLOGIA Y TALLER MECANICO III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(133,5,'SOL-300','SOLDADURA INDUSTRIAL II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(134,5,'MOC-300','MODELADO EN CAD',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(135,5,'INT-400','INGLES TECNICO',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(136,5,'EMM-400','ELEMENTOS Y MECANISMOS DE MAQUINAS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(137,5,'NEH-400','NEUMATICA E HIDRAULICA',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(138,5,'TTM-400','TECNOLIGIA Y TALLER MECANICO IV',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(139,5,'SOL-400','SOLDADURA INDUSTRIAL III',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(140,5,'CNC-400','CONTROL NUMERICO COMPUTARIZADO I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(141,5,'ENH-500','ELECTRONEUMATICA - ELECTROHIDRAULICA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(142,5,'CNC-500','CONTROL NUMERICO COMPUTARIZADO II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(143,5,'SOL-500','SOLDADURA INDUSTRIAL IV',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(144,5,'DIM-500','DISEÑO DE MAQUINAS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(145,5,'PPM-500','PROCESOS DE MANUFACTURA Y MATRICERIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(146,5,'EMP-500','EMPRENDIMIENTO PRODUCTIVO I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(147,5,'TMG-500','TALLER DE MODALIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(148,5,'AII-600','AUTOMATIZACION E INSTRUMENTACION INDUSTRIAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(149,5,'SMR-600','SISTEMAS MECATRONICOS Y ROBOTICA INDUSTRIAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(150,5,'MEI-600','MANTENIMIENTO DE EQUIPOS INDUSTRIALES',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(151,5,'ESM-600','ESTRUCTURAS METALICAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(152,5,'MCM-600','MANUFACTURA Y CONSTRUCCION DE MAQUINAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(153,5,'EMP-600','EMPRENDIMIENTO PRODUCTIVO II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(154,5,'TMG-600','TALLER DE MODALIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(155,6,'SOM-100','SEGURIDAD OCUPACIONAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(156,6,'MOG-100','MOTORES A GASOLINA I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(157,6,'ELA-100','ELECTRICIDAD AUTOMOTRIZ I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(158,6,'MAA-100','MATEMATICA AUTOMOTRIZ',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(159,6,'MEA-100','METROLOGIA AUTOMOTRIZ',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(160,6,'DTA-100','DIBUJO TECNICO AUTOMOTRIZ I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(161,6,'QUA-100','QUIMICA AUTOMOTRIZ',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(162,6,'INT-200','INGLES TECNICO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(163,6,'MOG-200','MOTORES A GASOLINA II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(164,6,'ELA-200','ELECTRICIDAD AUTOMOTRIZ II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(165,6,'CHS-200','CHAPERIA Y SOLDADURA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(166,6,'FIS-200','FISICA AUTOMOTRIZ',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(167,6,'DTA-200','DIBUJO TECNICO AUTOMOTRIZ II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(168,6,'MOG-300','MOTORES A GASOLINA III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(169,6,'ELA-300','ELECTRICIDAD AUTOMOTRIZ III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(170,6,'MOD-300','MOTORES DIESEL I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(171,6,'ETA-300','ELECTRONICA AUTOMOTRIZ I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(172,6,'TER-300','TERMODINAMICA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(173,6,'TRA-300','TRANSMISIONES I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(174,6,'MOG-400','MOTORES A GASOLINA IV',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(175,6,'IAG-400','INYECCION A GASOLINA I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(176,6,'MOD-400','MOTORES DIESEL II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(177,6,'ETA-400','ELECTRONICA AUTOMOTRIZ II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(178,6,'TRA-400','TRANSMISIONES II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(179,6,'EMP-400','EMPRENDIMIENTO PRODUCTIVO',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(180,6,'IED-500','INYECCION ELECTRONICA DIESEL I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(181,6,'IAG-500','INYECCION A GASOLINA II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(182,6,'LAD-500','LABORATORIO DIESEL I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(183,6,'ETA-500','ELECTRONICA AUTOMOTRIZ III',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(184,6,'NEU-500','NEUMATICA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(185,6,'TRA-500','TRANSMISIONES III',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(186,6,'TMG-500','TALLER DE MODALIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(187,6,'IED-600','INYECCION ELECTRONICA DIESEL II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(188,6,'DAU-600','DIAGNOSTICO DEL AUTOMOVIL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(189,6,'LAD-600','LABORATORIO DIESEL II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(190,6,'HID-600','HIDRAULICA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(191,6,'MAP-600','MAQUINARIA AGRICOLA PESADA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(192,6,'IAG-600','INYECCION A GASOLINA III',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(193,6,'TRA-600','TRANSMISIONES IV',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(194,6,'TMG-600','TALLER DE MODALIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(195,7,'SIM-100','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(196,7,'ALC-100','ALGEBRA Y CALCULO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(197,7,'ACC-100','ANALISIS DE CIRCUITOS DE CORRIENTE CONTINUA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(198,7,'FIS-100','FISICA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(199,7,'INC-100','INSTRUMENTOS Y COMPONENTES',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(200,7,'INE-100','INSTALACIONES ELECTRICAS',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(201,7,'SIC-100','SISTEMAS CAD',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(202,7,'SIM-200','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(203,7,'ACC-200','ANALISIS DE CIRCUITOS DE CORRIENTE ALTERNA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(204,7,'ELA-200','ELECTRONICA ANALOGICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(205,7,'ELD-200','ELECTRONICA DIGITAL',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(206,7,'ALE-200','ALGORITMOS Y ESTRUCTURAS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(207,7,'INT-200','INGLES TECNICO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(208,7,'LTA-300','LINEAS DE TRANSMISION Y ANTENAS',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(209,7,'MII-300','MAQUINAS E INSTALACIONES INDUSTRIALES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(210,7,'OAP-300','OPERACIONES Y APLICAIONES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(211,7,'SLP-300','SISTEMAS LOGICOS PROGRAMABLES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(212,7,'PRO-300','PROGRAMACION',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(213,7,'EMP-300','EMPRENDIMIENTO PRODUCTIVO',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(214,7,'SIT-400','SISTEMAS DE TELECOMUNICACIONES',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(215,7,'ELE-400','ELECTROACUSTICA',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(216,7,'ELI-400','ELECTRONICA INDUSTRIAL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(217,7,'MAE-400','MANTENIMIENTO DE EQUIPOS ELECTRONICOS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(218,7,'ARD-400','ARQUITECTURA Y REDES DE COMPUTADORAS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(219,7,'MIC-400','MICROCONTROLADORES',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(220,7,'SDC-500','SISTEMAS DE CONTROL',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(221,7,'AUP-500','AUTOMATAS PROGRAMABLES',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(222,7,'SIN-500','SISTEMAS NEUMATICOS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(223,7,'SIT-500','SISTEMAS DE TELEFONIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(224,7,'RGD-500','REDES Y GESTION DE DATOS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(225,7,'TMG-500','TALLER DE MODADLIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(226,7,'COD-600','CONTROL DIGITAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(227,7,'SIS-600','SISTEMAS SCADA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(228,7,'ROI-600','ROBOTICA INDUSTRIAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(229,7,'SEN-600','SISTEMAS ELECTRONEUMATICOS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(230,7,'FIO-600','FIBRA OPTICA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(231,7,'TMG-600','TALLER DE MODADLIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(232,8,'INT-100','INGLES TECNICO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(233,8,'MAT-100','MATEMATICA PARA LA CONSTRUCCION',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(234,8,'DIB-100','DIBUJO TECNICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(235,8,'FIS-100','FISICA PARA LA CONSTRUCCION',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(236,8,'SIM-100','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(237,8,'MAC-100','MATERIALES DE CONSTRUCCION',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(238,8,'INT-200','INGLES TECNICO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(239,8,'DIB-200','DIBUJO CONSTRUCTIVO ASISTIDO POR COMPUTADORA I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(240,8,'EIS-200','ESTRUCTURAS ISOSTATICAS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(241,8,'HID-200','HIDRAULICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(242,8,'MES-200','MECANICA DE SUELOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(243,8,'PCO-200','PROCESOS CONSTRUCTIVOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(244,8,'THO-300','TECNOLOGIA DEL HORMIGON',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(245,8,'TOP-300','TOPOGRAFIA I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(246,8,'DIB-300','DIBUJO CONSTRUCTIVO ASISTIDO POR COMPUTADORA II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(247,8,'RDM-300','RESISTENCIA DE MATERIALES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(248,8,'MES-300','MECANICA DE SUELOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(249,8,'PCO-300','PROCESOS CONSTRUCTIVOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(250,8,'OSA-400','OBRAS SANITARIAS I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(251,8,'TOP-400','TOPOGRAFIA II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(252,8,'MEC-400','MAQUINARIA Y EQUIPO DE CONSTRUCCION',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(253,8,'COP-400','COSTOS Y PRESUPUESTOS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(254,8,'HOA-400','HORMIGON ARMADO I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(255,8,'PCO-400','PROCESOS CONSTRUCTIVOS III',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(256,8,'OSA-500','OBRAS SANITARIAS II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(257,8,'OVI-500','OBRAS VIALES',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(258,8,'DAO-500','DIRECCION Y ADMINISTRACION DE OBRAS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(259,8,'HOA-500','HORMIGON ARMADO II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(260,8,'EMP-500','EMPRENDIMIENTO PRODUCTIVO I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(261,8,'TMG-500','TALLER DE MODALIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(262,8,'SEO-600','SEGUIMIENTO DE OBRAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(263,8,'IOC-600','INSTALACIONES ESPECIALES EN OBRAS CIVILES',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(264,8,'EMA-600','ESTRUCTURAS EN MADERA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(265,8,'ESM-600','ESTRUCTURAS METALICAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(266,8,'EMP-600','EMPRENDIMIENTO PRODUCTIVO II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(267,8,'TMG-600','TALLER DE MODALIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matriculas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estudiante_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  `periodo_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('ACTIVA','RETIRADA','CONCLUIDA') NOT NULL DEFAULT 'ACTIVA',
  `plan_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `estudiante_id` (`estudiante_id`,`carrera_id`,`periodo_id`),
  UNIQUE KEY `id` (`id`,`carrera_id`,`periodo_id`),
  KEY `carrera_id` (`carrera_id`),
  KEY `periodo_id` (`periodo_id`),
  KEY `plan_id` (`plan_id`,`carrera_id`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`),
  CONSTRAINT `matriculas_ibfk_3` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`),
  CONSTRAINT `matriculas_ibfk_4` FOREIGN KEY (`plan_id`, `carrera_id`) REFERENCES `planes_estudio` (`id`, `carrera_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (1,1,1,1,'2026-07-15','ACTIVA',8),(2,2,2,1,'2026-07-15','ACTIVA',2),(3,3,3,1,'2026-07-16','ACTIVA',3),(5,5,1,1,'2026-10-16','ACTIVA',8);
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modalidades_graduacion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modalidades_graduacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalidades_graduacion`
--

LOCK TABLES `modalidades_graduacion` WRITE;
/*!40000 ALTER TABLE `modalidades_graduacion` DISABLE KEYS */;
INSERT INTO `modalidades_graduacion` VALUES (2,'Examen de grado'),(6,'Excelencia académica'),(4,'Proyecto de emprendimiento productivo'),(1,'Proyecto de grado'),(3,'Proyecto sociocomunitario productivo'),(5,'Trabajo dirigido externo');
/*!40000 ALTER TABLE `modalidades_graduacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_demo_historicas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas_demo_historicas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inscripcion_id` int(10) unsigned NOT NULL,
  `evaluacion` varchar(80) NOT NULL,
  `nota` decimal(5,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inscripcion_id` (`inscripcion_id`,`evaluacion`),
  CONSTRAINT `notas_demo_historicas_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`nota` between 0 and 100)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_demo_historicas`
--

LOCK TABLES `notas_demo_historicas` WRITE;
/*!40000 ALTER TABLE `notas_demo_historicas` DISABLE KEYS */;
INSERT INTO `notas_demo_historicas` VALUES (1,1,'Primer parcial',78.00,'2026-09-01'),(2,2,'Primer parcial',85.00,'2026-09-02'),(3,3,'Primer parcial',90.00,'2026-09-01'),(4,4,'Primer parcial',72.00,'2026-09-01');
/*!40000 ALTER TABLE `notas_demo_historicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofertas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofertas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `materia_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  `periodo_id` int(10) unsigned NOT NULL,
  `docente_id` int(10) unsigned NOT NULL,
  `paralelo` varchar(10) NOT NULL,
  `turno` enum('MAÑANA','TARDE','NOCHE') NOT NULL,
  `cupo` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `materia_id` (`materia_id`,`periodo_id`,`paralelo`),
  UNIQUE KEY `id` (`id`,`carrera_id`,`periodo_id`),
  KEY `materia_id_2` (`materia_id`,`carrera_id`),
  KEY `periodo_id` (`periodo_id`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `ofertas_ibfk_1` FOREIGN KEY (`materia_id`, `carrera_id`) REFERENCES `materias` (`id`, `carrera_id`),
  CONSTRAINT `ofertas_ibfk_2` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`),
  CONSTRAINT `ofertas_ibfk_3` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertas`
--

LOCK TABLES `ofertas` WRITE;
/*!40000 ALTER TABLE `ofertas` DISABLE KEYS */;
INSERT INTO `ofertas` VALUES (1,2,1,1,1,'A','MAÑANA',30),(2,1,1,1,1,'A','MAÑANA',30),(3,24,2,1,2,'A','NOCHE',35),(4,48,3,1,3,'A','TARDE',25),(6,3,1,1,1,'Dfbc571','MAÑANA',10);
/*!40000 ALTER TABLE `ofertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cargo_id` int(10) unsigned NOT NULL,
  `recibo` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo` enum('EFECTIVO','TRANSFERENCIA','QR') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recibo` (`recibo`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`monto` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,1,'DEMO-001','2026-07-18',100.00,'EFECTIVO'),(2,2,'DEMO-002','2026-07-18',60.00,'QR'),(3,4,'DEMO-fbc571','2026-10-16',40.00,'QR');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pasantias`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pasantias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `tutor_id` int(10) unsigned DEFAULT NULL,
  `empresa` varchar(150) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `horas` smallint(5) unsigned DEFAULT NULL,
  `estado` enum('SOLICITADA','EN_CURSO','CONCLUIDA') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  KEY `tutor_id` (`tutor_id`),
  CONSTRAINT `pasantias_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `pasantias_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `docentes` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`fecha_fin` is null or `fecha_fin` >= `fecha_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pasantias`
--

LOCK TABLES `pasantias` WRITE;
/*!40000 ALTER TABLE `pasantias` DISABLE KEYS */;
INSERT INTO `pasantias` VALUES (1,5,1,'Empresa Ficticia Demo','2026-10-16',NULL,NULL,'SOLICITADA');
/*!40000 ALTER TABLE `pasantias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`fecha_fin` >= `fecha_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos`
--

LOCK TABLES `periodos` WRITE;
/*!40000 ALTER TABLE `periodos` DISABLE KEYS */;
INSERT INTO `periodos` VALUES (1,'DEMO-2026','2026-07-20','2026-12-04');
/*!40000 ALTER TABLE `periodos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_materias`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_materias` (
  `plan_id` int(10) unsigned NOT NULL,
  `materia_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`plan_id`,`materia_id`),
  KEY `plan_id` (`plan_id`,`carrera_id`),
  KEY `materia_id` (`materia_id`,`carrera_id`),
  CONSTRAINT `plan_materias_ibfk_1` FOREIGN KEY (`plan_id`, `carrera_id`) REFERENCES `planes_estudio` (`id`, `carrera_id`),
  CONSTRAINT `plan_materias_ibfk_2` FOREIGN KEY (`materia_id`, `carrera_id`) REFERENCES `materias` (`id`, `carrera_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_materias`
--

LOCK TABLES `plan_materias` WRITE;
/*!40000 ALTER TABLE `plan_materias` DISABLE KEYS */;
INSERT INTO `plan_materias` VALUES (1,232,8),(1,233,8),(1,234,8),(1,235,8),(1,236,8),(1,237,8),(1,238,8),(1,239,8),(1,240,8),(1,241,8),(1,242,8),(1,243,8),(1,244,8),(1,245,8),(1,246,8),(1,247,8),(1,248,8),(1,249,8),(1,250,8),(1,251,8),(1,252,8),(1,253,8),(1,254,8),(1,255,8),(1,256,8),(1,257,8),(1,258,8),(1,259,8),(1,260,8),(1,261,8),(1,262,8),(1,263,8),(1,264,8),(1,265,8),(1,266,8),(1,267,8),(2,24,2),(2,25,2),(2,26,2),(2,27,2),(2,28,2),(2,29,2),(2,30,2),(2,31,2),(2,32,2),(2,33,2),(2,34,2),(2,35,2),(2,36,2),(2,37,2),(2,38,2),(2,39,2),(2,40,2),(2,41,2),(2,42,2),(2,43,2),(2,44,2),(2,45,2),(2,46,2),(2,47,2),(3,48,3),(3,49,3),(3,50,3),(3,51,3),(3,52,3),(3,53,3),(3,54,3),(3,55,3),(3,56,3),(3,57,3),(3,58,3),(3,59,3),(3,60,3),(3,61,3),(3,62,3),(3,63,3),(3,64,3),(3,65,3),(3,66,3),(3,67,3),(3,68,3),(3,69,3),(3,70,3),(3,71,3),(3,72,3),(3,73,3),(3,74,3),(3,75,3),(3,76,3),(3,77,3),(3,78,3),(3,79,3),(3,80,3),(3,81,3),(3,82,3),(3,83,3),(3,84,3),(4,195,7),(4,196,7),(4,197,7),(4,198,7),(4,199,7),(4,200,7),(4,201,7),(4,202,7),(4,203,7),(4,204,7),(4,205,7),(4,206,7),(4,207,7),(4,208,7),(4,209,7),(4,210,7),(4,211,7),(4,212,7),(4,213,7),(4,214,7),(4,215,7),(4,216,7),(4,217,7),(4,218,7),(4,219,7),(4,220,7),(4,221,7),(4,222,7),(4,223,7),(4,224,7),(4,225,7),(4,226,7),(4,227,7),(4,228,7),(4,229,7),(4,230,7),(4,231,7),(5,155,6),(5,156,6),(5,157,6),(5,158,6),(5,159,6),(5,160,6),(5,161,6),(5,162,6),(5,163,6),(5,164,6),(5,165,6),(5,166,6),(5,167,6),(5,168,6),(5,169,6),(5,170,6),(5,171,6),(5,172,6),(5,173,6),(5,174,6),(5,175,6),(5,176,6),(5,177,6),(5,178,6),(5,179,6),(5,180,6),(5,181,6),(5,182,6),(5,183,6),(5,184,6),(5,185,6),(5,186,6),(5,187,6),(5,188,6),(5,189,6),(5,190,6),(5,191,6),(5,192,6),(5,193,6),(5,194,6),(6,119,5),(6,120,5),(6,121,5),(6,122,5),(6,123,5),(6,124,5),(6,125,5),(6,126,5),(6,127,5),(6,128,5),(6,129,5),(6,130,5),(6,131,5),(6,132,5),(6,133,5),(6,134,5),(6,135,5),(6,136,5),(6,137,5),(6,138,5),(6,139,5),(6,140,5),(6,141,5),(6,142,5),(6,143,5),(6,144,5),(6,145,5),(6,146,5),(6,147,5),(6,148,5),(6,149,5),(6,150,5),(6,151,5),(6,152,5),(6,153,5),(6,154,5),(7,85,4),(7,86,4),(7,87,4),(7,88,4),(7,89,4),(7,90,4),(7,91,4),(7,92,4),(7,93,4),(7,94,4),(7,95,4),(7,96,4),(7,97,4),(7,98,4),(7,99,4),(7,100,4),(7,101,4),(7,102,4),(7,103,4),(7,104,4),(7,105,4),(7,106,4),(7,107,4),(7,108,4),(7,109,4),(7,110,4),(7,111,4),(7,112,4),(7,113,4),(7,114,4),(7,115,4),(7,116,4),(7,117,4),(7,118,4),(8,1,1),(8,2,1),(8,3,1),(8,4,1),(8,5,1),(8,6,1),(8,7,1),(8,8,1),(8,9,1),(8,10,1),(8,11,1),(8,12,1),(8,13,1),(8,14,1),(8,15,1),(8,16,1),(8,17,1),(8,18,1),(8,19,1),(8,20,1),(8,21,1),(8,22,1),(8,23,1);
/*!40000 ALTER TABLE `plan_materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes_estudio`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planes_estudio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrera_id` int(10) unsigned NOT NULL,
  `denominacion` varchar(100) NOT NULL,
  `cohorte` varchar(30) NOT NULL,
  `regla_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`carrera_id`),
  UNIQUE KEY `carrera_id` (`carrera_id`,`denominacion`,`cohorte`),
  KEY `regla_id` (`regla_id`),
  CONSTRAINT `planes_estudio_ibfk_1` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`),
  CONSTRAINT `planes_estudio_ibfk_2` FOREIGN KEY (`regla_id`) REFERENCES `reglas_evaluacion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes_estudio`
--

LOCK TABLES `planes_estudio` WRITE;
/*!40000 ALTER TABLE `planes_estudio` DISABLE KEYS */;
INSERT INTO `planes_estudio` VALUES (1,8,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(2,2,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(3,3,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(4,7,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(5,6,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(6,5,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(7,4,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(8,1,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1);
/*!40000 ALTER TABLE `planes_estudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prerrequisitos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prerrequisitos` (
  `plan_id` int(10) unsigned NOT NULL,
  `materia_id` int(10) unsigned NOT NULL,
  `requerida_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`plan_id`,`materia_id`,`requerida_id`),
  KEY `plan_id` (`plan_id`,`requerida_id`),
  CONSTRAINT `prerrequisitos_ibfk_1` FOREIGN KEY (`plan_id`, `materia_id`) REFERENCES `plan_materias` (`plan_id`, `materia_id`),
  CONSTRAINT `prerrequisitos_ibfk_2` FOREIGN KEY (`plan_id`, `requerida_id`) REFERENCES `plan_materias` (`plan_id`, `materia_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`materia_id` <> `requerida_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prerrequisitos`
--

LOCK TABLES `prerrequisitos` WRITE;
/*!40000 ALTER TABLE `prerrequisitos` DISABLE KEYS */;
/*!40000 ALTER TABLE `prerrequisitos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyectos_graduacion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyectos_graduacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `modalidad_id` int(10) unsigned NOT NULL,
  `tutor_id` int(10) unsigned DEFAULT NULL,
  `titulo` varchar(250) NOT NULL,
  `estado` enum('PROPUESTO','EN_DESARROLLO','DEFENDIDO','APROBADO') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  KEY `modalidad_id` (`modalidad_id`),
  KEY `tutor_id` (`tutor_id`),
  CONSTRAINT `proyectos_graduacion_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `proyectos_graduacion_ibfk_2` FOREIGN KEY (`modalidad_id`) REFERENCES `modalidades_graduacion` (`id`),
  CONSTRAINT `proyectos_graduacion_ibfk_3` FOREIGN KEY (`tutor_id`) REFERENCES `docentes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyectos_graduacion`
--

LOCK TABLES `proyectos_graduacion` WRITE;
/*!40000 ALTER TABLE `proyectos_graduacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `proyectos_graduacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recuperaciones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recuperaciones` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `matricula_id` int(10) unsigned NOT NULL,
  `nota_prueba` decimal(5,2) NOT NULL CHECK (`nota_prueba` between 1 and 100),
  `nota_registrada` decimal(5,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`inscripcion_id`),
  KEY `matricula_id` (`matricula_id`),
  CONSTRAINT `recuperaciones_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `resultados_finales` (`inscripcion_id`),
  CONSTRAINT `recuperaciones_ibfk_2` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recuperaciones`
--

LOCK TABLES `recuperaciones` WRITE;
/*!40000 ALTER TABLE `recuperaciones` DISABLE KEYS */;
INSERT INTO `recuperaciones` VALUES (1,1,90.00,61.00,'2026-12-04'),(5,5,95.00,61.00,'2026-10-16');
/*!40000 ALTER TABLE `recuperaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER validar_recuperacion BEFORE INSERT ON recuperaciones FOR EACH ROW
BEGIN
 DECLARE v_matricula INT; DECLARE v_limite INT; DECLARE v_lock INT;
 SELECT i.matricula_id,IF(c.regimen='ANUAL',3,2) INTO v_matricula,v_limite
 FROM inscripciones i JOIN carreras c ON c.id=i.carrera_id WHERE i.id=NEW.inscripcion_id;
 
 SELECT id INTO v_lock FROM matriculas WHERE id=v_matricula FOR UPDATE;
 IF NEW.matricula_id<>v_matricula THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Matrícula incorrecta'; END IF;
 IF NOT EXISTS(SELECT 1 FROM resultados_finales WHERE inscripcion_id=NEW.inscripcion_id AND estado='REPROBADO' AND promedio>=40 AND promedio<61) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No cumple condiciones de recuperación'; END IF;
 IF (SELECT COUNT(*) FROM recuperaciones WHERE matricula_id=v_matricula)>=v_limite THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Supera el máximo de materias en recuperación'; END IF;
 SET NEW.nota_registrada=IF(NEW.nota_prueba>=61,61,NEW.nota_prueba);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER no_editar_recuperacion BEFORE UPDATE ON recuperaciones FOR EACH ROW
BEGIN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Recuperación cerrada: requiere rectificación administrativa'; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER no_borrar_recuperacion BEFORE DELETE ON recuperaciones FOR EACH ROW
BEGIN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Recuperación cerrada: requiere rectificación administrativa'; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reglas_evaluacion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reglas_evaluacion` (
  `id` int(10) unsigned NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `fuente` varchar(500) NOT NULL,
  `minimo` decimal(5,2) NOT NULL DEFAULT 1.00 CHECK (`minimo` = 1),
  `maximo` decimal(5,2) NOT NULL DEFAULT 100.00 CHECK (`maximo` = 100),
  `aprobacion` decimal(5,2) NOT NULL DEFAULT 61.00 CHECK (`aprobacion` = 61),
  `practica` decimal(4,3) NOT NULL DEFAULT 0.700 CHECK (`practica` = 0.700),
  `teoria` decimal(4,3) NOT NULL DEFAULT 0.300 CHECK (`teoria` = 0.300),
  `asistencia` decimal(5,2) NOT NULL DEFAULT 80.00 CHECK (`asistencia` = 80),
  `acceso_recuperacion` decimal(5,2) NOT NULL DEFAULT 40.00 CHECK (`acceso_recuperacion` = 40),
  `max_rec_anual` tinyint(4) NOT NULL DEFAULT 3 CHECK (`max_rec_anual` = 3),
  `max_rec_semestral` tinyint(4) NOT NULL DEFAULT 2 CHECK (`max_rec_semestral` = 2),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reglas_evaluacion`
--

LOCK TABLES `reglas_evaluacion` WRITE;
/*!40000 ALTER TABLE `reglas_evaluacion` DISABLE KEYS */;
INSERT INTO `reglas_evaluacion` VALUES (1,'R.M. 0189/2023, artículos 13–18','https://www.minedu.gob.bo/files/documentos-normativos/VESFP/2023/resoluciones/RM_N_0189.pdf',1.00,100.00,61.00,0.700,0.300,80.00,40.00,3,2);
/*!40000 ALTER TABLE `reglas_evaluacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultados_finales`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultados_finales` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `regla_id` int(10) unsigned NOT NULL,
  `promedio` decimal(8,5) NOT NULL,
  `porcentaje_asistencia` decimal(8,5) NOT NULL,
  `excepcion_documentada` tinyint(1) NOT NULL,
  `estado` enum('APROBADO','REPROBADO','REPROBADO_ASISTENCIA') NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`inscripcion_id`),
  KEY `regla_id` (`regla_id`),
  CONSTRAINT `resultados_finales_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`),
  CONSTRAINT `resultados_finales_ibfk_2` FOREIGN KEY (`regla_id`) REFERENCES `reglas_evaluacion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultados_finales`
--

LOCK TABLES `resultados_finales` WRITE;
/*!40000 ALTER TABLE `resultados_finales` DISABLE KEYS */;
INSERT INTO `resultados_finales` VALUES (1,1,53.00000,100.00000,0,'REPROBADO','2026-10-16 20:37:33'),(5,1,50.00000,80.00000,0,'REPROBADO','2026-10-16 20:47:56');
/*!40000 ALTER TABLE `resultados_finales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesiones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesiones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oferta_id` int(10) unsigned NOT NULL,
  `inicio` datetime NOT NULL,
  `fin` datetime NOT NULL,
  `estado` enum('PROGRAMADA','REALIZADA','CANCELADA') NOT NULL DEFAULT 'PROGRAMADA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`oferta_id`),
  UNIQUE KEY `oferta_id` (`oferta_id`,`inicio`),
  CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`fin` > `inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (1,1,'2026-07-20 08:00:00','2026-07-20 10:00:00','REALIZADA'),(2,6,'2026-10-16 08:00:00','2026-10-16 09:40:00','REALIZADA');
/*!40000 ALTER TABLE `sesiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_documento`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_documento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_documento`
--

LOCK TABLES `tipos_documento` WRITE;
/*!40000 ALTER TABLE `tipos_documento` DISABLE KEYS */;
INSERT INTO `tipos_documento` VALUES (5,'Boletín de calificación'),(6,'Carnet de estudiante'),(4,'Documento de tipo sanguíneo'),(2,'Fotocopia cédula de identidad'),(3,'Fotocopia certificado de nacimiento'),(1,'Fotocopia diploma de bachiller');
/*!40000 ALTER TABLE `tipos_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tramites`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tramites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `tipo` enum('CAMBIO_CARRERA','MATERIA_REPROBADA','PRORROGA_DIPLOMA','OTRO') NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('SOLICITADO','EN_REVISION','APROBADO','RECHAZADO') NOT NULL,
  `detalle` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  CONSTRAINT `tramites_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramites`
--

LOCK TABLES `tramites` WRITE;
/*!40000 ALTER TABLE `tramites` DISABLE KEYS */;
INSERT INTO `tramites` VALUES (1,1,'PRORROGA_DIPLOMA','2026-07-15','SOLICITADO','Ejemplo ficticio de trámite'),(2,5,'OTRO','2026-10-16','SOLICITADO','Solicitud ficticia de prueba');
/*!40000 ALTER TABLE `tramites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tribunales`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tribunales` (
  `defensa_id` int(10) unsigned NOT NULL,
  `docente_id` int(10) unsigned NOT NULL,
  `funcion` varchar(50) NOT NULL,
  PRIMARY KEY (`defensa_id`,`docente_id`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `tribunales_ibfk_1` FOREIGN KEY (`defensa_id`) REFERENCES `defensas` (`id`),
  CONSTRAINT `tribunales_ibfk_2` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tribunales`
--

LOCK TABLES `tribunales` WRITE;
/*!40000 ALTER TABLE `tribunales` DISABLE KEYS */;
/*!40000 ALTER TABLE `tribunales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_boletin_final`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_boletin_final` AS SELECT
 1 AS `inscripcion_id`,
  1 AS `registro`,
  1 AS `estudiante`,
  1 AS `materia`,
  1 AS `promedio`,
  1 AS `porcentaje_asistencia`,
  1 AS `excepcion_documentada`,
  1 AS `nota_final`,
  1 AS `resultado`,
  1 AS `nota_prueba_recuperacion` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_listado_academico`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_listado_academico` AS SELECT
 1 AS `registro`,
  1 AS `estudiante`,
  1 AS `carrera`,
  1 AS `periodo`,
  1 AS `materia`,
  1 AS `paralelo`,
  1 AS `turno`,
  1 AS `docente` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_saldos`
--

SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_saldos` AS SELECT
 1 AS `cargo_id`,
  1 AS `matricula_id`,
  1 AS `concepto`,
  1 AS `cargo`,
  1 AS `pagado`,
  1 AS `saldo` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'itsc_academico_v3'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cerrar_resultado`(IN p_inscripcion INT UNSIGNED)
BEGIN
 DECLARE v_oferta INT; DECLARE v_regla INT; DECLARE v_practica DECIMAL(10,5); DECLARE v_teoria DECIMAL(10,5);
 DECLARE v_total INT; DECLARE v_presentes INT; DECLARE v_excepcion BOOLEAN;
 DECLARE v_nota DECIMAL(8,5); DECLARE v_asistencia DECIMAL(8,5);
 IF NOT EXISTS(SELECT 1 FROM inscripciones WHERE id=p_inscripcion AND estado<>'RETIRADA') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inscripción inexistente o retirada'; END IF;
 SELECT i.oferta_id,p.regla_id INTO v_oferta,v_regla FROM inscripciones i
 JOIN matriculas m ON m.id=i.matricula_id JOIN planes_estudio p ON p.id=m.plan_id WHERE i.id=p_inscripcion;
 IF NOT EXISTS(SELECT 1 FROM cierres_oferta WHERE oferta_id=v_oferta) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Primero debe cerrarse la carga horaria de la oferta'; END IF;
 IF (SELECT COUNT(*) FROM (SELECT componente FROM evaluaciones WHERE oferta_id=v_oferta GROUP BY componente HAVING SUM(peso)=100) t)<>2 THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cada componente requiere pesos que sumen 100'; END IF;
 IF EXISTS(SELECT 1 FROM evaluaciones e LEFT JOIN calificaciones c ON c.evaluacion_id=e.id AND c.inscripcion_id=p_inscripcion WHERE e.oferta_id=v_oferta AND c.inscripcion_id IS NULL) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Faltan calificaciones'; END IF;
 SELECT SUM(CASE WHEN e.componente='PRACTICA' THEN c.nota*e.peso/100 ELSE 0 END),
 SUM(CASE WHEN e.componente='TEORIA' THEN c.nota*e.peso/100 ELSE 0 END)
 INTO v_practica,v_teoria FROM evaluaciones e JOIN calificaciones c ON c.evaluacion_id=e.id WHERE c.inscripcion_id=p_inscripcion;
 SELECT minutos_carga INTO v_total FROM cierres_oferta WHERE oferta_id=v_oferta;
 IF (SELECT COALESCE(SUM(TIMESTAMPDIFF(MINUTE,inicio,fin)),0) FROM sesiones WHERE oferta_id=v_oferta AND estado='REALIZADA')<>v_total
 OR EXISTS(SELECT 1 FROM sesiones WHERE oferta_id=v_oferta AND estado='PROGRAMADA') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Sesiones realizadas deben completar la carga y no quedar pendientes'; END IF;
 IF EXISTS(SELECT 1 FROM sesiones s LEFT JOIN asistencias_sesion a ON a.sesion_id=s.id AND a.inscripcion_id=p_inscripcion
 WHERE s.oferta_id=v_oferta AND s.estado='REALIZADA' AND a.inscripcion_id IS NULL) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Faltan registros de asistencia'; END IF;
 SELECT COALESCE(SUM(a.minutos_presentes),0) INTO v_presentes FROM asistencias_sesion a JOIN sesiones s ON s.id=a.sesion_id
 WHERE a.inscripcion_id=p_inscripcion AND s.estado='REALIZADA';
 SET v_asistencia=100.0*v_presentes/v_total;
 SET v_excepcion=EXISTS(SELECT 1 FROM excepciones_asistencia WHERE inscripcion_id=p_inscripcion);
 SELECT v_practica*practica+v_teoria*teoria INTO v_nota FROM reglas_evaluacion WHERE id=v_regla;
 INSERT INTO resultados_finales(inscripcion_id,regla_id,promedio,porcentaje_asistencia,excepcion_documentada,estado)
 VALUES(p_inscripcion,v_regla,v_nota,v_asistencia,v_excepcion,
 CASE WHEN v_asistencia<80 AND NOT v_excepcion THEN 'REPROBADO_ASISTENCIA' WHEN v_nota>=61 THEN 'APROBADO' ELSE 'REPROBADO' END);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `itsc_academico_v3`
--

USE `itsc_academico_v3`;

--
-- Final view structure for view `v_boletin_final`
--

/*!50001 DROP VIEW IF EXISTS `v_boletin_final`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_boletin_final` AS select `i`.`id` AS `inscripcion_id`,`e`.`registro` AS `registro`,concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `estudiante`,`ma`.`nombre` AS `materia`,`r`.`promedio` AS `promedio`,`r`.`porcentaje_asistencia` AS `porcentaje_asistencia`,`r`.`excepcion_documentada` AS `excepcion_documentada`,case when `re`.`nota_prueba` >= 61 then 61 else `r`.`promedio` end AS `nota_final`,case when `re`.`nota_prueba` >= 61 then 'APROBADO_RECUPERACION' else `r`.`estado` end AS `resultado`,`re`.`nota_prueba` AS `nota_prueba_recuperacion` from ((((((`resultados_finales` `r` join `inscripciones` `i` on(`i`.`id` = `r`.`inscripcion_id`)) join `matriculas` `m` on(`m`.`id` = `i`.`matricula_id`)) join `estudiantes` `e` on(`e`.`id` = `m`.`estudiante_id`)) join `ofertas` `o` on(`o`.`id` = `i`.`oferta_id`)) join `materias` `ma` on(`ma`.`id` = `o`.`materia_id`)) left join `recuperaciones` `re` on(`re`.`inscripcion_id` = `i`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_listado_academico`
--

/*!50001 DROP VIEW IF EXISTS `v_listado_academico`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_listado_academico` AS select `e`.`registro` AS `registro`,concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `estudiante`,`c`.`nombre` AS `carrera`,`p`.`nombre` AS `periodo`,`m`.`nombre` AS `materia`,`o`.`paralelo` AS `paralelo`,`o`.`turno` AS `turno`,concat(`d`.`nombres`,' ',`d`.`apellidos`) AS `docente` from (((((((`inscripciones` `i` join `matriculas` `mt` on(`mt`.`id` = `i`.`matricula_id`)) join `estudiantes` `e` on(`e`.`id` = `mt`.`estudiante_id`)) join `carreras` `c` on(`c`.`id` = `i`.`carrera_id`)) join `periodos` `p` on(`p`.`id` = `i`.`periodo_id`)) join `ofertas` `o` on(`o`.`id` = `i`.`oferta_id`)) join `materias` `m` on(`m`.`id` = `o`.`materia_id`)) join `docentes` `d` on(`d`.`id` = `o`.`docente_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_saldos`
--

/*!50001 DROP VIEW IF EXISTS `v_saldos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_saldos` AS select `c`.`id` AS `cargo_id`,`c`.`matricula_id` AS `matricula_id`,`c`.`concepto` AS `concepto`,`c`.`monto` AS `cargo`,coalesce(sum(`p`.`monto`),0) AS `pagado`,`c`.`monto` - coalesce(sum(`p`.`monto`),0) AS `saldo` from (`cargos` `c` left join `pagos` `p` on(`p`.`cargo_id` = `c`.`id`)) group by `c`.`id`,`c`.`matricula_id`,`c`.`concepto`,`c`.`monto` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-16 17:43:12
