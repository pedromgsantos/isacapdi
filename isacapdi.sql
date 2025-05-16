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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(56,'Can view django job execution',14,'view_djangojobexecution');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$870000$UQU8dRV2FKQaipJDLN5Dxg$HFhjySJUlikV+LqKCNFPdRUobWDgzTBXRf8bHviUf9c=','2025-05-16 19:16:25.278765',1,'pedro','Pedro','Santos','ppedro.ssantos21@gmail.com',1,1,'2025-02-13 15:20:52.000000'),
(2,'pbkdf2_sha256$870000$71uFQr8CUrMMXl4aA7YEku$76saiPJQhDCqTHVKYaJMiDwYp7Hqy/F3KmUm0BjdCTM=',NULL,0,'Henrique','','','',0,1,'2025-03-06 15:47:01.877541');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES
(3,'ppedro.ssantos21@gmail.comp','pedro123','2025-05-16 13:22:02.041020',24);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
INSERT INTO `contactos` VALUES
(1,'Pedro','ppedro.ssantos21@gmail.com','Certificados','123',NULL,NULL,NULL,'2025-05-16 13:30:09.287923',0),
(2,'Anos do Pedro :)','ppedro.ssantos21@gmail.com','Ser Membro ISACA','quero entrar','2¬∫ Ano','Licenciatura','Gest√£o de Empresas','2025-05-16 13:31:38.041090',0),
(3,'Pedro','ppedro.ssantos21@gmail.com','Outro','111',NULL,NULL,NULL,'2025-05-16 13:41:50.201510',0),
(4,'Pedro','ppedro.ssantos21@gmail.com','Ser Membro ISACA','111','1.¬∫ Ano','Mestrado','Marketing e Neg√≥cios Internacionais','2025-05-16 13:45:48.367984',0),
(5,'Pedro','ppedro.ssantos21@gmail.com','Ser Membro ISACA','12','1.¬∫ Ano','Licenciatura','Contabilidade e Auditoria','2025-05-16 13:45:58.204264',0),
(6,'jonny','asdas@pedro.com','Certificados','como?',NULL,NULL,NULL,'2025-05-16 13:50:29.340686',0),
(7,'Pedro√ßalallalala','ben.10.pedro@hotmail.com','Ser Membro ISACA','12','2.¬∫ Ano','Licenciatura','Ci√™ncia de Dados para a Gest√£o','2025-05-16 13:50:47.588523',0);
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_newsarticle`
--

LOCK TABLES `dashboard_newsarticle` WRITE;
/*!40000 ALTER TABLE `dashboard_newsarticle` DISABLE KEYS */;
INSERT INTO `dashboard_newsarticle` VALUES
(1,'IT/OT Convergence: An Era of Interconnected Risk and Reward','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/an-era-of-interconnected-risk-and-reward','Successful IT/OT convergence comes down to aligning three distinct paradigms: IT Operations, OT Operations and Cyber Operations.','2025-05-15 00:00:00.000000','2025-05-16 16:42:02.417608',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/deidre-diamond_blog.png'),
(2,'Ethics, Accountability, and the Pursuit of Responsible AI','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/ethics-accountability-and-the-pursuit-of-responsible-ai','Addressing accountability in AI deployment is essential to safeguarding integrity and societal well-being. This will require increased transparency within explainable AI and strengthened ethical governance.','2025-05-16 19:12:17.560716','2025-05-16 16:42:02.422078',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_ethics-accountability.png'),
(3,'Securing Desktops and Data from Ransomware Attacks','https://www.isaca.org/resources/news-and-trends/isaca-podcast-library/securing-desktops-and-data-from-ransomware-attacks','Ransomware remains one of the most formidable cybersecurity threats facing organizations worldwide.','2025-05-16 00:00:00.000000','2025-05-16 16:42:02.425374',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/resources/podcasts/featured/netwrix_logo_550.png'),
(4,'Seven Strategies Business Leaders Can Adopt to Protect Operational Technologies and Critical Infrastructure Against Sophisticated Cyber Threats','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/seven-strategies-to-protect-against-sophisticated-cyber-threats','Tailored strategies to protect critical assets are needed at a time when the attack surface is expanding, putting critical infrastructure at heightened risk.','2025-05-13 00:00:00.000000','2025-05-16 16:42:02.428578',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/ope-ajibola_blog.png'),
(5,'Vendor Risk Assessments: Do Organizations Still Need Them?','https://www.isaca.org/resources/news-and-trends/industry-news/2025/vendor-risk-assessments-do-organizations-still-need-them','While it is acceptable and commonplace to have work completed by another vendor based on mutually agreed contracts, the overall management of related risk is a pertinent point of attention.','2025-05-12 00:00:00.000000','2025-05-16 16:42:02.431679',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/vj-srinivas.png'),
(6,'Mindfully Befriending Your Certification Exam-Day Anxiety','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/mindfully-befriending-your-certification-exam-day-anxiety','Certification exam day can be stressful for exam-takers, but a mindful approach can go a long way toward constructively dealing with the nerves and improving performance.','2025-05-09 00:00:00.000000','2025-05-16 16:42:02.435166',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/natasha-barnes_blog.png'),
(7,'Six Steps for Third-Party AI Risk Management','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/six-steps-for-third-party-ai-risk-management','ISACA members Mary Carmichael and Dooshima Dabo\'Adzuana shared their insights in a session on third-party AI risk at RSA Conference 2025.','2025-05-08 00:00:00.000000','2025-05-16 16:42:02.439271',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/mary-carmichael_dooshima-dapo-oyewole_blog.png'),
(8,'The Zero-ETL Paradigm: Transforming Enterprise Data Integration in Real Time','https://www.isaca.org/resources/news-and-trends/industry-news/2025/the-zero-etl-paradigm-transforming-enterprise-data-integration-in-real-time','Zero-ETL offers direct data movement capabilities and advanced cloud technologies and allows for the leveraging of modern architectural patterns to enable real-time data access while significantly reducing operational complexity and costs.','2025-05-08 00:00:00.000000','2025-05-16 16:42:02.442846',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/shamnad-shaffi.png'),
(9,'Detecting and Mitigating APTs in Endpoints','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/detecting-and-mitigating-apts-in-endpoints','Organizations relying on standard security tools may miss sophisticated APT techniques unless they implement specialized threat intelligence and proactive monitoring strategies.','2025-05-16 19:12:17.595219','2025-05-16 16:42:02.447482',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_detecting-and-mitigating.png'),
(10,'Fortifying Digital Defenses: The Imperative of a Unified Cybersecurity Platform','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/the-imperative-of-a-unified-cybersecurity-platform','A data-driven and cost-effective strategy‚Äîcentered on governance, technology, and human expertise‚Äîis the approach organizations need to improve their cybersecurity posture and resilience.','2025-05-06 00:00:00.000000','2025-05-16 16:42:02.451610',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/welland-chu_blog.png'),
(11,'ISACA Research: Quantum Computing Preparedness Lagging','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-9/quantum-computing-preparedness-lagging','Quantum computing advancements pose a massive risk to cybersecurity and business stability, but many enterprises are not yet responding accordingly, according to new research from ISACA‚Äôs global Quantum Computing Pulse Poll.','2025-05-05 00:00:00.000000','2025-05-16 16:42:02.455242',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250505-newsletter-article.png'),
(12,'The Perfect Recipe for the Homogenius Technologicus: Next-Gen Auditors','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-9/the-perfect-recipe-for-the-homogenius-technologicus-next-gen-auditors','By combining curiosity, expertise and collaboration, we can prepare auditors who are not only skilled but also inspired to drive transformative change in their organizations.','2025-05-05 00:00:00.000000','2025-05-16 16:42:02.459688',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/chidambaram-narayanan_newsletter-article.png'),
(13,'The 2025 Software Supply Chain Security Report: Threats Growing and Evolving','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/the-2025-software-supply-chain-security-report','The threat landscape facing software today is changing fast! RL‚Äôs new research report explores those changes and shares key learnings and action items.','2025-05-05 00:00:00.000000','2025-05-16 16:42:02.463391',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/carolynn-van-arsdale_blog.png'),
(14,'ISACA 2024 Annual Report Showcases Future Focus','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isaca-2024-annual-report-showcases-future-focus','The 2024 ISACA Annual Report provides insight into how ISACA is working to future-proof members\' careers in a time of volatility and innovation across the digital trust fields.','2025-05-02 00:00:00.000000','2025-05-16 16:42:02.467240',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/why-isaca/annual-report/2024-annual-report_550.png'),
(15,'Protecting Kubernetes Clusters and Workloads at Scale','https://www.isaca.org/resources/news-and-trends/industry-news/2025/protecting-kubernetes-clusters-and-workloads-at-scale','As organizations increasingly adopt Kubernetes for its scalability and flexibility, it is imperative to prioritize the security of both Kubernetes clusters and workloads.','2025-05-01 00:00:00.000000','2025-05-16 16:42:02.471237',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/nivathan-somasundharam.png'),
(16,'Information Security Matters: Artificial Intelligence‚ÄîEthics and Security','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/artificial-intelligence-ethics-and-security','Any information gained by AI should be managed so that only those who are authorized to use it may do so. The use of AI systems should be monitored to ensure that it is not being abused.','2025-05-16 19:12:17.626340','2025-05-16 16:42:02.475135',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_ai-ethics.png'),
(17,'The Digital Trust Imperative: Building Trust Through Transparency‚ÄîAddressing Digital Exhaust','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/building-trust-through-transparency','Organizations have an imperative to share what data is collected and how it is going to be used. Their choices in using said data must bring value back to the customer.','2025-05-16 19:12:17.630385','2025-05-16 16:42:02.479033',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_building-trust.png'),
(18,'Privacy in Practice: Rules for Thee But Not for Me','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/rules-for-thee-but-not-for-me','The removal of end-to-end encryption in the United Kingdom is problematic. Additionally, governments appear to have conflicting attitudes toward privacy, which ultimately can lead to the erosion of individuals‚Äô right to privacy.','2025-05-16 19:12:17.633582','2025-05-16 16:42:02.482784',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_rules-for-thee.png'),
(19,'AI‚Äôs Evolving Impact on the IT Risk Landscape','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/ais-evolving-impact-on-the-it-risk-landscape','The impact of AI will be systemic. Accordingly, significant changes to the way professionals approach risk management for AI are in order.','2025-05-16 19:12:17.637289','2025-05-16 16:42:02.486165',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_ai-evolving.png'),
(20,'Rethinking ESG: Balancing Profit and Purpose','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/rethinking-esg','There is a need to manage the tension created by the innovation‚Äìintegrity dilemma in the interests of sustainable outcomes for both people and planet.','2025-05-16 19:12:17.640665','2025-05-16 16:42:02.489151',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_rethinking-esg.png'),
(21,'The Power of Accountability in AI Governance','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/the-power-of-accountability-in-ai-governance','Establishing AI accountability mechanisms can be straightforward, especially when leveraging governance frameworks that are already available.','2025-05-16 19:12:17.644283','2025-05-16 16:42:02.492037',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_the-power.png'),
(22,'Examining the Ethics of the Digital Afterlife Industry','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/examining-the-ethics-of-the-digital-afterlife-industry','The digital afterlife is a fast-developing area of innovation. It engages sensitive matters in the realm of ethics and emerging technologies.','2025-05-16 19:12:17.648009','2025-05-16 16:42:02.494897',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_examining-the-ethics.png'),
(23,'Behind the Machines: Uncovering Occupational Fraud in Digital Banking','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/behind-the-machines','Somewhere a trusted employee, embedded within the core of an institution, is secretly siphoning off resources for personal gain.','2025-05-16 19:12:17.651971','2025-05-16 16:42:02.497836',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_behind-the-machines.png'),
(24,'Mergers and Acquisitions: Bracing for the Information Security Aftershock','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/mergers-and-acquisitions','Before deciding to enter a merger or make an acquisition, it is imperative to conduct a comprehensive analysis of the target organization\'s cybermaturity.','2025-05-16 19:12:17.655962','2025-05-16 16:42:02.501232',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_mergers-and-acquisitions.png'),
(25,'CMMI in the AI Age: Driving Efficiency, Innovation, and Governance','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/cmmi-in-the-ai-age','CMMI provides a framework to assess, refine, and optimize capabilities. With AI-driven insights and automation, organizations can accelerate decision making and process enhancements.','2025-05-16 19:12:17.659835','2025-05-16 16:42:02.504228',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_cmmi-ai-age.png'),
(26,'A Practical Approach to ESA Implementation at Small and Medium Enterprises','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/a-practical-approach-to-esa-implementation-at-small-and-medium-enterprises','SMEs can establish an enterprise security architecture by taking a step-by-step approach emphasizing practical strategies.','2025-05-16 19:12:17.663104','2025-05-16 16:42:02.507091',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_a-practical-approach.png'),
(27,'Optimizing Crypto Custody Operations With COBIT','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-3/optimizing-crypto-custody-operations-with-cobit','A leading provider of crypto asset services strengthened its data governance framework to enhance customer experiences, drive innovation, and maintain a competitive edge.','2025-05-16 19:12:17.666664','2025-05-16 16:42:02.509971',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-3/j25v3_optimizing-crypto.png'),
(28,'Elevating ISACA\'s Impact: Building a High-Performing Board for the Future','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/elevating-isacas-impact-building-a-high-performing-board-for-the-future','ISACA Board Director Asaf Weisberg addresses the Board\'s composition and varied backgrounds in this installment of Notes from the Boardroom.','2025-04-30 00:00:00.000000','2025-05-16 16:42:02.512923',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/asaf-weisberg_blog.png'),
(29,'No More Excuses for Procrastinating on Quantum Preparation','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/no-more-excuses-for-procrastinating-on-quantum-preparation','We have an urgency problem when it comes to quantum computing that is rivaling even the underlying technology challenge.','2025-04-28 00:00:00.000000','2025-05-16 16:42:02.516533',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/rob-clyde-blog.png'),
(30,'Preparing Our Stakeholders to Navigate Quantum Computing','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/preparing-our-stakeholders-to-navigate-quantum-computing','Within the cybersecurity space, quantum computing has often been linked to doomsday scenarios such as the cracking of RSA.','2025-04-28 00:00:00.000000','2025-05-16 16:42:02.519527',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/donavan-cheah-blog_1.png'),
(31,'Post-Quantum Cryptography: A Call to Action','https://www.isaca.org/resources/news-and-trends/industry-news/2025/post-quantum-cryptography-a-call-to-action','While the world has been laser-focused on artificial intelligence (AI), major advancements are occurring in quantum computing.','2025-04-28 00:00:00.000000','2025-05-16 16:42:02.522419',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/collin-beder.png'),
(32,'Strategic CIO Responses to Today‚Äôs Leadership Trends','https://www.isaca.org/resources/news-and-trends/industry-news/2025/strategic-cio-responses-to-todays-leadership-trends','The strategic chief information officer (CIO) must keep an eye not only on the evolving technology landscape, but also on evolving leadership and governance trends and their inevitable dilemmas, as these factors shape IT strategy and influence the way IT productively enables enterprise value creation.','2025-04-25 00:00:00.000000','2025-05-16 16:42:02.526692',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/digital-trust/state-of-digital-trust/guy-pearce_550x550.png'),
(33,'Lessons from the CCOA: Failing Forward as a Cybersecurity Leader','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/lessons-from-the-ccoa-failing-forward-as-a-cybersecurity-leader','A failed attempt at the CCOA exam provided important lessons learned and deepened my commitment to earning ISACA\'s new cybersecurity credential.','2025-04-24 00:00:00.000000','2025-05-16 16:42:02.529677',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/ravi-ragoonanan_blog.png'),
(34,'Mitigating the Cybersecurity Workforce Shortage With the NIST NICE Framework','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/mitigating-the-cybersecurity-workforce-shortage-with-the-nist-nice-framework','There is a dire need for workers with marketable security skills, from traditional information security to modern cybersecurity.','2025-05-16 19:12:17.692784','2025-05-16 16:42:02.533607',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_mitigating-the-cybersecurity.png'),
(35,'Adaptive Access Control: Navigating Cybersecurity in the Era of AI and Zero Trust','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/adaptive-access-control-navigating-cybersecurity-in-the-era-of-ai-and-zero-trust','Adaptive Access Control, an AI-driven security approach, gives organizations a better opportunity to counteract the modern, sophisticated threat landscape.','2025-04-22 00:00:00.000000','2025-05-16 16:42:02.536637',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/ola-akinsuli_blog.png'),
(36,'Proven Strategies to Uncover AI Risks and Strengthen Audits','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-8/proven-strategies-to-uncover-ai-risks-and-strengthen-audits','Artificial Intelligence (AI) often conjures images of futuristic concepts. Yet, it has propelled today\'s business innovation.','2025-04-21 00:00:00.000000','2025-05-16 16:42:02.540213',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/maman-ibrahim_newsletter-article.png'),
(37,'Volunteer Appreciation Week: Get Involved with ISACA','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-8/volunteer-appreciation-week-get-involved-with-isaca','This Volunteer Appreciation Week (20-26 April) we‚Äôre celebrating our volunteers around the world.','2025-04-21 00:00:00.000000','2025-05-16 16:42:02.543666',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250421-newsletter-article.png'),
(38,'ISACA Career Catalyst Stories: Freeman Ng, Principal Consultant at iSystems Security Limited','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isaca-career-catalyst-stories-freeman-ng-principal-consultant-at-isystems-security-limited','A major career change meant that Freeman Ng had to prove himself all over again, and turning to ISACA played a big part in his next phase.','2025-04-21 00:00:00.000000','2025-05-16 16:42:02.547444',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/freeman-ng_blog.png'),
(39,'ISACA‚Äôs Growing Influence as a Resource for Governments','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/isacas-growing-influence-as-a-resource-for-governments','ISACA\'s growing policy influence with global governments will create healthier digital trust disciplines and expand opportunities for ISACA members.','2025-04-18 00:00:00.000000','2025-05-16 16:42:02.550383',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/massimo-migliuolo_blog.png'),
(40,'Debunking Cybersecurity Myths in 2025','https://www.isaca.org/resources/news-and-trends/industry-news/2025/debunking-cybersecurity-myths-in-2025','ITis prudent to examine and debunk some of the most overt cybersecurity misconceptions and exaggerations circulating today and provide accurate information. This empowers organizations to reinforce their infrastructure and connected assets and technologies','2025-04-18 00:00:00.000000','2025-05-16 16:42:02.553663',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/chester-avey.png'),
(41,'Welcome to the IT Audit Awards: Ctrl + Alt + Defend Night','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/welcome-to-the-it-audit-awards','From Phantom Access to the Longest Audit Report and beyond, these IT Audit Awards come in many categories that might not be as much of a joke as we\'d like to think.','2025-04-17 00:00:00.000000','2025-05-16 16:42:02.556608',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/chidambaram-narayanan-blog.png'),
(42,'Practical Strategies to Overcome Cyber Security Compliance Standards Fatigue','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/practical-strategies-to-overcome-cyber-security-compliance-standards-fatigue','Elizabeth Kinuthia shares three practical strategies cyber teams can deploy to overcome compliance fatigue.','2025-04-16 00:00:00.000000','2025-05-16 16:42:02.559815',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/liz-kinuthia_blog.png'),
(43,'The Governance Game of Chess: Mapping ISO/IEC 27001:2022 to COBIT¬Æ','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/the-governance-game-of-chess-mapping-isoiec-27001-2022-to-cobit','The opening moves in the game of chess can be used to map controls specified in ISACA‚Äôs COBIT¬Æ framework to the ISO/IEC 27001:2022 standard outcomes.','2025-05-16 19:12:17.728239','2025-05-16 16:42:02.563006',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_governance-game.png'),
(44,'An Overnight Wakeup Call: Coordinating Responses to Major Cyber Attacks','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/an-overnight-wakeup-call-coordinating-responses-to-major-cyber-attacks','Gamification can be an effective approach to trust-building that will allow diverse stakeholders to be better prepared to deal with stressful and high-stakes cybersecurity incidents.','2025-04-14 00:00:00.000000','2025-05-16 16:42:02.566165',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/mary-carmichael.png'),
(45,'CIO vs. CISO: The Key Differences ‚Äî and Why They Matter','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/cio-vs-ciso-the-key-differences-and-why-they-matter','Discover the key differences between the CIO and CISO positions ‚Äî including responsibilities, education and certifications ‚Äî and why they matter.','2025-04-10 00:00:00.000000','2025-05-16 16:42:02.569931',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/michelle-moore_blog.png'),
(46,'Lessons from The Art of War: A Fresh Look at Modern Auditing','https://www.isaca.org/resources/news-and-trends/isaca-now-blog/2025/a-fresh-look-at-modern-auditing','Maman Ibrahim shares the lessons auditors can learn from Sun Tzu\'s The Art of War.','2025-04-09 00:00:00.000000','2025-05-16 16:42:02.574044',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/isaca-now-blog/maman-ibrahim_blog.png'),
(47,'Cybersecurity Governance in Digital Transformation','https://www.isaca.org/resources/news-and-trends/industry-news/2025/cybersecurity-governance-in-digital-transformation','Digital transformation initiatives have become a major investment priority as organizations strive to leverage technology to reshape business models, drive efficiency and growth, and gain competitive advantage.','2025-04-09 00:00:00.000000','2025-05-16 16:42:02.577283',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/articles/industry-news/authors/oma-martins-okonkwo.png'),
(48,'The Board of Directors and the Volcano Dilemma: Due Care in the Face of Enterprise Cyberrisk','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/the-board-of-directors-and-the-volcano-dilemma-due-care-in-the-face-of-enterprise-cyberrisk','Recent research states that \"[a]ny attempt to ‚Äòpredict‚Äô the future is futile, which usually results in executives simply not bothering to determine how various political, regulatory changes or the manifestation of cyber risk (emphasis added) may affect their operations.\"','2025-05-16 19:12:17.747045','2025-05-16 16:42:02.581663',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_bod.png'),
(49,'Applying Interstellar Wisdom to Navigate the Digital Age','https://www.isaca.org/resources/isaca-journal/issues/2025/volume-2/applying-interstellar-wisdom-to-navigate-the-digital-age','The film Interstellar parallels the pressing issues of sustainability, the evolving role of AI, and the importance of resilience in the face of technological advancement.','2025-05-16 19:12:17.750891','2025-05-16 16:42:02.585207',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/journal/2025/volume-2/j25v2_applying-interstellar-wisdom.png'),
(51,'ISACA Certification-Holders Share Top Tips for Exam Success','https://www.isaca.org/resources/news-and-trends/newsletters/atisaca/2025/volume-7/isaca-certification-holders-share-top-tips-for-exam-success','Preparing for a certification exam can be quite challenging, but a strategic and disciplined approach can help position certification candidates for success on exam day.','2025-04-07 00:00:00.000000','2025-05-16 19:12:17.757123',1,'https://www.isaca.org/-/media/images/isacadp/project/isaca/atisaca/tiles/2025/at-isaca-20250407-newsletter-article.png');
/*!40000 ALTER TABLE `dashboard_newsarticle` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES
(1,'2025-02-13 15:44:50.477513','1','pedro',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]',4,1),
(2,'2025-02-27 18:21:24.752605','13','Eventos object (13)',1,'[{\"added\": {}}]',10,1),
(3,'2025-03-06 15:47:02.579384','2','Henrique',1,'[{\"added\": {}}]',4,1);
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
('fetch_news_job','2025-05-19 02:00:00.000000','Äï>\0\0\0\0\0\0}î(åversionîKåidîåfetch_news_jobîåfuncîå\"dashboard.scheduler:run_fetch_newsîåtriggerîåapscheduler.triggers.cronîåCronTriggerîìî)Åî}î(hKåtimezoneîåbuiltinsîågetattrîìîåzoneinfoîåZoneInfoîìîå	_unpickleîÜîRîå\rEurope/LondonîKÜîRîå\nstart_dateîNåend_dateîNåfieldsî]î(å apscheduler.triggers.cron.fieldsîå	BaseFieldîìî)Åî}î(ånameîåyearîå\nis_defaultîàåexpressionsî]îå%apscheduler.triggers.cron.expressionsîå\rAllExpressionîìî)Åî}îåstepîNsbaubhå\nMonthFieldîìî)Åî}î(h\"åmonthîh$àh%]îh))Åî}îh,NsbaubhåDayOfMonthFieldîìî)Åî}î(h\"ådayîh$àh%]îh))Åî}îh,Nsbaubhå	WeekFieldîìî)Åî}î(h\"åweekîh$àh%]îh))Åî}îh,NsbaubhåDayOfWeekFieldîìî)Åî}î(h\"åday_of_weekîh$âh%]îh\'åWeekdayRangeExpressionîìî)Åî}î(h,NåfirstîK\0ålastîK\0ubaubh)Åî}î(h\"åhourîh$âh%]îh\'åRangeExpressionîìî)Åî}î(h,NhOKhPKubaubh)Åî}î(h\"åminuteîh$âh%]îhV)Åî}î(h,NhOK\0hPK\0ubaubh)Åî}î(h\"åsecondîh$àh%]îhV)Åî}î(h,NhOK\0hPK\0ubaubeåjitterîNubåexecutorîådefaultîåargsî)åkwargsî}îh\"årun_fetch_newsîåmisfire_grace_timeîKåcoalesceîàå\rmax_instancesîKå\rnext_run_timeîådatetimeîådatetimeîìîC\nÈ\0\0\0\0\0îhÜîRîu.');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(8,'dashboard','comentarios'),
(9,'dashboard','contactos'),
(10,'dashboard','eventos'),
(12,'dashboard','newsarticle'),
(11,'dashboard','newsletter'),
(7,'dashboard','user'),
(13,'django_apscheduler','djangojob'),
(14,'django_apscheduler','djangojobexecution'),
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(59,'dashboard','0004_newsarticle_dashboard_n_publish_5e8710_idx','2025-05-16 19:05:46.188144');
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
('9avnga7zpiihfficfv4e5sbo7vbrfsdv','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1u7Kok:2gPpzpn6F-qnoOulCEN7rQEN-MNMJjkt8QMUynVswIQ','2025-05-06 21:06:10.899506'),
('cdiimumrj3dgdftv6ubsnvlorr8ik4qh','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1tuv2E:xgpAqNVhT64qBYWS7F93sQfXi-T4R1pgeM6zM3qcgY8','2025-04-02 15:08:46.797652'),
('d2kcvmkddd4oe5ak1tcmt36bieuvsjvq','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1tyGJP:EZlF6PbOuDdlyP0kl1jgRX86tJqKuALo2tg2pAfAlHU','2025-04-11 20:28:19.190935'),
('xbkrilq6midvyb2u2puv8d4n5old2ag0','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1uG0Xh:UYsB1fhzWooC2BpepgUnMITIfJkiAjGcqEBMWeYU-5k','2025-05-30 19:16:25.281379'),
('yze2j5f8sb010zbn4zcfr01xpp9c27fs','.eJxVjEEOwiAQRe_C2hCmhba4dO8ZyMDMSNVAUtqV8e7apAvd_vfef6mA25rD1ngJM6mzAnX63SKmB5cd0B3LrepUy7rMUe-KPmjT10r8vBzu30HGlr-1wCQGjdgBxEVLYDyKddQBuyGxGBiht5SYkHrP0o8cPUTD3k6xE1TvD_W6OLY:1tib4N:UYEQtw-PYPuJfE80kzKQdWa5EXDdyyu-MGGttzcMTV4','2025-02-27 15:24:03.847237');
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES
(23,'Confer√™ncia IA Global','2025-05-13','A confer√™ncia \"IA no Servi√ßo P√∫blico\" explora o uso da intelig√™ncia artificial para modernizar e inovar a gest√£o p√∫blica.','O evento aborda temas como automa√ß√£o de processos, an√°lise de dados para tomada de decis√£o, atendimento ao cidad√£o e melhoria da efici√™ncia operacional. Tamb√©m s√£o debatidos os desafios √©ticos, a privacidade dos dados e a inclus√£o tecnol√≥gica, com o objetivo de explorar como a IA pode promover uma gest√£o mais eficiente, acess√≠vel e transparente. A confer√™ncia √© uma oportunidade para compartilhar conhecimentos e boas pr√°ticas, impulsionando a inova√ß√£o no setor p√∫blico.','eventos_imgs/AI.jpeg',NULL,0,'[\"online\", \"inteligencia-artificial\"]'),
(24,'Reshaping the Future: AI-Driven Audit, Risk, and Security','2025-01-08','Confer√™ncia com o tema \"Reshaping the Future\" - AI-driven, Audit, Risk and Security.','Esta confer√™ncia explora o impacto da intelig√™ncia artificial nos campos de auditoria, gest√£o de riscos e seguran√ßa. O evento re√∫ne especialistas e profissionais para discutir como a IA est√° transformando esses setores, abordando inova√ß√µes, desafios e oportunidades. Com foco em temas como automa√ß√£o de processos, preven√ß√£o de fraudes, seguran√ßa cibern√©tica e governan√ßa tecnol√≥gica, a confer√™ncia promove reflex√µes sobre o uso respons√°vel da IA para construir um futuro mais eficiente e seguro.','eventos_imgs/reshapingthefuture.jpg',NULL,0,'[\"online\", \"inteligencia-artificial\"]'),
(25,'Green IT','2024-10-15','A confer√™ncia sobre Green IT debate como a tecnologia pode promover sustentabilidade e reduzir impactos ambientais.','A confer√™ncia sobre Green IT explora como a tecnologia da informa√ß√£o pode contribuir para a sustentabilidade ambiental e a redu√ß√£o do impacto ecol√≥gico. O evento aborda temas como efici√™ncia energ√©tica em data centers, pr√°ticas de TI sustent√°vel, economia circular no setor tecnol√≥gico e a ado√ß√£o de solu√ß√µes digitais que promovam a responsabilidade ambiental. Reunindo especialistas, gestores e pesquisadores, a confer√™ncia visa debater estrat√©gias para alinhar inova√ß√£o tecnol√≥gica com pr√°ticas ecol√≥gicas, fomentando um futuro mais sustent√°vel para empresas e governos.','eventos_imgs/GREENIT_B605Qrr.jpeg',NULL,0,'[\"presencial\", \"sustentabilidade\"]'),
(26,'Digital Leaders of Tomorrow','2024-04-11','Futureproofing your career in the age of AI.','O Digital Leaders of Tomorrow √© um semin√°rio que ocorre anualmente na Coimbra Business School. Num mundo cada vez mais moldado pela Intelig√™ncia Artificial, preparar a sua carreira para o futuro √© mais importante do que nunca. Esta sess√£o inovadora ir√° explorar estrat√©gias essenciais para se adaptar, destacar e prosperar num mercado de trabalho em constante evolu√ß√£o.\r\n\r\nNesta sess√£o, ir√° descobrir:\r\n->Como identificar e desenvolver as compet√™ncias mais procuradas para o futuro.\r\n->Formas de integrar a IA no seu trabalho para aumentar a produtividade e a criatividade.\r\n->Tend√™ncias emergentes e setores em crescimento que oferecem novas oportunidades.\r\n->Perspetivas de especialistas sobre como a IA est√° a transformar o panorama profissional.\r\n\r\nParticipe nesta confer√™ncia para aprender como transformar desafios em oportunidades e posicionar-se como l√≠der na era da transforma√ß√£o digital. Seja qual for o seu setor ou n√≠vel de experi√™ncia, este evento ir√° equip√°-lo com as ferramentas e conhecimentos para construir uma carreira s√≥lida e preparada para o futuro.','eventos_imgs/DLT_5RPFgQT.jpeg',NULL,1,'[\"online\"]');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter`
--

LOCK TABLES `newsletter` WRITE;
/*!40000 ALTER TABLE `newsletter` DISABLE KEYS */;
INSERT INTO `newsletter` VALUES
(1,'Pedro','de la cruz','ppedro.ssantos21@gmail.com','2025-05-16 19:16:13.805409',1);
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

-- Dump completed on 2025-05-16 20:36:26
