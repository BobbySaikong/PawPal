-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2025 at 09:12 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pawpal_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pets`
--

CREATE TABLE `tbl_pets` (
  `pet_id` int(11) NOT NULL COMMENT 'Unique ID',
  `user_id` int(11) NOT NULL COMMENT 'Foreign key to tbl_users',
  `pet_name` varchar(100) NOT NULL,
  `pet_type` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL COMMENT 'Adoption/Donation/Help',
  `description` text NOT NULL,
  `image_paths` text NOT NULL COMMENT 'JSON or comma-separated list of up to 3 paths',
  `latitude` varchar(50) NOT NULL COMMENT 'Latitude',
  `longitude` varchar(50) NOT NULL COMMENT 'Longitude',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL COMMENT 'Unique ID',
  `user_name` varchar(100) NOT NULL COMMENT 'User''s full name',
  `user_email` varchar(100) NOT NULL COMMENT 'User login email',
  `user_password` varchar(255) NOT NULL COMMENT 'Hashed password',
  `user_phone` varchar(20) NOT NULL COMMENT 'Required',
  `user_regdate` datetime NOT NULL COMMENT 'Timestamp'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_name`, `user_email`, `user_password`, `user_phone`, `user_regdate`) VALUES
(1, 'Zaki Adib', 'zakiadib4646@gmail.com', 'a15ac34f197fa99cb250cb65e36fb3acd9b5226c', '0164086242', '2025-11-25 21:31:30'),
(2, 'Wardah Kamilah', 'wardahkamilahahmad@gmail.com', 'ef4b433eb704285ae6d9fa6bb7c2fecec3b2d82c', '0199815945', '2025-12-04 11:45:15'),
(3, 'megat', 'megat@gmail.com', 'e647c6c76403c2df48d46709e84051a8a98b8ccd', '01946732', '0000-00-00 00:00:00'),
(4, 'nabil', 'nabil@gmail.com', 'ca54b1f05c301cdaa56388164b677d47c7974f30', '01123456', '0000-00-00 00:00:00'),
(5, 'azizi', 'azizi@gmail.com', 'b5db8e969376f1fc088268f09c6633add40ac64d', '0198994066', '0000-00-00 00:00:00'),
(6, 'alip', 'alip@gmail.com', 'e4b350197a72dd0a97f041deca53ea420e0b71bb', '019899500', '0000-00-00 00:00:00'),
(7, 'dwi', 'dwi@gmail.com', '03cb3d0958c37eff1579d63639b6870f186bdc23', '019863782', '0000-00-00 00:00:00'),
(8, 'irza', 'irza@gmail.com', 'e96306ec85e68b2cd9aa91792d743c6c94460136', '0198994066', '0000-00-00 00:00:00'),
(9, 'fariz', 'fariz@gmail.com', '75e85eaca23b5c9eebbd4e40993f1c872406ef99', '011888999', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_pets`
--
ALTER TABLE `tbl_pets`
  ADD PRIMARY KEY (`pet_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_pets`
--
ALTER TABLE `tbl_pets`
  MODIFY `pet_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID';

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID', AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
