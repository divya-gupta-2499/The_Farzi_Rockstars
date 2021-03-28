-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: testing
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `activation_codes`
--

DROP TABLE IF EXISTS `activation_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activation_codes` (
  `username` varchar(50) NOT NULL,
  `code` varchar(20) NOT NULL,
  PRIMARY KEY (`code`),
  KEY `username` (`username`),
  CONSTRAINT `activation_codes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activation_codes`
--

LOCK TABLES `activation_codes` WRITE;
/*!40000 ALTER TABLE `activation_codes` DISABLE KEYS */;
INSERT INTO `activation_codes` VALUES ('danish','EtTwqARy2n0UJFJ'),('divya','kBMZmMs4kptdKTs'),('j&k','K3g0jLJvyiEvRJM'),('mm','WuxO8VbGEHDikTe');
/*!40000 ALTER TABLE `activation_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `all_orders`
--

DROP TABLE IF EXISTS `all_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `all_orders` (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Packaging',
  `courierId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`orderId`),
  KEY `username` (`username`),
  KEY `courierId` (`courierId`),
  CONSTRAINT `all_orders_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`) ON DELETE CASCADE,
  CONSTRAINT `all_orders_ibfk_2` FOREIGN KEY (`courierId`) REFERENCES `courier` (`username`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_orders`
--

LOCK TABLES `all_orders` WRITE;
/*!40000 ALTER TABLE `all_orders` DISABLE KEYS */;
INSERT INTO `all_orders` VALUES (1,'khushiagr','Delivered','courier1'),(2,'khushiagr','Delivered','courier1'),(3,'khushiagr','Packaging',NULL),(4,'janhavi','Delivered','courier2'),(5,'khushiagr','Packaging',NULL),(6,'khushiagr','Delivered','courier1');
/*!40000 ALTER TABLE `all_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `orderId` int NOT NULL,
  `dateOfIssue` date NOT NULL,
  `paymentMethod` varchar(100) DEFAULT 'Cash on Delivery',
  `shipping_address` varchar(500) NOT NULL,
  PRIMARY KEY (`orderId`),
  CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `all_orders` (`orderId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1,'2019-10-13','Cash on delivery','Room No 533,New IIT Girls Hostel,BHU'),(2,'2019-10-14','Cash on delivery','Room No 533,New IIT Girls Hostel,BHU'),(3,'2019-11-05','Cash on delivery','Room No 533,New IIT Girls Hostel,BHU'),(4,'2019-11-11','Cash on delivery','533,IIT-BHU, Banaras Hindu University Campus, Uttar Pr,Varanasi'),(5,'2020-02-14','Cash on delivery','Room No 533,New IIT Girls Hostel,BHU'),(6,'2021-01-02','Cash on delivery','Room No 533,New IIT Girls Hostel,BHU');
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `username` varchar(50) NOT NULL,
  `productId` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`username`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`) ON DELETE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES ('hackout',2,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryName` varchar(50) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`categoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('Fruits','All fresh fruits.'),('Juice','Fresh Juices available here!'),('Vegetables','All fresh vegetables.');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courier`
--

DROP TABLE IF EXISTS `courier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courier` (
  `username` varchar(50) NOT NULL,
  `courierCompanyName` varchar(80) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `courier_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courier`
--

LOCK TABLES `courier` WRITE;
/*!40000 ALTER TABLE `courier` DISABLE KEYS */;
INSERT INTO `courier` VALUES ('courier1','Bluedart','bluedartofficial@gmail.com'),('courier2','Bluedart','khushia.cd.cse17@itbhu.ac.in');
/*!40000 ALTER TABLE `courier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `username` varchar(50) NOT NULL,
  `fName` varchar(100) NOT NULL,
  `lName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact` bigint NOT NULL,
  `age` int NOT NULL,
  `houseNo` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `locality` varchar(50) NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('danish','Danish','Sheikh','khushia.cd.cse17@itbhu.ac.in',8604673216,21,'54','D63/25 A-3 KHA, Mahmoorganj','mahmoorganj'),('divya','Divya','Gupta','khushia.cd.cse17@itbhu.ac.in',7985763158,21,'123','D63/25 A-3 KHA, Mahmoorganj','123'),('hackout','Khushi','Agrawal','khushia.cd.cse17@itbhu.ac.in',7985763158,200,'987','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('j&k','Janhavi','Khushi','khushia.cd.cse17@itbhu.ac.in',7985763158,20,'569','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('janhavi','Janhavi','Gupta','khushia.cd.cse17@itbhu.ac.in',8604673216,20,'533','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('jkl','Janhavi','Khushi','khushia.cd.cse17@itbhu.ac.in',7985763158,20,'569','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('khushiagr','Khushi','Agrawal','khushia.cd.cse17@itbhu.ac.in',8604673216,20,'Room No 533','New IIT Girls Hostel','BHU'),('mm','kh','lkj','khushia.cd.cse17@itbhu.ac.in',86,10,'l','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('mma','kh','lkj','khushia.cd.cse17@itbhu.ac.in',86,10,'l','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('raghav','Raghav','Sangar','khushia.cd.cse17@itbhu.ac.in',9456,20,'20','IIT-BHU, Banaras Hindu University Campus, Uttar Pr','Varanasi'),('simran','Simran','Jaiswal','simranjaiswal95@gmail.com',7985763158,24,'D63/25 A-1','Fatman Road','Mahmoorganj');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedbackId` int NOT NULL AUTO_INCREMENT,
  `contact_info` varchar(50) NOT NULL,
  `subject` varchar(500) NOT NULL,
  `details` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`feedbackId`),
  KEY `contact_info` (`contact_info`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`contact_info`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,'khushiagr','Stale products','I had ordered onions and tomatoes around a week back and upon delivery, I received stale products, clearly not suitable for cooking. Please look into the matter. I have been a regular customer and this is the first time such a thing is happening.'),(2,'simran','Awesome service!','I absolutely love the service. It is fast and reliable. 10/10 definitely'),(3,'manoj','Nice Service','I have been a partner with your store for over a year now, and I am pretty happy with all our deals and proposals so far. Hope this continues.'),(4,'courier1','Unable to contact. Please contact me soon.',NULL),(5,'khushiagr','Unable to register','xcc'),(6,'courier1','WiFi Installation Details','XX-YY-ZZ');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fk`
--

DROP TABLE IF EXISTS `fk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fk` (
  `p` int NOT NULL,
  `f` int DEFAULT NULL,
  PRIMARY KEY (`p`),
  KEY `fk_1` (`f`),
  CONSTRAINT `fk_1` FOREIGN KEY (`f`) REFERENCES `fk` (`p`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fk`
--

LOCK TABLES `fk` WRITE;
/*!40000 ALTER TABLE `fk` DISABLE KEYS */;
/*!40000 ALTER TABLE `fk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fk1`
--

DROP TABLE IF EXISTS `fk1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fk1` (
  `p` int NOT NULL,
  `f` int DEFAULT NULL,
  PRIMARY KEY (`p`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fk1`
--

LOCK TABLES `fk1` WRITE;
/*!40000 ALTER TABLE `fk1` DISABLE KEYS */;
INSERT INTO `fk1` VALUES (2,4),(3,4),(4,3),(5,2),(6,4),(7,2),(9,5);
/*!40000 ALTER TABLE `fk1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `names`
--

DROP TABLE IF EXISTS `names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `names` (
  `id` int DEFAULT NULL,
  `num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `names`
--

LOCK TABLES `names` WRITE;
/*!40000 ALTER TABLE `names` DISABLE KEYS */;
INSERT INTO `names` VALUES (1,NULL),(2,NULL),(3,NULL),(4,NULL);
/*!40000 ALTER TABLE `names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `names1`
--

DROP TABLE IF EXISTS `names1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `names1` (
  `id` int DEFAULT NULL,
  `num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `names1`
--

LOCK TABLES `names1` WRITE;
/*!40000 ALTER TABLE `names1` DISABLE KEYS */;
INSERT INTO `names1` VALUES (1,NULL),(2,NULL),(3,NULL),(4,NULL);
/*!40000 ALTER TABLE `names1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_info` (
  `orderId` int NOT NULL,
  `productId` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`orderId`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `order_info_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `all_orders` (`orderId`) ON DELETE CASCADE,
  CONSTRAINT `order_info_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES (1,1,1),(1,4,1),(1,7,1),(2,2,1),(3,1,5),(3,3,2),(4,6,1),(5,2,5),(6,1,1),(6,2,4),(6,6,6),(6,7,9);
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `categoryName` varchar(50) DEFAULT NULL,
  `product_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`productId`),
  KEY `categoryName` (`categoryName`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`categoryName`) REFERENCES `category` (`categoryName`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Bell Pepper',100,'Vegetables','/resources/images/product-1.jpg'),(2,'Green Peas',200,'Vegetables','/resources/images/product-3.jpg'),(3,'Tomatoes',50,'Vegetables','/resources/images/product-5.jpg'),(4,'Onion',80,'Vegetables','/resources/images/product-9.jpg'),(5,'Garlic',30,'Vegetables','/resources/images/product-11.jpg'),(6,'Strawberry',220,'Fruits','/resources/images/product-2.jpg'),(7,'Apples',90,'Fruits','/resources/images/product-10.jpg'),(8,'Mango Juice',25,'Juice','https://www.freemockupworld.com/wp-content/uploads/2019/08/Juice-Bottle-Mockup.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `enabled` int NOT NULL DEFAULT '0',
  `user_role` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','$2a$10$o0B.smrTF3cm9/6DCLnswOnDjITNq2SN5y072TmLZ5QBpEQpsYGTa',1,'ROLE_ADMIN'),('courier1','$2a$10$o0B.smrTF3cm9/6DCLnswOnDjITNq2SN5y072TmLZ5QBpEQpsYGTa',1,'ROLE_COURIER'),('courier2','$2a$10$7QbjOH9pHoZ6yo0iMkLj5u/hcmGKzPz0chLrIA0fZ240Ojdl/Lf/K',1,'ROLE_COURIER'),('danish','$2a$10$mUDjNgLY7VT39cVSeq8.IeabfPFcE1Zy.GQvNg1YiYfDSuERY5L3K',0,'ROLE_USER'),('divya','$2a$10$KgI5y05TXHtj52zDZPs9WOJ0cjDn3cIm0t7ZfUfDvgRGfb8iFk/Xm',0,'ROLE_USER'),('hackout','$2a$10$ABthyfN78dNXmofR0vi9ju8TGuleBnrv4oJoiRo/JpQpk4kkKHAfe',1,'ROLE_USER'),('j&k','$2a$10$6zqeBMW0g7QzA/rGBKJMjOtOYvxFrydAktgSGvZwqJloNkscUqlTS',0,'ROLE_USER'),('janhavi','$2a$10$CVDG9cWhtv7dtTQkVB7SzO1iCZxRoAm03LWMLcAa4W1Mq3ayVDnmm',1,'ROLE_USER'),('janhavi007','$2a$10$XKMHWly9.46cMMSxQ3x8XuB2h/V.qCYlEaZPevqHvJ6jnvKSl1QxC',1,'ROLE_VENDOR'),('jkl','$2a$10$Coz8bbaE6DTw84e3aEbZseR7RharswswXT1a6oeA0XBI.snRSCSUe',1,'ROLE_USER'),('khushiagr','$2a$10$o0B.smrTF3cm9/6DCLnswOnDjITNq2SN5y072TmLZ5QBpEQpsYGTa',1,'ROLE_USER'),('manoj','$2a$10$ozEJWwavzsA4un0LfqabgO/ImYwJ9ohfEDg8LnTE.mb0paQ4TugIK',1,'ROLE_VENDOR'),('mm','$2a$10$KgKxV3FM2kc4Dp7BX5LK4eRxr6zcBxjVIHRbBLe3CZort6AdnE5ya',0,'ROLE_USER'),('mma','$2a$10$Sq532EesmJGfCT8n3lDrSO27Cm2eeT0FOSoNFUCnICu9hqJH6xiIW',1,'ROLE_USER'),('raghav','$2a$10$ahz1A/BmSU53TT/H6z5D3Og1cIzGFjuj4NE/7ys6O5vel2ClmBjra',1,'ROLE_USER'),('simran','$2a$10$H2j5T28uB59TR/2nYqK.8eMVKFjEy5J4lpzhJ18gJ.lBvrkOrUqwK',1,'ROLE_USER');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `username` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `companyName` varchar(80) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact` bigint NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `vendor_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES ('janhavi007','Janhavi Gupta','Amul','khushia.cd.cse17@itbhu.ac.in',7985763159),('manoj','Man','ServeFresh','manojverma@gmail.com',9415353);
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor_proposal`
--

DROP TABLE IF EXISTS `vendor_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_proposal` (
  `username` varchar(50) NOT NULL,
  `productId` int NOT NULL,
  `price` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `vendor_proposal_ibfk_1` FOREIGN KEY (`username`) REFERENCES `vendor` (`username`) ON DELETE CASCADE,
  CONSTRAINT `vendor_proposal_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor_proposal`
--

LOCK TABLES `vendor_proposal` WRITE;
/*!40000 ALTER TABLE `vendor_proposal` DISABLE KEYS */;
INSERT INTO `vendor_proposal` VALUES ('janhavi007',1,50,0),('manoj',7,10,1);
/*!40000 ALTER TABLE `vendor_proposal` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-28 13:55:15
