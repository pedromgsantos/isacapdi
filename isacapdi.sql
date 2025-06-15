/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.6.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: isacapdi
-- ------------------------------------------------------
-- Server version	11.6.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add user',7,'add_user'),
(26,'Can change user',7,'change_user'),
(27,'Can delete user',7,'delete_user'),
(28,'Can view user',7,'view_user'),
(29,'Can add comentarios',8,'add_comentarios'),
(30,'Can change comentarios',8,'change_comentarios'),
(31,'Can delete comentarios',8,'delete_comentarios'),
(32,'Can view comentarios',8,'view_comentarios'),
(33,'Can add contactos',9,'add_contactos'),
(34,'Can change contactos',9,'change_contactos'),
(35,'Can delete contactos',9,'delete_contactos'),
(36,'Can view contactos',9,'view_contactos'),
(37,'Can add eventos',10,'add_eventos'),
(38,'Can change eventos',10,'change_eventos'),
(39,'Can delete eventos',10,'delete_eventos'),
(40,'Can view eventos',10,'view_eventos'),
(41,'Can add newsletter',11,'add_newsletter'),
(42,'Can change newsletter',11,'change_newsletter'),
(43,'Can delete newsletter',11,'delete_newsletter'),
(44,'Can view newsletter',11,'view_newsletter'),
(45,'Can add Not√≠cia',12,'add_newsarticle'),
(46,'Can change Not√≠cia',12,'change_newsarticle'),
(47,'Can delete Not√≠cia',12,'delete_newsarticle'),
(48,'Can view Not√≠cia',12,'view_newsarticle'),
(49,'Can add django job',13,'add_djangojob'),
(50,'Can change django job',13,'change_djangojob'),
(51,'Can delete django job',13,'delete_djangojob'),
(52,'Can view django job',13,'view_djangojob'),
(53,'Can add django job execution',14,'add_djangojobexecution'),
(54,'Can change django job execution',14,'change_djangojobexecution'),
(55,'Can delete django job execution',14,'delete_djangojobexecution'),
(56,'Can view django job execution',14,'view_djangojobexecution'),
(57,'Can add Membro',15,'add_membro'),
(58,'Can change Membro',15,'change_membro'),
(59,'Can delete Membro',15,'delete_membro'),
(60,'Can view Membro',15,'view_membro'),
(61,'Can add certificate template',16,'add_certificatetemplate'),
(62,'Can change certificate template',16,'change_certificatetemplate'),
(63,'Can delete certificate template',16,'delete_certificatetemplate'),
(64,'Can view certificate template',16,'view_certificatetemplate'),
(65,'Can add certificate issued',17,'add_certificateissued'),
(66,'Can change certificate issued',17,'change_certificateissued'),
(67,'Can delete certificate issued',17,'delete_certificateissued'),
(68,'Can view certificate issued',17,'view_certificateissued'),
(69,'Can add reminder',18,'add_reminder'),
(70,'Can change reminder',18,'change_reminder'),
(71,'Can delete reminder',18,'delete_reminder'),
(72,'Can view reminder',18,'view_reminder'),
(73,'Can add static device',19,'add_staticdevice'),
(74,'Can change static device',19,'change_staticdevice'),
(75,'Can delete static device',19,'delete_staticdevice'),
(76,'Can view static device',19,'view_staticdevice'),
(77,'Can add static token',20,'add_statictoken'),
(78,'Can change static token',20,'change_statictoken'),
(79,'Can delete static token',20,'delete_statictoken'),
(80,'Can view static token',20,'view_statictoken'),
(81,'Can add TOTP device',21,'add_totpdevice'),
(82,'Can change TOTP device',21,'change_totpdevice'),
(83,'Can delete TOTP device',21,'delete_totpdevice'),
(84,'Can view TOTP device',21,'view_totpdevice'),
(85,'Can add site settings',22,'add_sitesettings'),
(86,'Can change site settings',22,'change_sitesettings'),
(87,'Can delete site settings',22,'delete_sitesettings'),
(88,'Can view site settings',22,'view_sitesettings'),
(89,'Can add user preferences',23,'add_userpreferences'),
(90,'Can change user preferences',23,'change_userpreferences'),
(91,'Can delete user preferences',23,'delete_userpreferences'),
(92,'Can view user preferences',23,'view_userpreferences'),
(93,'Can add static device',24,'add_staticdevice'),
(94,'Can change static device',24,'change_staticdevice'),
(95,'Can delete static device',24,'delete_staticdevice'),
(96,'Can view static device',24,'view_staticdevice'),
(97,'Can add static token',25,'add_statictoken'),
(98,'Can change static token',25,'change_statictoken'),
(99,'Can delete static token',25,'delete_statictoken'),
(100,'Can view static token',25,'view_statictoken');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$870000$UQU8dRV2FKQaipJDLN5Dxg$HFhjySJUlikV+LqKCNFPdRUobWDgzTBXRf8bHviUf9c=','2025-06-15 19:56:43.583874',1,'pedro','Pedro','Santos','ppedro.ssantos21@gmail.com',1,1,'2025-02-13 15:20:52.000000'),
(2,'pbkdf2_sha256$870000$71uFQr8CUrMMXl4aA7YEku$76saiPJQhDCqTHVKYaJMiDwYp7Hqy/F3KmUm0BjdCTM=',NULL,0,'Henrique','','','',0,1,'2025-03-06 15:47:01.000000'),
(3,'pbkdf2_sha256$870000$l7QxvTYebw2rGPqGaXM0gv$NxbaSEY1CeaOTAZ7TmxQ71tbR9maSOG2MyQgDcqtsHI=','2025-06-06 23:14:07.345383',0,'carolina','','','',0,1,'2025-05-31 11:11:57.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comentarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `mensagem` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `evento_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comentarios_evento_id_fk` (`evento_id`),
  CONSTRAINT `comentarios_evento_id_fk` FOREIGN KEY (`evento_id`) REFERENCES `eventos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES
(3,'ppedro.ssantos21@gmail.comp','pedro123','2025-05-16 13:22:02.041020',24),
(4,'ppedro.ssantos21@gmail.com','oi?','2025-05-31 11:57:14.777872',25);
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos`
--

DROP TABLE IF EXISTS `contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `assunto` varchar(100) NOT NULL,
  `mensagem` longtext NOT NULL,
  `ano` varchar(20) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `curso` varchar(100) DEFAULT NULL,
  `data_envio` datetime(6) NOT NULL,
  `lido` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
INSERT INTO `contactos` VALUES
(9,'Pedro Santos','ppedro.ssantos21@gmail.com','Ser Membro ISACA','Queria ser membro','1.¬∫ Ano','Licenciatura','Marketing e Neg√≥cios Internacionais','2025-05-31 11:54:57.865084',1),
(13,'Jo√£o da Rede','jrede@example.com','Certificados','Qual o melhor certificado para quem gosta de ciberseguran√ßa?',NULL,NULL,NULL,'2025-06-15 19:34:06.161085',0),
(14,'Miguel Azevedo','mazevedo@example.com','Outro','O que posso fazer se n√£o for aluno do ISCAC?',NULL,NULL,NULL,'2025-06-15 19:35:01.029833',0),
(15,'Pedro Afonso','pafonso@example.com','Ser Membro ISACA','Quero entrar por favor','1.¬∫ Ano','Mestrado','Sistemas de Informa√ß√£o de Gest√£o','2025-06-15 19:35:37.106322',0);
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_certificateissued`
--

DROP TABLE IF EXISTS `dashboard_certificateissued`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_certificateissued` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `participant_name` varchar(255) NOT NULL,
  `participant_email` varchar(254) NOT NULL,
  `certificate_file` varchar(100) NOT NULL,
  `issued_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dashboard_certificateiss_event_id_participant_nam_545a20e2_uniq` (`event_id`,`participant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_certificateissued`
--

LOCK TABLES `dashboard_certificateissued` WRITE;
/*!40000 ALTER TABLE `dashboard_certificateissued` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_certificateissued` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_certificatetemplate`
--

DROP TABLE IF EXISTS `dashboard_certificatetemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_certificatetemplate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `template_image` varchar(100) NOT NULL,
  `font_size` int(10) unsigned NOT NULL CHECK (`font_size` >= 0),
  `name_x` int(10) unsigned NOT NULL CHECK (`name_x` >= 0),
  `name_y` int(10) unsigned NOT NULL CHECK (`name_y` >= 0),
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_certificatetemplate`
--

LOCK TABLES `dashboard_certificatetemplate` WRITE;
/*!40000 ALTER TABLE `dashboard_certificatetemplate` DISABLE KEYS */;
INSERT INTO `dashboard_certificatetemplate` VALUES
(1,25,'certificates/templates/Certificado_De_Participa√ß√£o__2.png',100,1004,707,'2025-06-15 00:24:47.154933');
/*!40000 ALTER TABLE `dashboard_certificatetemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_membro`
--

DROP TABLE IF EXISTS `dashboard_membro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_membro` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `date_of_birth` date NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `study_cycle` varchar(100) NOT NULL,
  `course` varchar(255) NOT NULL,
  `year` int(10) unsigned NOT NULL CHECK (`year` >= 0),
  `interests` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `status` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_membro`
--

LOCK TABLES `dashboard_membro` WRITE;
/*!40000 ALTER TABLE `dashboard_membro` DISABLE KEYS */;
INSERT INTO `dashboard_membro` VALUES
(35,'Ana Silva','ana.silva@example.com','1998-04-12','351912345678','Licenciatura','Engenharia Inform√°tica',3,'Ciberseguran√ßa; Auditoria','2025-05-27 14:24:38.417686','2025-05-27 14:36:41.652010','atual'),
(36,'Bruno Costa','bruno.costa@example.com','1997-09-03','351913456789','Mestrado','Engenharia de Redes',2,'Redes; Cloud','2025-05-27 14:24:38.422694','2025-05-27 14:36:41.660487','atual'),
(37,'Carla Ferreira','carla.ferreira@example.com','1996-12-22','351914567890','Licenciatura','Engenharia Inform√°tica',4,'DevOps','2025-05-27 14:24:38.427048','2025-05-27 14:36:41.665326','atual'),
(38,'Daniel Lopes','daniel.lopes@example.com','1995-07-15','351915678901','Mestrado','Ciberseguran√ßa',1,'Pentesting','2025-05-27 14:24:38.432013','2025-05-27 14:36:41.669837','ex'),
(39,'Eva Martins','eva.martins@example.com','1994-02-28','351916789012','Licenciatura','Engenharia de Software',5,'Gest√£o de Projetos','2025-05-27 14:24:38.436958','2025-05-27 14:36:41.674134','ex');
/*!40000 ALTER TABLE `dashboard_membro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_newsarticle`
--

DROP TABLE IF EXISTS `dashboard_newsarticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_newsarticle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `url` varchar(200) NOT NULL,
  `summary` longtext NOT NULL,
  `published` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  KEY `dashboard_n_publish_5e8710_idx` (`published` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_newsarticle`
--

LOCK TABLES `dashboard_newsarticle` WRITE;
/*!40000 ALTER TABLE `dashboard_newsarticle` DISABLE KEYS */;
INSERT INTO `dashboard_newsarticle` VALUES
(1,'IT/OT Convergence: An Era of Interconnected Risk and Reward','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/an-era-of-interconnected-risk-and-reward','Successful IT/OT convergence comes down to aligning three distinct paradigms: IT Operations, OT Operations and Cyber Operations.','2025-05-15 00:00:00.000000','2025-05-16 16:42:02.417608',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/deidre-diamond_blog.png'),
(2,'Ethics, Accountability, and the Pursuit of Responsible AI','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/ethics-accountability-and-the-pursuit-of-responsible-ai','Addressing accountability in AI deployment is essential to safeguarding integrity and societal well-being. This will require increased transparency within explainable AI and strengthened ethical governance.','2025-06-15 19:28:31.081111','2025-05-16 16:42:02.422078',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_ethics-accountability.png'),
(3,'Securing Desktops and Data from Ransomware Attacks','https://www.isaca.org/resources/news-and-trends/isaca-podcast-library/securing-desktops-and-data-from-ransomware-attacks','Ransomware remains one of the most formidable cybersecurity threats facing organizations worldwide.','2025-05-16 00:00:00.000000','2025-05-16 16:42:02.425374',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/videos/podcasts/netwirix-podcast_550.png'),
(4,'Seven Strategies Business Leaders Can Adopt to Protect Operational Technologies and Critical Infrastructure Against Sophisticated Cyber Threats','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/seven-strategies-to-protect-against-sophisticated-cyber-threats','Tailored strategies to protect critical assets are needed at a time when the attack surface is expanding, putting critical infrastructure at heightened risk.','2025-05-13 00:00:00.000000','2025-05-16 16:42:02.428578',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/ope-ajibola_blog.png'),
(5,'Vendor Risk Assessments: Do Organizations Still Need Them?','https://www.isaca.org/resources/news-and-trends/industry-news/2025/vendor-risk-assessments-do-organizations-still-need-them','While it is acceptable and commonplace to have work completed by another vendor based on mutually agreed contracts, the overall management of related risk is a pertinent point of attention.','2025-05-12 00:00:00.000000','2025-05-16 16:42:02.431679',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/vj-srinivas.png'),
(6,'Mindfully Befriending Your Certification Exam-Day Anxiety','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/mindfully-befriending-your-certification-exam-day-anxiety','Certification exam day can be stressful for exam-takers, but a mindful approach can go a long way toward constructively dealing with the nerves and improving performance.','2025-05-09 00:00:00.000000','2025-05-16 16:42:02.435166',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/natasha-barnes_blog.png'),
(7,'Six Steps for Third-Party AI Risk Management','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/six-steps-for-third-party-ai-risk-management','ISACA members Mary Carmichael and Dooshima Dabo\'Adzuana shared their insights in a session on third-party AI risk at RSA Conference 2025.','2025-05-08 00:00:00.000000','2025-05-16 16:42:02.439271',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/mary-carmichael_dooshima-dapo-oyewole_blog.png'),
(8,'The Zero-ETL Paradigm: Transforming Enterprise Data Integration in Real Time','https://www.isaca.org/resources/news-and-trends/industry-news/2025/the-zero-etl-paradigm-transforming-enterprise-data-integration-in-real-time','Zero-ETL offers direct data movement capabilities and advanced cloud technologies and allows for the leveraging of modern architectural patterns to enable real-time data access while significantly reducing operational complexity and costs.','2025-05-08 00:00:00.000000','2025-05-16 16:42:02.442846',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/shamnad-shaffi.png'),
(10,'Fortifying Digital Defenses: The Imperative of a Unified Cybersecurity Platform','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/the-imperative-of-a-unified-cybersecurity-platform','A data-driven and cost-effective strategy‚Äîcentered on governance, technology, and human expertise‚Äîis the approach organizations need to improve their cybersecurity posture and resilience.','2025-05-06 00:00:00.000000','2025-05-16 16:42:02.451610',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/welland-chu_blog.png'),
(11,'ISACA Research: Quantum Computing Preparedness Lagging','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-9/quantum-computing-preparedness-lagging','Quantum computing advancements pose a massive risk to cybersecurity and business stability, but many enterprises are not yet responding accordingly, according to new research from ISACA‚Äôs global Quantum Computing Pulse Poll.','2025-05-05 00:00:00.000000','2025-05-16 16:42:02.455242',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250505-newsletter-article.png'),
(12,'The Perfect Recipe for the Homogenius Technologicus: Next-Gen Auditors','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-9/the-perfect-recipe-for-the-homogenius-technologicus-next-gen-auditors','By combining curiosity, expertise and collaboration, we can prepare auditors who are not only skilled but also inspired to drive transformative change in their organizations.','2025-05-05 00:00:00.000000','2025-05-16 16:42:02.459688',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/chidambaram-narayanan_newsletter-article.png'),
(13,'The 2025 Software Supply Chain Security Report: Threats Growing and Evolving','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/the-2025-software-supply-chain-security-report','The threat landscape facing software today is changing fast! RL‚Äôs new research report explores those changes and shares key learnings and action items.','2025-05-05 00:00:00.000000','2025-05-16 16:42:02.463391',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/carolynn-van-arsdale_blog.png'),
(14,'ISACA 2024 Annual Report Showcases Future Focus','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isaca-2024-annual-report-showcases-future-focus','The 2024 ISACA Annual Report provides insight into how ISACA is working to future-proof members\' careers in a time of volatility and innovation across the digital trust fields.','2025-05-02 00:00:00.000000','2025-05-16 16:42:02.467240',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/why-isaca/annual-report/2024-annual-report_550.png'),
(15,'Protecting Kubernetes Clusters and Workloads at Scale','https://www.isaca.org/resources/news-and-trends/industry-news/2025/protecting-kubernetes-clusters-and-workloads-at-scale','As organizations increasingly adopt Kubernetes for its scalability and flexibility, it is imperative to prioritize the security of both Kubernetes clusters and workloads.','2025-05-01 00:00:00.000000','2025-05-16 16:42:02.471237',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/nivathan-somasundharam.png'),
(16,'Information Security Matters: Artificial Intelligence‚ÄîEthics and Security','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/artificial-intelligence-ethics-and-security','Any information gained by AI should be managed so that only those who are authorized to use it may do so. The use of AI systems should be monitored to ensure that it is not being abused.','2025-06-15 19:28:31.106161','2025-05-16 16:42:02.475135',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_ai-ethics.png'),
(17,'The Digital Trust Imperative: Building Trust Through Transparency‚ÄîAddressing Digital Exhaust','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/building-trust-through-transparency','Organizations have an imperative to share what data is collected and how it is going to be used. Their choices in using said data must bring value back to the customer.','2025-06-15 19:28:31.108517','2025-05-16 16:42:02.479033',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_building-trust.png'),
(18,'Privacy in Practice: Rules for Thee But Not for Me','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/rules-for-thee-but-not-for-me','The removal of end-to-end encryption in the United Kingdom is problematic. Additionally, governments appear to have conflicting attitudes toward privacy, which ultimately can lead to the erosion of individuals‚Äô right to privacy.','2025-06-15 19:28:31.111297','2025-05-16 16:42:02.482784',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_rules-for-thee.png'),
(19,'AI‚Äôs Evolving Impact on the IT Risk Landscape','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/ais-evolving-impact-on-the-it-risk-landscape','The impact of AI will be systemic. Accordingly, significant changes to the way professionals approach risk management for AI are in order.','2025-06-15 19:28:31.113656','2025-05-16 16:42:02.486165',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_ai-evolving.png'),
(20,'Rethinking ESG: Balancing Profit and Purpose','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/rethinking-esg','There is a need to manage the tension created by the innovation‚Äìintegrity dilemma in the interests of sustainable outcomes for both people and planet.','2025-06-15 19:28:31.115930','2025-05-16 16:42:02.489151',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_rethinking-esg.png'),
(21,'The Power of Accountability in AI Governance','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/the-power-of-accountability-in-ai-governance','Establishing AI accountability mechanisms can be straightforward, especially when leveraging governance frameworks that are already available.','2025-06-15 19:28:31.118305','2025-05-16 16:42:02.492037',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_the-power.png'),
(22,'Examining the Ethics of the Digital Afterlife Industry','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/examining-the-ethics-of-the-digital-afterlife-industry','The digital afterlife is a fast-developing area of innovation. It engages sensitive matters in the realm of ethics and emerging technologies.','2025-06-15 19:28:31.120796','2025-05-16 16:42:02.494897',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_examining-the-ethics.png'),
(26,'A Practical Approach to ESA Implementation at Small and Medium Enterprises','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/a-practical-approach-to-esa-implementation-at-small-and-medium-enterprises','SMEs can establish an enterprise security architecture by taking a step-by-step approach emphasizing practical strategies.','2025-06-15 19:28:31.130930','2025-05-16 16:42:02.507091',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_a-practical-approach.png'),
(28,'Elevating ISACA\'s Impact: Building a High-Performing Board for the Future','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/elevating-isacas-impact-building-a-high-performing-board-for-the-future','ISACA Board Director Asaf Weisberg addresses the Board\'s composition and varied backgrounds in this installment of Notes from the Boardroom.','2025-04-30 00:00:00.000000','2025-05-16 16:42:02.512923',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/asaf-weisberg_blog.png'),
(29,'No More Excuses for Procrastinating on Quantum Preparation','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/no-more-excuses-for-procrastinating-on-quantum-preparation','We have an urgency problem when it comes to quantum computing that is rivaling even the underlying technology challenge.','2025-04-28 00:00:00.000000','2025-05-16 16:42:02.516533',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/rob-clyde-blog.png'),
(30,'Preparing Our Stakeholders to Navigate Quantum Computing','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/preparing-our-stakeholders-to-navigate-quantum-computing','Within the cybersecurity space, quantum computing has often been linked to doomsday scenarios such as the cracking of RSA.','2025-04-27 23:00:00.000000','2025-05-16 16:42:02.519527',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/donavan-cheah-blog_1.png'),
(31,'Post-Quantum Cryptography: A Call to Action','https://www.isaca.org/resources/news-and-trends/industry-news/2025/post-quantum-cryptography-a-call-to-action','While the world has been laser-focused on artificial intelligence (AI), major advancements are occurring in quantum computing.','2025-04-27 23:00:00.000000','2025-05-16 16:42:02.522419',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/collin-beder.png'),
(32,'Strategic CIO Responses to Today‚Äôs Leadership Trends','https://www.isaca.org/resources/news-and-trends/industry-news/2025/strategic-cio-responses-to-todays-leadership-trends','The strategic chief information officer (CIO) must keep an eye not only on the evolving technology landscape, but also on evolving leadership and governance trends and their inevitable dilemmas, as these factors shape IT strategy and influence the way IT productively enables enterprise value creation.','2025-04-24 23:00:00.000000','2025-05-16 16:42:02.526692',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/digital-trust/state-of-digital-trust/guy-pearce_550x550.png'),
(33,'Lessons from the CCOA: Failing Forward as a Cybersecurity Leader','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/lessons-from-the-ccoa-failing-forward-as-a-cybersecurity-leader','A failed attempt at the CCOA exam provided important lessons learned and deepened my commitment to earning ISACA\'s new cybersecurity credential.','2025-04-23 23:00:00.000000','2025-05-16 16:42:02.529677',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/ravi-ragoonanan_blog.png'),
(35,'Adaptive Access Control: Navigating Cybersecurity in the Era of AI and Zero Trust','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/adaptive-access-control-navigating-cybersecurity-in-the-era-of-ai-and-zero-trust','Adaptive Access Control, an AI-driven security approach, gives organizations a better opportunity to counteract the modern, sophisticated threat landscape.','2025-04-21 23:00:00.000000','2025-05-16 16:42:02.536637',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/ola-akinsuli_blog.png'),
(36,'Proven Strategies to Uncover AI Risks and Strengthen Audits','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-8/proven-strategies-to-uncover-ai-risks-and-strengthen-audits','Artificial Intelligence (AI) often conjures images of futuristic concepts. Yet, it has propelled today\'s business innovation.','2025-04-20 23:00:00.000000','2025-05-16 16:42:02.540213',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/maman-ibrahim_newsletter-article.png'),
(37,'Volunteer Appreciation Week: Get Involved with ISACA','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-8/volunteer-appreciation-week-get-involved-with-isaca','This Volunteer Appreciation Week (20-26 April) we‚Äôre celebrating our volunteers around the world.','2025-04-20 23:00:00.000000','2025-05-16 16:42:02.543666',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250421-newsletter-article.png'),
(38,'ISACA Career Catalyst Stories: Freeman Ng, Principal Consultant at iSystems Security Limited','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isaca-career-catalyst-stories-freeman-ng-principal-consultant-at-isystems-security-limited','A major career change meant that Freeman Ng had to prove himself all over again, and turning to ISACA played a big part in his next phase.','2025-04-20 23:00:00.000000','2025-05-16 16:42:02.547444',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/freeman-ng_blog.png'),
(39,'ISACA‚Äôs Growing Influence as a Resource for Governments','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isacas-growing-influence-as-a-resource-for-governments','ISACA\'s growing policy influence with global governments will create healthier digital trust disciplines and expand opportunities for ISACA members.','2025-04-17 23:00:00.000000','2025-05-16 16:42:02.550383',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/massimo-migliuolo_blog.png'),
(40,'Debunking Cybersecurity Myths in 2025','https://www.isaca.org/resources/news-and-trends/industry-news/2025/debunking-cybersecurity-myths-in-2025','ITis prudent to examine and debunk some of the most overt cybersecurity misconceptions and exaggerations circulating today and provide accurate information. This empowers organizations to reinforce their infrastructure and connected assets and technologies','2025-04-17 23:00:00.000000','2025-05-16 16:42:02.553663',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/chester-avey.png'),
(41,'Welcome to the IT Audit Awards: Ctrl + Alt + Defend Night','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/welcome-to-the-it-audit-awards','From Phantom Access to the Longest Audit Report and beyond, these IT Audit Awards come in many categories that might not be as much of a joke as we\'d like to think.','2025-04-16 23:00:00.000000','2025-05-16 16:42:02.556608',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/chidambaram-narayanan-blog.png'),
(42,'Practical Strategies to Overcome Cyber Security Compliance Standards Fatigue','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/practical-strategies-to-overcome-cyber-security-compliance-standards-fatigue','Elizabeth Kinuthia shares three practical strategies cyber teams can deploy to overcome compliance fatigue.','2025-04-15 23:00:00.000000','2025-05-16 16:42:02.559815',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/liz-kinuthia_blog.png'),
(43,'The Governance Game of Chess: Mapping ISO/IEC 27001:2022 to COBIT¬Æ','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/the-governance-game-of-chess-mapping-isoiec-27001-2022-to-cobit','teste','2025-05-16 19:12:00.000000','2025-05-16 16:42:02.563006',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_governance-game.png'),
(44,'An Overnight Wakeup Call: Coordinating Responses to Major Cyber Attacks','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/an-overnight-wakeup-call-coordinating-responses-to-major-cyber-attacks','Gamification can be an effective approach to trust-building that will allow diverse stakeholders to be better prepared to deal with stressful and high-stakes cybersecurity incidents.','2025-04-14 00:00:00.000000','2025-05-16 16:42:02.566165',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/mary-carmichael.png'),
(45,'CIO vs. CISO: The Key Differences ‚Äî and Why They Matter','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/cio-vs-ciso-the-key-differences-and-why-they-matter','Discover the key differences between the CIO and CISO positions ‚Äî including responsibilities, education and certifications ‚Äî and why they matter.','2025-04-10 00:00:00.000000','2025-05-16 16:42:02.569931',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/michelle-moore_blog.png'),
(46,'Lessons from The Art of War: A Fresh Look at Modern Auditing','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/a-fresh-look-at-modern-auditing','Maman Ibrahim shares the lessons auditors can learn from Sun Tzu\'s The Art of War.','2025-04-09 00:00:00.000000','2025-05-16 16:42:02.574044',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/maman-ibrahim_blog.png'),
(47,'Cybersecurity Governance in Digital Transformation','https://www.isaca.org/resources/news-and-trends/industry-news/2025/cybersecurity-governance-in-digital-transformation','Digital transformation initiatives have become a major investment priority as organizations strive to leverage technology to reshape business models, drive efficiency and growth, and gain competitive advantage.','2025-04-09 00:00:00.000000','2025-05-16 16:42:02.577283',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/oma-martins-okonkwo.png'),
(48,'The Board of Directors and the Volcano Dilemma: Due Care in the Face of Enterprise Cyberrisk','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/the-board-of-directors-and-the-volcano-dilemma-due-care-in-the-face-of-enterprise-cyberrisk','teste','2025-05-16 19:12:00.000000','2025-05-16 16:42:02.581663',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_bod.png'),
(49,'Applying Interstellar Wisdom to Navigate the Digital Age','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/applying-interstellar-wisdom-to-navigate-the-digital-age','testes','2025-05-16 19:12:00.000000','2025-05-16 16:42:02.585207',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_applying-interstellar-wisdom.png'),
(51,'ISACA Certification-Holders Share Top Tips for Exam Success','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-7/isaca-certification-holders-share-top-tips-for-exam-success','Preparing for a certification exam can be quite challenging, but a strategic and disciplined approach can help position certification candidates for success on exam day.','2025-04-07 00:00:00.000000','2025-05-16 19:12:17.757123',0,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250407-newsletter-article.png'),
(52,'Automation and AI/ML Opportunities in Third-Party Risk Assessment','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/automation-and-aiml-opportunities-in-third-party-risk-assessment','Automation and artificial intelligence/machine learning can set in motion a smarter, faster and more scalable future for third-party risk management.','2025-05-22 00:00:00.000000','2025-05-26 20:12:22.674057',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/sumit-sharma_blog.png'),
(53,'Beyond the Moat: Modern Defense- in-Depth Strategies','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/beyond-the-moat-modern-defense-in-depth-strategies','Just as medieval castles depended upon more than a single knight to stave off potential attacks, modern organizations need a deep arsenal of security tools to protect their critical assets.','2025-05-21 00:00:00.000000','2025-05-26 20:12:22.679108',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/alaina-lawson_blog.png'),
(54,'Biotechnology and IT Governance: Ethical and Security Implications for IT Professionals','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/biotechnology-and-it-governance-ethical-and-security-implications-for-it-professionals','Biotechnology has become the backbone of data-driven healthcare. With this advancement comes significant ethical and security challenges.','2025-06-15 19:28:31.066256','2025-05-26 20:12:22.683413',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_biotechnology.png'),
(55,'Harnessing GenAI to Improve Audit Work Efficiency Through Proper Planning','https://www.isaca.org/resources/news-and-trends/industry-news/2025/harnessing-genai-to-improve-audit-work-efficiency-through-proper-planning','GenAI has the potential to improve the audit function‚Äôs efficiency and effectiveness. However, the use of GenAI does not come without risk, and organizations should be aware of that risk when implementing GenAI. It is of the utmost importance to identify and mitigate risk before implementing GenAI or any emerging technology.','2025-05-20 00:00:00.000000','2025-05-26 20:12:22.688045',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/chelson-chong_meng-fai-chan.png'),
(56,'How to Conduct a Quantum Risk Assessment Using ISACA‚Äôs Risk IT Framework','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-10/how-to-conduct-a-quantum-risk-assessment-using-isacas-risk-it-framework','Could organizational encrypted customer data be at risk before quantum computing becomes mainstream?','2025-05-19 00:00:00.000000','2025-05-26 20:12:22.696414',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2024/mary-carmichael_tips-of-the-trade.png'),
(57,'ISACA 2024 Annual Report Showcases Future Focus','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-10/isaca-2024-annual-report-showcases-future-focus','The 2024 ISACA Annual Report highlights ISACA‚Äôs renewed focus on preparing members to thrive amid the dynamic technology landscape.','2025-05-19 00:00:00.000000','2025-05-26 20:12:22.701267',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250519-newsletter-article-2.png'),
(58,'Top ISACA Resources for Auditors to Keep Pace with AI','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-10/top-isaca-resources-to-keep-pace-with-ai','Artificial intelligence is reshaping the audit profession ‚Äì to the extent that 70% of audit/assurance professional respondents to ISACA‚Äôs 2025 AI Pulse Poll believe they will need to increase their skills and knowledge in AI within the next year to advance their career or even simply retain their jobs.','2025-05-19 00:00:00.000000','2025-05-26 20:12:22.705696',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250519-newsletter-article-1.png'),
(59,'Five Ways that IT Auditors Can Put AI to Good Use','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/five-ways-that-it-auditors-can-put-ai-to-good-use','The success auditors have in leveraging artificial intelligence is dependent upon balancing the technological capabilities with sound governance, clear objectives and a thorough understanding of audit standards.','2025-05-19 00:00:00.000000','2025-05-26 20:12:22.709601',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/abdul-jaleel.png'),
(60,'Why IT Auditors Need AAIA: Addressing AI Challenges in Audit','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/why-it-auditors-need-aaia-addressing-ai-challenges-in-audit','The new ISACA Advanced in AI Audit (AAIA) credential equips auditors for a changing landscape in which artificial intelligence is reshaping roles and presenting auditors with new opportunities.','2025-05-19 00:00:00.000000','2025-05-26 20:12:22.713626',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/wojciech-misiura-blog.png'),
(61,'Detecting and Mitigating APTs in Endpoints','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/detecting-and-mitigating-apts-in-endpoints','Organizations relying on standard security tools may miss sophisticated APT techniques unless they implement specialized threat intelligence and proactive monitoring strategies.','2025-06-15 19:28:31.094526','2025-05-26 20:12:22.752505',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_detecting-and-mitigating.png'),
(62,'Behind the Machines: Uncovering Occupational Fraud in Digital Banking','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/behind-the-machines','Somewhere a trusted employee, embedded within the core of an institution, is secretly siphoning off resources for personal gain.','2025-06-15 19:28:31.123239','2025-05-26 20:12:22.810876',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_behind-the-machines.png'),
(63,'Mergers and Acquisitions: Bracing for the Information Security Aftershock','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/mergers-and-acquisitions','Before deciding to enter a merger or make an acquisition, it is imperative to conduct a comprehensive analysis of the target organization\'s cybermaturity.','2025-06-15 19:28:31.125978','2025-05-26 20:12:22.815629',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_mergers-and-acquisitions.png'),
(67,'Versatilists in the Vanguard: Why the Future of Info/Cyber Security, Audit, Risk and Privacy Belongs to the Agile','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/versatilists-in-the-vanguard','Versatilists connect dots and adapt, characteristics that increasingly are in demand by employers as the digital trust landscape becomes more complex and interconnected.','2025-06-11 00:00:00.000000','2025-06-13 12:28:17.090697',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/david-foote_blog.png'),
(68,'Cyberwargaming in 2025: Why Enterprises Cannot Afford to Skip It','https://www.isaca.org/resources/news-and-trends/industry-news/2025/cyberwargaming-in-2025-why-enterprises-cannot-afford-to-skip-it','Cybercriminals are constantly refining their tactics, and many organizations fail to keep pace with newly evolved threats due to inadequate security training and obsolete IR plans.','2025-06-11 00:00:00.000000','2025-06-13 12:28:17.093632',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/bhavya-jain_blog.png'),
(69,'Unified SASE as a Service: Toward Agile Security Incident Response','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/unified-sase-as-a-service-toward-agile-security-incident-response','Unified secure access service edge as a service empowers organizations to adapt quickly to dynamic needs and enhance their overall cybersecurity posture.','2025-06-15 19:28:31.040120','2025-06-13 12:28:17.096736',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_unified-sase.png'),
(70,'ISACA Career Catalyst Stories: Jas Gill, CISA, CISM, Senior Internal Audit Manager at RELX','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isaca-career-catalyst-stories-jas-gill','ISACA member Jas Gill says her audit career has progressed since tapping into ISACA credentialing and learning resources, with an emphasis on auditing emerging technologies.','2025-06-06 00:00:00.000000','2025-06-13 12:28:17.099458',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/jas-gill_blog.png'),
(71,'DORA and NIS2: Connection Points and Key Differences','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/dora-and-nis2-connection-points-and-key-differences','Compliance with the DORA and NIS2 regulations should not be viewed only as a regulatory obligation but as a strategic opportunity to strengthen digital trust.','2025-06-05 00:00:00.000000','2025-06-13 12:28:17.102110',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/aamir-jamil_blog.png'),
(72,'The Future of Auditing: Combining Artificial Intelligence and Agile Scrum for Dynamic Risk Management','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/the-future-of-auditing-combining-artificial-intelligence-and-agile-scrum-for-dynamic-risk-management','By bringing together the power of AI and the step-by-step methods of Agile Scrum, exciting new possibilities are available to internal auditors.','2025-06-15 19:28:31.046518','2025-06-13 12:28:17.104815',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_future-of-auditing.png'),
(73,'Iron Man‚Äôs Due Diligence: How Tony Stark Would Audit J.A.R.V.I.S. Before Deployment','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/how-tony-stark-would-audit-jaris-before-deployment','Would your artificial intelligence audit align with industry standards in governance, risk and cybersecurity, and pass an Iron Man-level due diligence check?','2025-06-03 00:00:00.000000','2025-06-13 12:28:17.107300',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/chidambaram-narayanan-blog.png'),
(74,'Communicate to Connect: How to Unlock Career Growth Opportunities','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-11/how-to-unlock-career-growth-opportunities','Discover how developing clear, confident communication can elevate your career, improve team dynamics, and drive long-term success.','2025-06-02 00:00:00.000000','2025-06-13 12:28:17.110196',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/patience-ogunbona_career-corner.png'),
(75,'Six Takeaways from the 2025 RSA Conference','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-11/six-takeaways-from-the-2025-rsa-conference','Several ISACA members attended RSA Conference in San Francisco, California. Read their top takeaways, especially on industry trends involving AI.','2025-06-02 00:00:00.000000','2025-06-13 12:28:17.112640',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250602-newsletter-article.png'),
(76,'The Evolving Connection Points Between AI and Audit','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/the-evolving-connection-points-between-ai-and-audit','The integration of artificial intelligence (AI) in the audit profession is rapidly transforming how auditors work, enhancing skills development, improving efficiency, and revolutionizing risk analysis and monitoring processes.','2025-05-30 00:00:00.000000','2025-06-13 12:28:17.115333',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/mohammed-khan_blog.png'),
(77,'Five Mistakes Leading to a Biased Information Security Training and Awareness Program ‚Äì and How to Avoid Them','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/five-mistakes-leading-to-a-biased-information-security-training-and-awareness-program','Building a quality information security training and awareness program capable of elevating organizations requires intention, investment and a willingness to evolve.','2025-05-29 00:00:00.000000','2025-06-13 12:28:17.118454',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/glenda-suarez-cabrera-blog.png'),
(78,'Revisiting the Risk Equation: A Comprehensive Look at Measuring Control Strength in Cybersecurity','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/revisiting-the-risk-equation-a-comprehensive-look-at-measuring-control-strength-in-cybersecurity','By examining control strength in multidimensional terms, security professionals achieve a better understanding of how controls function.','2025-06-15 19:28:31.058108','2025-06-13 12:28:17.121060',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_revisiting-the-risk.png'),
(79,'Zero Trust in the Age of AI: Securing Cloud Environments Against Evolving Threats','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/zero-trust-in-the-age-of-ai-securing-cloud-environments-against-evolving-threats','The number of AI-powered attacks continues to grow and are becoming more difficult to detect, and security models using traditional methods are no longer effective.','2025-05-27 00:00:00.000000','2025-06-13 12:28:17.125133',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/advait-patel_blog.png'),
(80,'Upleveling AI Governance to Enhance Trust','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-12/upleveling-ai-governance-to-enhance-trust','Today‚Äôs AI systems are dynamic, complex and deeply embedded into business operations. Managing them requires more than traditional controls. It demands a governance model that is strategic, adaptive and deeply cross-functional.','2025-06-16 00:00:00.000000','2025-06-15 19:28:31.028581',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250616-newsletter-article-1.png'),
(81,'Want to Beat Burnout? Start Having More Fun','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-12/want-to-beat-burnout-start-having-more-fun','Fun isn‚Äôt just good for your personal life‚Äîit‚Äôs a powerful tool for professional success.','2025-06-16 00:00:00.000000','2025-06-15 19:28:31.031620',0,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250616-newsletter-article-2.png'),
(82,'A Practical Approach to Integrating Vulnerability Management into Enterprise Risk Management','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/a-practical-approach-to-integrating-vulnerability-management-into-enterprise-risk-management','Organizations can strengthen their vulnerability management and improve their risk posture without expensive tools by utilizing existing resources, fine-tuning internal processes and creating a security-aware culture.','2025-06-13 00:00:00.000000','2025-06-15 19:28:31.034348',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/krishna-bagla-blog.png'),
(83,'CMMI in the AI Age: Driving Efficiency, Innovation, and Governance','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/cmmi-in-the-ai-age','CMMI provides a framework to assess, refine, and optimize capabilities. With AI-driven insights and automation, organizations can accelerate decision making and process enhancements.','2025-06-15 19:28:31.128382','2025-06-15 19:28:31.129581',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_cmmi-ai-age.png');
/*!40000 ALTER TABLE `dashboard_newsarticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_reminder`
--

DROP TABLE IF EXISTS `dashboard_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_reminder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `notes` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_reminder`
--

LOCK TABLES `dashboard_reminder` WRITE;
/*!40000 ALTER TABLE `dashboard_reminder` DISABLE KEYS */;
INSERT INTO `dashboard_reminder` VALUES
(1,'Teste','2025-06-16','Lan√ßar publicacao','2025-06-15 11:41:08.686562'),
(2,'Enviar email aos oradores','2025-06-18','Miguel, envia email aos oradores para a confer√™ncia.','2025-06-15 19:38:13.164195');
/*!40000 ALTER TABLE `dashboard_reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_sitesettings`
--

DROP TABLE IF EXISTS `dashboard_sitesettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_sitesettings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(120) NOT NULL,
  `maintenance_mode` tinyint(1) NOT NULL,
  `maintenance_message` varchar(180) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_sitesettings`
--

LOCK TABLES `dashboard_sitesettings` WRITE;
/*!40000 ALTER TABLE `dashboard_sitesettings` DISABLE KEYS */;
INSERT INTO `dashboard_sitesettings` VALUES
(1,'Website ISACA',0,'Voltaremos em breve!','2025-06-15 19:56:34.559610');
/*!40000 ALTER TABLE `dashboard_sitesettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES
(1,'2025-02-13 15:44:50.477513','1','pedro',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]',4,1),
(2,'2025-02-27 18:21:24.752605','13','Eventos object (13)',1,'[{\"added\": {}}]',10,1),
(3,'2025-03-06 15:47:02.579384','2','Henrique',1,'[{\"added\": {}}]',4,1),
(4,'2025-05-26 18:01:58.726202','28','Eventos object (28)',3,'',10,1),
(5,'2025-05-31 11:11:58.237249','3','carolina',1,'[{\"added\": {}}]',4,1),
(6,'2025-05-31 11:13:08.203193','3','carolina',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),
(7,'2025-05-31 11:13:58.862198','3','carolina',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',4,1),
(8,'2025-05-31 11:14:29.422606','3','carolina',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\"]}}]',4,1),
(9,'2025-06-15 01:29:03.054280','5','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(10,'2025-06-15 01:29:05.824604','4','Carlos Dias ‚Äì evento 25',3,'',17,1),
(11,'2025-06-15 01:29:09.410333','3','Jo√£o Oliveira ‚Äì evento 25',3,'',17,1),
(12,'2025-06-15 01:29:12.696544','1','Pedro Santos ‚Äì evento 25',3,'',17,1),
(13,'2025-06-15 01:29:15.611485','2','Ana Costa ‚Äì evento 25',3,'',17,1),
(14,'2025-06-15 01:31:00.259543','8','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(15,'2025-06-15 01:31:03.024751','7','Carlos Dias ‚Äì evento 25',3,'',17,1),
(16,'2025-06-15 01:31:05.685533','6','Pedro Santos ‚Äì evento 25',3,'',17,1),
(17,'2025-06-15 01:32:44.452557','11','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(18,'2025-06-15 01:32:48.711702','10','Carlos Dias ‚Äì evento 25',3,'',17,1),
(19,'2025-06-15 01:32:52.530984','9','Pedro Santos ‚Äì evento 25',3,'',17,1),
(20,'2025-06-15 14:58:38.944057','31','Smart contracts',3,'',10,1),
(21,'2025-06-15 16:04:01.770081','15','Henrique Santos ‚Äì evento 25',3,'',17,1),
(22,'2025-06-15 16:04:01.770168','14','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(23,'2025-06-15 16:04:01.770197','13','Carlos Dias ‚Äì evento 25',3,'',17,1),
(24,'2025-06-15 16:04:01.770217','12','Pedro Santos ‚Äì evento 25',3,'',17,1),
(25,'2025-06-15 16:10:55.180210','19','Henrique Santos ‚Äì evento 25',3,'',17,1),
(26,'2025-06-15 16:10:55.180268','18','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(27,'2025-06-15 16:10:55.180292','17','Carlos Dias ‚Äì evento 25',3,'',17,1),
(28,'2025-06-15 16:10:55.180316','16','Pedro Santos ‚Äì evento 25',3,'',17,1),
(29,'2025-06-15 19:36:42.556424','23','Henrique Santos ‚Äì evento 25',3,'',17,1),
(30,'2025-06-15 19:36:42.556497','22','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(31,'2025-06-15 19:36:42.556521','21','Carlos Dias ‚Äì evento 25',3,'',17,1),
(32,'2025-06-15 19:36:42.556540','20','Pedro Santos ‚Äì evento 25',3,'',17,1),
(33,'2025-06-15 19:53:08.957479','27','Henrique Santos ‚Äì evento 25',3,'',17,1),
(34,'2025-06-15 19:53:08.957550','26','Maria Ferreira ‚Äì evento 25',3,'',17,1),
(35,'2025-06-15 19:53:08.957584','25','Carlos Dias ‚Äì evento 25',3,'',17,1),
(36,'2025-06-15 19:53:08.957633','24','Pedro Santos ‚Äì evento 25',3,'',17,1),
(37,'2025-06-15 19:57:23.717954','2','Henrique',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',4,1),
(38,'2025-06-15 19:57:29.022321','2','Henrique',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),
(39,'2025-06-15 19:57:36.318507','2','Henrique',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\"]}}]',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojob`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_apscheduler_djangojob` (
  `id` varchar(255) NOT NULL,
  `next_run_time` datetime(6) DEFAULT NULL,
  `job_state` longblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_apscheduler_djangojob_next_run_time_2f022619` (`next_run_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojob`
--

LOCK TABLES `django_apscheduler_djangojob` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojob` DISABLE KEYS */;
INSERT INTO `django_apscheduler_djangojob` VALUES
('fetch_news_job','2025-06-02 02:00:00.000000','Äï>\0\0\0\0\0\0}î(åversionîKåidîåfetch_news_jobîåfuncîå\"dashboard.scheduler:run_fetch_newsîåtriggerîåapscheduler.triggers.cronîåCronTriggerîìî)Åî}î(hKåtimezoneîåbuiltinsîågetattrîìîåzoneinfoîåZoneInfoîìîå	_unpickleîÜîRîå\rEurope/LondonîKÜîRîå\nstart_dateîNåend_dateîNåfieldsî]î(å apscheduler.triggers.cron.fieldsîå	BaseFieldîìî)Åî}î(ånameîåyearîå\nis_defaultîàåexpressionsî]îå%apscheduler.triggers.cron.expressionsîå\rAllExpressionîìî)Åî}îåstepîNsbaubhå\nMonthFieldîìî)Åî}î(h\"åmonthîh$àh%]îh))Åî}îh,NsbaubhåDayOfMonthFieldîìî)Åî}î(h\"ådayîh$àh%]îh))Åî}îh,Nsbaubhå	WeekFieldîìî)Åî}î(h\"åweekîh$àh%]îh))Åî}îh,NsbaubhåDayOfWeekFieldîìî)Åî}î(h\"åday_of_weekîh$âh%]îh\'åWeekdayRangeExpressionîìî)Åî}î(h,NåfirstîK\0ålastîK\0ubaubh)Åî}î(h\"åhourîh$âh%]îh\'åRangeExpressionîìî)Åî}î(h,NhOKhPKubaubh)Åî}î(h\"åminuteîh$âh%]îhV)Åî}î(h,NhOK\0hPK\0ubaubh)Åî}î(h\"åsecondîh$àh%]îhV)Åî}î(h,NhOK\0hPK\0ubaubeåjitterîNubåexecutorîådefaultîåargsî)åkwargsî}îh\"årun_fetch_newsîåmisfire_grace_timeîKåcoalesceîàå\rmax_instancesîKå\rnext_run_timeîådatetimeîådatetimeîìîC\nÈ\0\0\0\0\0îhÜîRîu.');
/*!40000 ALTER TABLE `django_apscheduler_djangojob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojobexecution`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojobexecution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_apscheduler_djangojobexecution` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `run_time` datetime(6) NOT NULL,
  `duration` decimal(15,2) DEFAULT NULL,
  `finished` decimal(15,2) DEFAULT NULL,
  `exception` varchar(1000) DEFAULT NULL,
  `traceback` longtext DEFAULT NULL,
  `job_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_job_executions` (`job_id`,`run_time`),
  KEY `django_apscheduler_djangojobexecution_run_time_16edd96b` (`run_time`),
  CONSTRAINT `django_apscheduler_djangojobexecution_job_id_daf5090a_fk` FOREIGN KEY (`job_id`) REFERENCES `django_apscheduler_djangojob` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojobexecution`
--

LOCK TABLES `django_apscheduler_djangojobexecution` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(17,'dashboard','certificateissued'),
(16,'dashboard','certificatetemplate'),
(8,'dashboard','comentarios'),
(9,'dashboard','contactos'),
(10,'dashboard','eventos'),
(15,'dashboard','membro'),
(12,'dashboard','newsarticle'),
(11,'dashboard','newsletter'),
(18,'dashboard','reminder'),
(22,'dashboard','sitesettings'),
(7,'dashboard','user'),
(23,'dashboard','userpreferences'),
(13,'django_apscheduler','djangojob'),
(14,'django_apscheduler','djangojobexecution'),
(19,'django_otp','staticdevice'),
(20,'django_otp','statictoken'),
(24,'otp_static','staticdevice'),
(25,'otp_static','statictoken'),
(21,'otp_totp','totpdevice'),
(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2025-02-13 15:20:02.187246'),
(2,'auth','0001_initial','2025-02-13 15:20:02.526476'),
(3,'admin','0001_initial','2025-02-13 15:20:02.586061'),
(4,'admin','0002_logentry_remove_auto_add','2025-02-13 15:20:02.596061'),
(5,'admin','0003_logentry_add_action_flag_choices','2025-02-13 15:20:02.608057'),
(6,'contenttypes','0002_remove_content_type_name','2025-02-13 15:20:02.676349'),
(7,'auth','0002_alter_permission_name_max_length','2025-02-13 15:20:02.708644'),
(8,'auth','0003_alter_user_email_max_length','2025-02-13 15:20:02.728796'),
(9,'auth','0004_alter_user_username_opts','2025-02-13 15:20:02.737798'),
(10,'auth','0005_alter_user_last_login_null','2025-02-13 15:20:02.764197'),
(11,'auth','0006_require_contenttypes_0002','2025-02-13 15:20:02.766200'),
(12,'auth','0007_alter_validators_add_error_messages','2025-02-13 15:20:02.775195'),
(13,'auth','0008_alter_user_username_max_length','2025-02-13 15:20:02.793682'),
(14,'auth','0009_alter_user_last_name_max_length','2025-02-13 15:20:02.815782'),
(15,'auth','0010_alter_group_name_max_length','2025-02-13 15:20:02.834862'),
(16,'auth','0011_update_proxy_permissions','2025-02-13 15:20:02.844877'),
(17,'auth','0012_alter_user_first_name_max_length','2025-02-13 15:20:02.866285'),
(18,'sessions','0001_initial','2025-02-13 15:20:02.888540'),
(47,'dashboard','0001_initial','2025-05-16 11:38:21.176033'),
(48,'dashboard','0002_newsarticle','2025-05-16 14:50:25.266993'),
(49,'dashboard','0003_newsarticle_image','2025-05-16 15:15:04.313803'),
(50,'django_apscheduler','0001_initial','2025-05-16 16:37:43.897067'),
(51,'django_apscheduler','0002_auto_20180412_0758','2025-05-16 16:37:43.924677'),
(52,'django_apscheduler','0003_auto_20200716_1632','2025-05-16 16:37:43.948498'),
(53,'django_apscheduler','0004_auto_20200717_1043','2025-05-16 16:37:44.280988'),
(54,'django_apscheduler','0005_migrate_name_to_id','2025-05-16 16:37:44.301258'),
(55,'django_apscheduler','0006_remove_djangojob_name','2025-05-16 16:37:44.319308'),
(56,'django_apscheduler','0007_auto_20200717_1404','2025-05-16 16:37:44.345617'),
(57,'django_apscheduler','0008_remove_djangojobexecution_started','2025-05-16 16:37:44.362453'),
(58,'django_apscheduler','0009_djangojobexecution_unique_job_executions','2025-05-16 16:37:44.380480'),
(59,'dashboard','0004_newsarticle_dashboard_n_publish_5e8710_idx','2025-05-16 19:05:46.188144'),
(60,'dashboard','0005_membro','2025-05-26 21:22:12.025302'),
(61,'dashboard','0006_membro_status','2025-05-27 13:38:45.254829'),
(62,'dashboard','0007_certificatetemplate_certificateissued','2025-06-14 22:41:09.267843'),
(63,'dashboard','0008_remove_certificatetemplate_font_file_and_more','2025-06-15 00:23:00.043792'),
(64,'dashboard','0009_reminder','2025-06-15 10:59:26.986530'),
(65,'dashboard','0010_eventos_seo_descricao_eventos_seo_keywords_and_more','2025-06-15 12:57:54.384159'),
(66,'dashboard','0011_sitesettings_userpreferences','2025-06-15 17:49:39.212249'),
(67,'otp_totp','0001_initial','2025-06-15 17:49:39.254272'),
(68,'otp_totp','0002_auto_20190420_0723','2025-06-15 17:49:39.306270'),
(69,'otp_totp','0003_add_timestamps','2025-06-15 17:49:39.378110'),
(70,'two_factor','0001_initial','2025-06-15 17:49:39.380218'),
(71,'two_factor','0002_auto_20150110_0810','2025-06-15 17:49:39.382111'),
(72,'two_factor','0003_auto_20150817_1733','2025-06-15 17:49:39.383567'),
(73,'two_factor','0004_auto_20160205_1827','2025-06-15 17:49:39.384961'),
(74,'two_factor','0005_auto_20160224_0450','2025-06-15 17:49:39.386383'),
(75,'two_factor','0006_phonedevice_key_default','2025-06-15 17:49:39.387860'),
(76,'two_factor','0007_auto_20201201_1019','2025-06-15 17:49:39.389579'),
(77,'two_factor','0008_delete_phonedevice','2025-06-15 17:49:39.391021'),
(78,'two_factor','0001_squashed_0008_delete_phonedevice','2025-06-15 17:49:39.394242'),
(79,'otp_static','0001_initial','2025-06-15 18:05:42.878209'),
(80,'otp_static','0002_throttling','2025-06-15 18:05:42.931412'),
(81,'otp_static','0003_add_timestamps','2025-06-15 18:05:42.977230'),
(82,'dashboard','0011_sitesettings','2025-06-15 18:32:25.187964');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('28s6577ak81b2os859y8yh97mxo7q7l3','.eJxVj8FugzAQRP_FZ0BeWGOcY-75BmvtXRfaCCRsIlVV_j1OxaG9zGFmdp72R3k6yuyPLLtfWF0UqOavFyh-yfoO-JPWj62L21r2JXTvSnemubttLPfr2f03MFOe63WCKWnSCUdIJiCDdpTQcA9ixihJg4UBOQoTD07SYCU4CFocTqFPVEfvlIunWJbHUr59yeoCFp1FMG5sVGU9Ku44fr-IqC0b4hY49i0im9ZVQhXAyRIIM6nnC5WVUUE:1uPjih:KSDbauA30U08-m6sXoPzmQNlejih-GCPsS5VPdiGe8Y','2025-06-12 16:49:59.797739'),
('2ll8qy5eo9j3e38938fh68ancd4yyfz3','.eJxVj0tuwzAMRO-idWyI-lnKsvueQaBEsnYb2EAsByiK3D1KkUW7nc8bzI_KeLQ5Hztf80LqrECd_moF6xevT4M-cf3Yxrqt7bqU8RkZX-4-vm_El7dX9h9gxn3ubYEoGrW4AOKLI9AJxXkywD5UFg0TWEeVCckmFjtxSVA0JxeLEezQC-4tY23LbWnfue3qDJNLEbz14aT61q3PHcfvC9FOglg9GB9pcJ08FHBxCJKwJGJdjFH3B5OdUUY:1uQ2uK:mhjN-kq5TEgn4pj6IplQSGvJW1pusHmGNbX3xmddrwY','2025-06-13 13:19:16.700652'),
('4s33j946taev4xx5n2ew5w283o7cqa4u','.eJxVj0uOwjAQRO_iNYm6444_LGc_Z7DadnsSQImEHaTRiLsTEAtmW68-qj8VeGtT2Kpcw5zVUaE6fGqR01mWJ8gnXn7WPq1Lu86xf1r6N63995rl8vX2_iuYuE57uqArwFDIYBkjZQTPhcY8oIwmSQG0qCknyZy1l6KtRI8RxJOLQ-G99MK1BU5tvs3tN7SqjmjJGUfG2oPat2773La9XtjEjHE0nRbQHRGbLiZwHcSBE0Ly7AZ1fwCb7lFg:1uLIlc:lJ1rxb7vS4xvFVBVNjIz1ZdwpGXOlECMFgokl7nnl-Y','2025-05-31 09:45:00.375605'),
('4uhu5xlcg4hm3t4b0j5r9rhs7k2scw3p','.eJxVj01uwjAQhe_iNYk8joM9LLvvGayxZ4akRYmEHaSq6t0bBAvYvu_96P2aRFub0lblmmY2JwPm8KplKt-y3AF_0XJe-7Iu7Trn_m7pn7T2nyvL5ePpfSuYqE57WiGqJav-CDpmz2CR1I_sQMZjEbUQYPBchIkHFB2CZIRsBX3MTmkvvVBtiUqbb3P7Sa2aEwSP0UU3xoPZt2773LY9XpRiGQE6DKSdj5Y7LIxdgZA1WOcF1fz9A5qqUYU:1uQ6GQ:fse20_M_aKMTWvgXh8DJAQ74QbNhxNTU0drmPBSt0og','2025-06-13 16:54:18.494710'),
('65et5xbcplfwpfcw8xnnsrqy99t1o5yc','.eJxVj0uOwjAQRO_iNYncib8sZz9nsNrubpIZlEjYQUKIuxNGLIZtvfqo7irh1qa0Vb6kmdRRgTr81zKWX15egH5wOa19WZd2mXP_svRvWvvvlfj89fZ-FExYpz0tEESjFuNAbDYEOqIYSwOwdYVFg4fRUGFCGiPL6DlHyJqjCXkQ3EvPWFvC0ubr3G6pVXUEb4ILzjh3UPvWdZ_btr8XCGWwo8UuZoid8TZ0KOw7GLzDwI4oR_V4ApPDUVk:1uLJET:TPNADqfkrhrh3jRXdt-cXlzgzM_SrAtxWc1dB2Ez3BI','2025-05-31 10:14:49.904200'),
('7r60lupp22min8cawha1iq3xf3s9n2qb','.eJxVj8FuwzAMQ__F5yawEtmuetx932DItrRkKxKgdgoMw_59LtbDdiX5SPDLRD7aEo8qt7gWczFgTn-1xPlDtodR3nl728e8b-22pvERGZ9uHV_3IteXZ_ZfwcJ16bTCWS1bRQ_qEhawxIquTCDOZ1ELAWYsWQqXmUTnIIkgWSE8p0m5l165tsi5rfe1fcZWzQUCEpEjhyfTt-597jh-X_gEQQMNntkPOCEMnDQMgMIwQeiUNd8_kX1QwA:1uQntF:nwnbpEesnt_OUwPSsLovRT2rmzRM-TCIPCjJ2cauDEs','2025-06-15 15:29:17.838599'),
('7y0aq2k0ve6o4nn45ixijglaut8nmk38','.eJxVj0uOwjAQRO_iNYncTvsTlrOfM1htu5tkBiUSdpAQ4u6EEYthW68-qruKtLUpbpUvcS7qqEAd_muJ8i8vL1B-aDmtfV6XdplT_7L0b1r777Xw-evt_SiYqE57WiCIJi3oQGzCAnokQVsMsHWZRYOHAUvmQmUYWQbPaYSkecSQjNBeeqbaIuU2X-d2i62qI3gMLlhr_EHtW9d9btv-XngnzjPYTpI3HSbvOgqOOgNmMBoNF0D1eAKPrlC3:1uLIzI:J0KdXaeWYq3VVe7NgZxA9nKOvobzxa50w3-uNX33HEw','2025-05-31 09:59:08.117677'),
('9avnga7zpiihfficfv4e5sbo7vbrfsdv','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1u7Kok:2gPpzpn6F-qnoOulCEN7rQEN-MNMJjkt8QMUynVswIQ','2025-05-06 21:06:10.899506'),
('9ogbpb8y0x419xlcc6b2imzpq48olsiq','.eJxVj01uwjAQhe_iNYk8iZPYLLvvGawZzwxJixIJO0gIcXdMxaJs39-ndzcR9zLHPcslLmyOBszhv0aYfmV9GfyD62lr07aWy0LtK9K-3dx-byznr3f2Y2DGPNe2gleLVt0IOpBjsAHVDdyBDGMStTBB7zgJI_dBtJ-EApCV4Dx1inX0jLlETGW5LuUWSzZHmJwfvXdjOJjKulbcvv-9SEmDC0wNIdumcoYmeIAm2U5714VELObxBKh6UeE:1uLJkp:Gdw_kBNVrBcoPMt5bz5uD0EszZHIPLj30OyEPK5R9QE','2025-05-31 10:48:15.047851'),
('9rssmuzg2nc6mbz91e1rgtn4765pnf33','.eJxVj0tuwzAMRO-idWyIsixTWXbfMwikKNZuAxuI5ABFkbvHKbJot_Pmg_kxifY2p72Wa1rEnA2Y01-NKX-V9Qnkk9aPrc_b2q4L909L_6K1f9-kXN5e3n8FM9X5SCugWrLqA-jIXsBGUj-KgzKGXNTCBIOXXIRkiEWHqXAEtiV6ZKd0lF6otkS5LbelfadWzRkmjwFj8OFkjq3bMbfvvy8iaEAm6Jxw7rxM3OEQsUMgJYeWXBZzfwCetlGv:1uLK3i:2OMzWgrjFaIYx34cLcEQvkORtDHSs08Df81qMctAOqY','2025-05-31 11:07:46.316101'),
('cdiimumrj3dgdftv6ubsnvlorr8ik4qh','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1tuv2E:xgpAqNVhT64qBYWS7F93sQfXi-T4R1pgeM6zM3qcgY8','2025-04-02 15:08:46.797652'),
('csppfyevplvubwwy9x07zsg3gtopwhjc','.eJxVj01uwjAQhe_iNYk89sSxWXbfM1gz9rgJoETCDlJVcXcCYkG373s_en8q0tamuFW5xjmrowJ1-NSY0lmWJ8gnWn7WPq1Lu87cPy39m9b-e81y-Xp7_xVMVKc9XcAXTbqggzIwZtCBCg7ZgAwuSdEwgsWcJFO2QYodhQOwloCeTaG99EK1RUptvs3tN7aqjjCidx69CQe1b932uW17vRgTEfDgOivadojkOk7ad5oNJdApkDfq_gCbtlFf:1uLIo1:xjvTOQfPKP2bCPhLogy-QzOCR4eE-_zm6YpjHVlo1mE','2025-05-31 09:47:29.207359'),
('d2kcvmkddd4oe5ak1tcmt36bieuvsjvq','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1tyGJP:EZlF6PbOuDdlyP0kl1jgRX86tJqKuALo2tg2pAfAlHU','2025-04-11 20:28:19.190935'),
('d5c526a8gtnq9zuu6w6llmvguy4smclk','.eJxVj01uwjAQhe_iNYk88diOWXbfM1gzHrsJoETCDlJVcXcCYkG373s_en8q0tamuNV8jbOoowJ1-NSY0jkvTyAnWn7WPq1Lu87cPy39m9b-e5V8-Xp7_xVMVKc9XWAsmnRBB8UyCuhABa0MkK1LuWjwYFBSFhITcjE-cwDWOeDIQ6G99EK1RUptvs3tN7aqjuBxdGFwBg9q37rtc9v2emExGW3Ydg7Fd0gBOwZO3YDaaLGkPXt1fwCLf1DS:1uLKpu:E4vcBOT1eKa0nzcl04Il2meFOKDShnfNco2CCYQW6iA','2025-05-31 12:27:14.817792'),
('dt19f97e5dbbmq623945foxj2hgf4b3v','.eJxVj01OwzAQhe_idRN56omd6ZI9Z7Bm7DEJVIlUO5UQ4u64qAvYvr9P78tEPtoSj6q3uGZzMWBOfzXh9KHbw8jvvL3tY9q3dltlfETGp1vH1z3r9eWZ_TewcF16u8BcLNuCHsokmMESF5zyGXTySYuFAA5z0szZkRYXVAjEKuEs58J99Mq1RU5tva_tM7ZqLhCQyM3B-ZPprHvHHcfvC4HgVXAanBMY0HkdyAsNGkBnDESdZr5_AJAOUKU:1uQZ0K:05u6Lt1p13PahDTpYRQV38oUV1ZMFEBbkwWfkomRPmU','2025-06-14 23:35:36.388794'),
('ebmv2t57n7tkwc3cp0j8jmet67qxun0m','.eJxVj0tuwzAMRO-idWyIsmTRWXbfMwiUSNZuAxuI5ABFkbvHKbJot_Pmg_kxifY2p73KNS1szgbM6a-WqXzJ-gT8SevH1pdtbdcl909L_6K1f99YLm8v77-Cmep8pBVQLVn1I2jInsFOpD6wAwljEbUQYfBchImHSXSIkifIViaP2SkdpReqLVFpy21p36lVc4bocUREO5zMsXU75vb994VD0ZwZuxgDdl5G16Fn7iCgY4LiRYO5PwCc7VGM:1uLJqC:y2b1569WV-K13oqh4Sm8immUWa0a7qHq3-NGGAkIAp4','2025-05-31 10:53:48.324349'),
('esnq8f8b1qmkb2rvxlby4fsg9os5fwfm','.eJxVj0uOwjAQRO_iNYm6_TfL2c8ZrLbdngRQImEHaTTi7gTEgtnWq4_qT0Ta-hS3xtc4F3EUKA6fWqJ85uUJyomWn3XM69KvcxqflvFN2_i9Fr58vb3_CiZq056u6CsQVG2xmqQLQqCqTZHIxmaugA6VLpkLFRW4KscpYAIO2idZaS-9UOuRcp9vc_-NvYkjOu2t91Lpg9i3bvvctr1eWAMpsAuDyiAHTdYNiSUPmJO0msEwgLg_AJDqUQw:1uLJh0:jAbP-C-ClNOXrePZLH0w591aTom_aD4zLfg6c6Sgy5w','2025-05-31 10:44:18.169328'),
('ewz78stif6kii68w5feezf6mkcy6af52','.eJxVjzsOwjAQRO_imkRex_GHkp4zWGvvmgRQIsUOEkLcnYAooJ03H81DBFzrENbCSxhJ7AWI3a8WMV14egM643Sa2zRPdRlj-7a0X1ra40x8PXy9fwUDlmFLZ3BZoszaQO6jJpAes-5JAfcmcZZgodOUmJA6z7mzHD1EyV67qDJupVcsNWCq422s91CL2IPVzjivjdyJbeu2za3r50VksORTbBTa1OiOXeOUsQ0ZJIXJKt-zeL4Ao5tRtA:1uLK0n:nd6fL-g4gJhxrpJUqcJeV7ib7DWz-qP9JrfI8IRzqzo','2025-05-31 11:04:45.828460'),
('fqhlc59u3abrj592y5fnmto2ojkgtjld','.eJxVj01OwzAQhe_idRN5Eru2u2TPGawZzwwJVIlUO5UQ4u64qAvYvu_96H2ZjEdb8lHlllc2FwPm9FcjLB-yPQC_4_a2j2Xf2m2l8WEZn7SOrzvL9eXp_VewYF16WiGqRavuDOrJMdiE6jxPIP5cRC0EmB0XYeQ5ic5BKAFZSS7SpNhLr1hbxtLW-9o-c6vmAsGlzn2IJ9O37n3uOH5fTB4LaLADFT8PzkIZiBAG9hNH9TFaieb7B50AUXY:1uQbZ4:SespKkwD59yjCl5nNzcDSEHqLYHzBWldznIkConi510','2025-06-15 02:19:38.398628'),
('h7tg1i9za7xbbiw0e02pl1yob01nddwa','.eJxVj01uwyAQhe_COrYGAwNk2X3PgAaYqd1GthRwpKrK3eNUWbTb970fvR-VaO9z2htf01LVWWl1-qtlKl-8PkH9pPVjG8u29uuSx6dlfNE2vm-VL28v77-Cmdp8pEUHAQKxqMVlWzVEEuvqpNlhYQHttbG1cKVqIovxnKPOwNGGPAkdpRdqPVHpy23p36k3ddbeBgwICCd1bN2OuX3_fYEwIXqxQw2GBus8DQFNGABiRhc4Sg7q_gCDNVCe:1uLJ7s:q_d7cJb2Q5KLX2gyWJhYM2RMWvKJtpMfOrts-1kDxXM','2025-05-31 10:08:00.243853'),
('hp4bixzefz5x7wg667d335ep895sxhdc','.eJxVTzuuwjAQvItrEnnjdRJTvv6dwVqv1ySAEgk7SAhxdwyigGaK-WruytNWJr9lufg5qr0CtfvmAvFJlpcQj7Qc1pbXpVzm0L4s7UfN7f8a5fz38f4UTJSnmk4wJk06YQ_JBoygHSW0sQOxPUvSMIDByBIpGifJDBIcBC0Ox9AlqqVnysUTl_k6l5svWe1hQOecdj3uVN261rlte78YmYLtzNB0Nd8gsjRk0TZiNDDzaCuoxxOVBlF8:1uQmai:RobapHKKRuQbvqcpS-SQGtrlg3AwI1KEWlGxGpKgyUw','2025-06-15 14:06:04.462553'),
('hswe7uw4q6d6hyk675v9ys2ebafaohcv','.eJxVj0tuwzAMRO-idWyI1s_KsvueQSBFqnYb2EAkByiK3D1KkUW7nc8bzI9KeLQlHVWuaWV1VqBOfzXC_CXb0-BP3D72Me9bu640PiPjy63j-85yeXtl_wEWrEtvF5iLRl2sh-LIMuiIxTqeQJzPUjQEMJazMLKJUkwQikBaop1pKtihF6wtYW7rbW3fqVV1hmBj8B2lT6pv3frccfy-EC5OaJ4GE70MVjszRD3zoEkKSPZEFNT9AZ8FUdc:1uPon9:2eIxuTVCA_sxdnaaMUR4raeqMXH-MDSQki8xJUGTOz8','2025-06-12 22:14:55.208683'),
('ktec2hj4c7hr7tmffhsey5w9l2dcbky6','.eJxVj01uwjAQhe_iNYk88SSOWXbfM1hjz0wTQImEHaSq4u4ExIJu3_d-9P5MpK1OcStyjTObowFz-NQS5bMsT8AnWn7WNq9Lvc6pfVraNy3t98py-Xp7_xVMVKY9rTCqJas4gPYJGWwgxZ47kH7IohY8OOQsTOyCqPOSAiQrAcfUKe2lFyo1Uq7zba6_sRZzBI-h67vRuYPZt2773La9Xqj3lCCEhiW4BhVzk3RITUaxNHpBJ2zuD6QRUhI:1uNgZN:_ZFBdoMd-2uivLe5LfaHMztIDFOGfJyYxroq96TR1uQ','2025-06-07 01:03:53.118025'),
('lh2jg6ux6ha4ty1hb1118q4jzx0m9auc','.eJxVj01uwjAQhe_iNYk8zMSxWXbfM1hje4akRYmEHaSq6t0bEAvYvu_96P2ayFub4lblGudiTgbM4VVLnL9luYPyxct57fO6tOuc-rulf9Laf65FLh9P71vBxHXa0wpeLVslBzokKmADKw3lCDK4LGphBKSSpXDBIIqjpADJSiCfjsp76YVri5zbfJvbT2zVnGAk73xA7w5m37rtc9v2eKGIQmCxc5a4o5F9FzSELlsB58l6xGT-_gGK3lCV:1uLJzb:ODcQxZyUkuJGud4AvmuedaotdjhzVRYbkaotgNwJTu8','2025-05-31 11:03:16.548116'),
('m2btcrqv15fd5506bejipucgdloxsgb9','.eJxVj0tuwzAMRO-idWyQ-thSlt33DAIlkbXbwAYiOUBR5O5Riiza7XzeYH5UpKMt8ah8jWtRZ4Xq9FdLlL94exrlk7aPfcz71q5rGp-R8eXW8X0vfHl7Zf8BFqpLbwt6AQKxE4pLtiAEEuuKRnZTZgGc0diSuVAxgcXMnAIm4GB90kIdeqHaIuW23tb2HVtVZ5wdABof_En1rVufO47fFxbAe0YYDGs3WDFm6BQZxPsp6ElMcFrdH4SRUI4:1uQsYc:oBYYgkZ9T7anV8bFUGf3D6eK6uBrOB5Fm1SP_5inGZc','2025-06-15 20:28:18.956576'),
('mhy6aq9r6uq03yyee84n6bfvtoso1c1f','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1uLJuW:nUOu0o0Sf228hcTydkwqJ07lkpNPx-UW9sd83LNzLY8','2025-05-31 10:58:01.715904'),
('mrrh5f0z611qd0ghj1e6zlpve2kiq8ur','.eJxVj0uOwjAQRO_iNYn8t5vl7OcMVtvtngRQImEHaTTi7gTEgtnWq4_qTyTc-pS2Vq9pJnEUShw-tYzlXJcnoBMuP-tY1qVf5zw-LeObtvF7pXr5env_FUzYpj3NKrJEydYrdtmSkoBsHWlVnS-VpQrKWCqVkAxUNqFmUFlWsDFrxr30gq0nLH2-zf039SaOKtjoAaLTB7Fv3fa5bXu9AC-tdzIOmY0erA1hyNGEgYMDrQ1LIhD3B4DMUHY:1uLMiK:p-N7iD91zOxjoajxm46ePzegIcYr9yca8rs5q9eSC0o','2025-05-31 14:27:32.117886'),
('n5jorqdbmu1luz3y288z23twoxl0ghfw','.eJxVjzFuwzAMRe-iOTZIW7KsjN17BoEUqdptYAORHKAocvcoRYaWI9_n--CPiXTUJR5Fr3EVczZoTn93TOlLtyeQT9o-9j7tW72u3D8j_YuW_n0Xvby9sv8EC5WlXWecMxBkO2F2bAUhULZOBlQ3Jc2AHkcrSYVkDJpHrxyQQYOdecjUpBcqNVKq622t37EWc0bvoM0w4cm0rlurO47fLzJ48YLcAQTtrMxjN3vizjW7tYkbRXN_AJQ3UVo:1uQp0j:8TdwQTMdcPCaaS15uqNVYF6rzS5OEkuju4cdZ_esOOs','2025-06-15 16:41:05.959911'),
('n9po33cpuk3102vhx39z2ae4z1xon6ov','.eJxVj8tugzAQRf_Fa0Ae42eW2ecbrLFnXGgjkLCJVFX595CKRbu95z50f0TEvU1xr7zFmcRFgOj-agnzFy9vQJ-4fKxDXpe2zWl4W4aT1uG2Et-vp_dfwYR1OtIFfJEoi7ZQTNIEMmDRhhSwsZmLBAejpsyENAYuo-MUIEkO2idV8Ci9Y20Rc5sfc_uOrYoLOO2tD8aGThxbj2Nu339fJAZHIadeocu9Htn3XlnXk0VSmJ0KhsXzBaXDUb4:1uLK2X:7O8QKFOFOEv266PcBWqh-bWU-ktHVkFNNgfry9tj4nU','2025-05-31 11:06:33.895083'),
('noffwep3k8diwsxsbp1tu0gxumuttoh7','.eJxVj0tuwzAMRO-idWyIFvXLsvueQaAksnYb2EAkByiK3D1OkUW7nTcfzI9KtPc57Y2vaanqrECd_mqZyhevT1A_af3YxrKt_brk8WkZX7SN71vly9vL-69gpjYfaYEgmrSgA7EZK-hIgrZOwNYVFg0eDNbClaqJLMZzjpA1Rwx5EjpKL9R6otKX29K_U2_qDB6DC844e1LH1u2Y2_ffFz6QAFgZgq9uQCAaIrIbeAI7BcRsyKv7A5MeUPI:1uLJCs:DPqEPAv8SLeg4Vvk9wJHnS0Om3XWVLEm_iYQnpxMMqI','2025-05-31 10:13:10.005950'),
('pj2o552qtzb3accrt8lyr9rp5irod4z8','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1uG1VU:Da38UJYfEzpW_PaHxKpC_ksy_bDk5cvJbjttXieI3oI','2025-05-30 20:18:12.337635'),
('q3cprse8f3ue47b0ieiwu4xs698wa7ni','.eJxVj8tqwzAQRf9F69jM2Hpm2X2_QcxopNhtsCGSA6X032uHLJLtfR3ur4q0tSluNd_iLOqsUJ1eNab0nZfDkC9aLmuf1qXdZu6PSP90a_-5Sr5-PLNvAxPVaW8X9AUIirZYDGtBCFS0kQGzsSkXQIejlpSFZAy5jC5zQIYctOeh0D56pdoipTbf5_YTW1VndNpbH0C7k9pZ9x23bY8XYlxCL6kj8LbTA0MXjKaujGAPGBOx-vsHmUVRmQ:1uLJu8:ODE0kNGMHFUcUqBeV6MLO6DW-d_BmXBStKf8i1Jtgao','2025-05-31 10:57:37.231711'),
('qcb5kci30z1i42htoxa9erii1tb2v7mo','.eJxVj0uOwjAQRO_iNYm6Y8cflrOfM1htu3sSQImEHaTRiLsTEAtmW68-qj8VaWtT3Cpf41zUUaE6fGqJ8pmXJygnWn7WPq9Lu86pf1r6N63991r48vX2_iuYqE57WtALEIixKGMyBSGQmLEMyKPNLIAOtSmZCxUdWLTjFDABB-PTILSXXqi2SLnNt7n9xlbVEZ3x1o_e-YPat2773La9XgQTSINA59kOndGD7zyE0qEDm7QW0A7U_QGErlA0:1uLJ50:G9vXf22Hw9-h1t_7WEMV6M2_Ce1HKLrxeWQLJesyCFM','2025-05-31 10:05:02.748509'),
('s2qlhnvnjrt3kxkbbbmnbnkqr44vpq6g','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1uI4z8:qvsAtrbulwKxOt2uJQr1qM99sW8MxmxDtR72HRiOG9g','2025-06-05 12:25:18.773968'),
('t0njvcsn5y7bjxz53p00hbidk7u2fsxp','.eJxVj01uwjAQhe_iNYk8ie3YLLvvGayxZ4akRYmEHSSEuDumYlG27-_Tu6uIe53jXvgSF1JHBerwX0uYf3l9GfSD62nr87bWy5L6V6R_u6X_3ojPX-_sx8CMZW5tAS8atRgHYpMh0AHFWBqArcssGiYYDWUmpDGwjBOnAElzMD4Ngm30jKVGzHW5LvUWa1FHmIx33sPgD6qxrg23738vGsVZzLZjEOpMSNIF61JnzZglTw0ZrHo8AZ8eUZE:1uLJfI:CsM_aEUrxGhYnto4xqa5h3XnfxjNLI3nnce17AAMr18','2025-05-31 10:42:32.824424'),
('uak8xcpb7k4pmnvhskgtxw1sord7bk00','.eJxVj0tuwzAMRO-idWyIFkVJWXbfMwjUh7XbwAYiOUBR5O5xiiza7bz5YH5U5L3PcW_1GpeizgrU6a-WOH_V9QnKJ68f25i3tV-XND4t44u28X0r9fL28v4rmLnNR1rAi2YtSCA2YQEdWNCWCaqlXEWDA4Ml18LFhCrG1RQg6RrQp0n4KL1w65FzX25L_469qTM49ORpIjypY-t2zO377wsHNodgpoFdoAGLkYHJ4kDBi0l1IkKj7g-JDVCk:1uLJBE:zOx8HaqoZOiylVV54l6gumpZl5ogqfVuA8UZ2lim-84','2025-05-31 10:11:28.486050'),
('uijp0ae65h7fqela73ij3gj9mjkm35ba','.eJxVj01OwzAQhe_idRN5Go9jd8meM1hjzwwJVIlUO5UQ4u64qAvYvr9P78skOtqSjiq3tLK5GDCnv1qm8iHbw-B32t72sexbu615fETGp1vH153l-vLM_htYqC69rRDUklXnQTE7BhtJHfIZBH0RtTDD5LgIE09RdJolR8hWogv5rNRHr1RbotLW-9o-U6vmArMLPgTAeDKdde-44_h90SkeqeAgoDy4mHWI6POAbipa5o6MaL5_AJ_9UZU:1uLJfo:o96Byxf2YzrHWBjlFwxa2c128J0m4gPNWgKfY7TPcsk','2025-05-31 10:43:04.855388'),
('wiwvrj2nk01vlwx3hby0mwrd9k5gaft7','.eJxVj01uwjAQhe_iNYk88diOWXbfM1gz9rgJoETCDlJVcXcCYkG373s_en8q0tamuFW5xjmrowJ1-NSY0lmWJ8gnWn7WPq1Lu87cPy39m9b-e81y-Xp7_xVMVKc9XWAsmnRBB8UyZtCBCto8gFiXpGjwYDAnyZRNkGK8cADWEnDkodBeeqHaIqU23-b2G1tVR_AYwuiC1Qe1b932uW17vUBngudsOgkeOyQrHRO7ToMdirFkBgR1fwCTIFDp:1uQlY2:dNqBwJHzuQTa_FPvVjJPSUhwrfifO7vLThME20-Ql8o','2025-06-15 12:59:14.017214'),
('xhvdseyyf9hhgr1gmum0qn0smh5qcaps','.eJxVj00OwiAQhe_C2jYMpQVcuvcMZIAZWzVtUqiJMd5dNC50-36-l_cQHrcy-i3T6qck9gLE7lcLGC80v410xvm0tHGZyzqF9h1pv25uj0ui6-Gb_QOMmMfaZrAsUbIegPugE0iHrPukgPohEksw0OkUKWHqHHFnKDgIkpy2QTFW6BVz8RjLdJvK3Zcs9mC0HawD2e1E3brVuW37vLDKkjIRGo5aNRXBTSBNjUGnBjYOgYN4vgCZuFG0:1uLJv2:nN4-2Y-L70p5X5YCaH_qlOlZ_AS62aOx_OOIRsL3-wE','2025-05-31 10:58:33.630253'),
('xsrrbwkuhwt0y64qjwnq1yzjzs058clf','.eJxVj0tuwzAMRO-idWyIEW2ZWXbfMwiUSNZuAxuI5ABF0bvXKbJot_Pmg_lyifc2p73qLS3iLg7c6a-WuXzo-gDyzuvb1pdtbbcl9w9L_6S1f91Ery9P77-Cmet8pA0m8-wNR7Aho4AnNhzkDDqMRc1DhIBSVFgCqYWomSB7JZzy2fgovXJtiUtb7kv7TK26C0SkCT0QndyxdT_m9v33hUUSZB07HwE7HAJ3BBw7DehDgBGY1H3_AI9KULc:1uQ9N1:tmxULKly4X1uo1LFYaYtqXUqL6-htnaOmZfpPny9br8','2025-06-13 20:13:19.797325'),
('yju8n42lesogs4rxc9g3kzvchkc04dk6','.eJxVj0uOwjAQRO_iNYnc8TcsZz9nsNru7kkAJRJ2kEYj7k5ALJhtvfqo_lTCrU1pq3xNM6mjAnX41DKWMy9PQCdcfta-rEu7zrl_Wvo3rf33Snz5env_FUxYpz0tEEWjFutBXLYEekSxjgZg5wuLhgDGUmFCMiOLCZxHyJpHG_MguJdesLaEpc23uf2mVtURgo0--kHbg9q3bvvctr1e5GCMF6GODdjOSokdEobOgUSMxg1GnLo_AJ8IUXw:1uLJAG:gex61eDsW2vnpz5Nqwi3ed_bR7jqtWfRwoREUx6tXno','2025-05-31 10:10:28.464151'),
('yze2j5f8sb010zbn4zcfr01xpp9c27fs','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1tib4N:UYEQtw-PYPuJfE80kzKQdWa5EXDdyyu-MGGttzcMTV4','2025-02-27 15:24:03.847237'),
('zc0au2lwhx7mdx1yzlt6mmpmcdxfd8p7','.eJxVj01uwyAQhe_COrYYGMBk2X3PgGYYqN1GthRwpKrK3eNUWbTb970fvR-VaO9z2lu5pkXUWYE6_dWY8ldZn0A-af3Yxryt_brw-LSML9rG903K5e3l_VcwU5uPdIWpatIVPVTHKKAjVXRioDifS9UQwKLkIiQ2lmpD4QisS8SJTaWj9EKtJ8p9uS39O_WmzhAwGuf0hCd1bN2OuX3_feEE0HtDAyPbAQPwQB558CIBjDG2OKPuD44VUNA:1uNh9g:8TZyaLigic9HDDMUD-nc8vaPRTQgwPi2mJ6g3dgPRYk','2025-06-07 01:41:24.977453'),
('zqi5v33vu8rm9ghe4dilyiu2q12p57bj','.eJxVj01OwzAQhe_idRPNOOPa7pI9Z7DGnjEJVIlUO5UQ4u6kqAvYvu_96H2ZxHuf0970lhYxF4Pm9FfLXD50fQB55_VtG8u29tuSx4dlfNI2vm6i15en91_BzG0-0hVDBYZKZ6wukyBEruTEorpz0QrocSIpKixT1Dp5zREzaKSQbeWj9MqtJy59uS_9M_VmLugpBkc20MkcW_djbt9_X9hYFFD8ABp4IJnCwNX6wRaWCFgcZDXfP5smUZw:1uQD2C:IE_NXYsxS3WvPPIDIisuSDaHlNpHCOL1SJXhEwxdsvY','2025-06-14 00:08:04.399831');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(128) NOT NULL,
  `data` date DEFAULT NULL,
  `descricao` varchar(256) DEFAULT NULL,
  `texto` text DEFAULT NULL,
  `imagem` varchar(100) DEFAULT NULL,
  `visivel` int(11) DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tags`)),
  `seo_descricao` varchar(256) DEFAULT NULL,
  `seo_keywords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`seo_keywords`)),
  `seo_texto` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES
(23,'Confer√™ncia IA Global','2025-06-16','A confer√™ncia \"IA no Servi√ßo P√∫blico\" explora o uso da intelig√™ncia artificial para modernizar e inovar a gest√£o p√∫blica.','O evento aborda temas como automa√ß√£o de processos, an√°lise de dados para tomada de decis√£o, atendimento ao cidad√£o e melhoria da efici√™ncia operacional. Tamb√©m s√£o debatidos os desafios √©ticos, a privacidade dos dados e a inclus√£o tecnol√≥gica, com o objetivo de explorar como a IA pode promover uma gest√£o mais eficiente, acess√≠vel e transparente. A confer√™ncia √© uma oportunidade para compartilhar conhecimentos e boas pr√°ticas, impulsionando a inova√ß√£o no setor p√∫blico.','eventos_imgs/AI.jpeg',NULL,0,'[\"online\", \"inteligencia-artificial\"]','Confer√™ncia IA no Servi√ßo P√∫blico: explore o uso da IA na moderniza√ß√£o da gest√£o p√∫blica, abordando automa√ß√£o, an√°lise de dados, atendimento ao cidad√£o e desafios √©ticos.','[\"Intelig\\u00eancia Artificial\", \"IA\", \"Servi\\u00e7o P\\u00fablico\", \"Gest\\u00e3o P\\u00fablica\", \"Automa\\u00e7\\u00e3o\", \"An\\u00e1lise de Dados\"]','Descubra como a Intelig√™ncia Artificial est√° a revolucionar a gest√£o p√∫blica! A Confer√™ncia IA no Servi√ßo P√∫blico explora a automa√ß√£o de processos, a an√°lise preditiva para tomada de decis√£o, a melhoria do atendimento ao cidad√£o e a otimiza√ß√£o da efici√™ncia operacional.  Debateremos os desafios √©ticos, a privacidade de dados e a inclus√£o tecnol√≥gica, para construir uma gest√£o p√∫blica mais eficiente, transparente e acess√≠vel.  Participe e partilhe boas pr√°ticas com especialistas do setor!'),
(24,'Reshaping the Future: AI-Driven Audit, Risk, and Security','2025-01-08','Confer√™ncia com o tema \"Reshaping the Future\" - AI-driven, Audit, Risk and Security.','Esta confer√™ncia explora o impacto da intelig√™ncia artificial nos campos de auditoria, gest√£o de riscos e seguran√ßa. O evento re√∫ne especialistas e profissionais para discutir como a IA est√° transformando esses setores, abordando inova√ß√µes, desafios e oportunidades. Com foco em temas como automa√ß√£o de processos, preven√ß√£o de fraudes, seguran√ßa cibern√©tica e governan√ßa tecnol√≥gica, a confer√™ncia promove reflex√µes sobre o uso respons√°vel da IA para construir um futuro mais eficiente e seguro.','eventos_imgs/reshapingthefuture.jpg',NULL,0,'[\"online\", \"inteligencia-artificial\"]',NULL,'[]',NULL),
(25,'Green IT','2024-10-15','A confer√™ncia sobre Green IT debate como a tecnologia pode promover sustentabilidade e reduzir impactos ambientais.','A confer√™ncia sobre Green IT explora como a tecnologia da informa√ß√£o pode contribuir para a sustentabilidade ambiental e a redu√ß√£o do impacto ecol√≥gico. O evento aborda temas como efici√™ncia energ√©tica em data centers, pr√°ticas de TI sustent√°vel, economia circular no setor tecnol√≥gico e a ado√ß√£o de solu√ß√µes digitais que promovam a responsabilidade ambiental. Reunindo especialistas, gestores e pesquisadores, a confer√™ncia visa debater estrat√©gias para alinhar inova√ß√£o tecnol√≥gica com pr√°ticas ecol√≥gicas, fomentando um futuro mais sustent√°vel para empresas e governos.','eventos_imgs/GREENIT_B605Qrr.jpeg',NULL,0,'[\"presencial\", \"sustentabilidade\"]',NULL,'[]',NULL),
(26,'Digital Leaders of Tomorrow','2024-04-11','Futureproofing your career in the age of AI.','O Digital Leaders of Tomorrow √© um semin√°rio que ocorre anualmente na Coimbra Business School. Num mundo cada vez mais moldado pela Intelig√™ncia Artificial, preparar a sua carreira para o futuro √© mais importante do que nunca. Esta sess√£o inovadora ir√° explorar estrat√©gias essenciais para se adaptar, destacar e prosperar num mercado de trabalho em constante evolu√ß√£o.\r\n\r\nNesta sess√£o, ir√° descobrir:\r\n->Como identificar e desenvolver as compet√™ncias mais procuradas para o futuro.\r\n->Formas de integrar a IA no seu trabalho para aumentar a produtividade e a criatividade.\r\n->Tend√™ncias emergentes e setores em crescimento que oferecem novas oportunidades.\r\n->Perspetivas de especialistas sobre como a IA est√° a transformar o panorama profissional.\r\n\r\nParticipe nesta confer√™ncia para aprender como transformar desafios em oportunidades e posicionar-se como l√≠der na era da transforma√ß√£o digital. Seja qual for o seu setor ou n√≠vel de experi√™ncia, este evento ir√° equip√°-lo com as ferramentas e conhecimentos para construir uma carreira s√≥lida e preparada para o futuro.','eventos_imgs/DLT_5RPFgQT.jpeg',NULL,0,'[\"online\"]',NULL,'[]',NULL),
(29,'Smart contracts','2025-05-20','Sess√£o de quiz sobre Smart Contracts e Blockchain no dia 20 de maio √†s 15h45, na Sala Fausto Rocha. Testa os teus conhecimentos e ganha 10‚Ç¨ em Bitcoin!','Vem participar numa quiz session interativa sobre Smart Contracts e Auditoria de Blockchain, no pr√≥ximo dia 20 de maio, √†s 15h45, na Sala Fausto Rocha. Esta atividade, promovida no √¢mbito da UC de Auditoria Inform√°tica (Licenciatura em Inform√°tica de Gest√£o ‚Äì 3¬∫ ano), desafia-te a p√¥r √† prova os teus conhecimentos sobre tecnologia blockchain, contratos inteligentes e seguran√ßa digital.\r\nüéØ O vencedor receber√° 10‚Ç¨ em Bitcoin como pr√©mio!\r\nN√£o percas esta oportunidade de aprender, competir e ainda ganhar cripto!\r\n\r\n','eventos_imgs/Smartcontracts.jpg',NULL,0,'[\"presencial\"]',NULL,'[]',NULL),
(30,'Intelig√™ncia Artificial baseada em projetos','2025-06-13','Workshop intensivo sobre a integra√ß√£o da Intelig√™ncia Artificial em projetos pedag√≥gicos, explorando riscos e oportunidades e metodologias inovadoras.','Descubra como a Intelig√™ncia Artificial pode revolucionar a aprendizagem baseada em projetos!  Este workshop imersivo explora as aplica√ß√µes da IA na administra√ß√£o p√∫blica e ind√∫stria, oferecendo oficinas pr√°ticas para docentes e estudantes.  Aprenda a usar a IA em unidades curriculares, atrav√©s da metodologia \'Sala de Aula Aberta\', e explore a idea√ß√£o e mentoria para projetos acad√©micos.  Prepare-se para o futuro, adquirindo compet√™ncias essenciais para o sucesso na era digital.  Inscreva-se agora!','eventos_imgs/1749484644379.jpeg',NULL,0,'[\"presencial\", \"inteligencia-artificial\"]','Workshop intensivo sobre IA em projetos pedag√≥gicos. Explore riscos, oportunidades e metodologias inovadoras para revolucionar a aprendizagem. Inscreva-se!','[\"Intelig\\u00eancia Artificial\", \"IA\", \"Educa\\u00e7\\u00e3o\", \"Projetos Pedag\\u00f3gicos\", \"Workshop\", \"Sala de Aula Aberta\"]','Descubra como a Intelig√™ncia Artificial pode transformar a educa√ß√£o! Este workshop foca a integra√ß√£o da IA em projetos pedag√≥gicos, abordando riscos e oportunidades. Atrav√©s de oficinas pr√°ticas e da metodologia \'Sala de Aula Aberta\', docentes e estudantes aprender√£o a usar a IA em unidades curriculares e projetos acad√©micos.  Explore a idea√ß√£o e mentoria para projetos inovadores e prepare-se para o futuro da educa√ß√£o digital. Inscreva-se agora e adquira compet√™ncias essenciais para a era digital!');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `apelido` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `data_subscricao` datetime(6) NOT NULL,
  `ativo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter`
--

LOCK TABLES `newsletter` WRITE;
/*!40000 ALTER TABLE `newsletter` DISABLE KEYS */;
INSERT INTO `newsletter` VALUES
(1,'Pedro','de la cruz','ppedro.ssantos21@gmail.com','2025-05-16 19:16:13.805409',1),
(2,'jonny','aa','ppedro.ssantos21@gmail.coma','2025-05-31 11:55:27.484836',1),
(3,'joao','aaa','123@gmail.com','2025-06-13 12:14:53.978908',1),
(4,'asdasd','santos','ppedro.ssantosaass21@gmail.com','2025-06-13 19:39:53.718640',1);
/*!40000 ALTER TABLE `newsletter` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-06-15 19:59:22
