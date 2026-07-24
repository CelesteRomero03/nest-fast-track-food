-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: food_service_new
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `createdAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_8b0be371d28245da6e4f4b6187` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Pizzas','Todo tipo de pizzas',1,'2026-06-06 17:18:42.669919','2026-06-06 17:18:42.669919'),(2,'Empanadas','Empanadas salteñas',1,'2026-06-06 17:23:15.499815','2026-07-09 17:00:56.000000'),(3,'Hamburguesas','Hamburguesas artesanales',1,'2026-06-06 17:23:58.371788','2026-07-09 17:00:58.000000'),(5,'Bebidas','Bebidas en general Gaseosas, jugos y aguas',1,'2026-06-18 23:17:05.239029','2026-07-16 15:01:36.000000'),(6,'Postres','Helados, tortas y dulces',0,'2026-06-18 23:17:13.033573','2026-07-16 15:00:24.000000'),(7,'Tragos','Variedades de tragos frutales y tropicales',0,'2026-07-08 15:24:57.850411','2026-07-08 15:35:42.000000'),(9,'SUSHI','Comida Japonesa y Woks',1,'2026-07-16 15:03:24.040050','2026-07-16 15:03:24.040050'),(10,'Panchos','variedad de panchos',1,'2026-07-24 16:50:47.070735','2026-07-24 16:50:47.070735');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_modes`
--

