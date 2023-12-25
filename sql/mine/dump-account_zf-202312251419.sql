-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: account_zf
-- ------------------------------------------------------
-- Server version	11.2.2-MariaDB-1:11.2.2+maria~ubu2204

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `AccountID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) NOT NULL,
  `Password` varchar(70) NOT NULL,
  `Salt` varchar(45) DEFAULT NULL,
  `AuthorityID` smallint(6) unsigned NOT NULL DEFAULT 1,
  `StatusID` smallint(6) unsigned NOT NULL DEFAULT 1,
  `IPAddress` varchar(45) DEFAULT NULL,
  `MacAddress` varchar(64) NOT NULL DEFAULT '',
  `Registered` datetime NOT NULL DEFAULT current_timestamp(),
  `VipLevel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ParentIdentity` int(4) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`AccountID`) USING BTREE,
  UNIQUE KEY `AccountID_UNIQUE` (`AccountID`) USING BTREE,
  UNIQUE KEY `Username_UNIQUE` (`Username`) USING BTREE,
  KEY `fk_account_account_authority_idx` (`AuthorityID`) USING BTREE,
  KEY `fk_account_account_status_idx` (`StatusID`) USING BTREE,
  CONSTRAINT `fk_account_account_authority` FOREIGN KEY (`AuthorityID`) REFERENCES `account_authority` (`AuthorityID`),
  CONSTRAINT `fk_account_account_status` FOREIGN KEY (`StatusID`) REFERENCES `account_status` (`StatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (7,'test','3c4d012c6ba416731e1d1f11123899a241a564e5a9098e609b62a1add1991130','ie4f0WTDZ70pbuLPdjuj3HjeMySToO',7,7,'127.0.0.1','7','2023-12-21 20:18:12',0,0);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `account_passwordhash` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
    
	
	
	
	
	
	
	
	
    
	
	IF (NEW.`Salt` IS NULL) THEN
    
		IF (LENGTH(NEW.`Password`) > 16) THEN
			SET NEW.`Password` = NULL;
        END IF;
        
        SET NEW.`Salt` = MD5(RAND());
        SET NEW.`Password` = SHA2(CONCAT(NEW.`Password`, NEW.`Salt`), 256);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `account_authority`
--

