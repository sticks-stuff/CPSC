use kitsune;
ALTER TABLE `penguins` CHANGE `Username` `Username` CHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
ALTER TABLE `penguins` CHANGE `Nickname` `Nickname` CHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;