DROP TABLE IF EXISTS `delivery_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_modes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mode` enum('delivery','take_away','dine_in') NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_c20040a29d4ecd2b3fb63060f2` (`mode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_modes`
--

LOCK TABLES `delivery_modes` WRITE;
/*!40000 ALTER TABLE `delivery_modes` DISABLE KEYS */;
INSERT INTO `delivery_modes` VALUES (1,'delivery',1),(2,'take_away',1),(3,'dine_in',1);
/*!40000 ALTER TABLE `delivery_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `productName` varchar(200) NOT NULL,
  `productDescription` text DEFAULT NULL,
  `unitPrice` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_f1d359a55923bb45b057fbdab0d` (`orderId`),
  KEY `FK_cdb99c05982d5191ac8465ac010` (`productId`),
  CONSTRAINT `FK_cdb99c05982d5191ac8465ac010` FOREIGN KEY (`productId`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_f1d359a55923bb45b057fbdab0d` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,2,17000.00,''),(2,1,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(3,2,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(4,2,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(5,3,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(6,3,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(7,4,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(8,4,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(9,5,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(10,5,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(11,6,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(12,6,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(14,7,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(17,8,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,2,19000.00,''),(18,8,2,'Hamburguesa doble','pan, carne y chedar',9500.00,2,19000.00,''),(19,7,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(20,9,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(21,9,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,2,19000.00,''),(22,10,2,'Hamburguesa doble','pan, carne y chedar',9500.00,2,19000.00,''),(23,11,4,'Pizza Fugazzeta','Muzzarella y cebolla',10000.00,1,10000.00,''),(24,11,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(25,11,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(26,12,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(27,12,5,'Empanada de Carne','Empanada salteña tradicional',1200.00,1,1200.00,''),(28,13,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(29,13,7,'Hamburguesa Clásica','Carne, lechuga y tomate',7500.00,1,7500.00,''),(30,14,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(31,15,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(32,16,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(33,17,3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,1,9500.00,''),(34,18,4,'Pizza Fugazzeta','Muzzarella y cebolla',10000.00,1,10000.00,''),(35,19,33,'Agua mineral','Agua sin gas',1500.00,2,3000.00,''),(36,19,30,'Hamburguesa americana','doble carne, cheddar y cebolla',10000.00,1,10000.00,''),(37,20,27,'Empanada de carne','carne picada a cuchillo',1500.00,1,1500.00,''),(38,20,36,'Cerveza SCHNEIDER','CERVEZA SCHNEIDER LATA 710cc',2500.00,1,2500.00,''),(39,21,1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,1,8500.00,''),(40,22,27,'Empanada de carne','carne picada a cuchillo',1500.00,1,1500.00,''),(41,23,33,'Agua mineral','Agua sin gas',1500.00,1,1500.00,''),(42,24,27,'Empanada de carne','carne picada a cuchillo',1500.00,2,3000.00,''),(43,24,33,'Agua mineral','Agua sin gas',1500.00,1,1500.00,''),(44,25,40,'cono pizza','queso y jamon',4000.00,2,8000.00,''),(45,26,35,'Cerveza corona','Cerveza Corona x 710 ml',4500.00,2,9000.00,''),(64,26,33,'Agua mineral','Agua sin gas',1500.00,1,1500.00,''),(65,16,33,'Agua mineral','Agua sin gas',1500.00,2,3000.00,''),(66,23,17,'Hamburguesa BBQ','Carne, queso y salsa barbacoa',9800.00,2,19600.00,''),(67,27,33,'Agua mineral','Agua sin gas',1500.00,1,1500.00,''),(68,28,27,'Empanada de carne','carne picada a cuchillo',1500.00,1,1500.00,''),(69,28,23,'Fanta 1.5L','Gaseosa sabor naranja',2500.00,1,2500.00,''),(70,29,42,'hamburguesa Halloween','doble carne cheddar ,cebolla morada y lechuga',9000.00,1,9000.00,''),(71,29,18,'Limonada Natural','Limonada fresca con hielo',2800.00,1,2800.00,''),(72,30,32,'Coca Cola 1.5L','Gaseosa sabor coca cola',2500.00,1,2500.00,''),(73,31,27,'Empanada de carne','carne picada a cuchillo',1500.00,1,1500.00,''),(74,32,40,'Cono pizza','queso y jamon o salame',4000.00,1,4000.00,''),(75,32,2,'Hamburguesa doble','pan, carne y chedar',9500.00,1,9500.00,''),(76,33,35,'Cerveza corona','Cerveza Corona x 710 ml',4500.00,1,4500.00,'');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status_history`
--

DROP TABLE IF EXISTS `order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `fromStatus` enum('pending','confirmed','preparing','ready','out_for_delivery','completed','cancelled','rejected') DEFAULT NULL,
  `toStatus` enum('pending','confirmed','preparing','ready','out_for_delivery','completed','cancelled','rejected') NOT NULL,
  `changedBy` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `changedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  PRIMARY KEY (`id`),
  KEY `FK_689db3835e5550e68d26ca32676` (`orderId`),
  KEY `FK_e8c23988e2e618bbff2b4b43a59` (`changedBy`),
  CONSTRAINT `FK_689db3835e5550e68d26ca32676` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_e8c23988e2e618bbff2b4b43a59` FOREIGN KEY (`changedBy`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status_history`
--

LOCK TABLES `order_status_history` WRITE;
/*!40000 ALTER TABLE `order_status_history` DISABLE KEYS */;
INSERT INTO `order_status_history` VALUES (1,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 15:22:56.088026'),(2,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 15:29:53.275484'),(3,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 15:43:07.857796'),(4,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 15:45:41.402642'),(5,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 15:49:15.839699'),(6,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 15:51:11.595687'),(7,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 15:51:11.613035'),(8,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 16:07:54.189587'),(9,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 16:07:54.202266'),(10,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 16:30:35.250079'),(11,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 16:48:19.050474'),(12,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 16:48:19.070060'),(13,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 17:36:38.093408'),(14,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 17:36:38.113314'),(15,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 17:38:47.468637'),(16,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 17:38:47.486037'),(17,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 17:39:03.900716'),(18,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 17:39:03.915346'),(19,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 18:27:41.377052'),(20,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 18:27:41.414029'),(21,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 18:33:18.344994'),(22,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 18:33:18.387883'),(23,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 18:39:20.507138'),(24,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 18:39:48.493515'),(25,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 18:39:48.537458'),(26,25,'pending','pending',1,'Se agregaron 2 producto(s) al pedido',NULL,'2026-07-16 18:49:10.443447'),(27,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 18:56:58.086743'),(28,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 18:56:58.135439'),(29,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 18:58:10.199032'),(30,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 18:58:10.253139'),(31,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 19:01:11.787345'),(32,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 19:01:11.835096'),(33,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 19:01:20.587692'),(34,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 19:01:20.625841'),(35,26,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 19:34:10.849887'),(36,26,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 19:34:10.903198'),(37,26,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 19:34:18.110484'),(38,26,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 19:34:18.144740'),(39,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 19:45:03.613638'),(40,25,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 19:45:03.658768'),(41,26,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:33:35.210647'),(42,26,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 20:33:35.262609'),(43,26,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:33:39.360292'),(44,26,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 20:33:39.390811'),(45,26,'pending','pending',1,'Se modificaron cantidades de 2 producto(s)',NULL,'2026-07-16 20:34:57.436181'),(46,26,'pending','pending',1,'Se modificaron cantidades de 2 producto(s)',NULL,'2026-07-16 20:34:59.878157'),(47,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:40:16.178095'),(48,25,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:40:21.793825'),(49,16,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:41:07.226968'),(50,16,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 20:41:07.266299'),(51,16,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:41:09.904517'),(52,16,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 20:41:09.930448'),(53,7,'pending','pending',1,'Se modificaron cantidades de 2 producto(s)',NULL,'2026-07-16 20:42:14.552394'),(54,7,'pending','pending',1,'Se modificaron cantidades de 2 producto(s)',NULL,'2026-07-16 20:42:16.756137'),(55,24,'pending','pending',1,'Se modificaron cantidades de 2 producto(s)',NULL,'2026-07-16 20:42:50.837847'),(56,24,'pending','pending',1,'Se modificaron cantidades de 2 producto(s)',NULL,'2026-07-16 20:42:52.642057'),(57,23,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:43:27.441783'),(58,23,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 20:43:27.477195'),(59,23,'pending','pending',1,'Se modificaron cantidades de 1 producto(s)',NULL,'2026-07-16 20:43:29.425062'),(60,23,'pending','pending',1,'Se agregaron 1 producto(s) al pedido',NULL,'2026-07-16 20:43:29.453717'),(61,27,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-16 21:38:27.626483'),(62,28,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-16 21:43:01.817231'),(63,29,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-16 22:12:33.417860'),(64,30,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-16 22:15:11.646690'),(65,31,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-24 16:26:34.332612'),(66,30,'pending','confirmed',1,'Estado cambiado a confirmed',NULL,'2026-07-24 16:52:28.178019'),(67,30,'confirmed','preparing',1,'Estado cambiado a preparing',NULL,'2026-07-24 16:52:31.387351'),(68,30,'preparing','ready',1,'Estado cambiado a ready',NULL,'2026-07-24 16:53:21.800232'),(69,30,'ready','completed',1,'Estado cambiado a completed',NULL,'2026-07-24 16:53:26.240868'),(70,32,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-24 16:58:54.881385'),(71,33,NULL,'pending',NULL,'Pedido creado por el cliente',NULL,'2026-07-24 18:18:55.945206'),(72,33,'pending','confirmed',1,'Estado cambiado a confirmed',NULL,'2026-07-24 18:22:01.842216'),(73,33,'confirmed','preparing',1,'Estado cambiado a preparing',NULL,'2026-07-24 18:22:02.968774'),(74,33,'preparing','ready',1,'Estado cambiado a ready',NULL,'2026-07-24 18:22:09.695968'),(75,33,'ready','out_for_delivery',1,'Estado cambiado a out_for_delivery',NULL,'2026-07-24 18:22:14.687867'),(76,33,'out_for_delivery','completed',1,'Estado cambiado a completed',NULL,'2026-07-24 18:22:19.343985');
/*!40000 ALTER TABLE `order_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderNumber` varchar(20) NOT NULL,
  `status` enum('pending','confirmed','preparing','ready','out_for_delivery','completed','cancelled','rejected') NOT NULL DEFAULT 'pending',
  `deliveryMode` enum('delivery','take_away','dine_in') NOT NULL,
  `customerName` varchar(100) NOT NULL,
  `customerLastName` varchar(100) NOT NULL,
  `customerEmail` varchar(150) DEFAULT NULL,
  `customerPhone` varchar(20) DEFAULT NULL,
  `deliveryAddress` text DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `deliveryCost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `notes` text DEFAULT NULL,
  `estimatedPreparationTime` int(11) DEFAULT NULL,
  `estimatedDeliveryTime` int(11) DEFAULT NULL,
  `totalEstimatedTime` int(11) DEFAULT NULL,
  `confirmedAt` datetime DEFAULT NULL,
  `preparingAt` datetime DEFAULT NULL,
  `readyAt` datetime DEFAULT NULL,
  `outForDeliveryAt` datetime DEFAULT NULL,
  `completedAt` datetime DEFAULT NULL,
  `cancelledAt` datetime DEFAULT NULL,
  `rejectedAt` datetime DEFAULT NULL,
  `cancellationReason` text DEFAULT NULL,
  `rejectionReason` text DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `lastModifiedBy` int(11) DEFAULT NULL,
  `deliveryPersonId` int(11) DEFAULT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_59b0c3b34ea0fa5562342f2414` (`orderNumber`),
  KEY `FK_8d17fd47a7bbf512e58209fbb38` (`createdBy`),
  KEY `FK_390af95a9c53b3af5f8123ecaa8` (`lastModifiedBy`),
  CONSTRAINT `FK_390af95a9c53b3af5f8123ecaa8` FOREIGN KEY (`lastModifiedBy`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_8d17fd47a7bbf512e58209fbb38` FOREIGN KEY (`createdBy`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'ORD-260618-233628895','completed','delivery','Juan','Perez','juan@test.com','123456789','Calle Falsa 123',26500.00,0.00,265000.00,'Entregar después de las 19hs',25,15,40,'2026-06-19 16:10:08','2026-06-19 16:13:11','2026-06-19 16:14:56','2026-06-19 16:17:57','2026-06-19 16:19:28',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-18 23:36:28.744694','2026-06-19 16:19:28.000000'),(2,'ORD-260619-165649182','pending','delivery','Diego','Paz','diego@test.com','123456897','Calle Falsa 123',18000.00,0.00,180000.00,'Entregar después de las 19hs',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-19 16:56:49.691223','2026-06-19 16:56:49.000000'),(3,'ORD-260619-165805724','confirmed','delivery','Diego','Paz','diego@test.com','123456897','Calle Falsa 123',18000.00,0.00,180000.00,'Entregar después de las 19hs',20,30,50,'2026-06-19 16:58:58',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-19 16:58:05.835330','2026-06-19 16:58:58.000000'),(4,'ORD-260619-170429879','rejected','delivery','Aye','Paz','aye@test.com','123456897','Calle Falsa 123',18000.00,0.00,180000.00,'Entregar después de las 19hs',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-19 17:04:47',NULL,'Producto no disponible',NULL,1,NULL,'2026-06-19 17:04:29.702657','2026-06-19 17:04:47.000000'),(5,'ORD-260619-181206559','cancelled','delivery','Ser','Colon','ser@test.com','123456897','Calle Falsa 123',18000.00,0.00,180000.00,'Entregar después de las 19hs',20,30,50,NULL,NULL,NULL,NULL,NULL,'2026-06-19 18:12:22',NULL,'Cliente solicitó cancelación',NULL,NULL,1,NULL,'2026-06-19 18:12:06.455154','2026-06-19 18:12:22.000000'),(6,'ORD-260619-181400984','pending','delivery','Eze','Falcon','eze@test.com','123456897','Calle Falsa 123',19000.00,0.00,190000.00,'Entregar después de las 19hs',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-19 18:14:00.310124','2026-06-19 18:14:00.000000'),(7,'ORD-260619-181613626','pending','delivery','facu','Falcon','eze@test.com','123456897','Calle Falsa 123',19000.00,0.00,19000.00,'Entregar después de las 19hs',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-19 18:16:13.749895','2026-07-16 20:42:16.000000'),(8,'ORD-260619-182330117','pending','delivery','mora','Falcon','mora@test.com','123456897','Calle Falsa 123',38000.00,0.00,380000.00,'Entregar después de las 19hs',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-19 18:23:30.290799','2026-06-19 18:23:30.000000'),(9,'ORD-260619-183703710','pending','take_away','Maria','Gomez',NULL,'987654321',NULL,27500.00,0.00,275000.00,NULL,20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-19 18:37:03.171338','2026-06-19 18:37:03.000000'),(10,'ORD-260619-211630530','confirmed','dine_in','Carlos','Lopez',NULL,NULL,NULL,19000.00,0.00,190000.00,'Mesa 5',20,0,20,'2026-07-01 16:40:52',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-19 21:16:30.103174','2026-07-01 16:40:52.000000'),(11,'ORD-260624-182708530','pending','delivery','celeste','Roemro','cel@gmail.com','123456','barrio la merced',28000.00,0.00,280000.00,'',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-24 18:27:08.168990','2026-06-24 18:27:08.000000'),(12,'ORD-260624-191527161','pending','take_away','pablo','facundo','fa@gmail.com','34678','',10700.00,0.00,107000.00,'',20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-24 19:15:27.404402','2026-06-24 19:15:27.000000'),(13,'ORD-260624-193415295','pending','delivery','emi','perez','emi@gmail.com','6798','santa rosa 455',17000.00,0.00,170000.00,'',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-24 19:34:15.628052','2026-06-24 19:34:15.000000'),(14,'ORD-260624-193803694','pending','delivery','pepe','falcon','pe@gmail.com','5678','belgrano',9500.00,0.00,95000.00,'',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-24 19:38:03.852828','2026-06-24 19:38:03.000000'),(15,'ORD-260624-194301492','preparing','take_away','leila','perez','le@gmail.com','6578','',9500.00,0.00,95000.00,'',20,0,20,'2026-07-14 16:42:18','2026-07-14 16:42:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-24 19:43:01.839191','2026-07-14 16:42:40.000000'),(16,'ORD-260624-201001779','pending','delivery','lau','jimenez','la@gmail.com','97854','albornoz',11000.00,0.00,11000.00,'',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-24 20:10:01.187022','2026-07-16 20:41:09.000000'),(17,'ORD-260624-201001897','preparing','delivery','lau','jimenez','la@gmail.com','97854','albornoz',9500.00,0.00,95000.00,'',20,30,50,'2026-07-01 17:33:03','2026-07-01 17:33:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-24 20:10:01.205010','2026-07-01 17:33:06.000000'),(18,'ORD-260624-202113166','completed','dine_in','mica','perez','emi@gmail.com','213455','',10000.00,0.00,100000.00,'',20,0,20,'2026-07-01 16:03:07','2026-07-01 16:03:15','2026-07-01 16:03:24',NULL,'2026-07-01 16:03:47',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-24 20:21:13.751648','2026-07-01 16:03:47.000000'),(19,'ORD-260625-160955798','cancelled','dine_in','joel','lago','jo@gmail.com','45678','',13000.00,0.00,130000.00,'haburg sin cebolla',20,0,20,NULL,NULL,NULL,NULL,NULL,'2026-07-01 15:55:12',NULL,'demora tiempo',NULL,NULL,1,NULL,'2026-06-25 16:09:55.595296','2026-07-01 15:55:12.000000'),(20,'ORD-260625-172530035','completed','take_away','pepe','perez','pepe@gmail.com','9876','',4000.00,0.00,40000.00,'',20,0,20,'2026-07-01 15:36:25','2026-07-01 15:36:27','2026-07-01 15:36:40',NULL,'2026-07-01 15:36:42',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-25 17:25:30.074881','2026-07-01 15:36:42.000000'),(21,'ORD-260629-165353075','cancelled','delivery','felix','Falcon','felix@test.com','123456897','Calle Falsa 123',8500.00,0.00,85000.00,'Entregar después de las 19hs',20,30,50,'2026-06-30 20:09:54','2026-06-30 20:09:58',NULL,NULL,NULL,'2026-07-01 15:52:47',NULL,'demora',NULL,NULL,1,NULL,'2026-06-29 16:53:53.580362','2026-07-01 15:52:47.000000'),(22,'ORD-260629-233930008','completed','delivery','pedro','Perez','pedro@gmail.com','12345','las maderas',1500.00,0.00,15000.00,'',20,30,50,'2026-06-30 18:32:50','2026-06-30 19:58:46','2026-06-30 19:58:54','2026-06-30 20:07:16','2026-06-30 20:07:17',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-06-29 23:39:30.756531','2026-06-30 20:07:17.000000'),(23,'ORD-260702-194942978','pending','dine_in','martina','Perez','marti@gmail.com','968574','',11300.00,0.00,11300.00,'',20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-07-02 19:49:42.566176','2026-07-16 20:43:29.000000'),(24,'ORD-260702-195359581','pending','dine_in','fernando','palacios','fer@email.com','456733','',4500.00,0.00,4500.00,'',20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-07-02 19:53:59.940778','2026-07-16 20:42:52.000000'),(25,'ORD-260702-195833192','pending','take_away','ailen','Rodriguez','ailen@gmail.com','234567','',8000.00,0.00,8000.00,'',20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-07-02 19:58:33.097723','2026-07-16 20:40:21.000000'),(26,'ORD-260713-190015820','pending','take_away','lorenzo','Perez','loren@gmail.com','38867896','',10500.00,0.00,10500.00,'',20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-07-13 19:00:15.413679','2026-07-16 20:34:59.000000'),(27,'ORD-260716-213827264','pending','dine_in','kike','cari','kike@gmail.com','3888456932',NULL,1500.00,0.00,1500.00,NULL,20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-16 21:38:27.546358','2026-07-16 21:38:27.000000'),(28,'ORD-260716-214301045','pending','take_away','soledad','manzano','sole@gmail.com','3888956874',NULL,4000.00,0.00,4000.00,NULL,20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-16 21:43:01.770840','2026-07-16 21:43:01.000000'),(29,'ORD-260716-221233629','pending','delivery','fausto','Lopez','fa@gmail.com','3888123456','calle sarmiento 567',11800.00,0.00,11800.00,NULL,20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-16 22:12:33.358595','2026-07-16 22:12:33.000000'),(30,'ORD-260716-221511438','completed','take_away','carolina','Serda','caro@gmail.com','3888906785','',2500.00,0.00,2500.00,'',20,0,20,'2026-07-24 16:52:28','2026-07-24 16:52:31','2026-07-24 16:53:21',NULL,'2026-07-24 16:53:26',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-07-16 22:15:11.604631','2026-07-24 16:53:26.000000'),(31,'ORD-260724-162634489','pending','delivery','pedro','Lopez','pedro@gmail.com','3888456787','barrio las maderas 455',1500.00,0.00,1500.00,'',20,30,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-24 16:26:34.062094','2026-07-24 16:26:34.000000'),(32,'ORD-260724-165854548','pending','dine_in','vanesa','lopez','vane@gmail.com','3884567328','',13500.00,0.00,13500.00,NULL,20,0,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-24 16:58:54.637039','2026-07-24 16:58:54.000000'),(33,'ORD-260724-181855790','completed','delivery','pablo','rodriguez','pablo@gmail.com','388845678','la merced 455',4500.00,0.00,4500.00,'',20,30,50,'2026-07-24 18:22:01','2026-07-24 18:22:02','2026-07-24 18:22:09','2026-07-24 18:22:14','2026-07-24 18:22:19',NULL,NULL,NULL,NULL,NULL,1,NULL,'2026-07-24 18:18:55.733073','2026-07-24 18:22:19.000000');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `isAvailable` tinyint(4) NOT NULL DEFAULT 1,
  `stock` int(11) NOT NULL DEFAULT 0,
  `categoryId` int(11) NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  PRIMARY KEY (`id`),
  KEY `FK_ff56834e735fa78a15d0cf21926` (`categoryId`),
  CONSTRAINT `FK_ff56834e735fa78a15d0cf21926` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Pizza Margherita','Muzzarella, tomate y albahaca',8500.00,NULL,1,4,1,'2026-06-06 17:26:02.670868','2026-07-09 17:02:14.000000'),(2,'Hamburguesa doble','pan, carne y chedar',9500.00,NULL,1,0,2,'2026-06-18 23:10:15.639365','2026-07-24 16:58:54.000000'),(3,'Pizza Napolitana','Muzzarella, tomate y ajo',9500.00,NULL,1,6,1,'2026-06-18 23:32:53.942923','2026-07-16 20:42:14.000000'),(4,'Pizza Fugazzeta','Muzzarella y cebolla',10000.00,NULL,1,4,1,'2026-06-18 23:33:18.043951','2026-07-16 18:49:10.000000'),(5,'Empanada de Carne','Empanada salteña tradicional',1200.00,NULL,1,48,2,'2026-06-18 23:33:39.938100','2026-07-16 18:39:48.000000'),(7,'Hamburguesa Clásica','Carne, lechuga y tomate',7500.00,NULL,0,19,3,'2026-06-18 23:34:09.828609','2026-06-29 16:39:57.000000'),(13,'Pizza Pepperoni','Muzzarella y pepperoni',11000.00,'https://images.unsplash.com/photo-1628840042765-356cda07504e',1,20,1,'2026-06-24 23:08:57.654028','2026-06-24 23:08:57.654028'),(14,'Pizza Cuatro Quesos','Mozzarella, parmesano, roquefort y provolone',12000.00,'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',1,20,1,'2026-06-24 23:09:10.070717','2026-06-24 23:09:10.070717'),(16,'Hamburguesa Bacon','Doble carne, cheddar y panceta',10500.00,'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',1,15,3,'2026-06-24 23:09:54.265909','2026-06-24 23:09:54.265909'),(17,'Hamburguesa BBQ','Carne, queso y salsa barbacoa',9800.00,'https://images.unsplash.com/photo-1550547660-d9450f859349',1,13,3,'2026-06-24 23:10:03.621286','2026-07-16 20:43:29.000000'),(18,'Limonada Natural','Limonada fresca con hielo',2800.00,'https://images.unsplash.com/photo-1621263764928-df1444c5e859',1,29,5,'2026-06-24 23:10:19.249144','2026-07-16 22:12:33.000000'),(19,'Brownie con Helado','Brownie tibio con helado de vainilla',5500.00,'https://images.unsplash.com/photo-1606313564200-e75d5e30476c',0,15,6,'2026-06-24 23:10:26.849841','2026-07-09 17:11:09.000000'),(22,'Tiramisú','Postre italiano clásico',5800.00,'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9',1,15,6,'2026-06-24 23:35:29.329751','2026-06-24 23:35:29.329751'),(23,'Fanta 1.5L','Gaseosa sabor naranja',2500.00,'https://images.unsplash.com/photo-1624517452488-04869289c4ca',1,27,5,'2026-06-24 23:35:58.329780','2026-07-16 21:43:01.000000'),(24,'Pizza Especial','Queso, jamon, huevo y aceituna',12000.00,'https://cdn.pedix.app/Acj0eQITEQSB6cVtflUj/products/kInSZPbQRt5lXjGMQCoQb.png?size=800x800',1,20,1,'2026-06-24 23:46:36.245059','2026-06-24 23:46:36.245059'),(25,'Pizza Fugazzeta','Queso, cebolla y aceituna',10000.00,'https://cloverbar.com.ar/app/public/media/item/item-217.webp',1,15,1,'2026-06-24 23:50:13.217644','2026-06-24 23:50:13.217644'),(26,'Empanada de Pollo','Pollo',1400.00,'https://alicante.com.ar/wp-content/uploads/2022/06/iStock-1437638745-Empanadas-de-pollo-scaled.jpg',1,30,2,'2026-06-24 23:52:19.054509','2026-06-24 23:52:19.054509'),(27,'Empanada de carne','carne picada a cuchillo',1500.00,'https://i0.wp.com/lasuperiora.com.ar/wp-content/uploads/2024/05/recetas-empanadascarne.jpg?fit=1000%2C868&ssl=1',1,24,2,'2026-06-24 23:53:24.822135','2026-07-24 16:26:34.000000'),(28,'Empanada de jamon y queso','jamon y queso',1500.00,'https://marvinbaptista.com/storage/recipes/empanadas-de-jamon-y-queso-opt.jpg',1,30,2,'2026-06-24 23:55:57.178236','2026-06-24 23:55:57.178236'),(30,'Hamburguesa americana','doble carne, cheddar y cebolla',10000.00,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnnMpr_fVn_lYCWJhIHEF7IO43KiJAZfzAjg&s',1,12,3,'2026-06-25 00:00:07.384385','2026-07-01 15:55:12.000000'),(31,'Hamburguesa Smash','doble carne, cheddar, morron y bacon',11000.00,'https://www.carniceriademadrid.es/wp-content/uploads/2022/09/smash-burger-que-es.jpg',1,8,3,'2026-06-25 00:02:35.029217','2026-06-25 00:02:35.029217'),(32,'Coca Cola 1.5L','Gaseosa sabor coca cola',2500.00,'https://file.adomicil.io/carlsjr.adomicil.io/_files/images/product/divisiones10bebidas-0303702460277687.jpg',1,19,5,'2026-06-25 00:04:05.517571','2026-07-16 22:15:11.000000'),(33,'Agua mineral','Agua sin gas',1500.00,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb3w0Zx82uYXfPVo7037yd5dOgPiVk32YXSw&s',0,2,5,'2026-06-25 00:08:11.386985','2026-07-16 21:38:27.000000'),(34,'Trago frutal','trago de sandia',3500.00,'https://soloporgusto.com/wp-content/uploads/2018/02/IMG_0038.jpg',1,10,5,'2026-06-25 00:09:33.188432','2026-06-25 00:09:33.188432'),(35,'Cerveza corona','Cerveza Corona x 710 ml',4500.00,'https://acdn-us.mitiendanube.com/stores/001/211/660/products/corona-7101-9a2faa7ea9b4adc38d16196380770669-480-0.webp',1,6,5,'2026-06-25 00:11:34.428628','2026-07-24 18:18:55.000000'),(36,'Cerveza SCHNEIDER','CERVEZA SCHNEIDER LATA 710cc',2500.00,'https://www.californiasa.com.ar/wp-content/uploads/2025/06/7793147570606-600x450.jpg?x44201',1,15,5,'2026-06-25 00:13:10.597914','2026-06-29 14:49:04.000000'),(37,'Pizza Comun','queso,oregano y aceituna',8000.00,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQroE-lKZ4uOIpQVCSFwwOLHGEieMqW5L4gUw&s',1,8,1,'2026-06-25 00:16:48.113684','2026-07-16 19:34:18.000000'),(39,'Pizza al ajo','queso,ajo y tomate',10000.00,'https://www.laespanolaaceites.com/recetas/pizza-al-ajo-con-tomates-frescos/',1,15,1,'2026-06-27 18:23:01.613108','2026-07-16 14:55:29.000000'),(40,'Cono pizza','queso y jamon o salame',4000.00,'/imagenComidas/conoPizza.avif',1,9,1,'2026-06-27 23:23:23.713035','2026-07-24 16:58:54.000000'),(41,'Pizzetas','pizzetas veggie ,salsa,tomate cuadritos y zapallito',1500.00,'/imagenComidas/miniPizzasVegie.jpg',1,20,1,'2026-06-29 21:51:46.186565','2026-06-29 21:51:46.186565'),(42,'hamburguesa Halloween','doble carne cheddar ,cebolla morada y lechuga',9000.00,'/imagenComidas/hamburBlack.webp',1,9,3,'2026-07-16 14:58:48.120786','2026-07-16 22:12:33.000000'),(43,'hamburguesa de pollo','pollo,lechuga y tomate',5500.00,'/imagenComidas/hamburPollo.webp',1,9,3,'2026-07-24 16:44:40.207861','2026-07-24 16:44:40.207861');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','employee') NOT NULL DEFAULT 'employee',
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `emailVerified` tinyint(4) NOT NULL DEFAULT 0,
  `emailVerificationToken` varchar(255) DEFAULT NULL,
  `emailVerificationExpires` timestamp NULL DEFAULT NULL,
  `passwordResetToken` varchar(255) DEFAULT NULL,
  `passwordResetExpires` timestamp NULL DEFAULT NULL,
  `lastLoginAt` datetime DEFAULT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_97672ac88f789774dd47f7c8be` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Juan Carlos','Perez Rodriguez','ayelen.celeste03@gmail.com','$2b$10$1fmT6w5FEpitKF0/qoIM/u5zmUH9sQeS9kHg8yZG4PlIvzZojpxaa','admin',1,0,NULL,NULL,NULL,NULL,'2026-07-24 18:20:30','2026-06-06 18:33:40.074475','2026-07-24 18:20:30.000000'),(3,'Carlos','Lopez','carlos@test.com','$2b$10$/BR/CAbwcHiWCohcLProMed4fN4Ibyd8RWYlg4kLWkxayTxN7Ltza','employee',1,1,NULL,NULL,NULL,NULL,'2026-06-18 20:48:41','2026-06-18 20:08:56.769812','2026-06-18 20:48:41.000000'),(4,'Pedro','Lopez','pedro@test.com','$2b$10$lzDQJwcK/k8UTHfu1aKSSOMnO6sru90J3w.tu9raFIBslnjDFs0oy','employee',1,0,'95ba4cf6e03c3d67f604176551b636e8eacb3829de074f47cb38cd96658b3a78',NULL,NULL,NULL,NULL,'2026-06-18 20:20:04.558920','2026-06-18 20:20:04.558920'),(5,'Francisco','Perez','fran15@gmail.com','$2b$10$lJjkdJsryOK9517F9UJ4zO2Ht3eSmcMvZLuce.kgClwN/h23uy0ZS','employee',0,0,'737f22e7c5b6d080b70b101a064fec1fbe147d411ddf106e83a3e56632963032','2026-07-10 21:02:41',NULL,NULL,NULL,'2026-07-09 18:02:41.864588','2026-07-09 18:43:20.000000'),(7,'Monica Maria','Fernandez','moni50@gmail.com','$2b$10$a3/XHuqWEBH.kYE8BPX3Wu0NEWK1uAZ2hnGVV9.GQIAR/LeB.BqnO','employee',1,0,NULL,NULL,NULL,NULL,NULL,'2026-07-09 21:10:33.264383','2026-07-09 21:11:21.000000');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'food_service_new'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-24 18:46:17
