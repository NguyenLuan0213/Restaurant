-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: restaurant_demo
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20231001174735_FixFrameWork','7.0.11'),('20231002030943_NewIdentity','7.0.11'),('20231002031808_FixIdentiry','7.0.11');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `bill_date` timestamp NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `customer_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `promotion_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_customer_idx` (`customer_id`),
  KEY `fk_bill_order_idx` (`order_id`),
  KEY `fk_bill_promotion_idx` (`promotion_id`),
  CONSTRAINT `fk_bill_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`Id`),
  CONSTRAINT `fk_bill_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_bill_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1,1,'2023-09-15 03:00:00',180000.00,180000.00,NULL,NULL),(2,2,'2023-09-15 03:00:00',250000.00,250000.00,NULL,NULL),(3,3,'2023-09-15 03:00:00',130000.00,130000.00,NULL,NULL),(4,4,'2023-09-15 03:00:00',100000.00,100000.00,NULL,NULL),(5,5,'2023-09-14 21:30:00',360000.00,360000.00,NULL,NULL),(6,6,'2023-09-15 00:30:00',440000.00,440000.00,NULL,NULL),(7,7,'2023-09-14 20:00:00',185000.00,185000.00,NULL,NULL),(8,8,'2023-09-15 01:30:00',290000.00,290000.00,NULL,NULL),(9,9,'2023-09-14 20:30:00',270000.00,270000.00,NULL,NULL),(10,10,'2023-09-15 02:30:00',345000.00,345000.00,NULL,NULL),(11,11,'2023-09-15 22:00:00',110000.00,110000.00,NULL,NULL),(12,12,'2023-09-15 21:30:00',290000.00,290000.00,NULL,NULL),(13,13,'2023-09-15 02:05:00',130000.00,130000.00,NULL,NULL),(14,14,'2023-09-15 06:00:00',294000.00,294000.00,NULL,NULL),(15,15,'2023-09-14 22:00:00',160000.00,160000.00,NULL,NULL),(16,16,'2023-09-15 05:40:00',138000.00,138000.00,NULL,NULL),(17,17,'2023-09-15 21:10:00',550000.00,550000.00,NULL,NULL),(18,18,'2023-09-16 07:30:00',220000.00,220000.00,NULL,NULL),(19,19,'2023-09-15 03:40:00',324000.00,324000.00,NULL,NULL),(20,20,'2023-09-16 02:36:00',205000.00,205000.00,NULL,NULL),(21,21,'2023-09-15 21:10:00',260000.00,260000.00,NULL,NULL),(22,22,'2023-09-16 07:30:00',80000.00,80000.00,NULL,NULL),(23,23,'2023-09-14 23:10:00',170000.00,170000.00,NULL,NULL),(24,24,'2023-09-15 21:40:00',295000.00,295000.00,NULL,NULL),(25,25,'2023-09-15 02:20:00',210000.00,210000.00,NULL,NULL),(26,26,'2023-09-15 05:15:00',145000.00,145000.00,NULL,NULL),(27,27,'2023-09-14 16:10:00',130000.00,130000.00,NULL,NULL),(28,28,'2023-09-16 02:00:00',120000.00,120000.00,NULL,NULL),(29,29,'2023-09-15 03:10:00',130000.00,130000.00,NULL,NULL),(30,30,'2023-09-15 06:10:00',150000.00,150000.00,NULL,NULL),(31,31,'2023-09-16 01:20:00',110000.00,110000.00,NULL,NULL),(32,32,'2023-09-16 07:45:00',210000.00,210000.00,NULL,NULL),(33,33,'2023-09-16 05:30:00',230000.00,230000.00,NULL,NULL),(34,34,'2023-09-16 03:25:00',265000.00,265000.00,NULL,NULL),(35,35,'2023-09-15 01:20:00',290000.00,290000.00,NULL,NULL),(36,36,'2023-09-15 06:20:00',175000.00,175000.00,NULL,NULL),(37,37,'2023-09-15 23:11:00',148000.00,148000.00,NULL,NULL),(38,38,'2023-09-16 07:45:00',130000.00,130000.00,NULL,NULL),(39,39,'2023-09-15 22:26:00',235000.00,235000.00,NULL,NULL),(40,40,'2023-09-16 07:45:00',364000.00,364000.00,NULL,NULL),(41,41,'2023-09-14 22:00:00',120000.00,120000.00,NULL,NULL),(42,42,'2023-09-15 07:40:00',275000.00,275000.00,NULL,NULL),(43,43,'2023-09-14 19:55:00',225000.00,225000.00,NULL,NULL),(44,44,'2023-09-15 05:05:00',200000.00,200000.00,NULL,NULL),(45,45,'2023-09-15 07:55:00',110000.00,110000.00,NULL,NULL),(46,46,'2023-09-16 03:19:00',130000.00,130000.00,NULL,NULL),(47,47,'2023-09-14 22:06:00',160000.00,160000.00,NULL,NULL),(48,48,'2023-09-15 06:05:00',395000.00,395000.00,NULL,NULL),(49,49,'2023-09-14 23:16:00',145000.00,145000.00,NULL,NULL),(50,50,'2023-09-15 01:50:00',130000.00,130000.00,NULL,NULL),(51,51,'2023-09-15 06:10:00',355000.00,355000.00,NULL,NULL),(52,52,'2023-09-15 07:05:00',120000.00,120000.00,NULL,NULL),(53,53,'2023-09-15 20:06:00',170000.00,170000.00,NULL,NULL),(54,54,'2023-09-16 05:20:00',150000.00,150000.00,NULL,NULL),(55,55,'2023-09-14 22:20:00',220000.00,220000.00,NULL,NULL),(56,56,'2023-09-15 06:36:00',120000.00,120000.00,NULL,NULL),(57,57,'2023-09-15 04:10:00',140000.00,140000.00,NULL,NULL),(58,58,'2023-09-15 06:58:00',404000.00,404000.00,NULL,NULL),(59,59,'2023-09-16 04:15:00',275000.00,275000.00,NULL,NULL),(60,60,'2023-09-16 07:55:00',170000.00,170000.00,NULL,NULL);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `restaurant_id` int NOT NULL,
  `rating` int NOT NULL,
  `review_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `comment_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_coment_customer_idx` (`customer_id`),
  KEY `fk_coment_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_coment_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`Id`),
  CONSTRAINT `fk_coment_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurantsbr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mean`
