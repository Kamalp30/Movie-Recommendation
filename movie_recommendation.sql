-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 12, 2024 at 01:50 AM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movie_recommendation`
--

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `genre` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `title`, `genre`, `rating`, `createdAt`, `updatedAt`) VALUES
(1, 'Venom', '878', 6.834, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(2, 'Venom', '27', 5.5, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(3, 'Venom', '27', 4.8, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(4, 'Venom: Let There Be Carnage', '878', 6.8, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(5, 'Venom', '27', 5.6, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(6, 'Venom', '53', 5.5, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(7, 'Venom', '16', 8.3, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(8, 'Venom', NULL, 5, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(9, 'Venom', '99', 10, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(10, 'Venom', '35', 8, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(11, 'Venom: The Last Dance', '28', 6.7, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(12, 'Silent Venom', '28', 5.1, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(13, 'The Five Venoms', '28', 6.7, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(14, 'Spider-Man: The Venom Saga', '16', 6.8, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(15, 'Medusa\'s' Venom', '27', 6.2, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(16, 'Venom and Eternity', '35', 6.7, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(17, 'Snake Venom', '35', 5.3, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(18, 'Scorpion: Double Venom', '80', 3.8, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(19, 'Venom', '18', 6.2, '2024-12-11 09:48:40', '2024-12-11 09:48:40'),
(20, 'Venom - A diva in Exile', NULL, 10, '2024-12-11 09:48:40', '2024-12-11 09:48:40');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `reviewText` text,
  `movieId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `movieId` (`movieId`),
  KEY `userId` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `rating`, `reviewText`, `movieId`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 4, 'best', 1206617, 5, '2024-12-10 09:28:40', '2024-12-10 09:28:40'),
(2, 5, 'asda', 1138194, 5, '2024-12-10 09:46:33', '2024-12-10 09:46:33'),
(3, 4, 'gggsdgs', 1138194, 5, '2024-12-10 09:46:42', '2024-12-10 09:46:42'),
(4, 1, 'asdadas', 1138194, 5, '2024-12-10 09:46:55', '2024-12-10 09:46:55'),
(5, 4, 'asdasda', 912649, 5, '2024-12-10 09:59:09', '2024-12-10 09:59:09'),
(6, 5, 'asdasdada', 1138194, 5, '2024-12-10 10:01:35', '2024-12-10 10:01:35'),
(7, 2, 'asdadsad', 1064213, 5, '2024-12-10 10:02:47', '2024-12-10 10:02:47'),
(8, 5, 'asdasdadasd', 1064213, 6, '2024-12-10 10:03:35', '2024-12-10 10:03:35'),
(9, 5, 'qwqweq', 1138194, 6, '2024-12-10 10:09:57', '2024-12-10 10:09:57'),
(10, 5, 'ssssssssss', 1138194, 6, '2024-12-10 10:16:47', '2024-12-10 10:16:47'),
(11, 5, 'egefe', 912649, 8, '2024-12-10 10:29:35', '2024-12-10 10:29:35'),
(12, 5, 'xbvxnvx', 912649, 6, '2024-12-11 09:08:36', '2024-12-11 09:08:36'),
(13, 4, 'asdasda', 912649, 6, '2024-12-11 09:08:42', '2024-12-11 09:08:42'),
(14, 2, 'asdasda', 912649, 6, '2024-12-11 09:08:46', '2024-12-11 09:08:46'),
(15, 4, 'asfasfasfa', 912649, 6, '2024-12-11 09:08:52', '2024-12-11 09:08:52'),
(16, 5, 'asdad', 912649, 6, '2024-12-11 09:45:08', '2024-12-11 09:45:08');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `createdAt`, `updatedAt`) VALUES
(5, 'uu', 'sampathdp28@gmail.com', '$2b$10$P8HUPE9s5Twz4CKscNa90Ot.fXExLurvdMVa0OdyNWqD4MKKUdM1q', '2024-12-10 06:56:35', '2024-12-10 06:56:35'),
(6, 'sampath', 'sampathperies123@gmail.com', '$2b$10$sDZe0.tYNgpVbotmFrqTJuSzgq6dB7qHcDQ8KziB0ZiEsn6RWW1Dq', '2024-12-10 10:03:16', '2024-12-10 10:03:16'),
(7, 'test', 'test@gmail.com', '$2b$10$ZxLNA6tgoN47cNufyV1ov.O3j1fIHXAo0FW1COJnONfY06zBqARz2', '2024-12-10 10:23:50', '2024-12-10 10:23:50'),
(8, 'ttttt', 'test1@gmail.com', '$2b$10$Wo8T/DY6GZ6ZO90EM4u1K.TXxzliWlsaER/OeXOGu2XEmfTS.aGti', '2024-12-10 10:29:15', '2024-12-10 10:29:15');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
