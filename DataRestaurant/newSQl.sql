-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: restaurant
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `bill_date` timestamp NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `promotion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_customer_idx` (`customer_id`),
  KEY `fk_bill_order_idx` (`order_id`),
  KEY `fk_bill_promotion_idx` (`promotion_id`),
  CONSTRAINT `fk_bill_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_bill_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_bill_promotion` FOREIGN KEY (`promotion_id`) REFERENCES `promotion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1,1,'2023-09-15 10:00:00',180000.00,180000.00,NULL,NULL),(2,2,'2023-09-15 10:00:00',250000.00,250000.00,NULL,NULL),(3,3,'2023-09-15 10:00:00',130000.00,130000.00,NULL,NULL),(4,4,'2023-09-15 10:00:00',100000.00,100000.00,NULL,NULL),(5,5,'2023-09-15 04:30:00',360000.00,360000.00,NULL,NULL),(6,6,'2023-09-15 07:30:00',440000.00,440000.00,NULL,NULL),(7,7,'2023-09-15 03:00:00',185000.00,185000.00,NULL,NULL),(8,8,'2023-09-15 08:30:00',290000.00,290000.00,NULL,NULL),(9,9,'2023-09-15 03:30:00',270000.00,270000.00,NULL,NULL),(10,10,'2023-09-15 09:30:00',345000.00,345000.00,NULL,NULL),(11,11,'2023-09-16 05:00:00',110000.00,110000.00,NULL,NULL),(12,12,'2023-09-16 04:30:00',290000.00,290000.00,NULL,NULL),(13,13,'2023-09-15 09:05:00',130000.00,130000.00,NULL,NULL),(14,14,'2023-09-15 13:00:00',294000.00,294000.00,NULL,NULL),(15,15,'2023-09-15 05:00:00',160000.00,160000.00,NULL,NULL),(16,16,'2023-09-15 12:40:00',138000.00,138000.00,NULL,NULL),(17,17,'2023-09-16 04:10:00',550000.00,550000.00,NULL,NULL),(18,18,'2023-09-16 14:30:00',220000.00,220000.00,NULL,NULL),(19,19,'2023-09-15 10:40:00',324000.00,324000.00,NULL,NULL),(20,20,'2023-09-16 09:36:00',205000.00,205000.00,NULL,NULL),(21,21,'2023-09-16 04:10:00',260000.00,260000.00,NULL,NULL),(22,22,'2023-09-16 14:30:00',80000.00,80000.00,NULL,NULL),(23,23,'2023-09-15 06:10:00',170000.00,170000.00,NULL,NULL),(24,24,'2023-09-16 04:40:00',295000.00,295000.00,NULL,NULL),(25,25,'2023-09-15 09:20:00',210000.00,210000.00,NULL,NULL),(26,26,'2023-09-15 12:15:00',145000.00,145000.00,NULL,NULL),(27,27,'2023-09-14 23:10:00',130000.00,130000.00,NULL,NULL),(28,28,'2023-09-16 09:00:00',120000.00,120000.00,NULL,NULL),(29,29,'2023-09-15 10:10:00',130000.00,130000.00,NULL,NULL),(30,30,'2023-09-15 13:10:00',150000.00,150000.00,NULL,NULL),(31,31,'2023-09-16 08:20:00',110000.00,110000.00,NULL,NULL),(32,32,'2023-09-16 14:45:00',210000.00,210000.00,NULL,NULL),(33,33,'2023-09-16 12:30:00',230000.00,230000.00,NULL,NULL),(34,34,'2023-09-16 10:25:00',265000.00,265000.00,NULL,NULL),(35,35,'2023-09-15 08:20:00',290000.00,290000.00,NULL,NULL),(36,36,'2023-09-15 13:20:00',175000.00,175000.00,NULL,NULL),(37,37,'2023-09-16 06:11:00',148000.00,148000.00,NULL,NULL),(38,38,'2023-09-16 14:45:00',130000.00,130000.00,NULL,NULL),(39,39,'2023-09-16 05:26:00',235000.00,235000.00,NULL,NULL),(40,40,'2023-09-16 14:45:00',364000.00,364000.00,NULL,NULL),(41,41,'2023-09-15 05:00:00',120000.00,120000.00,NULL,NULL),(42,42,'2023-09-15 14:40:00',275000.00,275000.00,NULL,NULL),(43,43,'2023-09-15 02:55:00',225000.00,225000.00,NULL,NULL),(44,44,'2023-09-15 12:05:00',200000.00,200000.00,NULL,NULL),(45,45,'2023-09-15 14:55:00',110000.00,110000.00,NULL,NULL),(46,46,'2023-09-16 10:19:00',130000.00,130000.00,NULL,NULL),(47,47,'2023-09-15 05:06:00',160000.00,160000.00,NULL,NULL),(48,48,'2023-09-15 13:05:00',395000.00,395000.00,NULL,NULL),(49,49,'2023-09-15 06:16:00',145000.00,145000.00,NULL,NULL),(50,50,'2023-09-15 08:50:00',130000.00,130000.00,NULL,NULL),(51,51,'2023-09-15 13:10:00',355000.00,355000.00,NULL,NULL),(52,52,'2023-09-15 14:05:00',120000.00,120000.00,NULL,NULL),(53,53,'2023-09-16 03:06:00',170000.00,170000.00,NULL,NULL),(54,54,'2023-09-16 12:20:00',150000.00,150000.00,NULL,NULL),(55,55,'2023-09-15 05:20:00',220000.00,220000.00,NULL,NULL),(56,56,'2023-09-15 13:36:00',120000.00,120000.00,NULL,NULL),(57,57,'2023-09-15 11:10:00',140000.00,140000.00,NULL,NULL),(58,58,'2023-09-15 13:58:00',404000.00,404000.00,NULL,NULL),(59,59,'2023-09-16 11:15:00',275000.00,275000.00,NULL,NULL),(60,60,'2023-09-16 14:55:00',170000.00,170000.00,NULL,NULL);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `restaurant_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `review_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `comment_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_coment_customer_idx` (`customer_id`),
  KEY `fk_coment_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_coment_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_coment_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,13,1,5,'Nhà hàng này thật tuyệt vời! Thực đơn đa dạng và phục vụ chuyên nghiệp.','2023-09-20'),(2,14,1,4,'Tôi đã có một trải nghiệm tuyệt vời tại nhà hàng này. Mọi thứ đều ngon và không gian rất thoải mái.','2023-09-20'),(3,15,1,5,'Nhân viên ở đây rất thân thiện và chu đáo. Tôi sẽ quay lại đây vào dịp khác.','2023-09-20'),(4,16,1,4,'Không gian ấm cúng và thực đơn đa dạng. Tôi đã có một bữa tối thú vị tại nhà hàng này.','2023-09-20'),(5,13,2,5,'Nhân viên ở đây rất thân thiện và chu đáo. Tôi sẽ quay lại đây vào dịp khác.','2023-09-20'),(6,14,2,4,'Nhà hàng này thật tuyệt vời! Thực đơn đa dạng và phục vụ chuyên nghiệp.','2023-09-20'),(7,15,2,5,'Nhân viên ở đây rất thân thiện và chu đáo. Tôi sẽ quay lại đây vào dịp khác.','2023-09-20'),(8,16,2,4,'Không gian ấm cúng và thực đơn đa dạng. Tôi đã có một bữa tối thú vị tại nhà hàng này.','2023-09-20'),(9,13,3,5,'Nhân viên ở đây rất nhiệt tình và chu đáo. Tôi sẽ quay lại đây vào dịp khác.','2023-09-20'),(10,14,3,4,'Nhà hàng này thật xuất sắc! Thực đơn đa dạng và phục vụ chuyên nghiệp.','2023-09-20'),(11,15,3,5,'Tôi đã có một trải nghiệm tuyệt vời tại nhà hàng này. Mọi món ăn đều ngon và không gian rất thoải mái.','2023-09-20'),(12,16,3,4,'Không gian ấm cúng và thực đơn đa dạng. Tôi đã có một bữa trưa ngon miệng tại nhà hàng này.','2023-09-20');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mean`
--

DROP TABLE IF EXISTS `mean`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mean` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `fk_mean_order_idx` (`order_id`),
  CONSTRAINT `fk_mean_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mean`