--

DROP TABLE IF EXISTS `mean`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mean` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_mean_order` FOREIGN KEY (`id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mean`
--

LOCK TABLES `mean` WRITE;
/*!40000 ALTER TABLE `mean` DISABLE KEYS */;
INSERT INTO `mean` VALUES (1,NULL,NULL),(2,NULL,NULL),(3,NULL,NULL),(4,NULL,NULL),(5,NULL,NULL),(6,NULL,NULL),(7,NULL,NULL),(8,NULL,NULL),(9,NULL,NULL),(10,NULL,NULL),(11,NULL,NULL),(12,NULL,NULL),(13,NULL,NULL),(14,NULL,NULL),(15,NULL,NULL),(16,NULL,NULL),(17,NULL,NULL),(18,NULL,NULL),(19,NULL,NULL),(20,NULL,NULL),(21,NULL,NULL),(22,NULL,NULL),(23,NULL,NULL),(24,NULL,NULL),(25,NULL,NULL),(26,NULL,NULL),(27,NULL,NULL),(28,NULL,NULL),(29,NULL,NULL),(30,NULL,NULL),(31,NULL,NULL),(32,NULL,NULL),(33,NULL,NULL),(34,NULL,NULL),(35,NULL,NULL),(36,NULL,NULL),(37,NULL,NULL),(38,NULL,NULL),(39,NULL,NULL),(40,NULL,NULL),(41,NULL,NULL),(42,NULL,NULL),(43,NULL,NULL),(44,NULL,NULL),(45,NULL,NULL),(46,NULL,NULL),(47,NULL,NULL),(48,NULL,NULL),(49,NULL,NULL),(50,NULL,NULL),(51,NULL,NULL),(52,NULL,NULL),(53,NULL,NULL),(54,NULL,NULL),(55,NULL,NULL),(56,NULL,NULL),(57,NULL,NULL),(58,NULL,NULL),(59,NULL,NULL),(60,NULL,NULL);
/*!40000 ALTER TABLE `mean` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meanitem`
--

DROP TABLE IF EXISTS `meanitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meanitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mean_id` int NOT NULL,
  `menuItem_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meanItem_mean_idx` (`mean_id`),
  KEY `fk_meanItem_menuItem_idx` (`menuItem_id`),
  CONSTRAINT `fk_meanItem_mean` FOREIGN KEY (`mean_id`) REFERENCES `mean` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_meanItem_menuItem` FOREIGN KEY (`menuItem_id`) REFERENCES `menuitem` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meanitem`
--

LOCK TABLES `meanitem` WRITE;
/*!40000 ALTER TABLE `meanitem` DISABLE KEYS */;
INSERT INTO `meanitem` VALUES (1,1,1,2,NULL),(2,1,2,1,NULL),(3,1,10,1,NULL),(4,2,3,1,NULL),(5,2,4,2,NULL),(6,2,6,2,NULL),(7,3,16,1,NULL),(8,3,17,1,NULL),(9,3,25,1,NULL),(10,4,19,1,NULL),(11,4,24,1,NULL),(12,4,29,2,NULL),(13,5,41,1,NULL),(14,5,45,1,NULL),(15,5,50,2,NULL),(16,6,21,2,NULL),(17,6,38,2,NULL),(18,6,39,1,NULL),(19,7,64,1,NULL),(20,7,65,2,NULL),(21,7,70,3,NULL),(22,8,13,2,NULL),(23,8,32,1,NULL),(24,8,33,1,NULL),(25,9,59,2,NULL),(26,9,60,1,NULL),(27,9,72,2,NULL),(28,10,55,1,NULL),(29,10,60,1,NULL),(30,10,71,3,NULL),(31,11,1,1,NULL),(32,11,7,1,NULL),(33,11,14,1,NULL),(34,12,42,2,NULL),(35,12,43,1,NULL),(36,12,49,2,NULL),(37,13,19,1,NULL),(38,13,23,1,NULL),(39,13,28,3,NULL),(40,14,31,1,NULL),(41,14,36,2,NULL),(42,14,39,2,NULL),(43,15,65,2,NULL),(44,15,72,1,NULL),(45,15,75,1,NULL),(46,16,61,1,NULL),(47,16,62,1,NULL),(48,16,70,3,NULL),(49,17,43,2,NULL),(50,17,45,2,NULL),(51,17,49,2,NULL),(52,18,26,3,NULL),(53,18,46,1,NULL),(54,18,47,1,NULL),(55,19,31,1,NULL),(56,19,37,1,NULL),(57,19,39,1,NULL),(58,20,42,1,NULL),(59,20,44,1,NULL),(60,20,49,1,NULL),(61,21,52,2,NULL),(62,21,53,1,NULL),(63,21,69,2,NULL),(64,22,9,1,NULL),(65,22,10,1,NULL),(66,22,12,2,NULL),(67,23,3,3,NULL),(68,23,11,1,NULL),(69,23,12,1,NULL),(70,24,34,1,NULL),(71,24,38,1,NULL),(72,24,39,3,NULL),(73,25,44,1,NULL),(74,25,48,1,NULL),(75,25,50,2,NULL),(76,26,57,1,NULL),(77,26,58,1,NULL),(78,26,69,1,NULL),(79,27,67,2,NULL),(80,27,74,1,NULL),(81,27,75,1,NULL),(82,28,16,2,NULL),(83,28,26,1,NULL),(84,28,27,1,NULL),(85,29,20,1,NULL),(86,29,21,1,NULL),(87,29,28,3,NULL),(88,30,3,1,NULL),(89,30,4,1,NULL),(90,30,7,1,NULL),(91,31,9,2,NULL),(92,31,10,1,NULL),(93,31,15,2,NULL),(94,32,17,1,NULL),(95,32,24,1,NULL),(96,32,25,1,NULL),(97,33,14,3,NULL),(98,33,33,1,NULL),(99,33,35,1,NULL),(100,34,42,1,NULL),(101,34,47,1,NULL),(102,34,49,3,NULL),(103,35,54,2,NULL),(104,35,59,1,NULL),(105,35,70,2,NULL),(106,36,64,1,NULL),(107,36,68,1,NULL),(108,36,74,1,NULL),(109,37,63,1,NULL),(110,37,65,1,NULL),(111,37,70,3,NULL),(112,38,5,1,NULL),(113,38,6,1,NULL),(114,38,14,3,NULL),(115,39,37,1,NULL),(116,39,38,1,NULL),(117,39,40,2,NULL),(118,40,31,1,NULL),(119,40,33,1,NULL),(120,40,40,2,NULL),(121,41,21,2,NULL),(122,41,28,1,NULL),(123,41,30,1,NULL),(124,42,56,1,NULL),(125,42,57,1,NULL),(126,42,61,1,NULL),(127,43,59,1,NULL),(128,43,60,1,NULL),(129,43,71,1,NULL),(130,44,68,2,NULL),(131,44,70,2,NULL),(132,44,71,2,NULL),(133,45,23,1,NULL),(134,45,24,1,NULL),(135,45,28,3,NULL),(136,46,3,1,NULL),(137,46,5,1,NULL),(138,46,11,3,NULL),(139,47,20,1,NULL),(140,47,21,2,NULL),(141,47,28,1,NULL),(142,48,41,2,NULL),(143,48,42,1,NULL),(144,48,49,1,NULL),(145,49,66,1,NULL),(146,49,67,1,NULL),(147,49,74,2,NULL),(148,50,61,1,NULL),(149,50,65,1,NULL),(150,50,72,1,NULL),(151,51,36,1,NULL),(152,51,37,1,NULL),(153,51,38,3,NULL),(154,52,6,1,NULL),(155,52,8,1,NULL),(156,52,15,2,NULL),(157,53,21,1,NULL),(158,53,22,2,NULL),(159,53,28,2,NULL),(160,54,56,1,NULL),(161,54,57,1,NULL),(162,54,70,3,NULL),(163,55,55,1,NULL),(164,55,58,1,NULL),(165,55,72,3,NULL),(166,56,22,1,NULL),(167,56,23,1,NULL),(168,56,30,2,NULL),(169,57,3,1,NULL),(170,57,5,1,NULL),(171,57,15,2,NULL),(172,58,31,1,NULL),(173,58,32,1,NULL),(174,58,35,1,NULL),(175,59,20,1,NULL),(176,59,45,1,NULL),(177,59,49,3,NULL),(178,60,52,1,NULL),(179,60,54,1,NULL),(180,60,72,3,NULL);
/*!40000 ALTER TABLE `meanitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `fk_menu_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_menu_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurantsbr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Nhà hàng Chí Tiên',NULL),(2,2,'Nhà hàng Chí Tiên 2',NULL),(3,3,'Nhà hàng Sơn Trà',NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menu_menus_idx` (`menu_id`),
  CONSTRAINT `fk_menu_menus` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES (1,1,'Bánh Mì Hòa','Mì Quảng Đà Nẵng',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696320850/f38spctbdkzkybuxbx9k.jpg'),(2,1,'Bánh Mì Gà Rán','Bánh Mì Gà Rán',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696320934/t1micjxn5ctqdhmwcucn.png'),(3,1,'Phở Bò','Phở Bò Việt Nam',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321027/hezgl6junnem9pqpqums.jpg'),(4,1,'Bún Bò Huế',NULL,50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321175/l3a0grhiy0fqnjtzanpg.png'),(5,1,'Gỏi Cuốn','Gỏi Cuốn Gà',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321209/lt5k9m5a7ly9nj3yuzsi.jpg'),(6,1,'Bánh Xèo','Bánh Xèo Miền Trung',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321247/tdk6lqxifo6bhn5gxmfd.png'),(7,1,'Bún Chả','Bún Chả Hà Nội',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321278/jlrys0u1nra9nnfv1aan.jpg'),(8,1,'Cơm Tấm','Cơm Tấm Sài Gòn',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321301/ub75hkifw7hi1gkngcj7.jpg'),(9,1,'Bánh Mì Pate','Bánh Mì Pate Sốt',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321320/ujczrook438qi9ycxjpr.jpg'),(10,1,'Bánh Mì Pate','Bánh Mì Pate Sốt',30000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321343/rtimp0n7cwjkzj88qdpm.jpg'),(11,1,'CocaCola',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321492/tpwkj1t7jltizuw5edg4.png'),(12,1,'Sting đỏ',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321519/ebjwrhvpy3x9cbc0hiva.jpg'),(13,1,'Trà đá',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321540/rr1n5hwn1ggerglit9hz.png'),(14,1,'Nước sấu',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321732/o5kgifldobt3wnhofmv0.jpg'),(15,1,'Nước cam vắt',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321753/wtimansp7qz7dziar3sa.jpg'),(16,2,'Mì Quảng','Mì Quảng Đà Nẵng',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321821/avxnhgox7n1opn6h1qab.jpg'),(17,2,'Bánh Mì Hòa','Bánh Mì Gà Rán',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321852/valskyjixiak1xpoyssw.png'),(18,2,'Phở Bò','Phở Bò Việt Nam',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321882/qbgweuaivez6fzdcwfuu.jpg'),(19,2,'Bún Bò Huế','Phở Bò Việt Nam',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321907/kzlvec4jjeohbbgf8fya.png'),(20,2,'Gỏi Cuốn','Gỏi Cuốn Gà',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321935/jndhhx4vgldtpa0b3pns.jpg'),(21,2,'Bánh Xèo','Bánh Xèo Miền Trung',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696321973/qxx0wlibvubx06calznv.png'),(22,2,'Bún Chả','Bún Chả Hà Nội',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322114/wzq7lda9oatdabpko3i8.jpg'),(23,2,'Cơm Tấm','Cơm Tấm Sài Gòn',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322134/sv6mtemee3wpshnxjxr3.jpg'),(24,2,'Bánh Mì Pate','Bánh Mì Pate',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322150/donlduwzjijqpppkw9vq.jpg'),(25,2,'Bánh Mì Kẹp Thịt','Bánh Mì Kẹp Thịt Ngon',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322179/mh21pgkqxsgakhdqjv2l.jpg'),(26,2,'CocaCola',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322465/ha5yukfng8yha53jgaaz.png'),(27,2,'Sting đỏ',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322473/ud76eulujbot755w4u0t.jpg'),(28,2,'Trà đá',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322495/xei4r2qs04xu3cawobwk.png'),(29,2,'Nước sấu',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322507/se6kxntckx21cfapvxbd.jpg'),(30,2,'Nước cam vắt',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322524/yosnakvxj8s9xwdwpx5r.jpg'),(31,1,'Gà Nướng Mỡ Hành','Gà Nướng Mỡ Hành Miền Tây',194000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322615/hexjvzmas7vqvppp0jqp.png'),(32,1,'Cá Kho Tộ','Cá Kho Tộ Ngon',120000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322626/rvs6n0mbvw4szzwqtmyg.jpg'),(33,1,'Canh Chua Cá Lóc','Canh Chua Cá Lóc Ngon',150000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322645/eirdhassfs1xnynwno3j.jpg'),(34,1,'Hủ Tiếu Nam Vang','Hủ Tiếu Nam Vang Ngon',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322670/mfmmbkbsko1y26v8vicw.jpg'),(35,1,'Cơm Bò Lúc Lắc','Cơm Bò Lúc Lắc Mềm Ngon',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322701/m0dvyctczspgrswyighs.webp'),(36,1,'Cơm Bò Lúc Lắc','Cơm Bò Lúc Lắc Mềm Ngon',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322737/snx7yvnv0stvx7nttzdo.jpg'),(37,1,'Nem Nướng','Nem Nướng Nha Trang',120000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322908/is5uccyrzbuyoxjtrdjs.jpg'),(38,1,'Mì Xào Hải Sản','Mì Xào Hải Sản Tươi Ngon',65000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322926/fzkixax9gx0yzx9crms4.jpg'),(39,1,'7UP',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322951/k5xrxwsxvprshf9tkjp4.png'),(40,1,'Sprite',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696322968/rsbubdldaejrwjrv1o3b.jpg'),(41,2,'Gỏi Ngó Sen','Gỏi Ngó Sen Ngon',150000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323250/ph3bupke7ssyg8slmisk.jpg'),(42,2,'Mực Xào Sả Ớt','Mực Xào Sả Ớt Ngon',70000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323273/yzasppxgmhtlxtvuqvwn.png'),(43,2,'Bò Tái Chanh','Bò Tái Chanh Tươi Ngon',100000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323297/rkhn0qdbw5q6v4z8plir.jpg'),(44,2,'Hải Sản Hấp Gừng','Hải Sản Hấp Gừng Tươi Ngon',110000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323320/x5igu2qlvy0v2iitiwct.jpg'),(45,2,'Lẩu Thái','Lẩu Thái Chua Cay',150000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323336/tzwkrx9ea00wvymi6qto.jpg'),(46,2,'Gà Kho Gừng','Gà Kho Gừng Ngon ',70000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323366/aad7zqsjs0uwulxfeabz.jpg'),(47,2,'Cá Basa Chiên','Cá Basa Chiên Giòn',120000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323396/thfsi3ovu21nxiyfofn7.jpg'),(48,2,'Xôi Nén',NULL,40000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323413/cgt5d6b7qtnsqsbpq6as.webp'),(49,2,'Soda chanh dây',NULL,25000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323429/euq7ysqo4ufzqkztdl8s.png'),(50,2,'Sinh tố trái cây',NULL,30000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323454/omde2rxbknfj8kqfjiu4.jpg'),(51,3,'Gà Nướng Mắm','Gà Nướng Mắm Nhĩ ',200000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323601/ue7yeqwbvy4e602jrhkn.jpg'),(52,3,'Mì Xào Ốc Móng Tay','Mì Xào Ốc Móng Tay Ngon',50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323621/uz1dqp6lud1vjrdytzzw.jpg'),(53,3,'Cá Bớp Chiên Bơ',NULL,130000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323658/ao8byilrahkmxz2msqf1.jpg'),(54,3,'Ba Rọi Nướng Sa Tế','Ba Rọi Nướng Sa Tế Cay',90000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323814/s40htou1txlvziixzqgn.jpg'),(55,3,'Lòng Gà Trứng Non Cháy Tỏi',NULL,120000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323836/ssotwknnjtmwotfhjoa3.jpg'),(56,3,'Hủ Tiếu Bò Kho',NULL,60000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323885/wqddnrwzjjhmknx7d3v4.jpg'),(57,3,'Bún Mắm Nêm',NULL,60000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323906/qpgoqccgrbas1hqynvj0.jpg'),(58,3,'Bò Lá Lốt','Bò Lá Lốt Nướng ',70000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323943/a4mduj7o6p4ddgqwukud.jpg'),(59,3,'Gỏi Đu Đủ',NULL,50000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323975/ehyhtzntsz22zhvpumyj.png'),(60,3,'Gà Rang Muối','Gà Rang Muối Nguyên Con',150000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696323997/bhqkqy8foj8yx2bzsdjr.jpg'),(61,3,'Bánh Canh Cua','Bánh Canh Cua, Chả Cua',55000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324047/uqmmoutq6pjxq1vvrlud.png'),(62,3,'Cơm Tấm Ba Rọi Nướng ','Cơm Tấm Ba Rọi Nướng Ngon',53000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324063/ugwfmzrpb7f96nd7vceu.jpg'),(63,3,'Bún Thịt Nướng','Cơm Tấm Ba Rọi Nướng Ngon',53000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324088/y3scrh1bgjat7wmc8hdf.jpg'),(64,3,'Cháo Ếch Singapore',NULL,90000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324113/tyj0axi6ag0ej8hfgaq9.jpg'),(65,3,'Mì Trộn Sốt Cay Hàn Quốc',NULL,65000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324132/oojhnvoy9vzlsftvncrw.jpg'),(66,3,'Cơm Cánh Gà Sốt Mắm Tỏi',NULL,60000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324150/jrpdqrhis1kbljdqyxwu.jpg'),(67,3,'Bánh Ướt Lòng Gà',NULL,45000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324169/rhjcbcmyrvjeqrnouk2i.jpg'),(68,3,'Ếch Chiên Nước Mắm',NULL,65000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324181/hsxk4hepxeks0u1lflq7.jpg'),(69,3,'Chanh muối ',NULL,15000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324196/hfncl1p9le6earejlfra.jpg'),(70,3,'Nước mía',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324214/tfzndtkkyywhsylamkw9.jpg'),(71,3,'Bia Sài Gòn',NULL,25000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324233/l3z2o5yvrlzphglgkzms.jpg'),(72,3,'Nước Ngọt',NULL,10000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324245/tfjkldfckhsrplonb4gn.jpg'),(73,3,'Cà phê',NULL,15000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324257/tlhep9zwarpv8wkhtgfo.jpg'),(74,3,'Bạc Xỉu',NULL,20000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324280/p5f5vhjaq5mhtpv7t39l.png'),(75,3,'Nước Chanh Dây',NULL,20000.00,'https://res.cloudinary.com/dkba7robk/image/upload/v1696324290/z7rbvcdrqyval9v9loh2.png');
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cashier_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `table_id` int NOT NULL,
  `order_time` timestamp NOT NULL,
  `status` enum('Chưa thanh toán','Đã thanh toán','Đã hủy') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `totalPrice` decimal(10,2) DEFAULT NULL,
  `customer_id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_tables_idx` (`table_id`),
  KEY `FK_orders_users_CustomerId_idx` (`cashier_id`),
  KEY `FK_orders_users_CustomerId_idx1` (`customer_id`),
  CONSTRAINT `fk_order_cashier` FOREIGN KEY (`cashier_id`) REFERENCES `users` (`Id`),
  CONSTRAINT `fk_order_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK_orders_users_CustomerId` FOREIGN KEY (`customer_id`) REFERENCES `users` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,NULL,1,'2023-09-14 10:00:00','Đã thanh toán',NULL,NULL),(2,NULL,2,'2023-09-14 10:00:00','Đã thanh toán',NULL,NULL),(3,NULL,16,'2023-09-14 10:00:00','Đã thanh toán',NULL,NULL),(4,NULL,17,'2023-09-14 10:00:00','Đã thanh toán',NULL,NULL),(5,NULL,1,'2023-09-14 19:30:00','Đã thanh toán',NULL,NULL),(6,NULL,2,'2023-09-14 20:30:00','Đã thanh toán',NULL,NULL),(7,NULL,3,'2023-09-14 17:00:00','Đã thanh toán',NULL,NULL),(8,NULL,3,'2023-09-14 19:30:00','Đã thanh toán',NULL,NULL),(9,NULL,4,'2023-09-14 17:30:00','Đã thanh toán',NULL,NULL),(10,NULL,4,'2023-09-14 22:30:00','Đã thanh toán',NULL,NULL),(11,NULL,5,'2023-09-15 16:00:00','Đã thanh toán',NULL,NULL),(12,NULL,5,'2023-09-15 19:30:00','Đã thanh toán',NULL,NULL),(13,NULL,6,'2023-09-14 20:00:00','Đã thanh toán',NULL,NULL),(14,NULL,6,'2023-09-15 02:30:00','Đã thanh toán',NULL,NULL),(15,NULL,7,'2023-09-14 18:00:00','Đã thanh toán',NULL,NULL),(16,NULL,7,'2023-09-15 00:35:00','Đã thanh toán',NULL,NULL),(17,NULL,8,'2023-09-15 18:00:00','Đã thanh toán',NULL,NULL),(18,NULL,8,'2023-09-16 05:30:00','Đã thanh toán',NULL,NULL),(19,NULL,9,'2023-09-14 17:45:00','Đã thanh toán',NULL,NULL),(20,NULL,9,'2023-09-15 19:30:00','Đã thanh toán',NULL,NULL),(21,NULL,10,'2023-09-15 16:15:00','Đã thanh toán',NULL,NULL),(22,NULL,10,'2023-09-16 05:35:00','Đã thanh toán',NULL,NULL),(23,NULL,11,'2023-09-14 18:00:00','Đã thanh toán',NULL,NULL),(24,NULL,11,'2023-09-15 17:00:00','Đã thanh toán',NULL,NULL),(25,NULL,12,'2023-09-14 18:20:00','Đã thanh toán',NULL,NULL),(26,NULL,12,'2023-09-14 20:45:00','Đã thanh toán',NULL,NULL),(27,NULL,13,'2023-09-14 16:10:00','Đã thanh toán',NULL,NULL),(28,NULL,13,'2023-09-15 20:00:00','Đã thanh toán',NULL,NULL),(29,NULL,14,'2023-09-14 21:00:00','Đã thanh toán',NULL,NULL),(30,NULL,14,'2023-09-15 06:10:00','Đã thanh toán',NULL,NULL),(31,NULL,15,'2023-09-15 17:20:00','Đã thanh toán',NULL,NULL),(32,NULL,15,'2023-09-16 04:35:00','Đã thanh toán',NULL,NULL),(33,NULL,16,'2023-09-16 01:00:00','Đã thanh toán',NULL,NULL),(34,NULL,17,'2023-09-16 03:25:00','Đã thanh toán',NULL,NULL),(35,NULL,18,'2023-09-14 17:00:00','Đã thanh toán',NULL,NULL),(36,NULL,18,'2023-09-15 02:20:00','Đã thanh toán',NULL,NULL),(37,NULL,19,'2023-09-15 17:08:00','Đã thanh toán',NULL,NULL),(38,NULL,19,'2023-09-16 06:05:00','Đã thanh toán',NULL,NULL),(39,NULL,20,'2023-09-15 18:06:00','Đã thanh toán',NULL,NULL),(40,NULL,20,'2023-09-16 07:00:00','Đã thanh toán',NULL,NULL),(41,NULL,21,'2023-09-14 19:00:00','Đã thanh toán',NULL,NULL),(42,NULL,21,'2023-09-15 06:10:00','Đã thanh toán',NULL,NULL),(43,NULL,22,'2023-09-14 17:30:00','Đã thanh toán',NULL,NULL),(44,NULL,22,'2023-09-15 01:45:00','Đã thanh toán',NULL,NULL),(45,NULL,23,'2023-09-15 07:00:00','Đã thanh toán',NULL,NULL),(46,NULL,23,'2023-09-15 20:10:00','Đã thanh toán',NULL,NULL),(47,NULL,24,'2023-09-14 18:00:00','Đã thanh toán',NULL,NULL),(48,NULL,24,'2023-09-15 03:05:00','Đã thanh toán',NULL,NULL),(49,NULL,25,'2023-09-14 18:06:00','Đã thanh toán',NULL,NULL),(50,NULL,25,'2023-09-14 22:30:00','Đã thanh toán',NULL,NULL),(51,NULL,26,'2023-09-14 20:00:00','Đã thanh toán',NULL,NULL),(52,NULL,26,'2023-09-15 05:05:00','Đã thanh toán',NULL,NULL),(53,NULL,27,'2023-09-15 17:00:00','Đã thanh toán',NULL,NULL),(54,NULL,27,'2023-09-15 19:50:00','Đã thanh toán',NULL,NULL),(55,NULL,28,'2023-09-14 17:20:00','Đã thanh toán',NULL,NULL),(56,NULL,28,'2023-09-15 04:45:00','Đã thanh toán',NULL,NULL),(57,NULL,29,'2023-09-14 18:10:00','Đã thanh toán',NULL,NULL),(58,NULL,29,'2023-09-15 06:08:00','Đã thanh toán',NULL,NULL),(59,NULL,30,'2023-09-15 18:05:00','Đã thanh toán',NULL,NULL),(60,NULL,30,'2023-09-16 06:10:00','Đã thanh toán',NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `promotion_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` timestamp NOT NULL,
  `end_date` timestamp NOT NULL,
  `discount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_promotion_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_promotion_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurantsbr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,1,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-03-19 10:00:00','2023-03-22 10:00:00',10.00),(2,2,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-03-19 10:00:00','2023-03-22 10:00:00',10.00);
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurantsbr`
--

DROP TABLE IF EXISTS `restaurantsbr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurantsbr` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantsbr`
--

LOCK TABLES `restaurantsbr` WRITE;
/*!40000 ALTER TABLE `restaurantsbr` DISABLE KEYS */;
INSERT INTO `restaurantsbr` VALUES (1,'Nhà hàng Chí Tiên','Bình Thạnh, TP.HCM','Nhà hàng 3 sao','https://res.cloudinary.com/dkba7robk/image/upload/v1696604137/dlaue3rktoamoivgqm1o.jpg'),(2,'Nhà hàng Chí Tiên 2','Gò Vấp, TP.HCM','Nhà hàng 3 sao','https://res.cloudinary.com/dkba7robk/image/upload/v1696601830/pktf7azpntuisyvejnu2.jpg'),(3,'Nhà hàng Sơn Trà','Đà Nẵng, TP.HCM','Nhà hàng 3 sao','https://res.cloudinary.com/dkba7robk/image/upload/v1696604138/a8ejftwrzvyavfsml2oc.jpg');
/*!40000 ALTER TABLE `restaurantsbr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roleclaims`
--

DROP TABLE IF EXISTS `roleclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roleclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roleclaims`
--

LOCK TABLES `roleclaims` WRITE;
/*!40000 ALTER TABLE `roleclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `roleclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `Name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('08dbc3bf-3c23-4747-80a0-10a9e086a77b','ADMIN','ADMIN','0f8b9082-903a-431d-914b-54a62b468897'),('08dbc3bf-407f-4c5f-807f-96cf1ed06709','CASHIER','CASHIER','c663d41c-b783-469d-9afe-23945b0b30ae'),('08dbc3bf-45a8-480b-80d8-936fb5f74d57','WAITER','WAITER','4ef8cdb1-323d-4c4e-a14a-908f4138731f'),('08dbc3bf-49ca-476c-8df1-afb1e2c06549','CUSTOMER','CUSTOMER','56364e52-4d06-44f8-a044-91676dcf99f7');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `table_number` int NOT NULL,
  `seats` int NOT NULL,
  `status` enum('Chưa đặt','Đang đặt') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_waiter` char(36) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_restaurant_idx` (`restaurant_id`),
  KEY `fk_restaurant_waiter_idx` (`id_waiter`),
  CONSTRAINT `fk_idwaiter` FOREIGN KEY (`id_waiter`) REFERENCES `users` (`Id`),
  CONSTRAINT `fk_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurantsbr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,1,1,10,'Đang đặt',NULL),(2,1,2,10,'Chưa đặt',NULL),(3,1,3,10,'Chưa đặt',NULL),(4,1,4,10,'Chưa đặt',NULL),(5,1,5,10,'Chưa đặt',NULL),(6,1,6,10,'Chưa đặt',NULL),(7,1,7,10,'Chưa đặt',NULL),(8,1,8,10,'Chưa đặt',NULL),(9,1,9,10,'Chưa đặt',NULL),(10,1,10,10,'Chưa đặt',NULL),(11,2,1,10,'Chưa đặt',NULL),(12,2,2,10,'Chưa đặt',NULL),(13,2,3,10,'Chưa đặt',NULL),(14,2,4,10,'Chưa đặt',NULL),(15,2,5,10,'Chưa đặt',NULL),(16,2,6,10,'Chưa đặt',NULL),(17,2,7,10,'Chưa đặt',NULL),(18,2,8,10,'Chưa đặt',NULL),(19,2,9,10,'Chưa đặt',NULL),(20,2,10,10,'Chưa đặt',NULL),(21,3,1,10,'Chưa đặt',NULL),(22,3,2,10,'Chưa đặt',NULL),(23,3,3,10,'Chưa đặt',NULL),(24,3,4,10,'Chưa đặt',NULL),(25,3,5,10,'Chưa đặt',NULL),(26,3,6,10,'Chưa đặt',NULL),(27,3,7,10,'Chưa đặt',NULL),(28,3,8,10,'Chưa đặt',NULL),(29,3,9,10,'Chưa đặt',NULL),(30,3,10,10,'Chưa đặt',NULL);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userclaims`
--

DROP TABLE IF EXISTS `userclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userclaims`
--

LOCK TABLES `userclaims` WRITE;
/*!40000 ALTER TABLE `userclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `userclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userlogins`
--

DROP TABLE IF EXISTS `userlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userlogins` (
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderDisplayName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `UserId` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userlogins`
--

LOCK TABLES `userlogins` WRITE;
/*!40000 ALTER TABLE `userlogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `userlogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userroles`
--

DROP TABLE IF EXISTS `userroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userroles` (
  `UserId` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `RoleId` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES ('08dbc3c0-2014-49cc-8808-f0ed2a41e120','08dbc3bf-3c23-4747-80a0-10a9e086a77b'),('08dbc3c0-4022-4d45-83d6-ed48dcaebd02','08dbc3bf-407f-4c5f-807f-96cf1ed06709'),('08dbc3c1-00b7-42dd-8f70-e5984d7f99af','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbc409-a8c6-4a33-8381-bb0aee233c0a','08dbc3bf-49ca-476c-8df1-afb1e2c06549');
/*!40000 ALTER TABLE `userroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BrithDay` date DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Gender` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NormalizedUserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NormalizedEmail` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `SecurityStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('08dbc3c0-2014-49cc-8808-f0ed2a41e120','admin123',NULL,'admin123@gmail.com','Nguyễn Ngọc Luân','2023-09-15','Bình Thuận','Nam',NULL,'ADMIN123',NULL,0,'AQAAAAEAACcQAAAAEPXSZEv+ip/1TvcU4Fhb4P8j3rS71EN/E0KF3Bn790ZKpFverP5g7ZppB3LLAXfn2g==','3ZRKKSUOHZGNQRLQSOUEJT5DTLREML4V','239cf921-1637-4b47-af41-b9171bb877e2','0868196036',0,0,NULL,1,0),('08dbc3c0-4022-4d45-83d6-ed48dcaebd02','cashier123',NULL,'cashier123@gmail.com','Nguyễn Huyền Trang','2003-09-15','Bình Thuận','Nữ',NULL,'CASHIER123',NULL,0,'AQAAAAEAACcQAAAAEBokQxVGswnugS7ypdQvN5GasIQ+tjUncVZfs0zKfIxZjCtUmzgkFPM/MgIzFj0Nvg==','QO6H6HCHNJV7NULPQDNV4YHQPITYC4FQ','c82b5d00-40d0-43ee-89a9-ec9f989bd7a8','0868585956',0,0,NULL,1,0),('08dbc3c1-00b7-42dd-8f70-e5984d7f99af','customer123',NULL,'customer123@gmail.com','Nguyễn Hoàng Long','2002-09-15','Sài Gòn','Nam',NULL,'CUSTOMER123',NULL,0,'AQAAAAEAACcQAAAAECsfBX57Sy8R/P/iKjrGYDOzTYH4q/YI9CD6CbJQJHPZQtyM1hGPpcsthz0niHgjKA==','HK5HVT43IGVIH7WZ6UWK74QLBEOVE2H2','3801e77b-52fb-4b5c-b1b0-6678da7a21a0','0859469547',0,0,NULL,1,0),('08dbc409-a8c6-4a33-8381-bb0aee233c0a','hoanghuyen123',NULL,'hoanghuyen123@gmail.com','Hoàng Huyền','2003-06-03','Sài Gòn','Nữ',NULL,'HOANGHUYEN123',NULL,0,'AQAAAAEAACcQAAAAEIauPPIQ9QXquuJZ816K5So419b5A21pdtfu8xqnOMEzQTUlHF7m8Y/AU33EHUlLCQ==','U5VH4ONPS7Z5F63WXZHALILAULMXVQTM','a5324d2f-a0a9-48a5-bf62-eae480e04efa','0889595855',0,0,NULL,1,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertokens`
--

DROP TABLE IF EXISTS `usertokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usertokens` (
  `UserId` char(36) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertokens`
--

LOCK TABLES `usertokens` WRITE;
/*!40000 ALTER TABLE `usertokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `usertokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-12 14:00:35