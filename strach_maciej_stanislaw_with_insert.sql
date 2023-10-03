/*
 Navicat Premium Data Transfer

 Source Server         : maciek
 Source Server Type    : MySQL
 Source Server Version : 100707 (10.7.7-MariaDB)
 Source Host           : 10.9.9.9:3306
 Source Schema         : strach_maciej_stanislaw

 Target Server Type    : MySQL
 Target Server Version : 100707 (10.7.7-MariaDB)
 File Encoding         : 65001

 Date: 14/06/2023 12:03:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for GodzinyPracy
-- ----------------------------
DROP TABLE IF EXISTS `GodzinyPracy`;
CREATE TABLE `GodzinyPracy`  (
  `PracownikID` int UNSIGNED NOT NULL,
  `Dzien` date NOT NULL,
  `GodzinaRozpoczecia` time NOT NULL,
  `GodzinaZakonczenia` time NOT NULL,
  INDEX `PracownikID`(`PracownikID` ASC) USING BTREE,
  CONSTRAINT `GodzinyPracy_ibfk_1` FOREIGN KEY (`PracownikID`) REFERENCES `Pracownik` (`PracownikID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Klient
-- ----------------------------
DROP TABLE IF EXISTS `Klient`;
CREATE TABLE `Klient`  (
  `KlientID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Imie` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Nazwisko` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Miejscowosc` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Ulica` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NumerMieszkania` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Telefon` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`KlientID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Opinia
-- ----------------------------
DROP TABLE IF EXISTS `Opinia`;
CREATE TABLE `Opinia`  (
  `OpiniaID` int UNSIGNED NOT NULL,
  `KlientID` int UNSIGNED NOT NULL,
  `Tresc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `Ocena` int NOT NULL,
  `Data` date NOT NULL,
  PRIMARY KEY (`OpiniaID`) USING BTREE,
  INDEX `KlientID`(`KlientID` ASC) USING BTREE,
  CONSTRAINT `Opinia_ibfk_1` FOREIGN KEY (`KlientID`) REFERENCES `Klient` (`KlientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Pokoj
-- ----------------------------
DROP TABLE IF EXISTS `Pokoj`;
CREATE TABLE `Pokoj`  (
  `PokojID` int UNSIGNED NOT NULL,
  `NrPokoju` int UNSIGNED NOT NULL,
  `IloscOsob` int UNSIGNED NOT NULL,
  `CenaZaDobe` decimal(10, 2) NOT NULL,
  `Dostepnosc` tinyint(1) NOT NULL,
  PRIMARY KEY (`PokojID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Pracownik
-- ----------------------------
DROP TABLE IF EXISTS `Pracownik`;
CREATE TABLE `Pracownik`  (
  `PracownikID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Imie` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Nazwisko` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DataZatrudnienia` date NOT NULL,
  `Stanowisko` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Stawka` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`PracownikID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RaportRoczny
-- ----------------------------
DROP TABLE IF EXISTS `RaportRoczny`;
CREATE TABLE `RaportRoczny`  (
  `RaportID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Rok` int UNSIGNED NOT NULL,
  `LiczbaRezerwacji` int UNSIGNED NOT NULL,
  `DataGenerowania` date NULL DEFAULT curdate,
  PRIMARY KEY (`RaportID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Rezerwacja
-- ----------------------------
DROP TABLE IF EXISTS `Rezerwacja`;
CREATE TABLE `Rezerwacja`  (
  `RezerwacjaID` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `KlientID` int UNSIGNED NOT NULL,
  `PokojID` int UNSIGNED NOT NULL,
  `DataZameldowania` date NULL DEFAULT NULL,
  `DataWymeldowania` date NULL DEFAULT NULL,
  PRIMARY KEY (`RezerwacjaID`) USING BTREE,
  INDEX `KlientID`(`KlientID` ASC) USING BTREE,
  INDEX `PokojID`(`PokojID` ASC) USING BTREE,
  CONSTRAINT `Rezerwacja_ibfk_1` FOREIGN KEY (`KlientID`) REFERENCES `Klient` (`KlientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Rezerwacja_ibfk_2` FOREIGN KEY (`PokojID`) REFERENCES `Pokoj` (`PokojID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for RezerwacjaUslugi
-- ----------------------------
DROP TABLE IF EXISTS `RezerwacjaUslugi`;
CREATE TABLE `RezerwacjaUslugi`  (
  `RezerwacjaID` int UNSIGNED NULL DEFAULT NULL,
  `UslugaID` int UNSIGNED NULL DEFAULT NULL,
  INDEX `RezerwacjaID`(`RezerwacjaID` ASC) USING BTREE,
  INDEX `UslugaID`(`UslugaID` ASC) USING BTREE,
  CONSTRAINT `RezerwacjaUslugi_ibfk_1` FOREIGN KEY (`RezerwacjaID`) REFERENCES `Rezerwacja` (`RezerwacjaID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `RezerwacjaUslugi_ibfk_2` FOREIGN KEY (`UslugaID`) REFERENCES `UslugaDodatkowa` (`UslugaID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for UslugaDodatkowa
-- ----------------------------
DROP TABLE IF EXISTS `UslugaDodatkowa`;
CREATE TABLE `UslugaDodatkowa`  (
  `UslugaID` int UNSIGNED NOT NULL,
  `Nazwa` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Cena` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`UslugaID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Wydarzenia
-- ----------------------------
DROP TABLE IF EXISTS `Wydarzenia`;
CREATE TABLE `Wydarzenia`  (
  `Nazwa` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RezerwacjaID` int UNSIGNED NOT NULL,
  `Opis` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `DataRozpoczecia` date NOT NULL,
  `DataZakonczenia` date NOT NULL,
  `LiczbaUczestnikow` int UNSIGNED NOT NULL,
  PRIMARY KEY (`Nazwa`) USING BTREE,
  INDEX `RezerwacjaID`(`RezerwacjaID` ASC) USING BTREE,
  CONSTRAINT `Wydarzenia_ibfk_1` FOREIGN KEY (`RezerwacjaID`) REFERENCES `Rezerwacja` (`RezerwacjaID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ZadanieDodatkowe
-- ----------------------------
DROP TABLE IF EXISTS `ZadanieDodatkowe`;
CREATE TABLE `ZadanieDodatkowe`  (
  `PracownikID` int UNSIGNED NOT NULL,
  `Data` date NOT NULL,
  `Opis` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  INDEX `PracownikID`(`PracownikID` ASC) USING BTREE,
  CONSTRAINT `ZadanieDodatkowe_ibfk_1` FOREIGN KEY (`PracownikID`) REFERENCES `Pracownik` (`PracownikID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for DodatkoweZadaniaPracownik
-- ----------------------------
DROP VIEW IF EXISTS `DodatkoweZadaniaPracownik`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `DodatkoweZadaniaPracownik` AS select `Pracownik`.`PracownikID` AS `PracownikID`,`Pracownik`.`Imie` AS `Imie`,`Pracownik`.`Nazwisko` AS `Nazwisko`,count(`ZadanieDodatkowe`.`PracownikID`) AS `IloscZadan` from (`Pracownik` left join `ZadanieDodatkowe` on(`Pracownik`.`PracownikID` = `ZadanieDodatkowe`.`PracownikID`)) group by `Pracownik`.`PracownikID` order by count(`ZadanieDodatkowe`.`PracownikID`) desc;

-- ----------------------------
-- View structure for KlienciZWydarzeniem
-- ----------------------------
DROP VIEW IF EXISTS `KlienciZWydarzeniem`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `KlienciZWydarzeniem` AS select `Klient`.`KlientID` AS `KlientID`,`Klient`.`Imie` AS `Imie`,`Klient`.`Nazwisko` AS `Nazwisko`,`Rezerwacja`.`RezerwacjaID` AS `RezerwacjaID`,`Wydarzenia`.`Nazwa` AS `NazwaWydarzenia` from ((`Klient` join `Rezerwacja` on(`Klient`.`KlientID` = `Rezerwacja`.`KlientID`)) join `Wydarzenia` on(`Rezerwacja`.`RezerwacjaID` = `Wydarzenia`.`RezerwacjaID`)) order by `Wydarzenia`.`RezerwacjaID` desc;

-- ----------------------------
-- View structure for RezerwacjeKlientow
-- ----------------------------
DROP VIEW IF EXISTS `RezerwacjeKlientow`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `RezerwacjeKlientow` AS select `Rezerwacja`.`RezerwacjaID` AS `RezerwacjaID`,`Klient`.`Imie` AS `Imie`,`Klient`.`Nazwisko` AS `Nazwisko`,`Pokoj`.`NrPokoju` AS `NrPokoju`,`Rezerwacja`.`DataZameldowania` AS `DataZameldowania`,`Rezerwacja`.`DataWymeldowania` AS `DataWymeldowania` from ((`Rezerwacja` join `Klient` on(`Rezerwacja`.`KlientID` = `Klient`.`KlientID`)) join `Pokoj` on(`Rezerwacja`.`PokojID` = `Pokoj`.`PokojID`)) order by `Rezerwacja`.`DataZameldowania` desc;

-- ----------------------------
-- View structure for RezerwacjeUslugi
-- ----------------------------
DROP VIEW IF EXISTS `RezerwacjeUslugi`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `RezerwacjeUslugi` AS select `Rezerwacja`.`RezerwacjaID` AS `RezerwacjaID`,`Klient`.`Imie` AS `Imie`,`Klient`.`Nazwisko` AS `Nazwisko`,`UslugaDodatkowa`.`Nazwa` AS `NazwaUslugi`,`UslugaDodatkowa`.`Cena` AS `CenaUslugi` from (((`Rezerwacja` left join `Klient` on(`Rezerwacja`.`KlientID` = `Klient`.`KlientID`)) left join `RezerwacjaUslugi` on(`Rezerwacja`.`RezerwacjaID` = `RezerwacjaUslugi`.`RezerwacjaID`)) left join `UslugaDodatkowa` on(`RezerwacjaUslugi`.`UslugaID` = `UslugaDodatkowa`.`UslugaID`)) order by `Rezerwacja`.`RezerwacjaID` desc;

-- ----------------------------
-- View structure for WynagrodzeniaMiesieczne
-- ----------------------------
DROP VIEW IF EXISTS `WynagrodzeniaMiesieczne`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `WynagrodzeniaMiesieczne` AS select `Pracownik`.`PracownikID` AS `PracownikID`,`Pracownik`.`Imie` AS `Imie`,`Pracownik`.`Nazwisko` AS `Nazwisko`,sum(hour(`GodzinyPracy`.`GodzinaZakonczenia`) - hour(`GodzinyPracy`.`GodzinaRozpoczecia`)) * `Pracownik`.`Stawka` AS `Wynagrodzenie` from (`Pracownik` left join `GodzinyPracy` on(`Pracownik`.`PracownikID` = `GodzinyPracy`.`PracownikID`)) where month(`GodzinyPracy`.`Dzien`) = month(curdate()) group by `Pracownik`.`PracownikID` order by `Pracownik`.`PracownikID`;

-- ----------------------------
-- Function structure for ObliczKosztRezerwacji
-- ----------------------------
DROP FUNCTION IF EXISTS `ObliczKosztRezerwacji`;
delimiter ;;
CREATE FUNCTION `ObliczKosztRezerwacji`(p_rezerwacjaID INT UNSIGNED)
 RETURNS decimal(10,2)
BEGIN 
    DECLARE cena DECIMAL(10, 2);

    DECLARE liczba_dni INT;

    SELECT
        DATEDIFF(DataWymeldowania, DataZameldowania) INTO liczba_dni
    FROM
        Rezerwacja
    WHERE
        RezerwacjaID = p_rezerwacjaID;

    SELECT
        CenaZaDobe INTO cena
    FROM
        Pokoj
        INNER JOIN Rezerwacja ON Pokoj.PokojID = Rezerwacja.PokojID
    WHERE
        RezerwacjaID = p_rezerwacjaID;

    SET cena = cena * liczba_dni;
RETURN cena;
END
;;
delimiter ;

-- ----------------------------
-- Event structure for GenerujRocznyRaport
-- ----------------------------
DROP EVENT IF EXISTS `GenerujRocznyRaport`;
delimiter ;;
CREATE EVENT `GenerujRocznyRaport`
ON SCHEDULE
EVERY '1' YEAR STARTS '2024-01-01 00:00:00'
DO BEGIN
    INSERT INTO RaportRoczny (Rok, IloscRezerwacji)
    SELECT
        YEAR(Rezerwacja.DataZameldowania) AS Rok,
        COUNT(*) AS IloscRezerwacji
    FROM
        Rezerwacja
    WHERE
        YEAR(Rezerwacja.DataZameldowania) = YEAR(CURDATE()) - 1
    GROUP BY
        YEAR(Rezerwacja.DataZameldowania);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Klient
-- ----------------------------
DROP TRIGGER IF EXISTS `SprawdzTelefonKlient`;
delimiter ;;
CREATE TRIGGER `SprawdzTelefonKlient` BEFORE UPDATE ON `Klient` FOR EACH ROW BEGIN 
    IF (SELECT COUNT(*) FROM Klient WHERE Telefon = NEW.Telefon AND KlientID != NEW.KlientID) > 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Numer telefonu jest już przypisany do innego klienta.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Pracownik
-- ----------------------------
DROP TRIGGER IF EXISTS `SprawdzPracownikZadania`;
delimiter ;;
CREATE TRIGGER `SprawdzPracownikZadania` BEFORE DELETE ON `Pracownik` FOR EACH ROW BEGIN 
    IF (SELECT COUNT(*) FROM ZadanieDodatkowe WHERE PracownikID = OLD.PracownikID) > 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nie można usunąć pracownika, który ma przypisane zadania. Przypisz jego zadania innemu pracownikowi, aby móc go usunąć.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Rezerwacja
-- ----------------------------
DROP TRIGGER IF EXISTS `SprawdzDateRezerwacja`;
delimiter ;;
CREATE TRIGGER `SprawdzDateRezerwacja` AFTER INSERT ON `Rezerwacja` FOR EACH ROW BEGIN 
    IF NEW.DataWymeldowania <= NEW.DataZameldowania THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data wymeldowania musi być późniejsza niż data zameldowania.';
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
