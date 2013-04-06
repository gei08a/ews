-- --------------------------------------------------------

--
-- Table structure for table `crops`
--

CREATE TABLE IF NOT EXISTS `crops` (
  `cropID` int(2) NOT NULL AUTO_INCREMENT,
  `cropName` varchar(32) NOT NULL,
  PRIMARY KEY (`cropID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `crops`
--

INSERT INTO `crops` (`cropID`, `cropName`) VALUES
(1, 'Papa'),
(2, 'Cebolla'),
(3, 'Tomate'),
(4, 'Chile Morron'),
(5, 'Brocoli'),
(6, 'Coliflor'),
(7, 'Repollo'),
(8, 'Zanahoria'),
(9, 'Remolacha'),
(10, 'Banano'),
(11, 'Platano');

-- --------------------------------------------------------

--
-- Table structure for table `farmer`
--

CREATE TABLE IF NOT EXISTS `farmer` (
  `fName` varchar(32) NOT NULL,
  `lName` varchar(32) NOT NULL,
  `phoneNum` bigint(10) NOT NULL,
  `location` varchar(64) NOT NULL,
  PRIMARY KEY (`phoneNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmer`
--

INSERT INTO `farmer` (`fName`, `lName`, `phoneNum`, `location`) VALUES
('German', 'Irias', 2142268346, 'Abilene, TX'),
('David', 'Suazo', 2148861328, 'Abilene, TX'),
('Brent', 'Reeves', 3255131496, 'Abilene, TX'),
('Raul', 'Andino', 3255138624, 'Abilene, TX'),
('Mark', 'Crippen', 6263212902, 'Abilene, TX'),
('Simon', 'Yammouni', 9402311052, 'Abilene, TX'),
('Darby', 'ORear', 9792551031, 'College Station, TX');

-- --------------------------------------------------------

--
-- Table structure for table `market`
--

CREATE TABLE IF NOT EXISTS `market` (
  `marketID` int(2) NOT NULL AUTO_INCREMENT,
  `marketName` varchar(32) NOT NULL,
  `marketLocation` varchar(32) NOT NULL,
  PRIMARY KEY (`marketID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `market`
--

INSERT INTO `market` (`marketID`, `marketName`, `marketLocation`) VALUES
(1, 'Zonal Belen', 'Tegucigalpa'),
(2, 'Las Americas', 'Tegucigalpa'),
(3, 'M. Concepcion/Dandy', 'San Pedro Sula');

-- --------------------------------------------------------

--
-- Table structure for table `quote`
--

CREATE TABLE IF NOT EXISTS `quote` (
  `date` date NOT NULL,
  `marketID` int(2) NOT NULL,
  `cropID` int(2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`date`,`marketID`,`cropID`),
  KEY `cropID` (`cropID`),
  KEY `marketID` (`marketID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quote`
--

INSERT INTO `quote` (`date`, `marketID`, `cropID`, `price`) VALUES
('2012-04-27', 1, 1, 8.59),
('2012-04-27', 1, 3, 4.21),
('2012-04-27', 1, 10, 3.25),
('2012-04-28', 1, 1, 8.52),
('2012-04-28', 1, 3, 4.21),
('2012-04-28', 1, 10, 3.28),
('2012-05-03', 1, 1, 8.60),
('2012-05-03', 1, 3, 4.21),
('2012-05-03', 1, 10, 3.29),
('2012-05-04', 1, 1, 8.61),
('2012-05-04', 1, 3, 4.25),
('2012-05-04', 1, 10, 3.30),
('2012-05-08', 1, 1, 8.59),
('2012-05-08', 1, 2, 4.32),
('2012-05-08', 1, 3, 4.56),
('2012-05-08', 1, 4, 2.15),
('2012-05-08', 1, 5, 1.65),
('2012-05-08', 1, 6, 3.65),
('2012-05-08', 1, 7, 3.78),
('2012-05-08', 1, 8, 2.25),
('2012-05-08', 1, 9, 2.21),
('2012-05-08', 1, 10, 1.45),
('2012-05-08', 1, 11, 1.89),
('2012-05-08', 2, 1, 8.59),
('2012-05-08', 2, 2, 4.32),
('2012-05-08', 2, 3, 4.56),
('2012-05-08', 2, 4, 2.15),
('2012-05-08', 2, 5, 1.65),
('2012-05-08', 2, 6, 3.65),
('2012-05-08', 2, 7, 3.78),
('2012-05-08', 2, 8, 2.25),
('2012-05-08', 2, 9, 2.21),
('2012-05-08', 2, 10, 1.45),
('2012-05-08', 2, 11, 1.89),
('2012-05-08', 3, 1, 8.59),
('2012-05-08', 3, 2, 4.32),
('2012-05-08', 3, 3, 4.56),
('2012-05-08', 3, 4, 2.15),
('2012-05-08', 3, 5, 1.65),
('2012-05-08', 3, 6, 3.65),
('2012-05-08', 3, 7, 3.78),
('2012-05-08', 3, 8, 2.25),
('2012-05-08', 3, 9, 2.21),
('2012-05-08', 3, 10, 1.45),
('2012-05-08', 3, 11, 1.89),
('2012-05-15', 1, 2, 8.56),
('2012-05-15', 1, 5, 5.32),
('2012-05-15', 1, 6, 4.21);

-- --------------------------------------------------------

--
-- Table structure for table `registered_members`
--

CREATE TABLE IF NOT EXISTS `registered_members` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(65) NOT NULL DEFAULT '',
  `email` varchar(65) NOT NULL DEFAULT '',
  `password` varchar(65) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `registered_members`
--

INSERT INTO `registered_members` (`id`, `name`, `email`, `password`) VALUES
(1, 'German Irias', 'gei08a@acu.edu', 'bcf915a91b666482b3e29a6606f37cb8'),
(2, 'Axel Tabora', 'axeltabora@gmail.com', 'f394490387f52da2b85b40e0aef112e3'),
(5, 'Tito Zuniga', 'tito.zuniga@gmail.com', 'ac0ff2cac198811b557d90a9110a6dba');

-- --------------------------------------------------------

--
-- Table structure for table `subscribe`
--

CREATE TABLE IF NOT EXISTS `subscribe` (
  `phoneNum` bigint(10) NOT NULL,
  `marketID` int(2) NOT NULL,
  `cropID` int(2) NOT NULL,
  PRIMARY KEY (`phoneNum`,`marketID`,`cropID`),
  KEY `marketID` (`marketID`),
  KEY `cropID` (`cropID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscribe`
--

INSERT INTO `subscribe` (`phoneNum`, `marketID`, `cropID`) VALUES
(2142268346, 1, 2),
(2142268346, 1, 5),
(2142268346, 1, 6),
(3255131496, 1, 3),
(3255131496, 1, 6),
(3255131496, 1, 8),
(6263212902, 2, 2),
(6263212902, 2, 4),
(6263212902, 2, 11);

-- --------------------------------------------------------

--
-- Table structure for table `temp_members_db`
--

CREATE TABLE IF NOT EXISTS `temp_members_db` (
  `confirm_code` varchar(65) NOT NULL DEFAULT '',
  `name` varchar(65) NOT NULL DEFAULT '',
  `email` varchar(65) NOT NULL DEFAULT '',
  `password` varchar(65) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quote`
--
ALTER TABLE `quote`
  ADD CONSTRAINT `quote_ibfk_2` FOREIGN KEY (`cropID`) REFERENCES `crops` (`cropID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `quote_ibfk_3` FOREIGN KEY (`marketID`) REFERENCES `market` (`marketID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `subscribe`
--
ALTER TABLE `subscribe`
  ADD CONSTRAINT `subscribe_ibfk_5` FOREIGN KEY (`marketID`) REFERENCES `market` (`marketID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `subscribe_ibfk_6` FOREIGN KEY (`cropID`) REFERENCES `crops` (`cropID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `subscribe_ibfk_7` FOREIGN KEY (`phoneNum`) REFERENCES `farmer` (`phoneNum`) ON DELETE NO ACTION ON UPDATE CASCADE;
--
-- Database: `ews_test`
--
CREATE DATABASE `ews_test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ews_test`;

-- --------------------------------------------------------

--
-- Table structure for table `crops`
--

CREATE TABLE IF NOT EXISTS `crops` (
  `cropID` int(2) NOT NULL AUTO_INCREMENT,
  `cropName` varchar(32) NOT NULL,
  PRIMARY KEY (`cropID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `crops`
--

INSERT INTO `crops` (`cropID`, `cropName`) VALUES
(1, 'Papa'),
(2, 'Cebolla'),
(3, 'Tomate'),
(4, 'Chile Morron'),
(5, 'Brocoli'),
(6, 'Coliflor'),
(7, 'Repollo'),
(8, 'Zanahoria'),
(9, 'Remolacha'),
(10, 'Banano'),
(11, 'Platano');

-- --------------------------------------------------------

--
-- Table structure for table `farmer`
--

CREATE TABLE IF NOT EXISTS `farmer` (
  `fName` varchar(32) NOT NULL,
  `lName` varchar(32) NOT NULL,
  `phoneNum` bigint(10) NOT NULL,
  `location` varchar(64) NOT NULL,
  PRIMARY KEY (`phoneNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `farmer`
--

INSERT INTO `farmer` (`fName`, `lName`, `phoneNum`, `location`) VALUES
('German', 'Irias', 2142268346, 'Abilene, TX'),
('Brent', 'Reeves', 3255131496, 'Abilene, TX'),
('Raul', 'Andino', 3255138624, 'Abilene, TX'),
('Mark', 'Crippen', 6263212902, 'Abilene, TX'),
('Simon', 'Yammouni', 9402311052, 'Abilene, TX'),
('Darby', 'ORear', 9792551031, 'College Station, TX');

-- --------------------------------------------------------

--
-- Table structure for table `market`
--

CREATE TABLE IF NOT EXISTS `market` (
  `marketID` int(2) NOT NULL AUTO_INCREMENT,
  `marketName` varchar(32) NOT NULL,
  `marketLocation` varchar(32) NOT NULL,
  PRIMARY KEY (`marketID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `market`
--

INSERT INTO `market` (`marketID`, `marketName`, `marketLocation`) VALUES
(1, 'Zonal Belen', 'Tegucigalpa'),
(2, 'Las Americas', 'Tegucigalpa'),
(3, 'M. Concepcion/Dandy', 'San Pedro Sula');

-- --------------------------------------------------------

--
-- Table structure for table `quote`
--

CREATE TABLE IF NOT EXISTS `quote` (
  `date` date NOT NULL,
  `marketID` int(2) NOT NULL,
  `cropID` int(2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`date`,`marketID`,`cropID`),
  KEY `cropID` (`cropID`),
  KEY `marketID` (`marketID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `quote`
--

INSERT INTO `quote` (`date`, `marketID`, `cropID`, `price`) VALUES
('2012-04-27', 1, 1, 8.59),
('2012-04-27', 1, 3, 4.21),
('2012-04-27', 1, 10, 3.25),
('2012-04-28', 1, 1, 8.52),
('2012-04-28', 1, 3, 4.21),
('2012-04-28', 1, 10, 3.28),
('2012-05-03', 1, 1, 8.60),
('2012-05-03', 1, 3, 4.21),
('2012-05-03', 1, 10, 3.29),
('2012-05-04', 1, 1, 8.61),
('2012-05-04', 1, 3, 4.25),
('2012-05-04', 1, 10, 3.30),
('2012-05-08', 1, 1, 8.59),
('2012-05-08', 1, 2, 4.32),
('2012-05-08', 1, 3, 4.56),
('2012-05-08', 1, 4, 2.15),
('2012-05-08', 1, 5, 1.65),
('2012-05-08', 1, 6, 3.65),
('2012-05-08', 1, 7, 3.78),
('2012-05-08', 1, 8, 2.25),
('2012-05-08', 1, 9, 2.21),
('2012-05-08', 1, 10, 1.45),
('2012-05-08', 1, 11, 1.89),
('2012-05-08', 2, 1, 8.59),
('2012-05-08', 2, 2, 4.32),
('2012-05-08', 2, 3, 4.56),
('2012-05-08', 2, 4, 2.15),
('2012-05-08', 2, 5, 1.65),
('2012-05-08', 2, 6, 3.65),
('2012-05-08', 2, 7, 3.78),
('2012-05-08', 2, 8, 2.25),
('2012-05-08', 2, 9, 2.21),
('2012-05-08', 2, 10, 1.45),
('2012-05-08', 2, 11, 1.89),
('2012-05-08', 3, 1, 8.59),
('2012-05-08', 3, 2, 4.32),
('2012-05-08', 3, 3, 4.56),
('2012-05-08', 3, 4, 2.15),
('2012-05-08', 3, 5, 1.65),
('2012-05-08', 3, 6, 3.65),
('2012-05-08', 3, 7, 3.78),
('2012-05-08', 3, 8, 2.25),
('2012-05-08', 3, 9, 2.21),
('2012-05-08', 3, 10, 1.45),
('2012-05-08', 3, 11, 1.89),
('2012-05-15', 1, 2, 8.56),
('2012-05-15', 1, 5, 5.32),
('2012-05-15', 1, 6, 4.21),
('2012-06-12', 1, 2, 5.23);

-- --------------------------------------------------------

--
-- Table structure for table `registered_members`
--

CREATE TABLE IF NOT EXISTS `registered_members` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(65) NOT NULL DEFAULT '',
  `email` varchar(65) NOT NULL DEFAULT '',
  `password` varchar(65) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `registered_members`
--

INSERT INTO `registered_members` (`id`, `name`, `email`, `password`) VALUES
(2, 'German Irias', 'gei08a@acu.edu', 'bcf915a91b666482b3e29a6606f37cb8');

-- --------------------------------------------------------

--
-- Table structure for table `subscribe`
--

CREATE TABLE IF NOT EXISTS `subscribe` (
  `phoneNum` bigint(10) NOT NULL,
  `marketID` int(2) NOT NULL,
  `cropID` int(2) NOT NULL,
  PRIMARY KEY (`phoneNum`,`marketID`,`cropID`),
  KEY `marketID` (`marketID`),
  KEY `cropID` (`cropID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subscribe`
--

INSERT INTO `subscribe` (`phoneNum`, `marketID`, `cropID`) VALUES
(2142268346, 1, 2),
(2142268346, 1, 5),
(2142268346, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `temp_members_db`
--

CREATE TABLE IF NOT EXISTS `temp_members_db` (
  `confirm_code` varchar(65) NOT NULL DEFAULT '',
  `name` varchar(65) NOT NULL DEFAULT '',
  `email` varchar(65) NOT NULL DEFAULT '',
  `password` varchar(65) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quote`
--
ALTER TABLE `quote`
  ADD CONSTRAINT `quote_ibfk_2` FOREIGN KEY (`cropID`) REFERENCES `crops` (`cropID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `quote_ibfk_3` FOREIGN KEY (`marketID`) REFERENCES `market` (`marketID`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `subscribe`
--
ALTER TABLE `subscribe`
  ADD CONSTRAINT `subscribe_ibfk_5` FOREIGN KEY (`marketID`) REFERENCES `market` (`marketID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `subscribe_ibfk_6` FOREIGN KEY (`cropID`) REFERENCES `crops` (`cropID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `subscribe_ibfk_7` FOREIGN KEY (`phoneNum`) REFERENCES `farmer` (`phoneNum`) ON DELETE NO ACTION ON UPDATE CASCADE;