--

LOCK TABLES `mean` WRITE;
/*!40000 ALTER TABLE `mean` DISABLE KEYS */;
INSERT INTO `mean` VALUES (1,1,NULL),(2,2,NULL),(3,3,NULL),(4,4,NULL),(5,5,NULL),(6,6,NULL),(7,7,NULL),(8,8,NULL),(9,9,NULL),(10,10,NULL),(11,11,NULL),(12,12,NULL),(13,13,NULL),(14,14,NULL),(15,15,NULL),(16,16,NULL),(17,17,NULL),(18,18,NULL),(19,19,NULL),(20,20,NULL),(21,21,NULL),(22,22,NULL),(23,23,NULL),(24,24,NULL),(25,25,NULL),(26,26,NULL),(27,27,NULL),(28,28,NULL),(29,29,NULL),(30,30,NULL),(31,31,NULL),(32,32,NULL),(33,33,NULL),(34,34,NULL),(35,35,NULL),(36,36,NULL),(37,37,NULL),(38,38,NULL),(39,39,NULL),(40,40,NULL),(41,41,NULL),(42,42,NULL),(43,43,NULL),(44,44,NULL),(45,45,NULL),(46,46,NULL),(47,47,NULL),(48,48,NULL),(49,49,NULL),(50,50,NULL),(51,51,NULL),(52,52,NULL),(53,53,NULL),(54,54,NULL),(55,55,NULL),(56,56,NULL),(57,57,NULL),(58,58,NULL),(59,59,NULL),(60,60,NULL);
/*!40000 ALTER TABLE `mean` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meanitem`
--

DROP TABLE IF EXISTS `meanitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meanitem` (
  `id` int(11) NOT NULL,
  `mean_id` int(11) DEFAULT NULL,
  `menuItem_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meanItem_mean_idx` (`mean_id`),
  KEY `fk_meanItem_menuItem_idx` (`menuItem_id`),
  CONSTRAINT `fk_meanItem_mean` FOREIGN KEY (`mean_id`) REFERENCES `mean` (`id`),
  CONSTRAINT `fk_meanItem_menuItem` FOREIGN KEY (`menuItem_id`) REFERENCES `menuitem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meanitem`
--

LOCK TABLES `meanitem` WRITE;
/*!40000 ALTER TABLE `meanitem` DISABLE KEYS */;
INSERT INTO `meanitem` VALUES (1,1,1,2),(2,1,2,1),(3,1,10,1),(4,2,3,1),(5,2,4,2),(6,2,6,2),(7,3,16,1),(8,3,17,1),(9,3,25,1),(10,4,19,1),(11,4,24,1),(12,4,29,2),(13,5,41,1),(14,5,45,1),(15,5,50,2),(16,6,21,2),(17,6,38,2),(18,6,39,1),(19,7,64,1),(20,7,65,2),(21,7,70,3),(22,8,13,2),(23,8,32,1),(24,8,33,1),(25,9,59,2),(26,9,60,1),(27,9,72,2),(28,10,55,1),(29,10,60,1),(30,10,71,3),(31,11,1,1),(32,11,7,1),(33,11,14,1),(34,12,42,2),(35,12,43,1),(36,12,49,2),(37,13,19,1),(38,13,23,1),(39,13,28,3),(40,14,31,1),(41,14,36,2),(42,14,39,2),(43,15,65,2),(44,15,72,1),(45,15,75,1),(46,16,61,1),(47,16,62,1),(48,16,70,3),(49,17,43,2),(50,17,45,2),(51,17,49,2),(52,18,26,3),(53,18,46,1),(54,18,47,1),(55,19,31,1),(56,19,37,1),(57,19,39,1),(58,20,42,1),(59,20,44,1),(60,20,49,1),(61,21,52,2),(62,21,53,1),(63,21,69,2),(64,22,9,1),(65,22,10,1),(66,22,12,2),(67,23,3,3),(68,23,11,1),(69,23,12,1),(70,24,34,1),(71,24,38,1),(72,24,39,3),(73,25,44,1),(74,25,48,1),(75,25,50,2),(76,26,57,1),(77,26,58,1),(78,26,69,1),(79,27,67,2),(80,27,74,1),(81,27,75,1),(82,28,16,2),(83,28,26,1),(84,28,27,1),(85,29,20,1),(86,29,21,1),(87,29,28,3),(88,30,3,1),(89,30,4,1),(90,30,7,1),(91,31,9,2),(92,31,10,1),(93,31,15,2),(94,32,17,1),(95,32,24,1),(96,32,25,1),(97,33,14,3),(98,33,33,1),(99,33,35,1),(100,34,42,1),(101,34,47,1),(102,34,49,3),(103,35,54,2),(104,35,59,1),(105,35,70,2),(106,36,64,1),(107,36,68,1),(108,36,74,1),(109,37,63,1),(110,37,65,1),(111,37,70,3),(112,38,5,1),(113,38,6,1),(114,38,14,3),(115,39,37,1),(116,39,38,1),(117,39,40,2),(118,40,31,1),(119,40,33,1),(120,40,40,2),(121,41,21,2),(122,41,28,1),(123,41,30,1),(124,42,56,1),(125,42,57,1),(126,42,61,1),(127,43,59,1),(128,43,60,1),(129,43,71,1),(130,44,68,2),(131,44,70,2),(132,44,71,2),(133,45,23,1),(134,45,24,1),(135,45,28,3),(136,46,3,1),(137,46,5,1),(138,46,11,3),(139,47,20,1),(140,47,21,2),(141,47,28,1),(142,48,41,2),(143,48,42,1),(144,48,49,1),(145,49,66,1),(146,49,67,1),(147,49,74,2),(148,50,61,1),(149,50,65,1),(150,50,72,1),(151,51,36,1),(152,51,37,1),(153,51,38,3),(154,52,6,1),(155,52,8,1),(156,52,15,2),(157,53,21,1),(158,53,22,2),(159,53,28,2),(160,54,56,1),(161,54,57,1),(162,54,70,3),(163,55,55,1),(164,55,58,1),(165,55,72,3),(166,56,22,1),(167,56,23,1),(168,56,30,2),(169,57,3,1),(170,57,5,1),(171,57,15,2),(172,58,31,1),(173,58,32,1),(174,58,35,1),(175,59,20,1),(176,59,45,1),(177,59,49,3),(178,60,52,1),(179,60,54,1),(180,60,72,3);
/*!40000 ALTER TABLE `meanitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `fk_menu_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_menu_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Menu',NULL),(2,2,'Menu',NULL),(3,3,'Menu',NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menu_menus_idx` (`menu_id`),
  CONSTRAINT `fk_menu_menus` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES (1,1,'Mì Quảng','Mì Quảng Đà Nẵng',50000.00),(2,1,'Bánh Mì Hòa','Bánh Mì Gà Rán',50000.00),(3,1,'Phở Bò','Phở Bò Việt Nam',50000.00),(4,1,'Bún Bò Huế','Bún Bò Huế Ngon',50000.00),(5,1,'Gỏi Cuốn','Gỏi Cuốn Gà',50000.00),(6,1,'Bánh Xèo','Bánh Xèo Miền Trung',50000.00),(7,1,'Bún Chả','Bún Chả Hà Nội',50000.00),(8,1,'Cơm Tấm','Cơm Tấm Sài Gòn',50000.00),(9,1,'Bánh Mì Pate','Bánh Mì Pate Sốt',30000.00),(10,1,'Bánh Mì Kẹp Thịt','Bánh Mì Kẹp Thịt Ngon',30000.00),(11,1,'CocaCola','',10000.00),(12,1,'Sting đỏ','',10000.00),(13,1,'Trà đá','',10000.00),(14,1,'Nước sấu','',10000.00),(15,1,'Nước cam vắt','',10000.00),(16,2,'Mì Quảng','Mì Quảng Đà Nẵng',50000.00),(17,2,'Bánh Mì Hòa','Bánh Mì Gà Rán',50000.00),(18,2,'Phở Bò','Phở Bò Việt Nam',50000.00),(19,2,'Bún Bò Huế','Bún Bò Huế Ngon',50000.00),(20,2,'Gỏi Cuốn','Gỏi Cuốn Gà',50000.00),(21,2,'Bánh Xèo','Bánh Xèo Miền Trung',50000.00),(22,2,'Bún Chả','Bún Chả Hà Nội',50000.00),(23,2,'Cơm Tấm','Cơm Tấm Sài Gòn',50000.00),(24,2,'Bánh Mì Pate','Bánh Mì Pate Sốt',30000.00),(25,2,'Bánh Mì Kẹp Thịt','Bánh Mì Kẹp Thịt Ngon',30000.00),(26,2,'CocaCola','',10000.00),(27,2,'Sting đỏ','',10000.00),(28,2,'Trà đá','',10000.00),(29,2,'Nước sấu','',10000.00),(30,2,'Nước cam vắt','',10000.00),(31,1,'Gà Nướng Mỡ Hành','Gà Nướng Mỡ Hành Miền Tây',194000.00),(32,1,'Cá Kho Tộ','Cá Kho Tộ Ngon',120000.00),(33,1,'Canh Chua Cá Lóc','Canh Chua Cá Lóc Ngon',150000.00),(34,1,'Hủ Tiếu Nam Vang','Hủ Tiếu Nam Vang Ngon',50000.00),(35,1,'Cơm Bò Lúc Lắc','Cơm Bò Lúc Lắc Mềm Ngon',50000.00),(36,1,'Xôi Gà','Xôi Gà Mỹ Tho',40000.00),(37,1,'Nem Nướng','Nem Nướng Nha Trang',120000.00),(38,1,'Mì Xào Hải Sản','Mì Xào Hải Sản Tươi Ngon',65000.00),(39,1,'7UP',NULL,10000.00),(40,1,'Sprite',NULL,10000.00),(41,2,'Gỏi Ngó Sen','Gỏi Ngó Sen Ngon',150000.00),(42,2,'Mực Xào Sả Ớt','Mực Xào Sả Ớt Ngon',70000.00),(43,2,'Bò Tái Chanh','Bò Tái Chanh Tươi Ngon',100000.00),(44,2,'Hải Sản Hấp Gừng','Hải Sản Hấp Gừng Tươi Ngon',110000.00),(45,2,'Lẩu Thái','Lẩu Thái Chua Cay',150000.00),(46,2,'Gà Kho Gừng','Gà Kho Gừng Ngon ',70000.00),(47,2,'Cá Basa Chiên','Cá Basa Chiên Giòn',120000.00),(48,2,'Xôi Nén','Xôi Nén Ngon',40000.00),(49,2,'Soda chanh dây',NULL,25000.00),(50,2,'Sinh tố trái cây',NULL,30000.00),(51,3,'Gà Nướng Mắm','Gà Nướng Mắm Nhĩ ',200000.00),(52,3,'Mì Xào Ốc Móng Tay ','Mì Xào Ốc Móng Tay Ngon',50000.00),(53,3,'Cá Bớp Chiên Bơ','Cá Bớp Chiên Bơ Ngon',130000.00),(54,3,'Ba Rọi Nướng Sa Tế','Ba Rọi Nướng Sa Tế Cay',90000.00),(55,3,'Lòng Gà Trứng Non Cháy Tỏi','Lòng Gà Trứng Non Cháy Tỏi Thơm Ngon',120000.00),(56,3,'Hủ Tiếu Bò Kho','Hủ Tiếu Bò Kho Ngon',60000.00),(57,3,'Bún Mắm Nêm','Bún Mắm Nêm Tôm Thịt',60000.00),(58,3,'Bò Lá Lốt','Bò Lá Lốt Nướng ',70000.00),(59,3,'Gỏi Đu Đủ','Gỏi Đu Đủ Ngon',50000.00),(60,3,'Gà Rang Muối','Gà Rang Muối Nguyên Con',150000.00),(61,3,'Bánh Canh Cua','Bánh Canh Cua, Chả Cua',55000.00),(62,3,'Cơm Tấm Ba Rọi Nướng ','Cơm Tấm Ba Rọi Nướng Ngon',53000.00),(63,3,'Bún Thịt Nướng','Bún Thịt Nướng Ngon',53000.00),(64,3,'Cháo Ếch Singapore','Cháo Ếch Singapore 2 Con',90000.00),(65,3,'Mì Trộn Sốt Cay','Mì Trộn Sốt Cay Hàn Quốc',65000.00),(66,3,'Cơm Cánh Gà Sốt Mắm Tỏi','Cơm Cánh Gà Sốt Mắm Tỏi Ngon',60000.00),(67,3,'Bánh Ướt Lòng Gà','Bánh Ướt Lòng Gà Đà Lạt',45000.00),(68,3,'Ếch Chiên Nước Mắm','Ếch Chiên Nước Mắm Ngon',65000.00),(69,3,'Chanh muối ',NULL,15000.00),(70,3,'Nước mía',NULL,10000.00),(71,3,'Bia Sài Gòn',NULL,25000.00),(72,3,'Nước Ngọt',NULL,10000.00),(73,3,'Cà phê',NULL,15000.00),(74,3,'Bạc Xỉu',NULL,20000.00),(75,3,'Nước Chanh Dây',NULL,20000.00);
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cashier_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `order_time` timestamp NULL DEFAULT NULL,
  `status` enum('Chưa thanh toán','Đã thanh toán','Đã hủy') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_cashier_idx` (`cashier_id`),
  KEY `fk_order_tables_idx` (`table_id`),
  CONSTRAINT `fk_order_cashier` FOREIGN KEY (`cashier_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_order_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,11,1,'2023-09-14 17:00:00','Đã thanh toán'),(2,11,2,'2023-09-14 17:00:00','Đã thanh toán'),(3,12,16,'2023-09-14 17:00:00','Đã thanh toán'),(4,12,17,'2023-09-14 17:00:00','Đã thanh toán'),(5,11,1,'2023-09-15 02:30:00','Đã thanh toán'),(6,11,2,'2023-09-15 03:30:00','Đã thanh toán'),(7,11,3,'2023-09-15 00:00:00','Đã thanh toán'),(8,11,3,'2023-09-15 02:30:00','Đã thanh toán'),(9,11,4,'2023-09-15 00:30:00','Đã thanh toán'),(10,11,4,'2023-09-15 05:30:00','Đã thanh toán'),(11,11,5,'2023-09-15 23:00:00','Đã thanh toán'),(12,11,5,'2023-09-16 02:30:00','Đã thanh toán'),(13,11,6,'2023-09-15 03:00:00','Đã thanh toán'),(14,11,6,'2023-09-15 09:30:00','Đã thanh toán'),(15,11,7,'2023-09-15 01:00:00','Đã thanh toán'),(16,11,7,'2023-09-15 07:35:00','Đã thanh toán'),(17,11,8,'2023-09-16 01:00:00','Đã thanh toán'),(18,11,8,'2023-09-16 12:30:00','Đã thanh toán'),(19,11,9,'2023-09-15 00:45:00','Đã thanh toán'),(20,11,9,'2023-09-16 02:30:00','Đã thanh toán'),(21,11,10,'2023-09-15 23:15:00','Đã thanh toán'),(22,11,10,'2023-09-16 12:35:00','Đã thanh toán'),(23,12,11,'2023-09-15 01:00:00','Đã thanh toán'),(24,12,11,'2023-09-16 00:00:00','Đã thanh toán'),(25,12,12,'2023-09-15 01:20:00','Đã thanh toán'),(26,12,12,'2023-09-15 03:45:00','Đã thanh toán'),(27,12,13,'2023-09-14 23:10:00','Đã thanh toán'),(28,12,13,'2023-09-16 03:00:00','Đã thanh toán'),(29,12,14,'2023-09-15 04:00:00','Đã thanh toán'),(30,12,14,'2023-09-15 13:10:00','Đã thanh toán'),(31,12,15,'2023-09-16 00:20:00','Đã thanh toán'),(32,12,15,'2023-09-16 11:35:00','Đã thanh toán'),(33,12,16,'2023-09-16 08:00:00','Đã thanh toán'),(34,12,17,'2023-09-16 10:25:00','Đã thanh toán'),(35,12,18,'2023-09-15 00:00:00','Đã thanh toán'),(36,12,18,'2023-09-15 09:20:00','Đã thanh toán'),(37,12,19,'2023-09-16 00:08:00','Đã thanh toán'),(38,12,19,'2023-09-16 13:05:00','Đã thanh toán'),(39,12,20,'2023-09-16 01:06:00','Đã thanh toán'),(40,12,20,'2023-09-16 14:00:00','Đã thanh toán'),(41,22,21,'2023-09-15 02:00:00','Đã thanh toán'),(42,22,21,'2023-09-15 13:10:00','Đã thanh toán'),(43,22,22,'2023-09-15 00:30:00','Đã thanh toán'),(44,22,22,'2023-09-15 08:45:00','Đã thanh toán'),(45,22,23,'2023-09-15 14:00:00','Đã thanh toán'),(46,22,23,'2023-09-16 03:10:00','Đã thanh toán'),(47,22,24,'2023-09-15 01:00:00','Đã thanh toán'),(48,22,24,'2023-09-15 10:05:00','Đã thanh toán'),(49,22,25,'2023-09-15 01:06:00','Đã thanh toán'),(50,22,25,'2023-09-15 05:30:00','Đã thanh toán'),(51,22,26,'2023-09-15 03:00:00','Đã thanh toán'),(52,22,26,'2023-09-15 12:05:00','Đã thanh toán'),(53,22,27,'2023-09-16 00:00:00','Đã thanh toán'),(54,22,27,'2023-09-16 02:50:00','Đã thanh toán'),(55,22,28,'2023-09-15 00:20:00','Đã thanh toán'),(56,22,28,'2023-09-15 11:45:00','Đã thanh toán'),(57,22,29,'2023-09-15 01:10:00','Đã thanh toán'),(58,22,29,'2023-09-15 13:08:00','Đã thanh toán'),(59,22,30,'2023-09-16 01:05:00','Đã thanh toán'),(60,22,30,'2023-09-16 13:10:00','Đã thanh toán');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `promotion_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `start_date` timestamp NOT NULL,
  `end_date` timestamp NOT NULL,
  `discount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_promotion_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_promotion_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,1,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-03-19 17:00:00','2023-03-22 17:00:00',20.00),(2,2,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-03-19 17:00:00','2023-03-22 17:00:00',20.00);
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Nhà hàng Chí Tiên','Bình Thạnh, TP.HCM','Nhà hàng 3 sao'),(2,'Nhà hàng Chí Tiên 2','Gò Vấp, TP.HCM','Nhà hàng 3 sao'),(3,'Nhà hàng Sơn Trà','Đà Nẵng, TP.HCM','Nhà hàng 3 sao');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tables`
--

DROP TABLE IF EXISTS `tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `restaurant_id` int(11) NOT NULL,
  `table_number` int(11) NOT NULL,
  `seats` int(11) NOT NULL,
  `status` enum('Chưa đặt','Đang đặt') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_waiter` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `fk_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,1,1,10,'Chưa đặt',1),(2,1,2,10,'Chưa đặt',1),(3,1,3,10,'Chưa đặt',2),(4,1,4,10,'Chưa đặt',2),(5,1,5,10,'Chưa đặt',3),(6,1,6,10,'Chưa đặt',3),(7,1,7,10,'Chưa đặt',4),(8,1,8,10,'Chưa đặt',4),(9,1,9,10,'Chưa đặt',5),(10,1,10,10,'Chưa đặt',5),(11,2,1,10,'Chưa đặt',6),(12,2,2,10,'Chưa đặt',6),(13,2,3,10,'Chưa đặt',7),(14,2,4,10,'Chưa đặt',7),(15,2,5,10,'Chưa đặt',8),(16,2,6,10,'Chưa đặt',8),(17,2,7,10,'Chưa đặt',9),(18,2,8,10,'Chưa đặt',9),(19,2,9,10,'Chưa đặt',10),(20,2,10,10,'Chưa đặt',10),(21,3,1,10,'Chưa đặt',17),(22,3,2,10,'Chưa đặt',17),(23,3,3,10,'Chưa đặt',18),(24,3,4,10,'Chưa đặt',18),(25,3,5,10,'Chưa đặt',19),(26,3,6,10,'Chưa đặt',19),(27,3,7,10,'Chưa đặt',20),(28,3,8,10,'Chưa đặt',20),(29,3,9,10,'Chưa đặt',21),(30,3,10,10,'Chưa đặt',21);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `roles` enum('ADMIN','CUSTOMER','WAITER','CASHIER') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'nguyenvana@gmail.com','Nguyễn Văn An','0123456781','Hà Nội','WAITER'),(2,NULL,NULL,'tranthibinh@gmail.com','Trần Thị Bình','0123456782','Hồ Chí Minh','WAITER'),(3,NULL,NULL,'lehongcuong@gmail.com','Lê Hồng Cường','0123456783','Đà Nẵng','WAITER'),(4,NULL,NULL,'hoangquocdung@gmail.com','Hoàng Quốc Dũng','0123456784','Huế','WAITER'),(5,NULL,NULL,'trinhthilan@gmail.com','Trịnh Thị Lan','0123456785','Nha Trang','WAITER'),(6,NULL,NULL,'phamminhphong@gmail.com','Phạm Minh Phong','0123456786','Cần Thơ','WAITER'),(7,NULL,NULL,'levangiang@gmail.com','Lê Văn Giang','0123456787','Vinh','WAITER'),(8,NULL,NULL,'nguyenhaiyen@gmail.com','Nguyễn Hải Yến','0123456788','Quy Nhơn','WAITER'),(9,NULL,NULL,'dothiminh@gmail.com','Đỗ Thị Minh Anh','0123456789','Phan Thiết','WAITER'),(10,NULL,NULL,'phamvantien@gmail.com','Phạm Văn Tiến','0123456790','Tam Kỳ','WAITER'),(11,'ntu123','123456','nguyenthiuyen@gmail.com','Nguyễn Thị Uyên','0123485789','Phan Thiết','CASHIER'),(12,'ptt123','123456','phamthanh@gmail.com','Phạm Thanh Thanh','0123496790','Tam Kỳ','CASHIER'),(13,'lhc123','123456','lecuong@gmail.com','Lê Hồng Cường','0123456791','Đà Nẵng','CUSTOMER'),(14,'hqd123','123456','hoangdung@gmail.com','Hoàng Quốc Dũng','0123456792','Huế','CUSTOMER'),(15,'ttl123','123456','trinhlan@gmail.com','Trịnh Thị Lan','0123456793','Nha Trang','CUSTOMER'),(16,'pmp123','123456','phongpham@gmail.com','Phạm Minh Phong','0123456794','Cần Thơ','CUSTOMER'),(17,NULL,NULL,'voanhkiet@gmail.com','Võ Anh Kiệt','0123456795','Đà Nẵng','WAITER'),(18,NULL,NULL,'lethicattuong@gmail.com','Lê Thị Cát Tường','0123456796','Đắk Lắk','WAITER'),(19,NULL,NULL,'hoquangdat@gmail.com','Hồ Quang Đạt','0123456797','Hồ Chí Minh','WAITER'),(20,NULL,NULL,'nguyenngocanhthu@gmail.com','Nguyễn Ngọc Anh Thư','0123456798','Huế','WAITER'),(21,NULL,NULL,'buitienhung@gmail.com','Bùi Tiến Hùng','0123456799','Nha Trang','WAITER'),(22,'tqd123','123456','tranquangdat@gmail.com','Trần Quang Đạt','0123456800','Gia Lai','CASHIER');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-19 10:09:30