DROP TABLE IF EXISTS `account_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_authority` (
  `AuthorityID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `AuthorityName` varchar(45) NOT NULL,
  PRIMARY KEY (`AuthorityID`) USING BTREE,
  UNIQUE KEY `AuthorityID_UNIQUE` (`AuthorityID`) USING BTREE,
  UNIQUE KEY `AuthorityName_UNIQUE` (`AuthorityName`) USING BTREE,
  KEY `AuthorityID` (`AuthorityID`) USING BTREE,
  KEY `AuthorityID_2` (`AuthorityID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_authority`
--

LOCK TABLES `account_authority` WRITE;
/*!40000 ALTER TABLE `account_authority` DISABLE KEYS */;
INSERT INTO `account_authority` VALUES (7,'PM');
/*!40000 ALTER TABLE `account_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_ban`
--

DROP TABLE IF EXISTS `account_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_ban` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` int(10) unsigned NOT NULL DEFAULT 0,
  `AccountId` int(10) unsigned NOT NULL DEFAULT 0,
  `BanTime` datetime NOT NULL DEFAULT current_timestamp(),
  `ExpireTime` datetime NOT NULL DEFAULT '2199-12-31 23:59:59',
  `BannedBy` int(10) unsigned NOT NULL DEFAULT 0,
  `Reason` varchar(255) NOT NULL DEFAULT '',
  `UpdatedAt` datetime DEFAULT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_ban`
--

LOCK TABLES `account_ban` WRITE;
/*!40000 ALTER TABLE `account_ban` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_status`
--

DROP TABLE IF EXISTS `account_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_status` (
  `StatusID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `StatusName` varchar(45) NOT NULL,
  PRIMARY KEY (`StatusID`) USING BTREE,
  UNIQUE KEY `StatusID_UNIQUE` (`StatusID`) USING BTREE,
  UNIQUE KEY `StatusName_UNIQUE` (`StatusName`) USING BTREE,
  KEY `StatusID` (`StatusID`) USING BTREE,
  KEY `StatusID_2` (`StatusID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_status`
--

LOCK TABLES `account_status` WRITE;
/*!40000 ALTER TABLE `account_status` DISABLE KEYS */;
INSERT INTO `account_status` VALUES (7,'PM');
/*!40000 ALTER TABLE `account_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `user_id` int(4) unsigned NOT NULL DEFAULT 0,
  `section_id` int(4) unsigned NOT NULL DEFAULT 0,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `edit_date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `flag` bigint(16) unsigned NOT NULL DEFAULT 0,
  `del_date` datetime DEFAULT NULL,
  `thumb` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles_category`
--

DROP TABLE IF EXISTS `articles_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `order` int(4) unsigned NOT NULL DEFAULT 0,
  `type` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles_category`
--

LOCK TABLES `articles_category` WRITE;
/*!40000 ALTER TABLE `articles_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `articles_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles_content`
--

DROP TABLE IF EXISTS `articles_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles_content` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(4) unsigned NOT NULL,
  `creator_id` int(4) unsigned NOT NULL DEFAULT 0,
  `locale` varchar(8) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `last_editor_id` int(4) unsigned NOT NULL DEFAULT 0,
  `creation_date` datetime NOT NULL DEFAULT current_timestamp(),
  `edit_date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `article_set` (`article_id`) USING BTREE,
  KEY `article_owner` (`creator_id`) USING BTREE,
  KEY `article_editor` (`last_editor_id`) USING BTREE,
  CONSTRAINT `article_editor` FOREIGN KEY (`last_editor_id`) REFERENCES `ftw_account` (`id`),
  CONSTRAINT `article_owner` FOREIGN KEY (`creator_id`) REFERENCES `ftw_account` (`id`),
  CONSTRAINT `article_set` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles_content`
--

LOCK TABLES `articles_content` WRITE;
/*!40000 ALTER TABLE `articles_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `articles_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles_read_control`
--

DROP TABLE IF EXISTS `articles_read_control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles_read_control` (
  `Identity` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UserIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `SessionIdentity` varchar(255) NOT NULL DEFAULT '',
  `UserAgent` varchar(255) NOT NULL DEFAULT '',
  `IpAddress` varchar(255) NOT NULL DEFAULT '0.0.0.0',
  `Referer` varchar(255) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  PRIMARY KEY (`Identity`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles_read_control`
--

LOCK TABLES `articles_read_control` WRITE;
/*!40000 ALTER TABLE `articles_read_control` DISABLE KEYS */;
/*!40000 ALTER TABLE `articles_read_control` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` int(10) unsigned NOT NULL DEFAULT 0,
  `OwnerId` int(10) unsigned NOT NULL DEFAULT 0,
  `CheckoutItemId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `Part1` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `Part2` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `Part3` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `Part4` smallint(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `Password` varchar(20) NOT NULL DEFAULT '',
  `CreatedAt` datetime NOT NULL,
  `UsedAt` datetime DEFAULT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card_usage`
--

DROP TABLE IF EXISTS `credit_card_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card_usage` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CardId` int(10) unsigned NOT NULL DEFAULT 0,
  `TargetId` int(10) unsigned NOT NULL DEFAULT 0,
  `UsedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE KEY `cardid` (`CardId`) USING BTREE,
  KEY `userid` (`TargetId`) USING BTREE,
  CONSTRAINT `ChkCard` FOREIGN KEY (`CardId`) REFERENCES `credit_card` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card_usage`
--

LOCK TABLES `credit_card_usage` WRITE;
/*!40000 ALTER TABLE `credit_card_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_card_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card_vip`
--

DROP TABLE IF EXISTS `credit_card_vip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card_vip` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AccountId` int(10) unsigned NOT NULL DEFAULT 0,
  `CardId` int(10) unsigned NOT NULL DEFAULT 0,
  `CreationDate` datetime NOT NULL DEFAULT current_timestamp(),
  `BoundServerId` int(10) unsigned NOT NULL DEFAULT 0,
  `BoundTargetId` int(10) unsigned NOT NULL DEFAULT 0,
  `BindDate` datetime DEFAULT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card_vip`
--

LOCK TABLES `credit_card_vip` WRITE;
/*!40000 ALTER TABLE `credit_card_vip` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_card_vip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discord_channel`
--

DROP TABLE IF EXISTS `discord_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discord_channel` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ChannelId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(255) NOT NULL,
  `CreatedAt` int(11) NOT NULL DEFAULT 0,
  `Default` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discord_channel`
--

LOCK TABLES `discord_channel` WRITE;
/*!40000 ALTER TABLE `discord_channel` DISABLE KEYS */;
/*!40000 ALTER TABLE `discord_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discord_message`
--

DROP TABLE IF EXISTS `discord_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discord_message` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UserId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `CurrentUserName` varchar(255) NOT NULL,
  `ChannelId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `Message` text NOT NULL,
  `Timestamp` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discord_message`
--

LOCK TABLES `discord_message` WRITE;
/*!40000 ALTER TABLE `discord_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `discord_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discord_user`
--

DROP TABLE IF EXISTS `discord_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discord_user` (
  `Identity` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DiscordUserId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `AccountId` int(10) unsigned NOT NULL DEFAULT 0,
  `GameUserId` int(10) unsigned NOT NULL DEFAULT 0,
  `AccountName` varchar(64) NOT NULL,
  `GameName` varchar(16) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Discriminator` varchar(255) NOT NULL,
  `CreatedAt` int(11) NOT NULL DEFAULT 0,
  `MessagesSent` bigint(20) unsigned NOT NULL DEFAULT 0,
  `CharactersSent` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Identity`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discord_user`
--

LOCK TABLES `discord_user` WRITE;
/*!40000 ALTER TABLE `discord_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `discord_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `download`
--

DROP TABLE IF EXISTS `download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `download` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download`
--

LOCK TABLES `download` WRITE;
/*!40000 ALTER TABLE `download` DISABLE KEYS */;
/*!40000 ALTER TABLE `download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `download_url`
--

DROP TABLE IF EXISTS `download_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `download_url` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `download_id` int(4) unsigned NOT NULL DEFAULT 0,
  `provider_name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `download_id` (`download_id`) USING BTREE,
  CONSTRAINT `downloadidx` FOREIGN KEY (`download_id`) REFERENCES `download` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download_url`
--

LOCK TABLES `download_url` WRITE;
/*!40000 ALTER TABLE `download_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `download_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftw_account`
--

DROP TABLE IF EXISTS `ftw_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ftw_account` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `password` varchar(130) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `flag` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `salt` varchar(128) NOT NULL DEFAULT 'DEFAULT_PTZF_SALT',
  `hash` varchar(255) NOT NULL DEFAULT '',
  `vip` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `vip_coins` bigint(16) unsigned NOT NULL DEFAULT 0,
  `vip_points` int(4) unsigned NOT NULL DEFAULT 300,
  `security_code` bigint(16) unsigned NOT NULL DEFAULT 0,
  `security_question` int(4) NOT NULL DEFAULT 0,
  `security_answer` varchar(128) NOT NULL DEFAULT '',
  `country` varchar(64) NOT NULL DEFAULT '',
  `language` varchar(10) NOT NULL DEFAULT '',
  `real_name` varchar(128) NOT NULL DEFAULT '',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `age` date DEFAULT NULL,
  `phone` varchar(16) NOT NULL DEFAULT '',
  `netbar_ip` varchar(16) NOT NULL DEFAULT '',
  `creation_date` datetime DEFAULT NULL,
  `first_login` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `email_confirmed` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `phone_confirmed` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `twofactor_enabled` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `lockout_enabled` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `access_failed_count` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `lockout_end` timestamp NULL DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `default_billing_info` int(10) unsigned NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `email` (`id`) USING BTREE,
  UNIQUE KEY `idx` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftw_account`
--

LOCK TABLES `ftw_account` WRITE;
/*!40000 ALTER TABLE `ftw_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftw_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftw_account_vip`
--

DROP TABLE IF EXISTS `ftw_account_vip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ftw_account_vip` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AccountId` int(10) unsigned NOT NULL DEFAULT 0,
  `VipCredits` bigint(20) unsigned NOT NULL DEFAULT 0,
  `VipPoints` int(10) unsigned NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE KEY `AccountId` (`AccountId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftw_account_vip`
--

LOCK TABLES `ftw_account_vip` WRITE;
/*!40000 ALTER TABLE `ftw_account_vip` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftw_account_vip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftw_billing_information`
--

DROP TABLE IF EXISTS `ftw_billing_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ftw_billing_information` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL DEFAULT 0,
  `document` varchar(255) NOT NULL DEFAULT '',
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `address` varchar(128) NOT NULL,
  `complement` varchar(64) NOT NULL,
  `district` varchar(64) NOT NULL,
  `city` varchar(32) NOT NULL,
  `country` varchar(3) NOT NULL,
  `post_code` varchar(15) NOT NULL,
  `email` varchar(128) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `additional_info` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftw_billing_information`
--

LOCK TABLES `ftw_billing_information` WRITE;
/*!40000 ALTER TABLE `ftw_billing_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftw_billing_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ftw_security_question`
--

DROP TABLE IF EXISTS `ftw_security_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ftw_security_question` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `query_str` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ftw_security_question`
--

LOCK TABLES `ftw_security_question` WRITE;
/*!40000 ALTER TABLE `ftw_security_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftw_security_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `folder` varchar(255) NOT NULL DEFAULT '',
  `img` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images_screenshots`
--

DROP TABLE IF EXISTS `images_screenshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images_screenshots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `imgid` int(10) unsigned DEFAULT 0,
  `order` int(11) DEFAULT 999,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images_screenshots`
--

LOCK TABLES `images_screenshots` WRITE;
/*!40000 ALTER TABLE `images_screenshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `images_screenshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_activity`
--

DROP TABLE IF EXISTS `log_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_activity` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserId` int(10) unsigned NOT NULL DEFAULT 0,
  `Type` smallint(5) unsigned NOT NULL DEFAULT 0,
  `IdAddress` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Json` text NOT NULL,
  `Timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_activity`
--

LOCK TABLES `log_activity` WRITE;
/*!40000 ALTER TABLE `log_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_records`
--

DROP TABLE IF EXISTS `login_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_records` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(4) unsigned NOT NULL DEFAULT 0,
  `action` int(4) unsigned NOT NULL DEFAULT 0,
  `time` datetime NOT NULL,
  `ip_address` varchar(255) NOT NULL DEFAULT '0.0.0.0',
  `browser` varchar(255) NOT NULL DEFAULT 'Unknown Browser Information',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_records`
--

LOCK TABLES `login_records` WRITE;
/*!40000 ALTER TABLE `login_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_user`
--

DROP TABLE IF EXISTS `permission_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_user` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(4) unsigned NOT NULL,
  `permission_id` int(4) unsigned NOT NULL,
  `value` int(4) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_user`
--

LOCK TABLES `permission_user` WRITE;
/*!40000 ALTER TABLE `permission_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_usergroup`
--

DROP TABLE IF EXISTS `permission_usergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_usergroup` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(4) unsigned NOT NULL,
  `permission_id` int(4) unsigned NOT NULL,
  `value` int(4) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_usergroup`
--

LOCK TABLES `permission_usergroup` WRITE;
/*!40000 ALTER TABLE `permission_usergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_usergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_information`
--

DROP TABLE IF EXISTS `profile_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_information` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(4) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `facebook` varchar(255) NOT NULL,
  `instagram` varchar(255) NOT NULL,
  `twitter` varchar(255) NOT NULL,
  `youtube` varchar(255) NOT NULL,
  `twitch` varchar(255) NOT NULL,
  `about_me` text NOT NULL,
  `selected_character_id` int(4) unsigned NOT NULL DEFAULT 0,
  `post_count` int(4) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_information`
--

LOCK TABLES `profile_information` WRITE;
/*!40000 ALTER TABLE `profile_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_status_updates`
--

DROP TABLE IF EXISTS `profile_status_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_status_updates` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(4) unsigned NOT NULL,
  `type` int(4) unsigned zerofill NOT NULL DEFAULT 0000,
  `reply_from` int(4) unsigned NOT NULL DEFAULT 0,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_status_updates`
--

LOCK TABLES `profile_status_updates` WRITE;
/*!40000 ALTER TABLE `profile_status_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_status_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realm`
--

DROP TABLE IF EXISTS `realm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realm` (
  `RealmID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(16) NOT NULL,
  `AuthorityID` smallint(6) unsigned NOT NULL DEFAULT 1 COMMENT 'Authority level required',
  `GameIPAddress` varchar(45) NOT NULL DEFAULT '127.0.0.1',
  `RpcIPAddress` varchar(45) NOT NULL DEFAULT '127.0.0.1',
  `GamePort` int(10) unsigned NOT NULL DEFAULT 5816,
  `RpcPort` int(10) unsigned NOT NULL DEFAULT 5817,
  `Status` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Username` varchar(255) NOT NULL DEFAULT 'test',
  `Password` varchar(255) NOT NULL DEFAULT 'test',
  `LastPing` datetime DEFAULT NULL,
  `DatabaseHost` varchar(255) NOT NULL DEFAULT '',
  `DatabaseUser` varchar(255) NOT NULL DEFAULT '',
  `DatabasePass` varchar(255) NOT NULL DEFAULT '',
  `DatabaseSchema` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`RealmID`) USING BTREE,
  UNIQUE KEY `RealmID_UNIQUE` (`RealmID`) USING BTREE,
  UNIQUE KEY `Name_UNIQUE` (`Name`) USING BTREE,
  KEY `fk_realm_account_authority_idx` (`AuthorityID`) USING BTREE,
  CONSTRAINT `fk_realm_account_authority` FOREIGN KEY (`AuthorityID`) REFERENCES `account_authority` (`AuthorityID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realm`
--

LOCK TABLES `realm` WRITE;
/*!40000 ALTER TABLE `realm` DISABLE KEYS */;
INSERT INTO `realm` VALUES (7,'Dark',7,'192.168.0.106','127.0.0.1',5816,9865,1,'uOIMI9WHOMooKY0x','epPQ8dTJhtxxCobJ','2023-12-25 14:09:42','localhost','root','password','zf');
/*!40000 ALTER TABLE `realm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realms_status`
--

DROP TABLE IF EXISTS `realms_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realms_status` (
  `id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `realm_id` int(4) unsigned NOT NULL,
  `realm_name` varchar(255) NOT NULL,
  `old_status` tinyint(1) unsigned NOT NULL,
  `new_status` tinyint(1) unsigned NOT NULL,
  `time` datetime NOT NULL,
  `players_online` int(4) unsigned NOT NULL DEFAULT 0,
  `max_players_online` int(4) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `Realms` (`realm_id`) USING BTREE,
  CONSTRAINT `Realms` FOREIGN KEY (`realm_id`) REFERENCES `realm` (`RealmID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realms_status`
--

LOCK TABLES `realms_status` WRITE;
/*!40000 ALTER TABLE `realms_status` DISABLE KEYS */;
INSERT INTO `realms_status` VALUES (7,7,'Dark',0,0,'2023-12-21 11:51:16',1,2312312),(8,7,'Dark',1,1,'2023-12-21 12:20:47',0,0),(9,7,'Dark',1,1,'2023-12-21 12:21:02',0,0),(10,7,'Dark',1,1,'2023-12-21 12:21:18',0,0),(11,7,'Dark',1,1,'2023-12-21 12:21:33',0,0),(12,7,'Dark',1,1,'2023-12-21 12:21:48',0,0),(13,7,'Dark',1,1,'2023-12-21 12:22:02',0,0),(14,7,'Dark',1,1,'2023-12-21 12:22:17',0,0),(15,7,'Dark',1,1,'2023-12-21 12:22:32',0,0),(16,7,'Dark',1,1,'2023-12-21 12:22:47',0,0),(17,7,'Dark',1,1,'2023-12-21 12:23:02',0,0),(18,7,'Dark',1,1,'2023-12-21 12:23:18',0,0),(19,7,'Dark',1,1,'2023-12-21 12:23:33',0,0),(20,7,'Dark',1,1,'2023-12-21 12:24:03',0,0),(21,7,'Dark',1,1,'2023-12-21 12:24:18',0,0),(22,7,'Dark',1,1,'2023-12-21 12:24:33',0,0),(23,7,'Dark',1,1,'2023-12-21 12:24:48',0,0),(24,7,'Dark',1,1,'2023-12-21 12:25:04',0,0),(25,7,'Dark',1,1,'2023-12-21 12:25:19',0,0),(26,7,'Dark',1,1,'2023-12-21 12:25:33',0,0),(27,7,'Dark',1,1,'2023-12-21 12:25:48',0,0),(28,7,'Dark',1,1,'2023-12-21 12:26:03',0,0),(29,7,'Dark',1,1,'2023-12-21 12:26:18',0,0),(30,7,'Dark',1,1,'2023-12-21 12:26:33',0,0),(31,7,'Dark',1,1,'2023-12-21 12:26:49',0,0),(32,7,'Dark',1,1,'2023-12-21 12:27:04',0,0),(33,7,'Dark',1,1,'2023-12-21 12:27:19',0,0),(34,7,'Dark',1,1,'2023-12-21 12:27:33',0,0),(35,7,'Dark',1,1,'2023-12-21 12:27:48',0,0),(36,7,'Dark',1,1,'2023-12-21 12:28:03',0,0),(37,7,'Dark',1,1,'2023-12-21 12:28:18',0,0),(38,7,'Dark',1,1,'2023-12-21 12:28:33',0,0),(39,7,'Dark',1,1,'2023-12-21 12:28:48',0,0),(40,7,'Dark',1,1,'2023-12-21 12:29:04',0,0),(41,7,'Dark',1,1,'2023-12-21 12:29:19',0,0),(42,7,'Dark',1,1,'2023-12-21 12:29:34',0,0),(43,7,'Dark',1,1,'2023-12-21 12:29:48',0,0),(44,7,'Dark',1,1,'2023-12-21 12:30:03',0,0),(45,7,'Dark',1,1,'2023-12-21 12:30:18',0,0),(46,7,'Dark',1,1,'2023-12-21 12:30:33',0,0),(47,7,'Dark',1,1,'2023-12-21 12:30:57',0,0),(48,7,'Dark',1,1,'2023-12-21 12:31:13',0,0),(49,7,'Dark',1,1,'2023-12-21 12:31:28',0,0),(50,7,'Dark',1,1,'2023-12-21 12:31:43',0,0),(51,7,'Dark',1,1,'2023-12-21 12:31:57',0,0),(52,7,'Dark',1,1,'2023-12-21 12:32:19',0,0),(53,7,'Dark',1,1,'2023-12-21 12:32:34',0,0),(54,7,'Dark',1,1,'2023-12-21 12:32:49',0,0),(55,7,'Dark',1,1,'2023-12-21 12:33:04',0,0),(56,7,'Dark',1,1,'2023-12-21 12:33:19',0,0),(57,7,'Dark',1,1,'2023-12-21 12:33:55',0,0),(58,7,'Dark',1,1,'2023-12-21 12:34:10',0,0),(59,7,'Dark',1,1,'2023-12-21 12:34:25',0,0),(60,7,'Dark',1,1,'2023-12-21 12:34:41',0,0),(61,7,'Dark',1,1,'2023-12-21 12:34:56',0,0),(62,7,'Dark',1,1,'2023-12-21 12:35:11',0,0),(63,7,'Dark',1,1,'2023-12-21 12:35:49',0,0),(64,7,'Dark',1,1,'2023-12-21 12:44:23',0,0),(65,7,'Dark',1,1,'2023-12-21 12:44:37',0,0),(66,7,'Dark',1,1,'2023-12-21 12:44:52',0,0),(67,7,'Dark',1,1,'2023-12-21 12:45:07',0,0),(68,7,'Dark',1,1,'2023-12-21 12:45:22',0,0),(69,7,'Dark',1,1,'2023-12-21 12:45:37',0,0),(70,7,'Dark',1,1,'2023-12-21 12:45:53',0,0),(71,7,'Dark',1,1,'2023-12-21 12:46:08',0,0),(72,7,'Dark',1,1,'2023-12-21 12:46:23',0,0),(73,7,'Dark',1,1,'2023-12-21 12:46:37',0,0),(74,7,'Dark',1,1,'2023-12-21 12:46:52',0,0),(75,7,'Dark',1,1,'2023-12-21 12:47:07',0,0),(76,7,'Dark',1,1,'2023-12-21 12:47:22',0,0),(77,7,'Dark',1,1,'2023-12-21 12:47:38',0,0),(78,7,'Dark',1,1,'2023-12-21 12:47:53',0,0),(79,7,'Dark',1,1,'2023-12-21 12:48:08',0,0),(80,7,'Dark',1,1,'2023-12-21 12:48:22',0,0),(81,7,'Dark',1,1,'2023-12-21 12:48:37',0,0),(82,7,'Dark',1,1,'2023-12-21 12:48:52',0,0),(83,7,'Dark',1,1,'2023-12-21 12:49:07',0,0),(84,7,'Dark',1,1,'2023-12-21 12:49:22',0,0),(85,7,'Dark',1,1,'2023-12-21 12:49:37',0,0),(86,7,'Dark',1,1,'2023-12-21 12:49:53',0,0),(87,7,'Dark',1,1,'2023-12-21 12:50:08',0,0),(88,7,'Dark',1,1,'2023-12-21 12:50:23',0,0),(89,7,'Dark',1,1,'2023-12-21 12:50:37',0,0),(90,7,'Dark',1,1,'2023-12-21 12:50:52',0,0),(91,7,'Dark',1,1,'2023-12-21 12:51:07',0,0),(92,7,'Dark',1,1,'2023-12-21 12:51:22',0,0),(93,7,'Dark',1,1,'2023-12-21 12:51:37',0,0),(94,7,'Dark',1,1,'2023-12-21 12:51:52',0,0),(95,7,'Dark',1,1,'2023-12-21 12:52:08',0,0),(96,7,'Dark',1,1,'2023-12-21 12:52:23',0,0),(97,7,'Dark',1,1,'2023-12-21 12:52:37',0,0),(98,7,'Dark',1,1,'2023-12-21 12:52:52',0,0),(99,7,'Dark',1,1,'2023-12-21 12:54:23',0,0),(100,7,'Dark',1,1,'2023-12-21 12:54:38',0,0),(101,7,'Dark',1,1,'2023-12-21 12:54:53',0,0),(102,7,'Dark',1,1,'2023-12-21 12:55:08',0,0),(103,7,'Dark',1,1,'2023-12-21 12:55:24',0,0),(104,7,'Dark',1,1,'2023-12-21 12:55:39',0,0),(105,7,'Dark',1,1,'2023-12-21 12:55:54',0,0),(106,7,'Dark',1,1,'2023-12-21 12:56:08',0,0),(107,7,'Dark',1,1,'2023-12-21 12:57:05',0,0),(108,7,'Dark',1,1,'2023-12-21 12:57:20',0,0),(109,7,'Dark',1,1,'2023-12-21 12:57:34',0,0),(110,7,'Dark',1,1,'2023-12-21 12:57:49',0,0),(111,7,'Dark',1,1,'2023-12-21 12:58:04',0,0),(112,7,'Dark',1,1,'2023-12-21 12:58:19',0,0),(113,7,'Dark',1,1,'2023-12-21 12:58:34',0,0),(114,7,'Dark',1,1,'2023-12-21 12:58:50',0,0),(115,7,'Dark',1,1,'2023-12-21 12:59:05',0,0),(116,7,'Dark',1,1,'2023-12-21 12:59:20',0,0),(117,7,'Dark',1,1,'2023-12-21 12:59:44',0,0),(118,7,'Dark',1,1,'2023-12-21 12:59:59',0,0),(119,7,'Dark',1,1,'2023-12-21 13:00:15',0,0),(120,7,'Dark',1,1,'2023-12-21 13:00:30',0,0),(121,7,'Dark',1,1,'2023-12-21 13:00:45',0,0),(122,7,'Dark',1,1,'2023-12-21 13:00:59',0,0),(123,7,'Dark',1,1,'2023-12-21 13:01:14',0,0),(124,7,'Dark',1,1,'2023-12-21 13:01:29',0,0),(125,7,'Dark',1,1,'2023-12-21 13:01:44',0,0),(126,7,'Dark',1,1,'2023-12-21 13:01:59',0,0),(127,7,'Dark',1,1,'2023-12-21 13:02:15',0,0),(128,7,'Dark',1,1,'2023-12-21 13:02:30',0,0),(129,7,'Dark',1,1,'2023-12-21 13:02:44',0,0),(130,7,'Dark',1,1,'2023-12-21 13:02:59',0,0),(131,7,'Dark',1,1,'2023-12-21 13:03:14',0,0),(132,7,'Dark',1,1,'2023-12-21 13:03:29',0,0),(133,7,'Dark',1,1,'2023-12-21 13:03:44',0,0),(134,7,'Dark',1,1,'2023-12-21 13:04:00',0,0),(135,7,'Dark',1,1,'2023-12-21 13:04:15',0,0),(136,7,'Dark',1,1,'2023-12-21 13:04:30',0,0),(137,7,'Dark',1,1,'2023-12-21 13:04:45',0,0),(138,7,'Dark',1,1,'2023-12-21 13:04:59',0,0),(139,7,'Dark',1,1,'2023-12-21 13:05:14',0,0),(140,7,'Dark',1,1,'2023-12-21 13:05:29',0,0),(141,7,'Dark',1,1,'2023-12-21 13:05:44',0,0),(142,7,'Dark',1,1,'2023-12-21 13:05:59',0,0),(143,7,'Dark',1,1,'2023-12-21 13:06:15',0,0),(144,7,'Dark',1,1,'2023-12-21 13:06:30',0,0),(145,7,'Dark',1,1,'2023-12-21 13:06:45',0,0),(146,7,'Dark',1,1,'2023-12-21 13:06:59',0,0),(147,7,'Dark',1,1,'2023-12-21 13:07:14',0,0),(148,7,'Dark',1,1,'2023-12-21 13:07:29',0,0),(149,7,'Dark',1,1,'2023-12-21 13:07:44',0,0),(150,7,'Dark',1,1,'2023-12-21 13:07:59',0,0),(151,7,'Dark',1,1,'2023-12-21 13:08:14',0,0),(152,7,'Dark',1,1,'2023-12-21 13:08:30',0,0),(153,7,'Dark',1,1,'2023-12-21 13:08:45',0,0),(154,7,'Dark',1,1,'2023-12-21 13:09:00',0,0),(155,7,'Dark',1,1,'2023-12-21 13:09:14',0,0),(156,7,'Dark',1,1,'2023-12-21 13:09:29',0,0),(157,7,'Dark',1,1,'2023-12-21 13:09:44',0,0),(158,7,'Dark',1,1,'2023-12-21 13:09:59',0,0),(159,7,'Dark',1,1,'2023-12-21 13:10:14',0,0),(160,7,'Dark',1,1,'2023-12-21 13:10:29',0,0),(161,7,'Dark',1,1,'2023-12-21 13:10:45',0,0),(162,7,'Dark',1,1,'2023-12-21 13:11:00',0,0),(163,7,'Dark',1,1,'2023-12-21 13:11:15',0,0),(164,7,'Dark',1,1,'2023-12-21 13:11:29',0,0),(165,7,'Dark',1,1,'2023-12-21 13:11:44',0,0),(166,7,'Dark',1,1,'2023-12-21 13:11:59',0,0),(167,7,'Dark',1,1,'2023-12-21 13:12:14',0,0),(168,7,'Dark',1,1,'2023-12-21 13:19:11',0,0),(169,7,'Dark',1,1,'2023-12-21 13:19:26',0,0),(170,7,'Dark',1,1,'2023-12-21 13:19:41',0,0),(171,7,'Dark',1,1,'2023-12-21 13:19:55',0,0),(172,7,'Dark',1,1,'2023-12-21 13:20:10',0,0),(173,7,'Dark',1,1,'2023-12-21 13:20:25',0,0),(174,7,'Dark',1,1,'2023-12-21 13:20:40',0,0),(175,7,'Dark',1,1,'2023-12-21 13:20:56',0,0),(176,7,'Dark',1,1,'2023-12-21 13:21:11',0,0),(177,7,'Dark',1,1,'2023-12-21 13:21:26',0,0),(178,7,'Dark',1,1,'2023-12-21 13:21:41',0,0),(179,7,'Dark',1,1,'2023-12-21 13:21:56',0,0),(180,7,'Dark',1,1,'2023-12-21 13:22:11',0,0),(181,7,'Dark',1,1,'2023-12-21 13:22:26',0,0),(182,7,'Dark',1,1,'2023-12-21 13:22:41',0,0),(183,7,'Dark',1,1,'2023-12-21 13:22:56',0,0),(184,7,'Dark',1,1,'2023-12-21 13:23:12',0,0),(185,7,'Dark',1,1,'2023-12-21 13:23:27',0,0),(186,7,'Dark',1,1,'2023-12-21 13:23:42',0,0),(187,7,'Dark',1,1,'2023-12-21 13:23:56',0,0),(188,7,'Dark',1,1,'2023-12-21 13:24:11',0,0),(189,7,'Dark',1,1,'2023-12-21 13:24:26',0,0),(190,7,'Dark',1,1,'2023-12-21 13:24:41',0,0),(191,7,'Dark',1,1,'2023-12-21 13:24:56',0,0),(192,7,'Dark',1,1,'2023-12-21 13:25:12',0,0),(193,7,'Dark',1,1,'2023-12-21 13:25:27',0,0),(194,7,'Dark',1,1,'2023-12-21 13:25:42',0,0),(195,7,'Dark',1,1,'2023-12-21 13:25:56',0,0),(196,7,'Dark',1,1,'2023-12-21 13:26:11',0,0),(197,7,'Dark',1,1,'2023-12-21 13:26:26',0,0),(198,7,'Dark',1,1,'2023-12-21 13:26:41',0,0),(199,7,'Dark',1,1,'2023-12-21 13:26:56',0,0),(200,7,'Dark',1,1,'2023-12-21 13:27:12',0,0),(201,7,'Dark',1,1,'2023-12-21 13:27:27',0,0),(202,7,'Dark',1,1,'2023-12-21 13:27:42',0,0),(203,7,'Dark',1,1,'2023-12-21 13:27:56',0,0),(204,7,'Dark',1,1,'2023-12-21 13:28:11',0,0),(205,7,'Dark',1,1,'2023-12-21 13:28:26',0,0),(206,7,'Dark',1,1,'2023-12-21 13:28:41',0,0),(207,7,'Dark',1,1,'2023-12-21 13:28:56',0,0),(208,7,'Dark',1,1,'2023-12-21 13:29:12',0,0),(209,7,'Dark',1,1,'2023-12-21 13:29:27',0,0),(210,7,'Dark',1,1,'2023-12-21 13:29:42',0,0),(211,7,'Dark',1,1,'2023-12-21 13:29:57',0,0),(212,7,'Dark',1,1,'2023-12-21 13:30:11',0,0),(213,7,'Dark',1,1,'2023-12-21 13:30:26',0,0),(214,7,'Dark',1,1,'2023-12-21 13:30:41',0,0),(215,7,'Dark',1,1,'2023-12-21 13:30:56',0,0),(216,7,'Dark',1,1,'2023-12-21 13:31:12',0,0),(217,7,'Dark',1,1,'2023-12-21 13:31:27',0,0),(218,7,'Dark',1,1,'2023-12-21 13:31:42',0,0),(219,7,'Dark',1,1,'2023-12-21 13:31:56',0,0),(220,7,'Dark',1,1,'2023-12-21 13:32:11',0,0),(221,7,'Dark',1,1,'2023-12-21 13:32:26',0,0),(222,7,'Dark',1,1,'2023-12-21 13:32:41',0,0),(223,7,'Dark',1,1,'2023-12-21 13:32:56',0,0),(224,7,'Dark',1,1,'2023-12-21 13:33:12',0,0),(225,7,'Dark',1,1,'2023-12-21 13:33:27',0,0),(226,7,'Dark',1,1,'2023-12-21 13:33:42',0,0),(227,7,'Dark',1,1,'2023-12-25 11:19:12',0,0),(228,7,'Dark',1,1,'2023-12-25 11:19:27',0,0),(229,7,'Dark',1,1,'2023-12-25 11:19:42',0,0),(230,7,'Dark',1,1,'2023-12-25 11:19:57',0,0),(231,7,'Dark',1,1,'2023-12-25 11:20:12',0,0),(232,7,'Dark',1,1,'2023-12-25 11:20:27',0,0),(233,7,'Dark',1,1,'2023-12-25 11:20:43',0,0),(234,7,'Dark',1,1,'2023-12-25 11:20:58',0,0),(235,7,'Dark',1,1,'2023-12-25 11:21:13',0,0),(236,7,'Dark',1,1,'2023-12-25 11:21:27',0,0),(237,7,'Dark',1,1,'2023-12-25 11:21:42',0,0),(238,7,'Dark',1,1,'2023-12-25 11:21:57',0,0),(239,7,'Dark',1,1,'2023-12-25 11:22:35',0,0),(240,7,'Dark',1,1,'2023-12-25 11:22:50',0,0),(241,7,'Dark',1,1,'2023-12-25 11:23:04',0,0),(242,7,'Dark',1,1,'2023-12-25 11:23:19',0,0),(243,7,'Dark',1,1,'2023-12-25 11:23:34',0,0),(244,7,'Dark',1,1,'2023-12-25 11:23:49',0,0),(245,7,'Dark',1,1,'2023-12-25 11:24:04',0,0),(246,7,'Dark',1,1,'2023-12-25 11:24:20',0,0),(247,7,'Dark',1,1,'2023-12-25 11:24:35',0,0),(248,7,'Dark',1,1,'2023-12-25 11:24:53',0,0),(249,7,'Dark',1,1,'2023-12-25 11:25:08',0,0),(250,7,'Dark',1,1,'2023-12-25 11:25:23',0,0),(251,7,'Dark',1,1,'2023-12-25 11:25:39',0,0),(252,7,'Dark',1,1,'2023-12-25 11:25:54',0,0),(253,7,'Dark',1,1,'2023-12-25 11:26:09',0,0),(254,7,'Dark',1,1,'2023-12-25 11:26:23',0,0),(255,7,'Dark',1,1,'2023-12-25 11:26:38',0,0),(256,7,'Dark',1,1,'2023-12-25 11:26:53',0,0),(257,7,'Dark',1,1,'2023-12-25 11:27:08',0,0),(258,7,'Dark',1,1,'2023-12-25 11:27:23',0,0),(259,7,'Dark',1,1,'2023-12-25 11:27:38',0,0),(260,7,'Dark',1,1,'2023-12-25 11:27:54',0,0),(261,7,'Dark',1,1,'2023-12-25 11:28:09',0,0),(262,7,'Dark',1,1,'2023-12-25 11:28:24',0,0),(263,7,'Dark',1,1,'2023-12-25 11:28:38',0,0),(264,7,'Dark',1,1,'2023-12-25 11:28:53',0,0),(265,7,'Dark',1,1,'2023-12-25 11:29:08',0,0),(266,7,'Dark',1,1,'2023-12-25 11:29:38',0,0),(267,7,'Dark',1,1,'2023-12-25 11:29:53',0,0),(268,7,'Dark',1,1,'2023-12-25 11:30:08',0,0),(269,7,'Dark',1,1,'2023-12-25 11:31:54',0,0),(270,7,'Dark',1,1,'2023-12-25 11:32:09',0,0),(271,7,'Dark',1,1,'2023-12-25 11:32:25',0,0),(272,7,'Dark',1,1,'2023-12-25 11:32:40',0,0),(273,7,'Dark',1,1,'2023-12-25 11:32:55',0,0),(274,7,'Dark',1,1,'2023-12-25 11:33:10',0,0),(275,7,'Dark',1,1,'2023-12-25 11:33:25',0,0),(276,7,'Dark',1,1,'2023-12-25 11:33:40',0,0),(277,7,'Dark',1,1,'2023-12-25 11:33:55',0,0),(278,7,'Dark',1,1,'2023-12-25 11:34:10',0,0),(279,7,'Dark',1,1,'2023-12-25 11:34:25',0,0),(280,7,'Dark',1,1,'2023-12-25 11:34:56',0,0),(281,7,'Dark',1,1,'2023-12-25 11:35:10',0,0),(282,7,'Dark',1,1,'2023-12-25 11:35:25',0,0),(283,7,'Dark',1,1,'2023-12-25 11:35:40',0,0),(284,7,'Dark',1,1,'2023-12-25 11:35:55',0,0),(285,7,'Dark',1,1,'2023-12-25 11:36:20',0,0),(286,7,'Dark',1,1,'2023-12-25 11:36:35',0,0),(287,7,'Dark',1,1,'2023-12-25 11:36:50',0,0),(288,7,'Dark',1,1,'2023-12-25 11:37:05',0,0),(289,7,'Dark',1,1,'2023-12-25 11:37:21',0,0),(290,7,'Dark',1,1,'2023-12-25 11:37:36',0,0),(291,7,'Dark',1,1,'2023-12-25 11:37:50',0,0),(292,7,'Dark',1,1,'2023-12-25 11:38:05',0,0),(293,7,'Dark',1,1,'2023-12-25 11:38:20',0,0),(294,7,'Dark',1,1,'2023-12-25 11:38:35',0,0),(295,7,'Dark',1,1,'2023-12-25 11:38:50',0,0),(296,7,'Dark',1,1,'2023-12-25 11:39:05',0,0),(297,7,'Dark',1,1,'2023-12-25 11:39:21',0,0),(298,7,'Dark',1,1,'2023-12-25 11:39:36',0,0),(299,7,'Dark',1,1,'2023-12-25 11:39:51',0,0),(300,7,'Dark',1,1,'2023-12-25 11:40:05',0,0),(301,7,'Dark',1,1,'2023-12-25 11:40:20',0,0),(302,7,'Dark',1,1,'2023-12-25 11:40:35',0,0),(303,7,'Dark',1,1,'2023-12-25 11:40:50',0,0),(304,7,'Dark',1,1,'2023-12-25 11:41:05',0,0),(305,7,'Dark',1,1,'2023-12-25 11:41:29',0,0),(306,7,'Dark',1,1,'2023-12-25 11:41:44',0,0),(307,7,'Dark',1,1,'2023-12-25 11:41:58',0,0),(308,7,'Dark',1,1,'2023-12-25 11:42:13',0,0),(309,7,'Dark',1,1,'2023-12-25 11:42:28',0,0),(310,7,'Dark',1,1,'2023-12-25 11:42:43',0,0),(311,7,'Dark',1,1,'2023-12-25 11:42:58',0,0),(312,7,'Dark',1,1,'2023-12-25 11:43:14',0,0),(313,7,'Dark',1,1,'2023-12-25 11:43:36',0,0),(314,7,'Dark',1,1,'2023-12-25 11:43:51',0,0),(315,7,'Dark',1,1,'2023-12-25 11:44:06',0,0),(316,7,'Dark',1,1,'2023-12-25 11:44:22',0,0),(317,7,'Dark',1,1,'2023-12-25 11:45:28',0,0),(318,7,'Dark',1,1,'2023-12-25 11:45:43',0,0),(319,7,'Dark',1,1,'2023-12-25 11:45:58',0,0),(320,7,'Dark',1,1,'2023-12-25 11:46:13',0,0),(321,7,'Dark',1,1,'2023-12-25 11:46:28',0,0),(322,7,'Dark',1,1,'2023-12-25 11:46:43',0,0),(323,7,'Dark',1,1,'2023-12-25 11:46:59',0,0),(324,7,'Dark',1,1,'2023-12-25 11:47:14',0,0),(325,7,'Dark',1,1,'2023-12-25 11:47:29',0,0),(326,7,'Dark',1,1,'2023-12-25 11:47:44',0,0),(327,7,'Dark',1,1,'2023-12-25 11:47:59',0,0),(328,7,'Dark',1,1,'2023-12-25 11:48:14',0,0),(329,7,'Dark',1,1,'2023-12-25 11:48:37',0,0),(330,7,'Dark',1,1,'2023-12-25 11:49:04',0,0),(331,7,'Dark',1,1,'2023-12-25 11:49:20',0,0),(332,7,'Dark',1,1,'2023-12-25 11:49:20',0,0),(333,7,'Dark',1,1,'2023-12-25 11:49:30',0,0),(334,7,'Dark',1,1,'2023-12-25 11:49:45',0,0),(335,7,'Dark',1,1,'2023-12-25 11:49:59',0,0),(336,7,'Dark',1,1,'2023-12-25 11:50:14',0,0),(337,7,'Dark',1,1,'2023-12-25 11:50:29',0,0),(338,7,'Dark',1,1,'2023-12-25 11:50:44',0,0),(339,7,'Dark',1,1,'2023-12-25 11:50:59',0,0),(340,7,'Dark',1,1,'2023-12-25 11:51:15',0,0),(341,7,'Dark',1,1,'2023-12-25 11:51:30',0,0),(342,7,'Dark',1,1,'2023-12-25 11:51:45',0,0),(343,7,'Dark',1,1,'2023-12-25 11:51:59',0,0),(344,7,'Dark',1,1,'2023-12-25 11:52:14',0,0),(345,7,'Dark',1,1,'2023-12-25 11:52:29',0,0),(346,7,'Dark',1,1,'2023-12-25 11:52:44',0,0),(347,7,'Dark',1,1,'2023-12-25 11:53:02',0,0),(348,7,'Dark',1,1,'2023-12-25 11:53:18',0,0),(349,7,'Dark',1,1,'2023-12-25 11:53:41',0,0),(350,7,'Dark',1,1,'2023-12-25 11:53:51',0,0),(351,7,'Dark',1,1,'2023-12-25 11:54:02',0,0),(352,7,'Dark',1,1,'2023-12-25 11:54:18',0,0),(353,7,'Dark',1,1,'2023-12-25 11:54:33',0,0),(354,7,'Dark',1,1,'2023-12-25 11:54:48',0,0),(355,7,'Dark',1,1,'2023-12-25 11:55:02',0,0),(356,7,'Dark',1,1,'2023-12-25 11:55:17',0,0),(357,7,'Dark',1,1,'2023-12-25 11:55:32',0,0),(358,7,'Dark',1,1,'2023-12-25 11:55:47',0,0),(359,7,'Dark',1,1,'2023-12-25 11:56:02',0,0),(360,7,'Dark',1,1,'2023-12-25 11:56:17',0,0),(361,7,'Dark',1,1,'2023-12-25 11:56:33',0,0),(362,7,'Dark',1,1,'2023-12-25 11:56:48',0,0),(363,7,'Dark',1,1,'2023-12-25 11:57:02',0,0),(364,7,'Dark',1,1,'2023-12-25 11:57:17',0,0),(365,7,'Dark',1,1,'2023-12-25 11:57:32',0,0),(366,7,'Dark',1,1,'2023-12-25 11:57:47',0,0),(367,7,'Dark',1,1,'2023-12-25 11:58:02',0,0),(368,7,'Dark',1,1,'2023-12-25 11:58:17',0,0),(369,7,'Dark',1,1,'2023-12-25 11:58:33',0,0),(370,7,'Dark',1,1,'2023-12-25 11:58:48',0,0),(371,7,'Dark',1,1,'2023-12-25 11:59:03',0,0),(372,7,'Dark',1,1,'2023-12-25 11:59:17',0,0),(373,7,'Dark',1,1,'2023-12-25 11:59:32',0,0),(374,7,'Dark',1,1,'2023-12-25 11:59:47',0,0),(375,7,'Dark',1,1,'2023-12-25 12:00:02',0,0),(376,7,'Dark',1,1,'2023-12-25 12:00:17',0,0),(377,7,'Dark',1,1,'2023-12-25 12:00:32',0,0),(378,7,'Dark',1,1,'2023-12-25 12:00:48',0,0),(379,7,'Dark',1,1,'2023-12-25 12:01:03',0,0),(380,7,'Dark',1,1,'2023-12-25 12:01:18',0,0),(381,7,'Dark',1,1,'2023-12-25 12:01:32',0,0),(382,7,'Dark',1,1,'2023-12-25 12:01:47',0,0),(383,7,'Dark',1,1,'2023-12-25 12:02:02',0,0),(384,7,'Dark',1,1,'2023-12-25 12:02:17',0,0),(385,7,'Dark',1,1,'2023-12-25 12:02:32',0,0),(386,7,'Dark',1,1,'2023-12-25 12:02:48',0,0),(387,7,'Dark',1,1,'2023-12-25 12:03:03',0,0),(388,7,'Dark',1,1,'2023-12-25 12:03:18',0,0),(389,7,'Dark',1,1,'2023-12-25 12:03:32',0,0),(390,7,'Dark',1,1,'2023-12-25 12:03:47',0,0),(391,7,'Dark',1,1,'2023-12-25 12:04:02',0,0),(392,7,'Dark',1,1,'2023-12-25 12:04:17',0,0),(393,7,'Dark',1,1,'2023-12-25 12:04:32',0,0),(394,7,'Dark',1,1,'2023-12-25 12:04:47',0,0),(395,7,'Dark',1,1,'2023-12-25 12:05:03',0,0),(396,7,'Dark',1,1,'2023-12-25 12:05:18',0,0),(397,7,'Dark',1,1,'2023-12-25 12:05:33',0,0),(398,7,'Dark',1,1,'2023-12-25 12:05:47',0,0),(399,7,'Dark',1,1,'2023-12-25 12:06:02',0,0),(400,7,'Dark',1,1,'2023-12-25 12:06:17',0,0),(401,7,'Dark',1,1,'2023-12-25 12:06:32',0,0),(402,7,'Dark',1,0,'2023-12-25 12:06:47',0,0),(403,7,'Dark',1,1,'2023-12-25 12:07:02',0,0),(404,7,'Dark',1,1,'2023-12-25 14:09:48',0,0),(405,7,'Dark',1,1,'2023-12-25 14:10:04',0,0),(406,7,'Dark',1,1,'2023-12-25 14:10:19',0,0),(407,7,'Dark',1,1,'2023-12-25 14:10:34',1,1),(408,7,'Dark',1,1,'2023-12-25 14:10:48',1,1),(409,7,'Dark',1,1,'2023-12-25 14:11:03',1,1),(410,7,'Dark',1,1,'2023-12-25 14:11:18',1,1),(411,7,'Dark',1,1,'2023-12-25 14:11:33',1,1),(412,7,'Dark',1,1,'2023-12-25 14:11:48',1,1),(413,7,'Dark',1,1,'2023-12-25 14:12:04',1,1),(414,7,'Dark',1,1,'2023-12-25 14:12:19',1,1),(415,7,'Dark',1,1,'2023-12-25 14:12:33',1,1),(416,7,'Dark',1,1,'2023-12-25 14:12:48',1,1),(417,7,'Dark',1,1,'2023-12-25 14:13:03',1,1),(418,7,'Dark',1,1,'2023-12-25 14:13:18',1,1),(419,7,'Dark',1,1,'2023-12-25 14:13:34',1,1),(420,7,'Dark',1,1,'2023-12-25 14:13:49',1,1),(421,7,'Dark',1,1,'2023-12-25 14:14:03',1,1),(422,7,'Dark',1,1,'2023-12-25 14:14:18',1,1),(423,7,'Dark',1,1,'2023-12-25 14:14:33',1,1),(424,7,'Dark',1,1,'2023-12-25 14:14:48',1,1),(425,7,'Dark',1,1,'2023-12-25 14:15:03',1,1),(426,7,'Dark',1,1,'2023-12-25 14:15:19',1,1),(427,7,'Dark',1,1,'2023-12-25 14:15:34',1,1),(428,7,'Dark',1,1,'2023-12-25 14:15:48',1,1),(429,7,'Dark',1,1,'2023-12-25 14:16:03',1,1),(430,7,'Dark',1,1,'2023-12-25 14:16:18',1,1),(431,7,'Dark',1,1,'2023-12-25 14:16:33',1,1),(432,7,'Dark',1,1,'2023-12-25 14:16:48',1,1),(433,7,'Dark',1,1,'2023-12-25 14:17:04',1,1),(434,7,'Dark',1,1,'2023-12-25 14:17:19',1,1),(435,7,'Dark',1,1,'2023-12-25 14:17:33',1,1),(436,7,'Dark',1,1,'2023-12-25 14:17:48',1,1),(437,7,'Dark',1,1,'2023-12-25 14:18:03',1,1),(438,7,'Dark',1,1,'2023-12-25 14:18:18',0,1),(439,7,'Dark',1,1,'2023-12-25 14:18:33',0,1),(440,7,'Dark',1,1,'2023-12-25 14:18:49',0,1),(441,7,'Dark',1,1,'2023-12-25 14:19:04',0,1);
/*!40000 ALTER TABLE `realms_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records_family`
--

DROP TABLE IF EXISTS `records_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records_family` (
  `Identity` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ServerIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `FamilyIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `LeaderIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `Count` int(10) unsigned NOT NULL DEFAULT 0,
  `Money` bigint(20) unsigned NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  `ChallengeMap` int(10) unsigned NOT NULL DEFAULT 0,
  `DominatedMap` int(10) unsigned NOT NULL DEFAULT 0,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `BpTower` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Identity`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records_family`
--

LOCK TABLES `records_family` WRITE;
/*!40000 ALTER TABLE `records_family` DISABLE KEYS */;
/*!40000 ALTER TABLE `records_family` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records_guild_war`
--

DROP TABLE IF EXISTS `records_guild_war`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records_guild_war` (
  `Identity` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ServerIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `SyndicateIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `LeaderIdentity` int(10) unsigned NOT NULL,
  `Date` datetime NOT NULL,
  PRIMARY KEY (`Identity`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records_guild_war`
--

LOCK TABLES `records_guild_war` WRITE;
/*!40000 ALTER TABLE `records_guild_war` DISABLE KEYS */;
/*!40000 ALTER TABLE `records_guild_war` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records_syndicate`
--

DROP TABLE IF EXISTS `records_syndicate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records_syndicate` (
  `Id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `ServerIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `SyndicateIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(16) NOT NULL,
  `LeaderIdentity` int(4) unsigned NOT NULL DEFAULT 0,
  `Count` int(4) unsigned NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records_syndicate`
--

LOCK TABLES `records_syndicate` WRITE;
/*!40000 ALTER TABLE `records_syndicate` DISABLE KEYS */;
/*!40000 ALTER TABLE `records_syndicate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records_user`
--

DROP TABLE IF EXISTS `records_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `records_user` (
  `Id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `ServerIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `UserIdentity` int(11) unsigned NOT NULL,
  `AccountIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(16) NOT NULL,
  `MateId` int(4) unsigned NOT NULL,
  `Level` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `Experience` bigint(16) unsigned NOT NULL DEFAULT 0,
  `Profession` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `OldProfession` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `NewProfession` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Metempsychosis` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Strength` smallint(2) unsigned NOT NULL DEFAULT 0,
  `Agility` smallint(2) unsigned NOT NULL DEFAULT 0,
  `Vitality` smallint(2) unsigned NOT NULL DEFAULT 0,
  `Spirit` smallint(2) unsigned NOT NULL DEFAULT 0,
  `AdditionalPoints` smallint(2) unsigned NOT NULL DEFAULT 0,
  `SyndicateIdentity` int(4) unsigned NOT NULL DEFAULT 0,
  `SyndicatePosition` smallint(2) unsigned NOT NULL DEFAULT 0,
  `NobilityDonation` bigint(16) unsigned NOT NULL DEFAULT 0,
  `NobilityRank` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `SupermanCount` int(4) unsigned NOT NULL DEFAULT 0,
  `DeletedAt` datetime DEFAULT NULL,
  `Money` bigint(20) unsigned NOT NULL DEFAULT 0,
  `WarehouseMoney` int(10) unsigned NOT NULL DEFAULT 0,
  `ConquerPoints` int(10) unsigned NOT NULL DEFAULT 0,
  `FamilyIdentity` int(10) unsigned NOT NULL DEFAULT 0,
  `FamilyRank` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE KEY `IdIdx` (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records_user`
--

LOCK TABLES `records_user` WRITE;
/*!40000 ALTER TABLE `records_user` DISABLE KEYS */;
INSERT INTO `records_user` VALUES (3,7,0,0,'Cristian',0,1,0,40,0,0,0,2,7,1,0,0,0,0,0,0,0,NULL,1000,0,0,0,0),(4,7,0,0,'Cristian',0,19,0,40,0,0,0,13,45,6,0,0,0,0,0,0,0,NULL,7724,0,0,0,0);
/*!40000 ALTER TABLE `records_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reward_type`
--

DROP TABLE IF EXISTS `reward_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reward_type` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` int(10) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(255) NOT NULL DEFAULT 'StrUnknown',
  `ActionId` int(10) unsigned NOT NULL DEFAULT 0,
  `ItemType` int(10) unsigned NOT NULL DEFAULT 0,
  `Money` int(10) unsigned NOT NULL DEFAULT 0,
  `ConquerPoints` int(10) unsigned NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reward_type`
--

LOCK TABLES `reward_type` WRITE;
/*!40000 ALTER TABLE `reward_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `reward_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reward_user`
--

DROP TABLE IF EXISTS `reward_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reward_user` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AccountId` int(10) unsigned NOT NULL DEFAULT 0,
  `RewardId` int(10) unsigned NOT NULL DEFAULT 0,
  `ClaimerId` int(10) unsigned NOT NULL DEFAULT 0,
  `ClaimedAt` datetime DEFAULT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reward_user`
--

LOCK TABLES `reward_user` WRITE;
/*!40000 ALTER TABLE `reward_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `reward_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_checkout`
--

DROP TABLE IF EXISTS `shop_checkout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_checkout` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `UserId` int(10) unsigned NOT NULL DEFAULT 0,
  `Comment` text DEFAULT NULL,
  `BillingInformationId` int(10) unsigned NOT NULL DEFAULT 0,
  `PaymentType` int(10) unsigned NOT NULL DEFAULT 0,
  `TransactionToken` varchar(255) NOT NULL,
  `PaidAt` datetime DEFAULT NULL,
  `PaymentMethodType` int(10) unsigned NOT NULL DEFAULT 0,
  `PaymentMethodCode` int(10) unsigned NOT NULL DEFAULT 0,
  `PaymentUrl` varchar(255) NOT NULL,
  `TransactionStatus` int(11) NOT NULL DEFAULT 0,
  `ClientName` varchar(255) NOT NULL DEFAULT '',
  `ClientEmail` varchar(255) NOT NULL DEFAULT '',
  `ClientAddress` varchar(255) NOT NULL DEFAULT '',
  `ClientNumber` int(11) NOT NULL DEFAULT 0,
  `ClientComplement` varchar(255) NOT NULL DEFAULT '',
  `ClientDistrict` varchar(255) NOT NULL DEFAULT '',
  `ClientCity` varchar(255) NOT NULL DEFAULT '',
  `ClientState` varchar(255) NOT NULL DEFAULT '',
  `ClientPostalCode` varchar(255) NOT NULL DEFAULT '',
  `ClientPhone` varchar(255) NOT NULL DEFAULT '',
  `CancelationSource` varchar(255) NOT NULL DEFAULT '',
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000000034 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_checkout`
--

LOCK TABLES `shop_checkout` WRITE;
/*!40000 ALTER TABLE `shop_checkout` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_checkout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_checkout_items`
--

DROP TABLE IF EXISTS `shop_checkout_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_checkout_items` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CheckoutId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ProductId` int(10) unsigned NOT NULL DEFAULT 0,
  `Amount` int(10) unsigned NOT NULL DEFAULT 1,
  `Value` double NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `CheckoutId` (`CheckoutId`) USING BTREE,
  CONSTRAINT `ChkItems` FOREIGN KEY (`CheckoutId`) REFERENCES `shop_checkout` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_checkout_items`
--

LOCK TABLES `shop_checkout_items` WRITE;
/*!40000 ALTER TABLE `shop_checkout_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_checkout_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_checkout_status_tracking`
--

DROP TABLE IF EXISTS `shop_checkout_status_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_checkout_status_tracking` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CheckoutId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `TransactionId` varchar(255) NOT NULL,
  `NotificationCode` varchar(255) NOT NULL DEFAULT '',
  `NewStatus` int(10) unsigned NOT NULL DEFAULT 0,
  `Date` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`Id`) USING BTREE,
  KEY `CheckoutID` (`CheckoutId`) USING BTREE,
  CONSTRAINT `CheckoutID` FOREIGN KEY (`CheckoutId`) REFERENCES `shop_checkout` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_checkout_status_tracking`
--

LOCK TABLES `shop_checkout_status_tracking` WRITE;
/*!40000 ALTER TABLE `shop_checkout_status_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_checkout_status_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_products`
--

DROP TABLE IF EXISTS `shop_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_products` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `long_description` text NOT NULL,
  `value` double(20,2) unsigned NOT NULL DEFAULT 0.00,
  `data0` int(11) NOT NULL DEFAULT 0,
  `data1` int(11) NOT NULL DEFAULT 0,
  `data2` int(11) NOT NULL DEFAULT 0,
  `data3` int(11) NOT NULL DEFAULT 0,
  `data4` int(11) NOT NULL DEFAULT 0,
  `data5` int(11) NOT NULL DEFAULT 0,
  `data6` int(11) NOT NULL DEFAULT 0,
  `data7` int(11) NOT NULL DEFAULT 0,
  `img_thumb` int(10) unsigned NOT NULL DEFAULT 0,
  `img_main` int(10) unsigned NOT NULL DEFAULT 0,
  `flag` int(10) unsigned NOT NULL DEFAULT 0,
  `from` datetime DEFAULT NULL,
  `to` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000000052 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_products`
--

LOCK TABLES `shop_products` WRITE;
/*!40000 ALTER TABLE `shop_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_products_img`
--

DROP TABLE IF EXISTS `shop_products_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_products_img` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL,
  `folder` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_products_img`
--

LOCK TABLES `shop_products_img` WRITE;
/*!40000 ALTER TABLE `shop_products_img` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_products_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_tickets` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserId` int(10) unsigned NOT NULL DEFAULT 0,
  `Subject` varchar(255) NOT NULL DEFAULT '',
  `Content` text NOT NULL,
  `Urgency` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `RequireAdm` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `LastReply` datetime DEFAULT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  `Flag` int(11) NOT NULL DEFAULT 0,
  `Status` int(4) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets`
--

LOCK TABLES `support_tickets` WRITE;
/*!40000 ALTER TABLE `support_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_tickets_answers`
--

DROP TABLE IF EXISTS `support_tickets_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_tickets_answers` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TicketId` int(10) unsigned DEFAULT 0,
  `AuthorId` int(10) unsigned DEFAULT 0,
  `Message` text DEFAULT NULL,
  `Solution` tinyint(3) unsigned DEFAULT 0,
  `CreatedAt` datetime NOT NULL DEFAULT current_timestamp(),
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_tickets_answers`
--

LOCK TABLES `support_tickets_answers` WRITE;
/*!40000 ALTER TABLE `support_tickets_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_tickets_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_exception_handing`
--

DROP TABLE IF EXISTS `web_exception_handing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_exception_handing` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `Path` varchar(255) NOT NULL DEFAULT '',
  `Message` varchar(255) NOT NULL,
  `StackTrace` text NOT NULL,
  `Date` datetime NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_exception_handing`
--

LOCK TABLES `web_exception_handing` WRITE;
/*!40000 ALTER TABLE `web_exception_handing` DISABLE KEYS */;
/*!40000 ALTER TABLE `web_exception_handing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'account_zf'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetTopGuildWinners` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopGuildWinners`(IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	SELECT
		guild.`Name` `SyndicateName`,
		IFNULL( usr.`Name`, "StrUnknown" ) `LeaderName`,
		guild.Count `MemberCount`,
		( SELECT COUNT( gw.SyndicateIdentity ) FROM records_guild_war gw WHERE gw.SyndicateIdentity = guild.SyndicateIdentity ) `GuildWars` 
	FROM
		records_syndicate guild
		LEFT JOIN records_user usr ON usr.UserIdentity = guild.LeaderIdentity 
		WHERE (idServer = -1 OR guild.ServerIdentity = idServer)
		LIMIT maxLimit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopMoneybag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopMoneybag`(IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	
	SELECT
		ru0.`Name` `PlayerName`,
		IFNULL( ru1.`Name`, "None" ) `MateName`,
		ru0.`Level` `Level`,
		ru0.Profession `Profession`,
		(ru0.Money + ru0.WarehouseMoney) `Moneybag`,
		IFNULL( syn.`Name`, "None" ) `SyndicateName`
	FROM
		records_user ru0
		LEFT JOIN records_user ru1 ON ru0.MateId = ru1.Id
		LEFT JOIN records_syndicate syn ON syn.Id=ru0.SyndicateIdentity
	WHERE 
		ru0.`Name` NOT LIKE "%[%]%"
		AND (idServer = -1 OR ru0.ServerIdentity = idServer)
	ORDER BY (ru0.Money + ru0.WarehouseMoney) DESC
	LIMIT maxLimitFrom, maxLimit;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopNoble` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopNoble`(IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	
	SELECT
		ru0.`Name` `PlayerName`,
		IFNULL( ru1.`Name`, "None" ) `MateName`,
		ru0.`Level` `Level`,
		ru0.Profession `Profession`,
		ru0.NobilityDonation `NobleDonation`,
		IFNULL( syn.`Name`, "None" ) `SyndicateName`
	FROM
		records_user ru0
		LEFT JOIN records_user ru1 ON ru0.MateId = ru1.Id
		LEFT JOIN records_syndicate syn ON syn.Id=ru0.SyndicateIdentity
	WHERE 
		ru0.NobilityDonation > 3000000
		AND (idServer = -1 OR ru0.ServerIdentity = idServer)
	ORDER BY ru0.NobilityDonation DESC
	LIMIT maxLimitFrom, maxLimit;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopPlayers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopPlayers`(IN minLevel INT, IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	
	SELECT
		ru0.`Name` `PlayerName`,
		IFNULL( ru1.`Name`, "None" ) `MateName`,
		ru0.`Level` `Level`,
		ru0.Profession `Profession`,
		IFNULL( syn.`Name`, "None" ) `SyndicateName`
	FROM
		records_user ru0
		LEFT JOIN records_user ru1 ON ru0.MateId = ru1.UserIdentity
		LEFT JOIN records_syndicate syn ON syn.SyndicateIdentity=ru0.SyndicateIdentity
	WHERE 
		ru0.`Level` >= minLevel
		AND ru0.`Name` NOT LIKE "%[%]%"
		AND (idServer = -1 OR ru0.ServerIdentity = idServer)
	ORDER BY ru0.`Level` DESC, ru0.Experience DESC
	LIMIT maxLimitFrom, maxLimit;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopProfession` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopProfession`(IN minLevel INT, IN fromProf INT, IN toProf INT, IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	
	SELECT
		ru0.`Name` `PlayerName`,
		IFNULL( ru1.`Name`, "None" ) `MateName`,
		ru0.`Level` `Level`,
		ru0.Profession `Profession`,
		IFNULL( syn.`Name`, "None" ) `SyndicateName`
	FROM
		records_user ru0
		LEFT JOIN records_user ru1 ON ru0.MateId = ru1.UserIdentity
		LEFT JOIN records_syndicate syn ON syn.SyndicateIdentity=ru0.SyndicateIdentity
	WHERE 
		ru0.Profession BETWEEN fromProf AND toProf
		AND ru0.`Level` >= minLevel		
		AND ru0.`Name` NOT LIKE "%[%]%"
		AND (idServer = -1 OR ru0.ServerIdentity = idServer)
	ORDER BY ru0.`Level` DESC, ru0.Experience DESC
	LIMIT maxLimitFrom, maxLimit;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopSuperman` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopSuperman`(IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	
	SELECT
		ru0.`Name` `PlayerName`,
		IFNULL( ru1.`Name`, "None" ) `MateName`,
		ru0.`Level` `Level`,
		ru0.Profession `Profession`,
		ru0.SupermanCount `SupermanCount`,
		IFNULL( syn.`Name`, "None" ) `SyndicateName`
	FROM
		records_user ru0
		LEFT JOIN records_user ru1 ON ru0.MateId = ru1.Id
		LEFT JOIN records_syndicate syn ON syn.Id=ru0.SyndicateIdentity
	WHERE 
		ru0.`Name` NOT LIKE "%[%]%" AND ru0.SupermanCount > 0		
		AND (idServer = -1 OR ru0.ServerIdentity = idServer)
	ORDER BY ru0.`SupermanCount` DESC
	LIMIT maxLimitFrom, maxLimit;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTopSyndicate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTopSyndicate`(IN minMembers INT, IN maxLimit INT, IN maxLimitFrom INT, IN idServer INT)
BEGIN
	
	SELECT
		syn.`Name` `Name`,
		usr.`Name` `LeaderName`,
		syn.Count `SyndicateCount`,
		(SELECT COUNT(*) FROM records_guild_war rgw WHERE rgw.SyndicateIdentity=syn.SyndicateIdentity) `GuildWarCount`
	FROM
		records_syndicate syn
		LEFT JOIN records_user usr ON usr.UserIdentity=syn.LeaderIdentity AND usr.`Name` NOT LIKE "%[%]%"		
	WHERE 
		syn.Count >= minMembers
		AND ISNULL(syn.DeletedAt)
		AND (idServer = -1 OR ru0.ServerIdentity = idServer)
	ORDER BY syn.`Count` DESC
	LIMIT maxLimitFrom, maxLimit;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-25 14:19:13
