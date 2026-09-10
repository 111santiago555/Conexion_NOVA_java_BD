-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: novamarket
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `adminn`
--

DROP TABLE IF EXISTS `adminn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminn` (
  `IdAdmin` int NOT NULL AUTO_INCREMENT,
  `Password` varchar(150) NOT NULL,
  `NombreAdmin` varchar(250) NOT NULL,
  `IdentificacionAdmin` varchar(20) DEFAULT NULL,
  `Rol` varchar(50) NOT NULL,
  PRIMARY KEY (`IdAdmin`),
  UNIQUE KEY `IdentificacionAdmin` (`IdentificacionAdmin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminn`
--

LOCK TABLES `adminn` WRITE;
/*!40000 ALTER TABLE `adminn` DISABLE KEYS */;
INSERT INTO `adminn` VALUES (1,'12345','Orlando','14874625','SUPER ADMIN');
/*!40000 ALTER TABLE `adminn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallepedido`
--

DROP TABLE IF EXISTS `detallepedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallepedido` (
  `IdDetalle` int NOT NULL AUTO_INCREMENT,
  `IdPedido` int NOT NULL,
  `IdProducto` int NOT NULL,
  `Cantidad` int NOT NULL,
  `PrecioUnitario` decimal(10,2) NOT NULL,
  `SubTotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`IdDetalle`),
  KEY `FK_Detalle_Pedido` (`IdPedido`),
  KEY `FK_Detalle_Producto` (`IdProducto`),
  CONSTRAINT `FK_Detalle_Pedido` FOREIGN KEY (`IdPedido`) REFERENCES `pedido` (`IdPedido`) ON DELETE CASCADE,
  CONSTRAINT `FK_Detalle_Producto` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallepedido`
--

LOCK TABLES `detallepedido` WRITE;
/*!40000 ALTER TABLE `detallepedido` DISABLE KEYS */;
INSERT INTO `detallepedido` VALUES (1,1,1,2,3500.00,7000.00),(2,1,2,1,18500.00,18500.00);
/*!40000 ALTER TABLE `detallepedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historialprecio`
--

DROP TABLE IF EXISTS `historialprecio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialprecio` (
  `IdHistorial` int NOT NULL AUTO_INCREMENT,
  `IdProducto` int NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  `FechaVigencia` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdHistorial`),
  KEY `FK_Historial_Producto` (`IdProducto`),
  CONSTRAINT `FK_Historial_Producto` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialprecio`
--

LOCK TABLES `historialprecio` WRITE;
/*!40000 ALTER TABLE `historialprecio` DISABLE KEYS */;
INSERT INTO `historialprecio` VALUES (1,1,3500.00,'2026-09-09 20:46:51'),(2,2,18500.00,'2026-09-09 20:46:51');
/*!40000 ALTER TABLE `historialprecio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `IdInventario` int NOT NULL AUTO_INCREMENT,
  `IdProducto` int NOT NULL,
  `IdTienda` int NOT NULL,
  `Stock` int NOT NULL DEFAULT '0',
  `StockMinimo` int NOT NULL DEFAULT '0',
  `FechaActualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdInventario`),
  UNIQUE KEY `UK_Producto_Tienda` (`IdProducto`,`IdTienda`),
  KEY `FK_Inventario_Tienda` (`IdTienda`),
  CONSTRAINT `FK_Inventario_Producto` FOREIGN KEY (`IdProducto`) REFERENCES `producto` (`IdProducto`) ON DELETE CASCADE,
  CONSTRAINT `FK_Inventario_Tienda` FOREIGN KEY (`IdTienda`) REFERENCES `tienda` (`IdTienda`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,1,100,20,'2026-09-09 20:46:51'),(2,2,1,50,10,'2026-09-09 20:46:51');
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `IdPedido` int NOT NULL AUTO_INCREMENT,
  `IdProveedor` int NOT NULL,
  `IdTienda` int NOT NULL,
  `NumeroPedido` varchar(30) DEFAULT NULL,
  `Fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estado` varchar(50) NOT NULL DEFAULT 'PENDIENTE',
  `Total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdPedido`),
  UNIQUE KEY `NumeroPedido` (`NumeroPedido`),
  KEY `FK_Pedido_Proveedor` (`IdProveedor`),
  KEY `FK_Pedido_Tienda` (`IdTienda`),
  CONSTRAINT `FK_Pedido_Proveedor` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`),
  CONSTRAINT `FK_Pedido_Tienda` FOREIGN KEY (`IdTienda`) REFERENCES `tienda` (`IdTienda`),
  CONSTRAINT `CHK_Pedido_Estado` CHECK ((`Estado` in (_utf8mb4'PENDIENTE',_utf8mb4'CONFIRMADO',_utf8mb4'ENVIADO',_utf8mb4'RECIBIDO',_utf8mb4'CANCELADO')))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,1,1,'PED-0001','2026-09-09 15:46:51','PENDIENTE',25500.00);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `IdProducto` int NOT NULL AUTO_INCREMENT,
  `SKU` varchar(30) DEFAULT NULL,
  `NombreProducto` varchar(250) NOT NULL,
  `Descripcion` varchar(450) DEFAULT NULL,
  `PrecioActual` decimal(10,2) unsigned NOT NULL,
  `Cantidad` int NOT NULL DEFAULT '0',
  `RutaImagen` varchar(255) DEFAULT NULL,
  `IdProveedor` int NOT NULL,
  PRIMARY KEY (`IdProducto`),
  UNIQUE KEY `SKU` (`SKU`),
  KEY `FK_Producto_Proveedor` (`IdProveedor`),
  CONSTRAINT `FK_Producto_Proveedor` FOREIGN KEY (`IdProveedor`) REFERENCES `proveedor` (`IdProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'SKU001','Arroz Diana 500g','Arroz blanco premium',3500.00,0,NULL,1),(2,'SKU002','Aceite Premier 1L','Aceite vegetal',18500.00,0,NULL,1);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `IdProveedor` int NOT NULL AUTO_INCREMENT,
  `Codigo` varchar(10) NOT NULL,
  `Nombre` varchar(150) NOT NULL,
  `Password` varchar(150) NOT NULL,
  `Contacto` varchar(15) DEFAULT NULL,
  `Correo` varchar(250) DEFAULT NULL,
  `Direccion` varchar(150) DEFAULT NULL,
  `FechaRegistro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`IdProveedor`),
  UNIQUE KEY `Codigo` (`Codigo`),
  UNIQUE KEY `Correo` (`Correo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'63252','Tienda Ara','Santiago123','3154692179','santiagochaparro941@gmail.com','Calle 11B #27C-33','2026-09-09 20:46:51',1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tienda`
--

DROP TABLE IF EXISTS `tienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tienda` (
  `IdTienda` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) NOT NULL,
  `Password` varchar(150) NOT NULL,
  `Direccion` varchar(150) NOT NULL,
  `Ciudad` varchar(100) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Correo` varchar(150) DEFAULT NULL,
  `Estado` varchar(20) DEFAULT 'ACTIVA',
  PRIMARY KEY (`IdTienda`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tienda`
--

LOCK TABLES `tienda` WRITE;
/*!40000 ALTER TABLE `tienda` DISABLE KEYS */;
INSERT INTO `tienda` VALUES (1,'Nova Market Centro','12','Calle 10 #15-20','Tuluá','3101234567','centro@novamarket.com','ACTIVA');
/*!40000 ALTER TABLE `tienda` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-09 20:23:37
