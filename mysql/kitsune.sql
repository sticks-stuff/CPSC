SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `banned_ips`;
CREATE TABLE `banned_ips` (
  `ID` int(11) NOT NULL,
  `ips_banned` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `bans`;
CREATE TABLE `bans` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Moderator` char(12) NOT NULL,
  `Player` int(11) unsigned NOT NULL,
  `Comment` text NOT NULL,
  `Expiration` int(8) NOT NULL,
  `Time` int(8) NOT NULL,
  `Type` smallint(3) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Time` (`Time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Accepted` text NOT NULL,
  `Requests` text NOT NULL,
  `Besties` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `igloos`;
CREATE TABLE `igloos` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Owner` int(10) unsigned NOT NULL,
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Floor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Music` smallint(6) NOT NULL DEFAULT '0',
  `Furniture` longtext NOT NULL,
  `Locked` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `penguins`;
CREATE TABLE `penguins` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Username` char(255) NOT NULL,
  `Nickname` char(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Avatar` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Dont think ID will go beyond 255',
  `AvatarAttributes` char(98) NOT NULL DEFAULT '{"spriteScale":100,"spriteSpeed":100,"ignoresBlockLayer":false,"invisible":false,"floating":false}',
  `Email` char(254) NOT NULL,
  `RegistrationDate` int(8) NOT NULL,
  `Moderator` tinyint(1) NOT NULL DEFAULT '0',
  `Inventory` longtext NOT NULL,
  `CareInventory` text NOT NULL,
  `Coins` mediumint(7) unsigned NOT NULL DEFAULT '5000',
  `Igloo` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Current active igloo',
  `Igloos` longtext NOT NULL COMMENT 'Owned igloo types',
  `Floors` longtext NOT NULL COMMENT 'Owned floorings',
  `Locations` longtext NOT NULL COMMENT 'Owned locations',
  `Furniture` longtext NOT NULL COMMENT 'Furniture inventory',
  `Color` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `Head` varchar(255) NOT NULL DEFAULT '0',
  `Face` varchar(255) NOT NULL DEFAULT '0',
  `Neck` varchar(255) NOT NULL DEFAULT '0',
  `Body` varchar(255) NOT NULL DEFAULT '0',
  `Hand` varchar(255) NOT NULL DEFAULT '0',
  `Feet` varchar(255) NOT NULL DEFAULT '0',
  `Photo` varchar(255) NOT NULL DEFAULT '0',
  `Flag` varchar(255) NOT NULL DEFAULT '0',
  `Walking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Puffle ID',
  `Banned` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Timestamp of ban, set to perm for permanent ban',
  `Stamps` text NOT NULL,
  `StampBook` varchar(255) NOT NULL DEFAULT '1%1%1%1',
  `EPF` varchar(255) NOT NULL DEFAULT '0,0,0',
  `Buddies` longtext NOT NULL,
  `Ignores` longtext NOT NULL,
  `MinutesPlayed` varchar(255) NOT NULL DEFAULT '0',
  `LastPaycheck` int(11) NOT NULL DEFAULT '0',
  `Active` int(1) NOT NULL DEFAULT '1',
  `Walls` int(1) NOT NULL DEFAULT '0',
  `IP` varchar(255) NOT NULL DEFAULT '0',
  `Redeemed` varchar(255) NOT NULL,
  `NinjaBelt` int(11) NOT NULL DEFAULT '0',
  `NinjaPercentage` int(11) NOT NULL DEFAULT '0',
  `PuffleQuest` varchar(255) NOT NULL DEFAULT '0,1,|0;0;1403959119;',
  `Rank` int(1) NOT NULL DEFAULT '1',
  `halloweenmsg` varchar(255) NOT NULL DEFAULT '0,0,0,0,0',
  `halloweenquest` varchar(255) NOT NULL DEFAULT '0,0,0,0,0,0,0,0',
  `halloweenvisited` varchar(255) NOT NULL DEFAULT '0',
  `transformation` longtext NOT NULL,
  `Tracks` longtext NOT NULL,
  `invalidLogins` longtext NOT NULL,
  `LoginKey` char(32) NOT NULL,
  `ConfirmationHash` char(32) NOT NULL,
  `hackedItem` varchar(255) NOT NULL,
  `Namecolor` varchar(12) NOT NULL,
  `Nameglow` varchar(12) NOT NULL,
  `bubbletext` varchar(12) NOT NULL,
  `bubblecolour` varchar(12) NOT NULL,
  `penguinglow` varchar(12) NOT NULL,
  `snowballglow` varchar(12) NOT NULL,
  `bubbleglow` varchar(12) NOT NULL,
  `mood` varchar(30) NOT NULL DEFAULT 'Hello, I''m New!',
  `moodglow` varchar(12) NOT NULL,
  `title` varchar(8) NOT NULL,
  `speed` varchar(12) NOT NULL,
  `titlecolor` varchar(12) NOT NULL DEFAULT '0xffffff',
  `titleglow` varchar(12) NOT NULL,
  `wow` varchar(1) NOT NULL,
  `beaks` varchar(12) NOT NULL,
  `credits` varchar(12) NOT NULL DEFAULT '100',
  `marry` text NOT NULL,
  `bff` text NOT NULL,
  `moodcolor` varchar(12) NOT NULL DEFAULT '0xffffff',
  `ringcolour` varchar(12) NOT NULL,
  `chatglow` varchar(12) NOT NULL,
  `penguin_blend` int(11) NOT NULL,
  `penguin_alpha` int(11) NOT NULL,
  `isCloneable` int(11) NOT NULL,
  `VIP` int(1) NOT NULL DEFAULT '0',
  `Cards` varchar(255) NOT NULL DEFAULT '1,1,0|2,1,0|3,1,0|4,1,0|5,1,0|6,1,0|7,1,0|8,1,0|9,1,0' COMMENT 'Ninja',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `postcards`;
CREATE TABLE `postcards` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Recipient` int(10) unsigned NOT NULL,
  `SenderName` char(12) NOT NULL,
  `SenderID` int(10) unsigned NOT NULL,
  `Details` varchar(12) NOT NULL,
  `Date` int(8) NOT NULL,
  `Type` smallint(5) unsigned NOT NULL,
  `HasRead` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `puffles`;
CREATE TABLE `puffles` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Owner` int(10) unsigned NOT NULL,
  `Name` char(12) NOT NULL,
  `AdoptionDate` int(8) NOT NULL,
  `Type` tinyint(3) unsigned NOT NULL,
  `Subtype` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Hat` smallint(5) unsigned NOT NULL DEFAULT '0',
  `Food` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `Play` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `Rest` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `Clean` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `Backyard` tinyint(1) NOT NULL DEFAULT '0',
  `Walking` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `redemption`;
CREATE TABLE `redemption` (
  `ID` int(10) unsigned NOT NULL,
  `Type` varchar(255) NOT NULL DEFAULT 'BLANKET',
  `Code` char(16) NOT NULL,
  `Items` text NOT NULL,
  `Coins` int(11) NOT NULL DEFAULT '0',
  `Expires` int(11) NOT NULL DEFAULT '0',
  `Uses` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `servers`;
CREATE TABLE `servers` (
  `ID` int(5) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `port` int(10) NOT NULL,
  `capacity` int(11) NOT NULL,
  `Language` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `tracks`;
CREATE TABLE `tracks` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Owner` int(10) unsigned NOT NULL,
  `Hash` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Sharing` tinyint(1) NOT NULL DEFAULT '0',
  `Pattern` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `Likes` smallint(5) unsigned NOT NULL DEFAULT '0',
  `LikeStatistics` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 2017-11-18 00:13:17
