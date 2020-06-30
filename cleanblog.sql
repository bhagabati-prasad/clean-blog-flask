-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2020 at 05:36 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cleanblog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `phone` int(12) DEFAULT NULL,
  `msg` varchar(100) DEFAULT NULL,
  `email` varchar(65) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone`, `msg`, `email`, `date`) VALUES
(1, 'Admin', 1234567890, 'First Post.', 'example@abc.com', '2020-03-27 15:39:09'),
(2, 'sad', 1234, 'sadfgn', 'asdf', '2020-03-27 16:54:27'),
(3, 'Aleph Naught', 1234567890, 'Hi. I\'m Aleph Naught.', 'aleph@abc.com', '2020-03-27 17:55:25'),
(4, 'Bhagabati Prasad', 2147483647, 'Testing...', 'bhagabatiprasada@gmail.com', '2020-03-28 06:04:15'),
(5, 'Bhagabati Prasad', 2147483647, 'Testing...', 'bhagabatiprasada@gmail.com', '2020-03-28 06:04:51'),
(6, 'Bhagabati Prasad', 2147483647, 'Testing...', 'bhagabatiprasada@gmail.com', '2020-03-28 06:04:56'),
(7, 'Tuni Shark', 2147483647, 'Hi. I\'m Tuni Shark. ', 'bhagabatiprasada@gmail.com', '2020-03-28 06:07:46'),
(8, 'Tuni Shark', 2147483647, 'Hi. I\'m Tuni Shark. ', 'bhagabatiprasada@gmail.com', '2020-03-28 06:08:34'),
(9, 'Demo name', 322423, 'Demo Message.', 'demo@email.com', '2020-03-28 06:23:18'),
(10, 'Demo name', 322423, 'Demo Message.', 'demo@email.com', '2020-03-28 06:25:44'),
(11, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:28:10'),
(12, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:38:28'),
(13, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:38:48'),
(14, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:46:18'),
(15, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:46:37'),
(16, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:49:56'),
(17, 'No name', 21334, 'No message.', 'sdf@email.com', '2020-03-28 06:52:28'),
(18, 'Anything', 12314, 'adsfd', 'anything@abc,.com', '2020-03-28 07:03:23'),
(19, 'aedgsf', 1414, 'dvzcae', 'dvs', '2020-03-28 07:49:18');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `img_file` varchar(55) NOT NULL,
  `title` varchar(70) DEFAULT NULL,
  `tagline` varchar(60) NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` varchar(700) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `img_file`, `title`, `tagline`, `slug`, `content`, `date`) VALUES
(1, 'post-bg.jpg', 'This is my first post', 'First Post Tagline.', 'first-post', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2020-03-28 08:04:11'),
(2, 'post-bg.jpg', 'SecondPost', 'SecondPost Tagline', 'second-post', 'This is the second post.', '2020-03-29 07:09:41'),
(3, 'post-bg.jpg', 'Third Post', 'Third Post Tagline.', 'third-post', 'This is the Third post content.', '2020-03-29 07:13:33'),
(4, 'post-bg.jpg', 'New Title', 'New tagline', 'new-post', 'This is new Content.', '2020-03-31 17:48:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
