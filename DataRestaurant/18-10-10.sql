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
  KEY `fk_bill_promotion_idx` (`promotion_id`),
  KEY `fk_bill_order_idx` (`order_id`),
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
INSERT INTO `bill` VALUES (1,1,'2023-09-15 03:00:00',180000.00,180000.00,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',NULL),(2,2,'2023-09-15 03:00:00',250000.00,250000.00,'08dbc409-a8c6-4a33-8381-bb0aee233c0a',NULL),(3,3,'2023-09-15 03:00:00',150000.00,150000.00,'08dbcf34-9f7d-4ae3-85b7-69ff085c82e0',NULL),(4,4,'2023-09-15 03:00:00',120000.00,120000.00,'08dbcf34-f44e-4494-8541-a35dc0ee7ab2',NULL),(5,5,'2023-09-14 21:30:00',360000.00,360000.00,'08dbcf35-2dd3-4324-8d70-d98b0ad32799',NULL),(6,6,'2023-09-15 00:30:00',240000.00,240000.00,'08dbcf35-4b51-453d-8caf-e34e667b7961',NULL),(7,7,'2023-09-14 20:00:00',250000.00,250000.00,'08dbcf35-6e38-4617-885f-bae2ea6b940b',NULL),(8,8,'2023-09-15 01:30:00',290000.00,290000.00,'08dbcf35-8e2d-49fb-8fbb-56381f0578bc',NULL),(9,9,'2023-09-14 20:30:00',270000.00,270000.00,'08dbcf35-e370-4386-84ba-e4b42f0dbd52',NULL),(10,10,'2023-09-15 02:30:00',345000.00,345000.00,'08dbcf36-16a3-4dc6-8b2e-91bfcd58f677',NULL),(11,11,'2023-09-15 22:00:00',110000.00,110000.00,'08dbcf36-375c-4484-8c9d-c9b37bc87fc6',NULL),(12,12,'2023-09-15 21:30:00',290000.00,290000.00,'08dbcf36-657c-4dbd-859c-d5dfecfd78c7',NULL),(13,13,'2023-09-15 02:05:00',130000.00,130000.00,'08dbcf74-463d-496b-8fc8-dab17c9d9f34',NULL),(14,14,'2023-09-15 06:00:00',314000.00,314000.00,'08dbcf74-5865-47d1-8d6f-267c73fc3b9c',NULL),(15,15,'2023-09-14 22:00:00',160000.00,160000.00,'08dbcf74-6cd8-46f3-8df5-c678cb2f11a7',NULL),(16,16,'2023-09-15 05:40:00',138000.00,138000.00,'08dbcf74-8e9c-40d5-87e3-8a6eb614ce14',NULL),(17,17,'2023-09-15 21:10:00',550000.00,550000.00,'08dbcf75-0d33-4346-8d5c-562b922994ad',NULL),(18,18,'2023-09-16 07:30:00',220000.00,220000.00,'08dbcf75-23bf-4319-8ac3-601f76b2c8d2',NULL),(19,19,'2023-09-15 03:40:00',324000.00,324000.00,'08dbcf75-3226-458a-81bb-3cf9ccb5e8d2',NULL),(20,20,'2023-09-16 02:36:00',205000.00,205000.00,'08dbcf75-432e-4c35-8ebf-d8f50aa0fc74',NULL),(21,21,'2023-09-15 21:10:00',260000.00,260000.00,'08dbcf75-5101-44dd-8f89-5ac0606e3ab5',NULL),(22,22,'2023-09-16 07:30:00',100000.00,100000.00,'08dbcf75-6327-4602-85a9-158b59ac3138',NULL),(23,23,'2023-09-14 23:10:00',170000.00,170000.00,'08dbcf75-7a63-408d-8b24-93273bed8827',NULL),(24,24,'2023-09-15 21:40:00',145000.00,145000.00,'08dbcf75-a16d-4fe2-817d-b70df3a6b351',NULL),(25,25,'2023-09-15 02:20:00',210000.00,210000.00,'08dbcf75-c4b7-45d6-8efd-89369d9e36d3',NULL),(26,26,'2023-09-15 05:15:00',145000.00,145000.00,'08dbcf75-d54f-4c3e-81d9-877fb5a85b93',NULL),(27,27,'2023-09-14 16:10:00',130000.00,130000.00,'08dbcf75-e4f3-4c2f-87a5-87c446cf468a',NULL),(28,28,'2023-09-16 02:00:00',120000.00,120000.00,'08dbcf75-f498-44ad-8acf-a776f1eada9d',NULL),(29,29,'2023-09-15 03:10:00',130000.00,130000.00,'08dbcf76-0a36-4ff0-8bef-223619922599',NULL),(30,30,'2023-09-15 06:10:00',150000.00,150000.00,'08dbcf76-1ac2-4363-8182-091391d3f1a4',NULL),(31,31,'2023-09-16 01:20:00',150000.00,150000.00,'08dbcf76-281b-4d6d-8272-837378aa0dd4',NULL),(32,32,'2023-09-16 07:45:00',150000.00,150000.00,'08dbcf76-3b2a-4bfc-8024-f04257511038',NULL),(33,33,'2023-09-16 05:30:00',230000.00,230000.00,'08dbcf76-6038-4ae4-80d0-f3fc37a3546a',NULL),(34,34,'2023-09-16 03:25:00',265000.00,265000.00,'08dbcf76-6d23-45e5-8956-b11f5f857ced',NULL),(35,35,'2023-09-15 01:20:00',250000.00,250000.00,'08dbcf76-7c65-47ff-8efa-52d1591c8e65',NULL),(36,36,'2023-09-15 06:20:00',175000.00,175000.00,'08dbcf76-b944-4847-82e1-a548c0a87f20',NULL),(37,37,'2023-09-15 23:11:00',148000.00,148000.00,'08dbcf76-c887-4c5c-8de4-a1b6e9086b81',NULL),(38,38,'2023-09-16 07:45:00',130000.00,130000.00,'08dbcf76-da97-4160-8232-8446ea4fd7c8',NULL),(39,39,'2023-09-15 22:26:00',205000.00,205000.00,'08dbcf76-ea04-4c1b-876e-65a8f89f3d9b',NULL),(40,40,'2023-09-16 07:45:00',364000.00,364000.00,'08dbcf76-ffdd-4157-80ff-e2d79250f6cb',NULL),(41,41,'2023-09-14 22:00:00',120000.00,120000.00,'08dbcf77-13d8-4c89-89e8-096f4052699b',NULL),(42,42,'2023-09-15 07:40:00',175000.00,175000.00,'08dbcf77-23c4-42c8-8811-ab4dec8db8c4',NULL),(43,43,'2023-09-14 19:55:00',225000.00,225000.00,'08dbcf77-301a-4029-80b4-527bf4bc468d',NULL),(44,44,'2023-09-15 05:05:00',200000.00,200000.00,'08dbcf77-3e18-4597-8986-8b69e73635ca',NULL),(45,45,'2023-09-15 07:55:00',130000.00,130000.00,'08dbcf77-4d04-4359-8ee6-221590145177',NULL),(46,46,'2023-09-16 03:19:00',130000.00,130000.00,'08dbcf77-6f5a-405c-8712-52ed7e2ae808',NULL),(47,47,'2023-09-14 22:06:00',160000.00,160000.00,'08dbcf77-8f04-4081-8196-4893e4cbd641',NULL),(48,48,'2023-09-15 06:05:00',395000.00,395000.00,'08dbcf77-c3a7-42c1-8b12-0ae06c4f2b99',NULL),(49,49,'2023-09-14 23:16:00',145000.00,145000.00,'08dbcf77-e7d5-43aa-8da0-45661e8e4b16',NULL),(50,50,'2023-09-15 01:50:00',130000.00,130000.00,'08dbcf77-f53f-4f79-817f-cfb754e59aed',NULL),(51,51,'2023-09-15 06:10:00',365000.00,365000.00,'08dbcf78-0206-4d3b-8012-da6a2d662a6d',NULL),(52,52,'2023-09-15 07:05:00',120000.00,120000.00,'08dbcf78-0fbf-4779-8444-8a31761b08f7',NULL),(53,53,'2023-09-15 20:06:00',170000.00,170000.00,'08dbcf78-1f3c-4298-8e36-a719637b9775',NULL),(54,54,'2023-09-16 05:20:00',150000.00,150000.00,'08dbcf78-2e2d-428b-8311-f5604a061074',NULL),(55,55,'2023-09-14 22:20:00',220000.00,220000.00,'08dbcf78-3aae-452f-8cc9-eb84dc4436c4',NULL),(56,56,'2023-09-15 06:36:00',120000.00,120000.00,'08dbcf78-48c9-48f2-823d-259d5d5679b7',NULL),(57,57,'2023-09-15 04:10:00',120000.00,120000.00,'08dbcf78-54a5-4913-8b4f-540b76cdea56',NULL),(58,58,'2023-09-15 06:58:00',364000.00,364000.00,'08dbcf78-6315-4fa9-871b-39464f54ca4e',NULL),(59,59,'2023-09-16 04:15:00',275000.00,275000.00,'08dbcf78-7246-497c-8b7f-8dc6f40010c6',NULL),(60,60,'2023-09-16 07:55:00',170000.00,170000.00,'08dbcf78-b70d-4f5d-8188-b6d0f245ed68',NULL);
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
  CONSTRAINT `fk_coment_customer` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_coment_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurantsbr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',1,5,'Nhà hàng này thực sự xuất sắc! Tôi đã có một trải nghiệm ẩm thực tuyệt vời với các món ăn ngon và dịch vụ chuyên nghiệp. Không chỉ thức ăn ngon mắt mà còn phục vụ nhanh chóng và thân thiện. Tôi sẽ quay lại lần nữa chắc chắn!','2023-02-03'),(2,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',2,5,'Mình thực sự ấn tượng với nhà hàng này. Thực đơn đa dạng, món ăn ngon và được chế biến tinh tế. Mọi thứ đều sạch sẽ và tổ chức rất tốt. Điều này làm cho bữa tối của chúng tôi trở thành một trải nghiệm đáng nhớ. Khuyên mọi người hãy thử!','2023-02-03'),(3,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',3,5,'Nhà hàng này đã đánh bại tất cả mong đợi của tôi. Mọi thứ đều hoàn hảo từ không gian đến thực đơn và phục vụ. Tôi đã thưởng thức một bữa tối tuyệt vời ở đây và sẽ khuyên bạn bè và gia đình đến đây. Cảm ơn nhà hàng đã tạo ra một trải nghiệm ẩm thực tuyệt vời!','2023-02-03'),(4,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',1,5,'Mình thực sự ấn tượng với nhà hàng này. Thực đơn đa dạng, món ăn ngon và được chế biến tinh tế. Mọi thứ đều sạch sẽ và tổ chức rất tốt. Điều này làm cho bữa tối của chúng tôi trở thành một trải nghiệm đáng nhớ. Khuyên mọi người hãy thử!','2023-10-17'),(5,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',2,5,'Nhà hàng này thực sự xuất sắc! Tôi đã có một trải nghiệm ẩm thực tuyệt vời với các món ăn ngon và dịch vụ chuyên nghiệp. Không chỉ thức ăn ngon mắt mà còn phục vụ nhanh chóng và thân thiện. Tôi sẽ quay lại lần nữa chắc chắn!','2023-10-17'),(6,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af',3,5,'Nhà hàng này thực sự xuất sắc! Tôi đã có một trải nghiệm ẩm thực tuyệt vời với các món ăn ngon và dịch vụ chuyên nghiệp. Không chỉ thức ăn ngon mắt mà còn phục vụ nhanh chóng và thân thiện. Tôi sẽ quay lại lần nữa chắc chắn!','2023-10-17');
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
INSERT INTO `mean` VALUES (1,NULL,180000.00),(2,NULL,250000.00),(3,NULL,150000.00),(4,NULL,120000.00),(5,NULL,360000.00),(6,NULL,240000.00),(7,NULL,250000.00),(8,NULL,290000.00),(9,NULL,270000.00),(10,NULL,345000.00),(11,NULL,110000.00),(12,NULL,290000.00),(13,NULL,130000.00),(14,NULL,314000.00),(15,NULL,160000.00),(16,NULL,138000.00),(17,NULL,550000.00),(18,NULL,220000.00),(19,NULL,324000.00),(20,NULL,205000.00),(21,NULL,260000.00),(22,NULL,100000.00),(23,NULL,170000.00),(24,NULL,145000.00),(25,NULL,210000.00),(26,NULL,145000.00),(27,NULL,130000.00),(28,NULL,120000.00),(29,NULL,130000.00),(30,NULL,150000.00),(31,NULL,150000.00),(32,NULL,150000.00),(33,NULL,230000.00),(34,NULL,265000.00),(35,NULL,250000.00),(36,NULL,175000.00),(37,NULL,148000.00),(38,NULL,130000.00),(39,NULL,205000.00),(40,NULL,364000.00),(41,NULL,120000.00),(42,NULL,175000.00),(43,NULL,225000.00),(44,NULL,200000.00),(45,NULL,130000.00),(46,NULL,130000.00),(47,NULL,160000.00),(48,NULL,395000.00),(49,NULL,145000.00),(50,NULL,130000.00),(51,NULL,365000.00),(52,NULL,120000.00),(53,NULL,170000.00),(54,NULL,150000.00),(55,NULL,220000.00),(56,NULL,120000.00),(57,NULL,120000.00),(58,NULL,364000.00),(59,NULL,275000.00),(60,NULL,170000.00);
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
INSERT INTO `meanitem` VALUES (1,1,1,2,100000.00),(2,1,2,1,50000.00),(3,1,10,1,30000.00),(4,2,3,1,50000.00),(5,2,4,2,100000.00),(6,2,6,2,100000.00),(7,3,16,1,50000.00),(8,3,17,1,50000.00),(9,3,25,1,50000.00),(10,4,19,1,50000.00),(11,4,24,1,50000.00),(12,4,29,2,20000.00),(13,5,41,1,150000.00),(14,5,45,1,150000.00),(15,5,50,2,60000.00),(16,6,21,2,100000.00),(17,6,38,2,130000.00),(18,6,39,1,10000.00),(19,7,64,1,90000.00),(20,7,65,2,130000.00),(21,7,70,3,30000.00),(22,8,13,2,20000.00),(23,8,32,1,120000.00),(24,8,33,1,150000.00),(25,9,59,2,100000.00),(26,9,60,1,150000.00),(27,9,72,2,20000.00),(28,10,55,1,120000.00),(29,10,60,1,150000.00),(30,10,71,3,75000.00),(31,11,1,1,50000.00),(32,11,7,1,50000.00),(33,11,14,1,10000.00),(34,12,42,2,140000.00),(35,12,43,1,100000.00),(36,12,49,2,50000.00),(37,13,19,1,50000.00),(38,13,23,1,50000.00),(39,13,28,3,30000.00),(40,14,31,1,194000.00),(41,14,36,2,100000.00),(42,14,39,2,20000.00),(43,15,65,2,130000.00),(44,15,72,1,10000.00),(45,15,75,1,20000.00),(46,16,61,1,55000.00),(47,16,62,1,53000.00),(48,16,70,3,30000.00),(49,17,43,2,200000.00),(50,17,45,2,300000.00),(51,17,49,2,50000.00),(52,18,26,3,30000.00),(53,18,46,1,70000.00),(54,18,47,1,120000.00),(55,19,31,1,194000.00),(56,19,37,1,120000.00),(57,19,39,1,10000.00),(58,20,42,1,70000.00),(59,20,44,1,110000.00),(60,20,49,1,25000.00),(61,21,52,2,100000.00),(62,21,53,1,130000.00),(63,21,69,2,30000.00),(64,22,9,1,50000.00),(65,22,10,1,30000.00),(66,22,12,2,20000.00),(67,23,3,3,150000.00),(68,23,11,1,10000.00),(69,23,12,1,10000.00),(70,24,34,1,50000.00),(71,24,38,1,65000.00),(72,24,39,3,30000.00),(73,25,44,1,110000.00),(74,25,48,1,40000.00),(75,25,50,2,60000.00),(76,26,57,1,60000.00),(77,26,58,1,70000.00),(78,26,69,1,15000.00),(79,27,67,2,90000.00),(80,27,74,1,20000.00),(81,27,75,1,20000.00),(82,28,16,2,100000.00),(83,28,26,1,10000.00),(84,28,27,1,10000.00),(85,29,20,1,50000.00),(86,29,21,1,50000.00),(87,29,28,3,30000.00),(88,30,3,1,50000.00),(89,30,4,1,50000.00),(90,30,7,1,50000.00),(91,31,9,2,100000.00),(92,31,10,1,30000.00),(93,31,15,2,20000.00),(94,32,17,1,50000.00),(95,32,24,1,50000.00),(96,32,25,1,50000.00),(97,33,14,3,30000.00),(98,33,33,1,150000.00),(99,33,35,1,50000.00),(100,34,42,1,70000.00),(101,34,47,1,120000.00),(102,34,49,3,75000.00),(103,35,54,2,180000.00),(104,35,59,1,50000.00),(105,35,70,2,20000.00),(106,36,64,1,90000.00),(107,36,68,1,65000.00),(108,36,74,1,20000.00),(109,37,63,1,53000.00),(110,37,65,1,65000.00),(111,37,70,3,30000.00),(112,38,5,1,50000.00),(113,38,6,1,50000.00),(114,38,14,3,30000.00),(115,39,37,1,120000.00),(116,39,38,1,65000.00),(117,39,40,2,20000.00),(118,40,31,1,194000.00),(119,40,33,1,150000.00),(120,40,40,2,20000.00),(121,41,21,2,100000.00),(122,41,28,1,10000.00),(123,41,30,1,10000.00),(124,42,56,1,60000.00),(125,42,57,1,60000.00),(126,42,61,1,55000.00),(127,43,59,1,50000.00),(128,43,60,1,150000.00),(129,43,71,1,25000.00),(130,44,68,2,130000.00),(131,44,70,2,20000.00),(132,44,71,2,50000.00),(133,45,23,1,50000.00),(134,45,24,1,50000.00),(135,45,28,3,30000.00),(136,46,3,1,50000.00),(137,46,5,1,50000.00),(138,46,11,3,30000.00),(139,47,20,1,50000.00),(140,47,21,2,100000.00),(141,47,28,1,10000.00),(142,48,41,2,300000.00),(143,48,42,1,70000.00),(144,48,49,1,25000.00),(145,49,66,1,60000.00),(146,49,67,1,45000.00),(147,49,74,2,40000.00),(148,50,61,1,55000.00),(149,50,65,1,65000.00),(150,50,72,1,10000.00),(151,51,36,1,50000.00),(152,51,37,1,120000.00),(153,51,38,3,195000.00),(154,52,6,1,50000.00),(155,52,8,1,50000.00),(156,52,15,2,20000.00),(157,53,21,1,50000.00),(158,53,22,2,100000.00),(159,53,28,2,20000.00),(160,54,56,1,60000.00),(161,54,57,1,60000.00),(162,54,70,3,30000.00),(163,55,55,1,120000.00),(164,55,58,1,70000.00),(165,55,72,3,30000.00),(166,56,22,1,50000.00),(167,56,23,1,50000.00),(168,56,30,2,20000.00),(169,57,3,1,50000.00),(170,57,5,1,50000.00),(171,57,15,2,20000.00),(172,58,31,1,194000.00),(173,58,32,1,120000.00),(174,58,35,1,50000.00),(175,59,20,1,50000.00),(176,59,45,1,150000.00),(177,59,49,3,75000.00),(178,60,52,1,50000.00),(179,60,54,1,90000.00),(180,60,72,3,30000.00);
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
INSERT INTO `menu` VALUES (1,1,'Menu Nhà hàng Chí Tiên',NULL),(2,2,'Menu Nhà hàng Sơn Vũ',NULL),(3,3,'Menu Nhà hàng Sơn Trà',NULL);
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
  CONSTRAINT `fk_order_cashier` FOREIGN KEY (`cashier_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_order_tables` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `FK_orders_users_CustomerId` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',1,'2023-09-14 10:00:00','Đã thanh toán',180000.00,'08dbc3c1-00b7-42dd-8f70-e5984d7f99af'),(2,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',2,'2023-09-14 10:00:00','Đã thanh toán',250000.00,'08dbc409-a8c6-4a33-8381-bb0aee233c0a'),(3,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',16,'2023-09-14 10:00:00','Đã thanh toán',150000.00,'08dbcf34-9f7d-4ae3-85b7-69ff085c82e0'),(4,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',17,'2023-09-14 10:00:00','Đã thanh toán',120000.00,'08dbcf34-f44e-4494-8541-a35dc0ee7ab2'),(5,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',1,'2023-09-14 19:30:00','Đã thanh toán',360000.00,'08dbcf35-2dd3-4324-8d70-d98b0ad32799'),(6,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',2,'2023-09-14 20:30:00','Đã thanh toán',240000.00,'08dbcf35-4b51-453d-8caf-e34e667b7961'),(7,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',3,'2023-09-14 17:00:00','Đã thanh toán',250000.00,'08dbcf35-6e38-4617-885f-bae2ea6b940b'),(8,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',3,'2023-09-14 19:30:00','Đã thanh toán',290000.00,'08dbcf35-8e2d-49fb-8fbb-56381f0578bc'),(9,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',4,'2023-09-14 17:30:00','Đã thanh toán',270000.00,'08dbcf35-e370-4386-84ba-e4b42f0dbd52'),(10,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',4,'2023-09-14 22:30:00','Đã thanh toán',345000.00,'08dbcf36-16a3-4dc6-8b2e-91bfcd58f677'),(11,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',5,'2023-09-15 16:00:00','Đã thanh toán',110000.00,'08dbcf36-375c-4484-8c9d-c9b37bc87fc6'),(12,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',5,'2023-09-15 19:30:00','Đã thanh toán',290000.00,'08dbcf36-657c-4dbd-859c-d5dfecfd78c7'),(13,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',6,'2023-09-14 20:00:00','Đã thanh toán',130000.00,'08dbcf74-463d-496b-8fc8-dab17c9d9f34'),(14,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',6,'2023-09-15 02:30:00','Đã thanh toán',314000.00,'08dbcf74-5865-47d1-8d6f-267c73fc3b9c'),(15,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',7,'2023-09-14 18:00:00','Đã thanh toán',160000.00,'08dbcf74-6cd8-46f3-8df5-c678cb2f11a7'),(16,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',7,'2023-09-15 00:35:00','Đã thanh toán',138000.00,'08dbcf74-8e9c-40d5-87e3-8a6eb614ce14'),(17,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',8,'2023-09-15 18:00:00','Đã thanh toán',550000.00,'08dbcf75-0d33-4346-8d5c-562b922994ad'),(18,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',8,'2023-09-16 05:30:00','Đã thanh toán',220000.00,'08dbcf75-23bf-4319-8ac3-601f76b2c8d2'),(19,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',9,'2023-09-14 17:45:00','Đã thanh toán',324000.00,'08dbcf75-3226-458a-81bb-3cf9ccb5e8d2'),(20,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',9,'2023-09-15 19:30:00','Đã thanh toán',205000.00,'08dbcf75-432e-4c35-8ebf-d8f50aa0fc74'),(21,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',10,'2023-09-15 16:15:00','Đã thanh toán',260000.00,'08dbcf75-5101-44dd-8f89-5ac0606e3ab5'),(22,'08dbc3c0-4022-4d45-83d6-ed48dcaebd02',10,'2023-09-16 05:35:00','Đã thanh toán',100000.00,'08dbcf75-6327-4602-85a9-158b59ac3138'),(23,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',11,'2023-09-14 18:00:00','Đã thanh toán',170000.00,'08dbcf75-7a63-408d-8b24-93273bed8827'),(24,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',11,'2023-09-15 17:00:00','Đã thanh toán',145000.00,'08dbcf75-a16d-4fe2-817d-b70df3a6b351'),(25,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',12,'2023-09-14 18:20:00','Đã thanh toán',210000.00,'08dbcf75-c4b7-45d6-8efd-89369d9e36d3'),(26,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',12,'2023-09-14 20:45:00','Đã thanh toán',145000.00,'08dbcf75-d54f-4c3e-81d9-877fb5a85b93'),(27,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',13,'2023-09-14 16:10:00','Đã thanh toán',130000.00,'08dbcf75-e4f3-4c2f-87a5-87c446cf468a'),(28,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',13,'2023-09-15 20:00:00','Đã thanh toán',120000.00,'08dbcf75-f498-44ad-8acf-a776f1eada9d'),(29,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',14,'2023-09-14 21:00:00','Đã thanh toán',130000.00,'08dbcf76-0a36-4ff0-8bef-223619922599'),(30,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',14,'2023-09-15 06:10:00','Đã thanh toán',150000.00,'08dbcf76-1ac2-4363-8182-091391d3f1a4'),(31,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',15,'2023-09-15 17:20:00','Đã thanh toán',150000.00,'08dbcf76-281b-4d6d-8272-837378aa0dd4'),(32,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',15,'2023-09-16 04:35:00','Đã thanh toán',150000.00,'08dbcf76-3b2a-4bfc-8024-f04257511038'),(33,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',16,'2023-09-16 01:00:00','Đã thanh toán',230000.00,'08dbcf76-6038-4ae4-80d0-f3fc37a3546a'),(34,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',17,'2023-09-16 03:25:00','Đã thanh toán',265000.00,'08dbcf76-6d23-45e5-8956-b11f5f857ced'),(35,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',18,'2023-09-14 17:00:00','Đã thanh toán',250000.00,'08dbcf76-7c65-47ff-8efa-52d1591c8e65'),(36,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',18,'2023-09-15 02:20:00','Đã thanh toán',175000.00,'08dbcf76-b944-4847-82e1-a548c0a87f20'),(37,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',19,'2023-09-15 17:08:00','Đã thanh toán',148000.00,'08dbcf76-c887-4c5c-8de4-a1b6e9086b81'),(38,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',19,'2023-09-16 06:05:00','Đã thanh toán',130000.00,'08dbcf76-da97-4160-8232-8446ea4fd7c8'),(39,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',20,'2023-09-15 18:06:00','Đã thanh toán',205000.00,'08dbcf76-ea04-4c1b-876e-65a8f89f3d9b'),(40,'08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7',20,'2023-09-16 07:00:00','Đã thanh toán',364000.00,'08dbcf76-ffdd-4157-80ff-e2d79250f6cb'),(41,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',21,'2023-09-14 19:00:00','Đã thanh toán',120000.00,'08dbcf77-13d8-4c89-89e8-096f4052699b'),(42,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',21,'2023-09-15 06:10:00','Đã thanh toán',175000.00,'08dbcf77-23c4-42c8-8811-ab4dec8db8c4'),(43,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',22,'2023-09-14 17:30:00','Đã thanh toán',225000.00,'08dbcf77-301a-4029-80b4-527bf4bc468d'),(44,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',22,'2023-09-15 01:45:00','Đã thanh toán',200000.00,'08dbcf77-3e18-4597-8986-8b69e73635ca'),(45,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',23,'2023-09-15 07:00:00','Đã thanh toán',130000.00,'08dbcf77-4d04-4359-8ee6-221590145177'),(46,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',23,'2023-09-15 20:10:00','Đã thanh toán',130000.00,'08dbcf77-6f5a-405c-8712-52ed7e2ae808'),(47,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',24,'2023-09-14 18:00:00','Đã thanh toán',160000.00,'08dbcf77-8f04-4081-8196-4893e4cbd641'),(48,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',24,'2023-09-15 03:05:00','Đã thanh toán',395000.00,'08dbcf77-c3a7-42c1-8b12-0ae06c4f2b99'),(49,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',25,'2023-09-14 18:06:00','Đã thanh toán',145000.00,'08dbcf77-e7d5-43aa-8da0-45661e8e4b16'),(50,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',25,'2023-09-14 22:30:00','Đã thanh toán',130000.00,'08dbcf77-f53f-4f79-817f-cfb754e59aed'),(51,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',26,'2023-09-14 20:00:00','Đã thanh toán',365000.00,'08dbcf78-0206-4d3b-8012-da6a2d662a6d'),(52,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',26,'2023-09-15 05:05:00','Đã thanh toán',120000.00,'08dbcf78-0fbf-4779-8444-8a31761b08f7'),(53,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',27,'2023-09-15 17:00:00','Đã thanh toán',170000.00,'08dbcf78-1f3c-4298-8e36-a719637b9775'),(54,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',27,'2023-09-15 19:50:00','Đã thanh toán',150000.00,'08dbcf78-2e2d-428b-8311-f5604a061074'),(55,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',28,'2023-09-14 17:20:00','Đã thanh toán',220000.00,'08dbcf78-3aae-452f-8cc9-eb84dc4436c4'),(56,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',28,'2023-09-15 04:45:00','Đã thanh toán',120000.00,'08dbcf78-48c9-48f2-823d-259d5d5679b7'),(57,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',29,'2023-09-14 18:10:00','Đã thanh toán',120000.00,'08dbcf78-54a5-4913-8b4f-540b76cdea56'),(58,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',29,'2023-09-15 06:08:00','Đã thanh toán',364000.00,'08dbcf78-6315-4fa9-871b-39464f54ca4e'),(59,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',30,'2023-09-15 18:05:00','Đã thanh toán',275000.00,'08dbcf78-7246-497c-8b7f-8dc6f40010c6'),(60,'08dbcf38-ce8f-4367-8cd4-58a32726bfdb',30,'2023-09-16 06:10:00','Đã thanh toán',170000.00,'08dbcf78-b70d-4f5d-8188-b6d0f245ed68');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,1,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-03-19 10:00:00','2023-03-22 10:00:00',10.00),(2,2,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-03-19 10:00:00','2023-03-22 10:00:00',10.00),(3,3,'Khuyến Mãi 10%','Khuyến Mãi 10%','2023-10-17 12:17:35','2023-10-18 12:17:35',10.00);
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
INSERT INTO `restaurantsbr` VALUES (1,'Nhà hàng Chí Tiên','Bình Thạnh, TP.HCM','Nhà hàng 3 sao','https://res.cloudinary.com/dkba7robk/image/upload/v1696604137/dlaue3rktoamoivgqm1o.jpg'),(2,'Nhà hàng Sơn Vũ','Gò Vấp, TP.HCM','Nhà hàng 3 sao','https://res.cloudinary.com/dkba7robk/image/upload/v1696601830/pktf7azpntuisyvejnu2.jpg'),(3,'Nhà hàng Sơn Trà','Bình Tân , TP.HCM','Nhà hàng 3 sao','https://res.cloudinary.com/dkba7robk/image/upload/v1696604138/a8ejftwrzvyavfsml2oc.jpg');
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
  CONSTRAINT `fk_idwaiter` FOREIGN KEY (`id_waiter`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurantsbr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tables`
--

LOCK TABLES `tables` WRITE;
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` VALUES (1,1,1,10,'Chưa đặt','08dbcf37-5d16-4dd2-8218-20e2a7bc3521'),(2,1,2,10,'Chưa đặt','08dbcf37-5d16-4dd2-8218-20e2a7bc3521'),(3,1,3,10,'Chưa đặt','08dbcf37-c4eb-4ba4-8cb5-e3666185e676'),(4,1,4,10,'Chưa đặt','08dbcf37-c4eb-4ba4-8cb5-e3666185e676'),(5,1,5,10,'Chưa đặt','08dbcf38-3886-40a8-8f98-8632a59461d8'),(6,1,6,10,'Chưa đặt','08dbcf38-3886-40a8-8f98-8632a59461d8'),(7,1,7,10,'Chưa đặt','08dbcf38-6532-4606-86c8-61dfef2cdce1'),(8,1,8,10,'Chưa đặt','08dbcf38-6532-4606-86c8-61dfef2cdce1'),(9,1,9,10,'Chưa đặt','08dbcf38-88f5-41dc-8df6-5c1ab2a492e5'),(10,1,10,10,'Chưa đặt','08dbcf38-88f5-41dc-8df6-5c1ab2a492e5'),(11,2,1,10,'Chưa đặt','08dbcf39-0812-46cd-8af2-63db790076b3'),(12,2,2,10,'Chưa đặt','08dbcf39-0812-46cd-8af2-63db790076b3'),(13,2,3,10,'Chưa đặt','08dbcf39-1f02-48bf-835b-6cce18810075'),(14,2,4,10,'Chưa đặt','08dbcf39-1f02-48bf-835b-6cce18810075'),(15,2,5,10,'Chưa đặt','08dbcf3a-85cd-41a1-8ac4-29e7a7a29238'),(16,2,6,10,'Chưa đặt','08dbcf3a-85cd-41a1-8ac4-29e7a7a29238'),(17,2,7,10,'Chưa đặt','08dbcf3a-9f22-44da-8b20-221aefc993cc'),(18,2,8,10,'Chưa đặt','08dbcf3a-9f22-44da-8b20-221aefc993cc'),(19,2,9,10,'Chưa đặt','08dbcf3a-b345-4ab1-8513-498f683ba80f'),(20,2,10,10,'Chưa đặt','08dbcf3a-b345-4ab1-8513-498f683ba80f'),(21,3,1,10,'Chưa đặt','08dbcf3a-df39-4c7d-8149-3e148d2a247b'),(22,3,2,10,'Chưa đặt','08dbcf3a-df39-4c7d-8149-3e148d2a247b'),(23,3,3,10,'Chưa đặt','08dbcf3a-f367-403f-8449-be907e25e9df'),(24,3,4,10,'Chưa đặt','08dbcf3a-f367-403f-8449-be907e25e9df'),(25,3,5,10,'Chưa đặt','08dbcf3b-0ee9-45f7-8f9c-151be782eb50'),(26,3,6,10,'Chưa đặt','08dbcf3b-0ee9-45f7-8f9c-151be782eb50'),(27,3,7,10,'Chưa đặt','08dbcf3b-431f-429f-8b8a-ec48e095a7ba'),(28,3,8,10,'Chưa đặt','08dbcf3b-431f-429f-8b8a-ec48e095a7ba'),(29,3,9,10,'Chưa đặt','08dbcf3b-61a4-4aa6-85e9-ac066d3fa915'),(30,3,10,10,'Chưa đặt','08dbcf3b-61a4-4aa6-85e9-ac066d3fa915');
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
  CONSTRAINT `FK_AspNetUserClaims_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `FK_AspNetUserLogins_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE
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
  CONSTRAINT `FK_AspNetUserRoles_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userroles`
--

LOCK TABLES `userroles` WRITE;
/*!40000 ALTER TABLE `userroles` DISABLE KEYS */;
INSERT INTO `userroles` VALUES ('08dbc3c0-2014-49cc-8808-f0ed2a41e120','08dbc3bf-3c23-4747-80a0-10a9e086a77b'),('08dbc3c0-4022-4d45-83d6-ed48dcaebd02','08dbc3bf-407f-4c5f-807f-96cf1ed06709'),('08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7','08dbc3bf-407f-4c5f-807f-96cf1ed06709'),('08dbcf38-ce8f-4367-8cd4-58a32726bfdb','08dbc3bf-407f-4c5f-807f-96cf1ed06709'),('08dbcf37-5d16-4dd2-8218-20e2a7bc3521','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf37-c4eb-4ba4-8cb5-e3666185e676','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf38-3886-40a8-8f98-8632a59461d8','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf38-6532-4606-86c8-61dfef2cdce1','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf38-88f5-41dc-8df6-5c1ab2a492e5','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf39-0812-46cd-8af2-63db790076b3','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf39-1f02-48bf-835b-6cce18810075','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3a-85cd-41a1-8ac4-29e7a7a29238','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3a-9f22-44da-8b20-221aefc993cc','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3a-b345-4ab1-8513-498f683ba80f','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3a-df39-4c7d-8149-3e148d2a247b','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3a-f367-403f-8449-be907e25e9df','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3b-0ee9-45f7-8f9c-151be782eb50','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3b-431f-429f-8b8a-ec48e095a7ba','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbcf3b-61a4-4aa6-85e9-ac066d3fa915','08dbc3bf-45a8-480b-80d8-936fb5f74d57'),('08dbc3c1-00b7-42dd-8f70-e5984d7f99af','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbc409-a8c6-4a33-8381-bb0aee233c0a','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf34-9f7d-4ae3-85b7-69ff085c82e0','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf34-f44e-4494-8541-a35dc0ee7ab2','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf35-2dd3-4324-8d70-d98b0ad32799','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf35-4b51-453d-8caf-e34e667b7961','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf35-6e38-4617-885f-bae2ea6b940b','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf35-8e2d-49fb-8fbb-56381f0578bc','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf35-e370-4386-84ba-e4b42f0dbd52','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf36-16a3-4dc6-8b2e-91bfcd58f677','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf36-375c-4484-8c9d-c9b37bc87fc6','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf36-657c-4dbd-859c-d5dfecfd78c7','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf74-463d-496b-8fc8-dab17c9d9f34','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf74-5865-47d1-8d6f-267c73fc3b9c','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf74-6cd8-46f3-8df5-c678cb2f11a7','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf74-8e9c-40d5-87e3-8a6eb614ce14','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-0d33-4346-8d5c-562b922994ad','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-23bf-4319-8ac3-601f76b2c8d2','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-3226-458a-81bb-3cf9ccb5e8d2','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-432e-4c35-8ebf-d8f50aa0fc74','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-5101-44dd-8f89-5ac0606e3ab5','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-6327-4602-85a9-158b59ac3138','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-7a63-408d-8b24-93273bed8827','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-a16d-4fe2-817d-b70df3a6b351','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-c4b7-45d6-8efd-89369d9e36d3','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-d54f-4c3e-81d9-877fb5a85b93','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-e4f3-4c2f-87a5-87c446cf468a','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf75-f498-44ad-8acf-a776f1eada9d','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-0a36-4ff0-8bef-223619922599','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-1ac2-4363-8182-091391d3f1a4','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-281b-4d6d-8272-837378aa0dd4','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-3b2a-4bfc-8024-f04257511038','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-6038-4ae4-80d0-f3fc37a3546a','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-6d23-45e5-8956-b11f5f857ced','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-7c65-47ff-8efa-52d1591c8e65','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-b944-4847-82e1-a548c0a87f20','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-c887-4c5c-8de4-a1b6e9086b81','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-da97-4160-8232-8446ea4fd7c8','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-ea04-4c1b-876e-65a8f89f3d9b','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf76-ffdd-4157-80ff-e2d79250f6cb','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-13d8-4c89-89e8-096f4052699b','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-23c4-42c8-8811-ab4dec8db8c4','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-301a-4029-80b4-527bf4bc468d','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-3e18-4597-8986-8b69e73635ca','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-4d04-4359-8ee6-221590145177','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-6f5a-405c-8712-52ed7e2ae808','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-8f04-4081-8196-4893e4cbd641','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-c3a7-42c1-8b12-0ae06c4f2b99','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-e7d5-43aa-8da0-45661e8e4b16','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf77-f53f-4f79-817f-cfb754e59aed','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-0206-4d3b-8012-da6a2d662a6d','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-0fbf-4779-8444-8a31761b08f7','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-1f3c-4298-8e36-a719637b9775','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-2e2d-428b-8311-f5604a061074','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-3aae-452f-8cc9-eb84dc4436c4','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-48c9-48f2-823d-259d5d5679b7','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-54a5-4913-8b4f-540b76cdea56','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-6315-4fa9-871b-39464f54ca4e','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-7246-497c-8b7f-8dc6f40010c6','08dbc3bf-49ca-476c-8df1-afb1e2c06549'),('08dbcf78-b70d-4f5d-8188-b6d0f245ed68','08dbc3bf-49ca-476c-8df1-afb1e2c06549');
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
INSERT INTO `users` VALUES ('08dbc3c0-2014-49cc-8808-f0ed2a41e120','admin123',NULL,'admin123@gmail.com','Nguyễn Ngọc Luân','2002-09-15','Bình Thuận','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1696916847/zlipicaa9bmkkcl1evcl.jpg','ADMIN123',NULL,0,'AQAAAAEAACcQAAAAEPXSZEv+ip/1TvcU4Fhb4P8j3rS71EN/E0KF3Bn790ZKpFverP5g7ZppB3LLAXfn2g==','3ZRKKSUOHZGNQRLQSOUEJT5DTLREML4V','d3c7273a-bb18-46d1-9f1e-45f89d2a9e37','0868196036',0,0,NULL,1,0),('08dbc3c0-4022-4d45-83d6-ed48dcaebd02','nht123',NULL,'nht123@gmail.com','Nguyễn Huyền Trang','2003-09-15','Bình Thuận','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1696918236/qxopcxcaftvwjlllkuja.png','CASHIER123',NULL,0,'AQAAAAEAACcQAAAAEBokQxVGswnugS7ypdQvN5GasIQ+tjUncVZfs0zKfIxZjCtUmzgkFPM/MgIzFj0Nvg==','QO6H6HCHNJV7NULPQDNV4YHQPITYC4FQ','c82b5d00-40d0-43ee-89a9-ec9f989bd7a8','0868585956',0,0,NULL,1,0),('08dbc3c1-00b7-42dd-8f70-e5984d7f99af','nhl123',NULL,'nhl123@gmail.com','Nguyễn Hoàng Long','2002-09-15','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1696918473/r4n2wdn4kr15n7ikt1mt.png','CUSTOMER123',NULL,0,'AQAAAAEAACcQAAAAECsfBX57Sy8R/P/iKjrGYDOzTYH4q/YI9CD6CbJQJHPZQtyM1hGPpcsthz0niHgjKA==','HK5HVT43IGVIH7WZ6UWK74QLBEOVE2H2','3801e77b-52fb-4b5c-b1b0-6678da7a21a0','0859469547',0,0,NULL,1,0),('08dbc409-a8c6-4a33-8381-bb0aee233c0a','hoanghuyen123',NULL,'hoanghuyen123@gmail.com','Hoàng Huyền','2003-06-03','Sài Gòn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1696918236/qxopcxcaftvwjlllkuja.png','HOANGHUYEN123',NULL,0,'AQAAAAEAACcQAAAAEIauPPIQ9QXquuJZ816K5So419b5A21pdtfu8xqnOMEzQTUlHF7m8Y/AU33EHUlLCQ==','U5VH4ONPS7Z5F63WXZHALILAULMXVQTM','a5324d2f-a0a9-48a5-bf62-eae480e04efa','0889595855',0,0,NULL,1,0),('08dbcf34-9f7d-4ae3-85b7-69ff085c82e0','nva123',NULL,'nguyenvana@gmail.com','Nguyễn Văn An','2003-06-12','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697562910/g3ltizmmgheiy0ikaydz.jpg','NVA123',NULL,0,'AQAAAAEAACcQAAAAEFaK4YjCnZ7N3efxIa7sT/QY9vBKYTCRZp55edzWe9c8smc/vJbMnvu16PhKGduovQ==','FILHFO5EEUNX2G5UBZJB5E64N7XICURA','08402be5-004f-41dd-9cec-462aed388fc3','0123456781',0,0,NULL,1,0),('08dbcf34-f44e-4494-8541-a35dc0ee7ab2','lhc123',NULL,'lehongcuong@gmail.com','Lê Hồng Cường','2004-05-13','Đà Nẵng','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697563054/y4i9apmlfgqrlpfprdh3.jpg','LHC123',NULL,0,'AQAAAAEAACcQAAAAEOsS/3iSL3zj3cMfDr5zy2BaK+Dv0NgUD9Z8iJJPaDW+Th60y5tBQMHi/nPxFFuiCw==','NWAE4JT25E5Y7WYPC5F4BRYVFS6MKQ3Q','eb4d7127-6a46-49cd-8b8f-8fab78c72c42','0123456783',0,0,NULL,1,0),('08dbcf35-2dd3-4324-8d70-d98b0ad32799','ttb123',NULL,'tranthibinh@gmail.com','Trần Thị Bình','2004-02-18','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697563151/j07zdzxnqcfbfznfang3.jpg','TTB123',NULL,0,'AQAAAAEAACcQAAAAEBUPbNqHFNmWDscn98/uV4MqRWx1JFMY3FypeZuQUX0+GpbpMpX3Qv2UeMpHgZnXaw==','Q7S34KPLWJMTACKZZ6LMTGFJSHTKKZMK','7b208a7f-c748-4277-8e23-d79a0b91c86e','0123456782',0,0,NULL,1,0),('08dbcf35-4b51-453d-8caf-e34e667b7961','hqd123',NULL,'hoangquocdung@gmail.com','Hoàng Quốc Dũng','2003-10-18','Huế','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697563199/qqu3bu0sfocgzeddoa1s.jpg','HQD123',NULL,0,'AQAAAAEAACcQAAAAEMM6pH4nx8gplSHeJ0LK3O4y9CHnodR11f4nFbGcnmMKBzCoIIAPv71uO5yqn3WxPg==','VMGJ3OBHOFE5LEUSDAOJFGISURT4VVK4','bf80480d-dd62-4ead-83d2-4085571db928','0123456784',0,0,NULL,1,0),('08dbcf35-6e38-4617-885f-bae2ea6b940b','pmp123',NULL,'phamminhphong@gmail.com','Phạm Minh Phong','2003-02-18','Cần Thơ','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697563258/cpfrdygnzkxzvhwhvt46.jpg','PMP123',NULL,0,'AQAAAAEAACcQAAAAEECaOsaysOAG/THqoNXszptmhy80F/MXqAB9gqMXnfJON47U3GA3LOJkhuubknLkng==','XE4HFBWZPIMIRMU43PDR54Z4BG4UHCUH','bcdf3fc7-43cb-45ea-a5a7-b2309142d250','0123456786',0,0,NULL,1,0),('08dbcf35-8e2d-49fb-8fbb-56381f0578bc','lvg123',NULL,'levangiang@gmail.com','Lê Văn Giang','2003-02-18','Vinh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697563311/kz4j5mlhizxnczqwwapz.jpg','LVG123',NULL,0,'AQAAAAEAACcQAAAAEFC1ESMv2f7diNhsWpyIzA5kQ+ZwXw94lb/yeRtdtW2t8OSjLs7GTJ/iROzh4ECjQQ==','44JUSQB3QIO5GP3ZCPDJQKB25CKJXVFW','b40d955d-92e1-482a-b585-3920fa3bd3aa','0123456787',0,0,NULL,1,0),('08dbcf35-e370-4386-84ba-e4b42f0dbd52','pvt123',NULL,'phamvantien@gmail.com','Phạm Văn Tiến','2001-01-18','Tam Kỳ','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697563454/gffn2qgfsu8xickaxum1.jpg','PVT123',NULL,0,'AQAAAAEAACcQAAAAEKftcQE3rbuvR6ZIBB6Qgv48zIeIYhDB6u3P9joSMkiC1G4cEJi9aJZjiwz9wLNeUw==','G6KMYFZPHKOJIYRIJ5P4JSDVH7SGUNAI','be927221-7a41-40da-aa55-3b48414756f1','0123456790',0,0,NULL,1,0),('08dbcf36-16a3-4dc6-8b2e-91bfcd58f677','ttl123',NULL,'trinhthilan@gmail.com','Trịnh Thị Lan','2003-01-18','Nha Trang','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697563541/mq9jgk4c4uazen7injes.jpg','TTL123',NULL,0,'AQAAAAEAACcQAAAAEMP4SP/UtyfMZdFB7+IKnek4tyIz9mER8AsDl3oJzCLT5JmF7HyKZYsy0YddceaRAg==','ZNZTWTMWB3QHRCNF477KQ56QBKIXAINJ','7cbf7407-1136-434b-91b7-6b24955b30f6','0123456785',0,0,NULL,1,0),('08dbcf36-375c-4484-8c9d-c9b37bc87fc6','nhy123',NULL,'nguyenhaiyen@gmail.com','Nguyễn Hải Yến','2003-02-18','Quy Nhơn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697563594/arywn3fo1i6nihiyxd1d.jpg','NHY123',NULL,0,'AQAAAAEAACcQAAAAEPDgzYsCIsY8+OtE790ICalrZO4v39dJS2Wwyosw1i19vSfBrvfHLx74+cxCCh7bFw==','K55CY7Z6UHKVRIARG6X4KEWTI76CO26L','6d33c917-a6cc-437b-aa30-c8ce471fd889','0123456788',0,0,NULL,1,0),('08dbcf36-657c-4dbd-859c-d5dfecfd78c7','ptt123',NULL,'phamthanhtung@gmail.com','Phạm Thanh Tùng','2003-01-18','Tam Kỳ','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697563673/arxfm2ctqp69chsuvkny.jpg','PTT123',NULL,0,'AQAAAAEAACcQAAAAEDkNXaye5+fk76gdtQnOfD4mp9MFd2Cv8nRO5pL3rogc6G7427pYTM2fXjTNVjaoHQ==','KU4VKW3LEDHXUKLXLBULRYH6YMQWGY67','3bb14d88-f056-42d7-b7c2-dc0b8e591ef2','0123496790',0,0,NULL,1,0),('08dbcf37-5d16-4dd2-8218-20e2a7bc3521','dtm123',NULL,'dothiminh@gmail.com','Đỗ Thị Minh Anh','2002-03-06','Phan Thiết','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697564089/h3bnw9o0baltdjharu0u.jpg','DTM123',NULL,0,'AQAAAAEAACcQAAAAEEpnkCdEX8AEhbSC4lrQDE1USubrkvjLal5tfSxw07Dn+DSSHz6iPL2a6bAzNbD2RQ==','KHT4CW557LD3QGHPXH3QD7OJGVU5QPTL','52e81032-7b8e-4ffd-ac0c-11fef5390eec','0123456789',0,0,NULL,1,0),('08dbcf37-c4eb-4ba4-8cb5-e3666185e676','lhcuong123',NULL,'lecuong@gmail.com','Lê Hồng Cường','2002-03-06','Đà Nẵng','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697564262/g4hlolxlyerjuoiwwl56.jpg','LHCUONG123',NULL,0,'AQAAAAEAACcQAAAAEAhq6oSwB14gK+pk+CJB39PdlxeRwJ+6WDOhukc6G0mx8mQalRTzUTNkhTsBkQfmyg==','D3ASUDCHIJDS2MCDK3GZ7OGC2XSXU3AX','08bddf65-03ef-462a-97d3-27514e6e35ab','0123456791',0,0,NULL,1,0),('08dbcf38-3886-40a8-8f98-8632a59461d8','ttl12345',NULL,'trinhlan@gmail.com','Trịnh Thị Lan','2002-03-06','Nha Trang','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697564456/adi6xruesezwopxmidgt.jpg','TTL12345',NULL,0,'AQAAAAEAACcQAAAAEOOA5hO/mdXzfthnC/e7tLAwawfUiQaSPLhTy3MuE0yN0sBiR0+AXE+6dVwU+zaY+w==','O7E34YIB52VFNTNYCKDJ6E7G2EISUI4N','91f6a937-5b1e-45a6-b01a-8a0327f5262d','0123456793',0,0,NULL,1,0),('08dbcf38-6532-4606-86c8-61dfef2cdce1','pmpp123',NULL,'phongphamppham@gmail.com','Phạm Minh Phong','2002-03-06','Cần Thơ','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697564530/tsp6vxwosydjnyfy3qtr.jpg','PMPP123',NULL,0,'AQAAAAEAACcQAAAAEF2Sx1wE8gVc1TERgPZsVnnVtym6jtCV475ydh9PdcHynjR1TmjnjkjHoYQjt7uzNw==','H6TVVOYIPY6ELIUENAMTBRZ6BEEAS5UG','c7f0f923-ea2e-46a4-bc2e-08b80a87dcc3','0123456794',0,0,NULL,1,0),('08dbcf38-88f5-41dc-8df6-5c1ab2a492e5','vak123',NULL,'voanhkiet@gmail.com','Võ Anh Kiệt','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697564592/fpylserrdvp8alnlfklx.jpg','VAK123',NULL,0,'AQAAAAEAACcQAAAAELkSTjuQPvPFXeX6HoL9FCvfn25oYT1As6sdgToFDf2r5CV8YicUdC2duI68/Z6z0g==','GQULWI7LRJI27N62MDHYSCZTYOAICDX6','4996c656-7bff-4083-bb66-a218ebba1c2d','0123456795',0,0,NULL,1,0),('08dbcf38-b9f4-4dc5-8b77-73c57b11ddf7','ltct123',NULL,'lethicattuong@gmail.com','Lê Thị Cát Tường','2002-03-06','Sài Gòn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697564673/buvrzx5qryf2cnvlqihh.jpg','LTCT123',NULL,0,'AQAAAAEAACcQAAAAELy7dk//tuO6iKavfohObpmdXjgW9dRBle0Fs96QQ0haZmkTcqVqbNvbEx9kRtEIig==','BC2XPAHC4ECKUXTPDHUDVAFYRF52J2NV','748f8580-6cff-4626-97f6-b4d80458988e','0123456796',0,0,NULL,1,0),('08dbcf38-ce8f-4367-8cd4-58a32726bfdb','nnat123',NULL,'nguyenngocanhthu@gmail.com','Nguyễn Ngọc Anh Thư','2002-03-06','Sài Gòn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697564709/oovljnhellwl6rpxnhl1.jpg','NNAT123',NULL,0,'AQAAAAEAACcQAAAAEBChtMwm7kEPdam1v0jDDq4l1fAMyJ2j0hZBvQRfKWswuDK9rEPlr/HrWtHcPEN1nQ==','EVRDD3DAVDIXRLNZW2TQICYI67LZ6QO7','98bc8179-97d5-4348-8c80-06f6d2241d76','0123456798',0,0,NULL,1,0),('08dbcf39-0812-46cd-8af2-63db790076b3','hqd12345',NULL,'hoquangdat@gmail.com','Hồ Quang Đạt','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697564804/pureczcsrwowzqekqcr1.jpg','HQD12345',NULL,0,'AQAAAAEAACcQAAAAEKVR5jZM2ZDxh4mUop2radgP2QeNID5qzppwmTQOHMcTahREfTvYrUka9RdEw2JfNg==','PJEBBWRGFBCEKITIKG5DDWFLQKZW5K4K','05dbb314-b58a-4aaa-bb7d-b05b47d9e246','0123456797',0,0,NULL,1,0),('08dbcf39-1f02-48bf-835b-6cce18810075','bth123',NULL,'buitienhung@gmail.com','Bùi Tiến Hùng','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697564844/danhibglkvjt9uqw2q1y.jpg','BTH123',NULL,0,'AQAAAAEAACcQAAAAELkQA8M28kxf0iEZthanp9QNn3K8o2+ScqBtnxzDn3qYxXchKdkg3c9L/qv8vfPhXw==','P5MPEZIO4QCXDN6IWOUTPEKEJZ2WKTLV','06e36df4-08ee-4e38-9bac-834b862b3827','0123456799',0,0,NULL,1,0),('08dbcf3a-85cd-41a1-8ac4-29e7a7a29238','ngu123',NULL,'ngu123@gmail.com','Nguyễn Văn Anh','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697565446/r7kilfstevqvfycuum94.jpg','NGU123',NULL,0,'AQAAAAEAACcQAAAAEB7BMLti8KGVLh97qbWEBGHbkPJT+zssOiZt8QZumaCrM/nqpDRlLrCprY6XVdsVHg==','ECE3XTI25KWB5CPLPAGVALLRVTXS5TIL','172c12db-bd56-41a6-9979-1790fcf6c8ea','0860123458',0,0,NULL,1,0),('08dbcf3a-9f22-44da-8b20-221aefc993cc','tra123',NULL,'tra123@gmail.com','Trần Thị Bình Nhi','2002-03-06','Sài Gòn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697565487/fx4stp3ldqmeoszlevhk.jpg','TRA123',NULL,0,'AQAAAAEAACcQAAAAEOBxxXYQzKPvFmQdHCq+RyoQTFVFjPE/HM/nJdDga17el8qMRYGS/YxynlIVep0kSQ==','F4IDVZNUMFFO4LFS2R6UMRCEMGDJBJJ4','daa31482-73ab-4b40-a8b1-bb0e1af660f3','0860123457',0,0,NULL,1,0),('08dbcf3a-b345-4ab1-8513-498f683ba80f','lec123',NULL,'lec123@gmail.com','Lê Hồng Cường Kha','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697565521/jmdasccifnfmpvzyugin.jpg','LEC123',NULL,0,'AQAAAAEAACcQAAAAENF9CKVK26coEHDcrKolNXNVXAOFMPfQoM1JRkCc8u21LzSOue9luKjKjuW4KLp8wQ==','LTZM5XI7JXOVB53CS73OQ2Q3JPGG3UL2','45321286-1fc4-48f6-a038-b693087528c4','0869587995',0,0,NULL,1,0),('08dbcf3a-df39-4c7d-8149-3e148d2a247b','hoq123',NULL,'hoq123@gmail.com','Hoàng Quốc Dũng Dang','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697565596/jsdzbgj58kt9vz106dts.jpg','HOQ123',NULL,0,'AQAAAAEAACcQAAAAEOGJMoeDZYunCNDs/DMC/AlXSdcXebOmy8xGcsAlbAk9xsW6tIIJk9J+rSmkF1VWpg==','W4DZSTLMETAIGWKXJXKKC3KN4VIHYMPC','51811a2f-25ed-40d2-8003-5437c1f7c644','0860123459',0,0,NULL,1,0),('08dbcf3a-f367-403f-8449-be907e25e9df','tri123',NULL,'tri123@gmail.com','Trịnh Thị Lan Nhi','2002-03-06','Sài Gòn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697565630/mlbvrhiomkrxwqqgghva.jpg','TRI123',NULL,0,'AQAAAAEAACcQAAAAEOmp+qVQBWIh+ET3C0wgHdddXGZ/0LmTIIFf49hgUk7ixoC6KHvj1n3rfL9l3VU0bw==','VNTT5XDCYXL546VSLWDKDUKURWXHTJPB','f8be765f-ed93-41ff-9326-cebfb64ab45c','0860123460',0,0,NULL,1,0),('08dbcf3b-0ee9-45f7-8f9c-151be782eb50','pha123',NULL,'pha123@gmail.com','Phạm Phong Minh','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697565675/ymbgebt0ly9o3ao0ldzw.jpg','PHA123',NULL,0,'AQAAAAEAACcQAAAAEOTxbyFW+Hatvov/UgSwfBgq70vPqSIS+3nnFnU9qFqseYarCr3l8543y/54YkBXhQ==','RFLUIFQ3LE7KWGLVKB7SZZ25NRD2FJAF','13f1d691-0904-47a3-b8d1-cb0aecdf3b3c','0860123461',0,0,NULL,1,0),('08dbcf3b-431f-429f-8b8a-ec48e095a7ba','lev123',NULL,'lev123@gmail.com','Lê Văn Dũng','2002-03-06','Sài Gòn','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697565763/xpgidkb9l3aukbcwnwfv.jpg','LEV123',NULL,0,'AQAAAAEAACcQAAAAEN7zTktrgjA5exEfdPGe6GyoZrJ78HpznHL2hWISM5GB78blWzLnQiM640gy/wpBVQ==','MNCVEG7OG5SKNDCY3PGCES5E6K54UK44','664c8ac3-aa25-46a5-9466-a6278e912af4','0860123462',0,0,NULL,1,0),('08dbcf3b-61a4-4aa6-85e9-ac066d3fa915','ngy123',NULL,'ngy123@gmail.com','Nguyễn Hải Nhi','2002-03-06','Sài Gòn','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697565815/ytl56n8fkjcrqyl5ksdl.jpg','NGY123',NULL,0,'AQAAAAEAACcQAAAAECaNsXPd6/Xvna1mQDjZ/sbPxTTyNMy3BuEgo1rixOo7aE0zdwhzV34qmUY6cialbQ==','Z733QITBTSDVQ67B7GJ4YWF75YCHI4LP','a29019f7-4f19-4543-9354-54c11d1e0b25','0860123463',0,0,NULL,1,0),('08dbcf74-463d-496b-8fc8-dab17c9d9f34','nthuong123',NULL,'nthuong123@gmail.com','Nguyễn Thị Hương','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590250/bplioxruc8fe7ur8qbwf.png','NTHUONG123',NULL,0,'AQAAAAEAACcQAAAAEFHERNdkxTBln9jD6O531LcpHYlxpqufevw/AEeM8X/brgyUxRN4cFQjEqmhBNVqmg==','ISD744NUGTMW7U2F4W5MC6BECDA5S2OA','e78e8c19-fcc7-43e2-98da-093ebda1eaa7','0984376291',0,0,NULL,1,0),('08dbcf74-5865-47d1-8d6f-267c73fc3b9c','lethimai123',NULL,'lethimai123@gmail.com','Lê Thị Mai','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590281/ktxagiqjgfncw3f0rdps.png','LETHIMAI123',NULL,0,'AQAAAAEAACcQAAAAEKw0KBwOBNRvG38Dg28zgmZQYfcTvThvR2PBJYn/cjDDim1lNVn63i+VP0TL95nxbA==','7MUMD7VCR7EBY3CSVQKFQBHMVE23MAIH','0a2edf63-1c47-42c6-8f5a-81b9854864ea','0983765431',0,0,NULL,1,0),('08dbcf74-6cd8-46f3-8df5-c678cb2f11a7','dthanh123',NULL,'dthanh123@gmail.com','Đinh Thị Hạnh','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590315/vd2k7oeut7ysyhzslxo0.png','DTHANH123',NULL,0,'AQAAAAEAACcQAAAAEJ4OurWcN9By2qXwkFIM9zMYTyy2kumzoD77/wlBDooalgaP0SY3m14JyZ4e+HC9JQ==','WQWSKYVEZ6SH6RGMMKYTQBFPRFHAG3LM','e5363b85-a32d-4745-98ea-aca931b1fe82','0982187439',0,0,NULL,1,0),('08dbcf74-8e9c-40d5-87e3-8a6eb614ce14','htphuong123',NULL,'htphuong123@gmail.com','Hoàng Thị Phương','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590372/yjnwiqaatu6okvdulbaj.png','HTPHUONG123',NULL,0,'AQAAAAEAACcQAAAAEKiBJb+PF69q89KPVp0ISVRedHAU5Sui0k6UnhioeBdr103p+Naemy3KC1pZCJkW3g==','PRPIENVH7FNUI5CNQDEKS5RTROGMV5VY','1b8ca5f9-8319-4321-94ca-a5369f777c7c','0987654321',0,0,NULL,1,0),('08dbcf75-0d33-4346-8d5c-562b922994ad','btthu123',NULL,'btthu123@gmail.com','Bùi Thị Thu','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590584/i81lf6pzdq2tcezwvdau.png','BTTHU123',NULL,0,'AQAAAAEAACcQAAAAEKNywmeDHtRqwkckJTb8saCqvJoevs5S3FxZULfVJCi0k769GJPhBsrQhHORxYt7fA==','IX2JD6VG772EQYLW5KP3NK4GHVTHSRKF','d32fd7d3-6220-4d26-944b-766c800131a0','0986541237',0,0,NULL,1,0),('08dbcf75-23bf-4319-8ac3-601f76b2c8d2','ntanh123',NULL,'ntanh123@gmail.com','Nguyễn Thị Ánh','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590622/l07fmwze0baliwpy0xlf.png','NTANH123',NULL,0,'AQAAAAEAACcQAAAAEKupBvQfoD/K2NgU39CcrZSYYbOPlrzvyAlhsKU+CNIsptsxjoCDEHnNzccFRGD2jA==','JVFLWZMB5UOMOIWVWUZ4ZSLBFI2IKAOA','aeb90cc2-fb0e-42f9-b831-0907d4c54cf8','0982345671',0,0,NULL,1,0),('08dbcf75-3226-458a-81bb-3cf9ccb5e8d2','ntmai123',NULL,'ntmai123@gmail.com','Vũ Thị Mai','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590646/nwi2qzlndohjsyuwkprp.png','NTMAI123',NULL,0,'AQAAAAEAACcQAAAAEPNI9WKVv4SamJorL/mtUgbcLcT4S5x7Sx1XEYu9ipXXSQMGh3IBc+fyxyHgH4FXXg==','U63UFI6QK7QDINQBA4CKQXHNPYBFYGZ6','e90111f3-b631-466b-8262-eac576a041d4','0987654132',0,0,NULL,1,0),('08dbcf75-432e-4c35-8ebf-d8f50aa0fc74','pthanh123',NULL,'pthanh123@gmail.com','Phạm Thị Hạnh','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590674/i7l9fir3r2sdi8t9nr4g.png','PTHANH123',NULL,0,'AQAAAAEAACcQAAAAEBmfXYtWQ7fdNYZQSaSxTSiwJj5vhLgKOs3bWUrCVMTnvhlY9BOxmUe41cVjT0J0ow==','5Z3DXLFEYEBO5A7J5ACUCY7PHV7IP5CL','1a9bbda7-5104-4a1b-8556-8ef5ace669c5','0983478562',0,0,NULL,1,0),('08dbcf75-5101-44dd-8f89-5ac0606e3ab5','ntngoc123',NULL,'ntngoc123@gmail.com','Nguyễn Thị Ngọc','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590698/mric5qaeeswaxkayifxr.png','NTNGOC123',NULL,0,'AQAAAAEAACcQAAAAEKLSUt9AUlSe3S7p7aqzaoOeQd7PAzxe5kID1QLTJBo8daf9MhwCkwAfwUfjZ9jWuw==','4SHCWB4O4ODENG4VTB2B26LLANOSLRWQ','3b5916a6-cfd1-47f8-ae34-92881072b5e6','0983478562',0,0,NULL,1,0),('08dbcf75-6327-4602-85a9-158b59ac3138','ltan123',NULL,'ltan123@gmail.com','Lê Thị An','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590728/pmz8boudh5zelvnpq6vl.png','LTAN123',NULL,0,'AQAAAAEAACcQAAAAEGsXLh5eUpC/x9OQ6Coz7nxQhQgNtnr/T6En234wMvhD9qSPV6H3xsItidG3YIKMFQ==','UI5IU4NND4MQN6P6KXHARSVGT3U6FCDB','ff816017-ce81-48a4-be2c-b2bbd15c3e92','0985678432',0,0,NULL,1,0),('08dbcf75-7a63-408d-8b24-93273bed8827','tttrang123',NULL,'tttrang123@gmail.com','Trần Thị Trang','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590767/fk38qqtjzl4wdca6niyw.png','TTTRANG123',NULL,0,'AQAAAAEAACcQAAAAEFR+U9wFSyCg7acelKk+TOrfuGrpdQMRDilG3wVeiOqmSUeAYwZDioaK9AI1V5Hn/w==','4X5ZI23BMWH4SHSFIFPJ5QMD4DPGY6SG','a8765dc6-fa4a-46a1-a9fb-25724717dbd0','0983450671',0,0,NULL,1,0),('08dbcf75-a16d-4fe2-817d-b70df3a6b351','ltathu123',NULL,'ltathu123@gmail.com','Lê Thị Anh Thư','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590833/cpbsqsmaptw3oaj12pxb.png','LTATHU123',NULL,0,'AQAAAAEAACcQAAAAEDDd++mWEfkKKkwBa7h8yDLJnrm+gAnOlF5hPzVyuIV1bpBGap0GpKgmCPDsANt4cw==','3UKCD2CCYC5TZIOOHM5HGDEI5N3RPEPL','9905abc4-00f5-458f-9e70-23a0057d4f2f','0983450671',0,0,NULL,1,0),('08dbcf75-c4b7-45d6-8efd-89369d9e36d3','dthihanh123',NULL,'dthanh123@gmail.com','Đặng Thị Hạnh','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590892/iuh7xnsydw6eqvgnxjyr.png','DTHIHANH123',NULL,0,'AQAAAAEAACcQAAAAEPtXli1ElLolHB0p/iHn8JD6v29fWAv5jPx+yqB7ue2IhtVdGL0JcUAkXO4r596Idg==','SAR4IVDZGINGKEMIR2MBT2EHGY2Z6JBE','39351952-37d3-4d90-946e-33534447025c','0982356789',0,0,NULL,1,0),('08dbcf75-d54f-4c3e-81d9-877fb5a85b93','lthilan123',NULL,'lthilan123@gmail.com','Lý Thị Lan','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590920/avdbmzp7ninsj8jutfcc.png','LTHILAN123',NULL,0,'AQAAAAEAACcQAAAAEKgnCl5VmUbLl1TsOZS5okBEXgEtKo1TjhjNgocAVI2+5uKSpKWQcVnqkAd7+uJaag==','5PRSGHYYDFC724OOIH5VII5TMQSBSVU7','2962a596-c7ee-41d8-bcb6-8d2278145e4f','0986421537',0,0,NULL,1,0),('08dbcf75-e4f3-4c2f-87a5-87c446cf468a','pthithu123',NULL,'pthithu123@gmail.com','Phan Thị Thu','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590946/rgtfwb7hjjl1dgo6qusb.png','PTHITHU123',NULL,0,'AQAAAAEAACcQAAAAEMn/0+Vm9XCVohYpPPJD4rAfydyEg3sFc6IHjSaVHGElVYtWVAk2MZguXIePJmaq7g==','ONZ4N45CTCSZQGMVJYGHQVX4K644BKQO','29f6a1aa-c9f6-47c2-98c0-b4f5e44186f7','0986782314',0,0,NULL,1,0),('08dbcf75-f498-44ad-8acf-a776f1eada9d','nthinhung123',NULL,'nthinhung123@gmail.com','Nguyễn Thị Nhung','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697590972/bbfactbpgkwoywbbofqe.png','NTHINHUNG123',NULL,0,'AQAAAAEAACcQAAAAEJQt+hr4liKzvNy4YBMmytoV6iyQ5VTOxisLyXNXPkFyXAvG5u2Q1xKMA1oCgF23hQ==','HN67S5X6LNFSB5TYR6PY3L55K5R555CD','32da9034-2a6f-4961-b122-1a0edf98e42d','0985432167',0,0,NULL,1,0),('08dbcf76-0a36-4ff0-8bef-223619922599','lthihoa123',NULL,'lthihoa123@gmail.com','Lê Thị Hoa','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591008/kimykrjpw0dbzrdvjnbp.png','LTHIHOA123',NULL,0,'AQAAAAEAACcQAAAAEJ3CT3FW4baihfep/qo4Z+pW6apkJ5uQWqwxaBzzDCeLWVrFlNlh6bWpYgj8XCBwoQ==','B37NU4V6NAIG35YTMBARCFCWNPJATE44','89fc3305-e68b-43fd-8a21-ddc18cc28979','0982187654',0,0,NULL,1,0),('08dbcf76-1ac2-4363-8182-091391d3f1a4','pthibich123',NULL,'pthibich123@gmail.com','Phạm Thị Bích','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591036/nh9spaxztiiqdetuef2t.png','PTHIBICH123',NULL,0,'AQAAAAEAACcQAAAAEBtIfFHwAoPtL3ZjWuTuZuRxyVc/HdRuMFogwVS8PXOLTJ7ImJ+kEHbD2mLBWAjCUw==','D5ZCPMAEF2RCHHYQ2GZ5CPBVWAGCJLGQ','7301c47a-3a50-4d44-a8b5-b2eceb1b9692','0984447416',0,0,NULL,1,0),('08dbcf76-281b-4d6d-8272-837378aa0dd4','hthilan123',NULL,'hthilan123@gmail.com','Hoàng Thị Loan','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591059/tk0id0onfdd6yeuwtprb.png','HTHILAN123',NULL,0,'AQAAAAEAACcQAAAAEPK1VbLd2Kl7UTOSW7LT8CTe8d55FU3NBnFYL8DrowKrCLg318+oyIANrjSUMX9Nkw==','CKBJAGMZMPCPR6PPVBVCKEL4PI4RYDFC','8b0359e3-5945-461b-9b12-6c9b6727a60a','0984444427',0,0,NULL,1,0),('08dbcf76-3b2a-4bfc-8024-f04257511038','hthihong123',NULL,'hthihong123@gmail.com','Trần Thị Hồng','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591091/umy0m0hlilv4ngbhet9g.png','HTHIHONG123',NULL,0,'AQAAAAEAACcQAAAAEPchiivR/MuETY+iAE8McIOcCsuYHhwBdczH4vUeu5yc5zYYUneTs25LrN/SQ0lXLg==','RVFTMN7E4QPLLBV55O6LKKQKSIUBPXOH','128934a4-95eb-45ed-b92e-3ed58d351cba','0986541273',0,0,NULL,1,0),('08dbcf76-6038-4ae4-80d0-f3fc37a3546a','pthihong123',NULL,'pthihong123@gmail.com','Phạm Thị Hằng','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591153/tkwv7c9rjwo5tgi6s4ds.png','PTHIHONG123',NULL,0,'AQAAAAEAACcQAAAAEBJoGjORWUE10qIiy5zZtstpAW2VciYL8RP21gM77FIDd08LN5hw1hKcu1Iub8fWYw==','GPS7XOOMR5GMJHTUY3WLLBKVBPL4PLRO','10ed52cb-e8f3-4496-a9ad-410ee12d900b','0986541234',0,0,NULL,1,0),('08dbcf76-6d23-45e5-8956-b11f5f857ced','dtmaianh123',NULL,'dtmaianh123@gmail.com','Đinh Thị Mai Anh','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591174/atncedpcizqum0br5um1.png','DTMAIANH123',NULL,0,'AQAAAAEAACcQAAAAECv6p6phd2Cry4DOxefT7eJrdas0JDJY2knjZwPlFpRRtmsrqvssLOQYHnGC/vhPhQ==','AGOYF74ZDGXEMHQHZIXO6PIUHGE7BEVZ','c44d5838-6049-4611-a376-a24e9e2d234e','0984444313',0,0,NULL,1,0),('08dbcf76-7c65-47ff-8efa-52d1591c8e65','vthihong123',NULL,'vthihong123@gmail.com','Vũ Thị Hồng','2003-03-05','Hồ Chí Minh','Nữ','https://res.cloudinary.com/dkba7robk/image/upload/v1697591200/wpouc2sl6av15fzxyuvf.png','VTHIHONG123',NULL,0,'AQAAAAEAACcQAAAAEJO8MOYXPBGF6MlultLM0xUgH72GWm2ly++Ett2YdK2ZEF4zjZ37ZvSUd7WAB5AjDw==','DV7R7ZYDQUFCVH3CUF52QE7KQMAML2WP','d9356ecb-d0e8-4859-9479-a2998b2c2394','0982345670',0,0,NULL,1,0),('08dbcf76-b944-4847-82e1-a548c0a87f20','tvanhai123',NULL,'tvanhai123@gmail.com','Trần Văn Hải','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591302/jgc6jmhxemy9fqohynjc.png','TVANHAI123',NULL,0,'AQAAAAEAACcQAAAAEGl5gzddTMz7XhTs2gjz/XqLkZ3iuHDZjYrRU4waQto5E0So5Ghz6PRMA/USlKjfaw==','KJ772A7QQTYP6KHK232XXMYKM6JWFLDH','d6634337-4a1c-4ad3-8fc3-fd58d0ac92ea','0986219763',0,0,NULL,1,0),('08dbcf76-c887-4c5c-8de4-a1b6e9086b81','pvanhung123',NULL,'pvanhung123@gmail.com','Phạm Văn Hưng','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591328/wuzwcabbcelybzv50lo9.png','PVANHUNG123',NULL,0,'AQAAAAEAACcQAAAAEOdSPTS6f9c/yIAzXEoALPza0ogTlhcdjxWD/bY90JAwaMGjyPZBSXWKA5eD6ozJZg==','3T3EQ53TJDAUD47C2NI2UPZ2ACMCLCJF','1e1fb715-c524-432d-83d7-70d3d65d1543','0985432178',0,0,NULL,1,0),('08dbcf76-da97-4160-8232-8446ea4fd7c8','vminhduc123',NULL,'vminhduc123@gmail.com','Vũ Minh Đức','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591358/esxlpnqweppldzruqs16.png','VMINHDUC123',NULL,0,'AQAAAAEAACcQAAAAEBOr1J2vIYfw7imetT8olVBoJVSe5TK8HDgJOIqRrHVv0H5J8WNxqvX8Z4mOFB64jg==','TQZ5YJNRGKW2P6HVRLDML5GPFJJNOIZ7','681e9ef0-159e-41d1-8405-3bf239ba28f0','0986547213',0,0,NULL,1,0),('08dbcf76-ea04-4c1b-876e-65a8f89f3d9b','nvanhung123',NULL,'nvanhung123@gmail.com','Nguyễn Văn Hùng','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591384/kcen8iswz09lw9fgrwfl.png','NVANHUNG123',NULL,0,'AQAAAAEAACcQAAAAEK82NErku+Bs3kQKhIxi94VFnb20pNa2L8TQOh3ZYuoMH05Oo9V4XOonM8s80tnoyg==','YSBBEZLR6NQ23O54J25IHZVIOIEENU7X','53579b24-86e2-460e-bf42-3c487a395ba4','0982349156',0,0,NULL,1,0),('08dbcf76-ffdd-4157-80ff-e2d79250f6cb','lvantuan123',NULL,'lvantuan123@gmail.com','Lê Văn Tuấn','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591421/yqaaa0rff5qwrpaygb9y.png','LVANTUAN123',NULL,0,'AQAAAAEAACcQAAAAEGd5gNvKo3S50HLq96MF0XwL0H/U9fKuru3bXQwMj1razVLcdbeBH4kKlwFkykhoMw==','2FWCZXDJXGLDUNW3G35SF4JWRTGARCD6','e89bf672-e228-4d64-a3bb-c75f70f7274a','0984444312',0,0,NULL,1,0),('08dbcf77-13d8-4c89-89e8-096f4052699b','tthanhtung123',NULL,'tthanhtung123@gmail.com','Trần Thanh Tùng','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591454/mphtmpglnxpnjinphuuk.png','TTHANHTUNG123',NULL,0,'AQAAAAEAACcQAAAAEDdJz+NUR18M+SNTexIsY7Mix/jEFipLf4PwowOA8ldP9myPIMUHVbq2Cd+db66s9w==','4YK44KEIEJ6ODZBDYSYA5KS36YYDPFGL','9faee024-ae1e-4476-a11f-0f7902dcb6e8','0984562713',0,0,NULL,1,0),('08dbcf77-23c4-42c8-8811-ab4dec8db8c4','dvanduc123',NULL,'dvanduc123@gmail.com','Đinh Văn Đức','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591481/uotdonegzkfboyybsaeu.png','DVANDUC123',NULL,0,'AQAAAAEAACcQAAAAEJMQYeI0p1uJbmlR29xn7zRV1MF4v4Yk/LswUQU6Gw+8EsxZpnOa+qNx/15mFDK5pA==','Z4P24MN4HDB42XZCLK3QD2X5R43YWIAZ','8bf69d66-a832-48ba-a2c6-a44ec985033f','0985237641',0,0,NULL,1,0),('08dbcf77-301a-4029-80b4-527bf4bc468d','lvananh123',NULL,'lvananh123@gmail.com','Lê Văn Anh','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591501/epvs5oprudehzu4rkvyg.png','LVANANH123',NULL,0,'AQAAAAEAACcQAAAAEOCfDERgxsGu6JUYQJz1XnY32dRMLHBDM9fTzPfhw1aG9rbgaqd1CbttYSxFDAsyAg==','JOQDJ3U4DDXUTAIW6SFEUTU4NMYJPNTL','d526ae8d-d576-449b-89d0-36b5d1766106','0983216547',0,0,NULL,1,0),('08dbcf77-3e18-4597-8986-8b69e73635ca','tvanphuc123',NULL,'tvanphuc123@gmail.com','Trần Văn Phúc','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591525/fbhfnrsxslcaicwx8o0k.png','TVANPHUC123',NULL,0,'AQAAAAEAACcQAAAAEE4vJt528TkEiyLOevZCozAm+/d7feWFCE+5sYB0vxNB69W40i3ij8FQuxaoulzlJA==','SELZ32MX322RXUY7JFDXO2GVMZJ646MH','728b3c88-8a77-45dc-83fe-e69bcc71f2b7','0987644413',0,0,NULL,1,0),('08dbcf77-4d04-4359-8ee6-221590145177','nvannam123',NULL,'nvannam123@gmail.com','Nguyễn Văn Nam','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591550/txbjjb0nuinhvsmdql1i.png','NVANNAM123',NULL,0,'AQAAAAEAACcQAAAAEDvRYaqrugR7kMXYQFYTR9ovm7iwEJuSAun3ypFWQICR+07QQ8QZ7yvJqdlHigdkvQ==','JZNGRFI724IEX3X7DYOKXKOIIWTXPOVD','63c102e7-379e-4037-827d-c3523ae03560','0985678921',0,0,NULL,1,0),('08dbcf77-6f5a-405c-8712-52ed7e2ae808','pvanthanh123',NULL,'pvanthanh123@gmail.com','Phạm Văn Thành','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591608/zcjh5nbzorqc2vayeulk.png','PVANTHANH123',NULL,0,'AQAAAAEAACcQAAAAEMqw9pOiEqDX3WhyR/daIBkwfc8hZ2Wa5sPph6F/j0zsW2akGP3Ky6z06gNt1h5IFw==','WPOZHKQZB4VUPORGY2UYMHBFSDESJVEY','c1dea217-c814-427c-824b-a9a68d5b791d','0984567219',0,0,NULL,1,0),('08dbcf77-8f04-4081-8196-4893e4cbd641','hvantuan123',NULL,'hvantuan123@gmail.com','Hoàng Văn Tuấn','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591661/houribirpa1l2gbolxve.png','HVANTUAN123',NULL,0,'AQAAAAEAACcQAAAAELbQq3m3QMBW4PPhspbz6mucQQzi9E/56sS4HKrrONfPCb2x2jJE/iwzy+mwdsTmPg==','AGDC52RWTTVC2MYXIZB37RKWGUPIKRF4','8af41dda-7a53-4878-84ae-5dd153575c62','0987238156',0,0,NULL,1,0),('08dbcf77-c3a7-42c1-8b12-0ae06c4f2b99','tvanhai12345',NULL,'tvanhai12345@gmail.com','Trương Văn Hải','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591749/wmpyyk87lx1howlehvtc.png','TVANHAI12345',NULL,0,'AQAAAAEAACcQAAAAENz645oecVCs73xyAiW6M3LtQcefif4axX2XjgZ6yt/muQtZIxGBrOg4HZG9BLQ9iw==','ZYQWNRHCD4N6W6VJJC5E6PTKOILZYCTQ','9366871b-8502-4ff0-b5ea-cd2dcea59c1d','0984267315',0,0,NULL,1,0),('08dbcf77-e7d5-43aa-8da0-45661e8e4b16','nvantrung123',NULL,'nvantrung123@gmail.com','Nguyễn Văn Trung','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591810/ppzs9blglbjlkccdnxj1.png','NVANTRUNG123',NULL,0,'AQAAAAEAACcQAAAAEDrcJm/Xk4KRYGL4YPt5D53mN9fJeWuCBanKp+4mMqlqn6IOv51LC8XJShIu05Kzug==','UQNMUBHNJTOV7POLNPHIF2QX2PLCMFKA','e6ee6f80-98fc-425c-aa74-3c048849bd94','0982133456',0,0,NULL,1,0),('08dbcf77-f53f-4f79-817f-cfb754e59aed','vvanthang123',NULL,'vvanthang123@gmail.com','Võ Văn Thắng','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591832/dmxccbdlk64ogfh6fka3.png','VVANTHANG123',NULL,0,'AQAAAAEAACcQAAAAEJpdG5sc2ne/ME402q4vic2mJxrM1lMew7q9dsiJGLt475xb8wnITs3h+opdxW+vFw==','IVP7HJDBQEFLUJSFFEROINSYQ75JWXLS','718a7269-34c0-453e-9f17-612107b4fb8c','0987654123',0,0,NULL,1,0),('08dbcf78-0206-4d3b-8012-da6a2d662a6d','tvanduc123',NULL,'tvanduc123@gmail.com','Trần Văn Đức','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591854/qt9pthebprjgqfwoxbyt.png','TVANDUC123',NULL,0,'AQAAAAEAACcQAAAAEAfL7kc2MDXWvjfLd3MrMS/SCl+mtT3KXAvzqAew1R85H/XKSyltOYvMvJ2dB6/77Q==','FEIQFS5HEL5FEDKHEBT4VEKSIRDQ7WWL','875f7eba-5437-4293-aa16-67d11b38af7d','0983444462',0,0,NULL,1,0),('08dbcf78-0fbf-4779-8444-8a31761b08f7','nvantai123',NULL,'nvantai123@gmail.com','Nguyễn Văn Tài','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591877/auntocdxnguytgnhsiwk.png','NVANTAI123',NULL,0,'AQAAAAEAACcQAAAAEPLc1m97DRZzSTS2kKc3knuCeNGyPwcy4zmme8VxMRvDAA3d1/Fx6cxp0xfh2f2hXA==','YP5UMFVE2K5PJWSIM6QSZXKJRP2JWWKT','230e357b-98ef-4666-a44f-73dbd03cf1da','0984562731',0,0,NULL,1,0),('08dbcf78-1f3c-4298-8e36-a719637b9775','dvantung123',NULL,'dvantung123@gmail.com','Đào Văn Tùng','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591903/m1udvwhlj75a7tmrn4ba.png','DVANTUNG123',NULL,0,'AQAAAAEAACcQAAAAEHOXP8Xm632kF0KeWK1LvMII9p6n/krvEfAzaaUXTMewwbSwDjjAnPO2vR1H95ny5A==','UAOM5RYH4HUVHYD4W2Z5CBEAPCZN2SFB','7ab046f6-b0d0-4c11-8059-93ea4da1e6b1','0987654312',0,0,NULL,1,0),('08dbcf78-2e2d-428b-8311-f5604a061074','levanphu123',NULL,'levanphu123@gmail.com','Lê Văn Phú','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591928/mv7u8mrczhvdiuygprpk.png','LEVANPHU123',NULL,0,'AQAAAAEAACcQAAAAEHNQwMJ/6yqS3GnuwaYXLlhO3ZeFlhuemXTvNqgljI4JIJglCypialIdD5f4Sv4BpQ==','YYBDRRLQBXWGAUWJQOZHSJOX3D3DNS7U','919b6de3-f56f-45f8-9048-30f4c99fab7b','0983216475',0,0,NULL,1,0),('08dbcf78-3aae-452f-8cc9-eb84dc4436c4','tvanan12345',NULL,'tvanan12345@gmail.com','Trương Văn An','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591949/zlssv5acdreuddx3bq83.png','TVANAN12345',NULL,0,'AQAAAAEAACcQAAAAELmy2NiJBEKORp0/M9nNwsh2AYRjUP9ZY+wWRJ6ybP8HJIGBt343kqdkeyFAMQbsjw==','AZIZSU3XK4XPGWVA2HGI6B6YY4QUW7FM','4304e532-f27a-4d36-92f1-48633ac558a3','0983450672',0,0,NULL,1,0),('08dbcf78-48c9-48f2-823d-259d5d5679b7','nvandat123',NULL,'nvandat123@gmail.com','Nguyễn Văn Đạt','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591972/i3xy5v2spwtuohrq3pum.png','NVANDAT123',NULL,0,'AQAAAAEAACcQAAAAEAbXgA1d/CLdy1/Mr7/NflbXT9h07NzRfppH5Fv2Z9HRc+a64CPoflcloZyMGMiPiw==','LOFBIOVIYIU7RFOW4PCIROGFZHO63YJG','116af806-b195-4643-b3b3-4969bce8c233','0987654320',0,0,NULL,1,0),('08dbcf78-54a5-4913-8b4f-540b76cdea56','levannam123',NULL,'levannam123@gmail.com','Lê Văn Nam','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697591992/y5bpqb8hyyow5s24p8dh.png','LEVANNAM123',NULL,0,'AQAAAAEAACcQAAAAEObSw27NowUMLfQdP/M3DC4Wsz2Llzbea2DIpfm4Mr/LsSE5PeA491EGRyUTfQF2jw==','HPSJUUC5YWVP65LCJXHGMCR2U6BXVW43','1190819c-b2b1-41ce-bab8-9713a23e9b26','0986219761',0,0,NULL,1,0),('08dbcf78-6315-4fa9-871b-39464f54ca4e','tvanlong123',NULL,'tvanlong123@gmail.com','Trần Văn Long','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697592017/z7xccnbbvsxpvlfybq8x.png','TVANLONG123',NULL,0,'AQAAAAEAACcQAAAAENH5slVmRCw1H7mC8/aQODww/QJb42PbruwHQRgB9GDjikJNGSYPVhnrt44ed2A7cQ==','4QVCAIBUROJRVMNJ7OIW6GAP5ZGXFAPE','7ffd550c-830c-4584-8738-a2fee3d173a0','0983456789',0,0,NULL,1,0),('08dbcf78-7246-497c-8b7f-8dc6f40010c6','dvantuan123',NULL,'dvantuan123@gmail.com','Đỗ Văn Tuấn','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697592042/mg3gmk6vqdvuw7goih5z.png','DVANTUAN123',NULL,0,'AQAAAAEAACcQAAAAEGFs7J6R2EXJU6Ak0+7LjQIOF+TIq14C6sIkPSBt7PrOWIueoZFuKGO4KVSt/Y7i/Q==','B3YACISSHGP4RFUTNIPKOIQ3BBM7YWOF','72687721-e0fb-430c-8467-cc49fa4d16bc','0985678943',0,0,NULL,1,0),('08dbcf78-b70d-4f5d-8188-b6d0f245ed68','lvanphu123',NULL,'lvanphu123@gmail.com','Lý Văn Phú','2003-03-05','Hồ Chí Minh','Nam','https://res.cloudinary.com/dkba7robk/image/upload/v1697592158/wju4yb7tjoufli8bpym8.png','LVANPHU123',NULL,0,'AQAAAAEAACcQAAAAEDlssR0+6Ls063bPXEA9kCeRs9pqFA/FNjAhM2Zm0CQgufB1ZET7DzTuvLM73DNCkA==','N74GIELJKCKPHV4IALCAAZVPO5RYCFVN','f29adb59-b4f5-4b9a-b0ca-8717efb73c5d','0985678921',0,0,NULL,1,0);
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

-- Dump completed on 2023-10-18  8:53:54
