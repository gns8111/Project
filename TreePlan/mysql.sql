-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        5.7.27-log - MySQL Community Server (GPL)
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- teamproject 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `teamproject` /*!40100 DEFAULT CHARACTER SET euckr */;
USE `teamproject`;

-- 테이블 teamproject.complete 구조 내보내기
CREATE TABLE IF NOT EXISTS `complete` (
  `pjtIdx` int(11) NOT NULL DEFAULT '0',
  `id` char(20) NOT NULL DEFAULT '',
  `days` char(50) NOT NULL DEFAULT '',
  `DATE` char(20) NOT NULL DEFAULT '',
  `detail` char(100) NOT NULL DEFAULT '',
  `TIME` char(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`pjtIdx`,`id`,`days`,`DATE`),
  KEY `detailPlanIdx` (`days`),
  CONSTRAINT `FK_complete_detailplan` FOREIGN KEY (`pjtIdx`, `id`, `days`) REFERENCES `detailplan` (`pjtIdx`, `id`, `days`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 teamproject.detailplan 구조 내보내기
CREATE TABLE IF NOT EXISTS `detailplan` (
  `pjtIdx` int(11) NOT NULL AUTO_INCREMENT,
  `id` char(20) NOT NULL DEFAULT '',
  `days` char(10) NOT NULL,
  `detail` char(100) NOT NULL,
  `onOff` int(2) NOT NULL,
  PRIMARY KEY (`pjtIdx`,`id`,`days`),
  KEY `memberIdx` (`id`),
  CONSTRAINT `FK_detailplan_pjtmembers` FOREIGN KEY (`pjtIdx`, `id`) REFERENCES `pjtmembers` (`pjtIdx`, `id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=euckr;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 teamproject.pjtmembers 구조 내보내기
CREATE TABLE IF NOT EXISTS `pjtmembers` (
  `pjtIdx` int(11) NOT NULL,
  `id` char(20) NOT NULL,
  `joinDate` char(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`pjtIdx`,`id`),
  KEY `pjtIdx` (`pjtIdx`),
  KEY `pjtmembers_ibfk_2` (`id`),
  CONSTRAINT `pjtmembers_ibfk_1` FOREIGN KEY (`pjtIdx`) REFERENCES `projects` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pjtmembers_ibfk_2` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 teamproject.projects 구조 내보내기
CREATE TABLE IF NOT EXISTS `projects` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `pjtName` char(100) NOT NULL,
  `creator` char(20) NOT NULL,
  `team` int(1) NOT NULL,
  `photo` char(100) DEFAULT NULL,
  `startDate` char(50) NOT NULL DEFAULT '',
  `endDate` char(50) NOT NULL DEFAULT '',
  `numMax` int(11) NOT NULL,
  `numofppl` int(11) NOT NULL,
  `PASSWORD` char(20) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `projects_ibfk_1` (`creator`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=euckr;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 teamproject.qna 구조 내보내기
CREATE TABLE IF NOT EXISTS `qna` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `id` char(20) NOT NULL,
  `title` char(20) NOT NULL,
  `question` char(100) NOT NULL,
  `qDate` char(50) NOT NULL DEFAULT '',
  `answer` char(100) DEFAULT NULL,
  `aDate` char(50) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `id` (`id`),
  CONSTRAINT `qna_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=euckr;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 teamproject.users 구조 내보내기
CREATE TABLE IF NOT EXISTS `users` (
  `id` char(20) NOT NULL,
  `pwd` char(20) NOT NULL,
  `NAME` char(20) NOT NULL,
  `photo` char(200) NOT NULL,
  `address` char(50) NOT NULL,
  `email` char(40) NOT NULL,
  `admin` int(1) DEFAULT '0',
  `pwdQ` char(100) NOT NULL,
  `pwdA` char(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
