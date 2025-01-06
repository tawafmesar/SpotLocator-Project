-- spotlocatordb.sql
-- This file contains the schema and sample data for SpotLocator.
-- Use it for setting up a development environment.


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spotlocatordb`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(255) NOT NULL,
  `dept_short` varchar(50) NOT NULL,
  `dept_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`, `dept_short`, `dept_image`) VALUES
(1, 'Parking Department 1', 'PDept1', 'dept1.png'),
(2, 'Parking Department 2', 'PDept2', 'dept2.png');

-- --------------------------------------------------------

--
-- Table structure for table `parkingreservation`
--

CREATE TABLE `parkingreservation` (
  `reservation_id` int(11) NOT NULL,
  `reservation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `reservation_status` int(11) NOT NULL DEFAULT 0,
  `vehicle_id` int(11) NOT NULL,
  `parkingspot_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `parkingreservation`
--

INSERT INTO `parkingreservation` (`reservation_id`, `reservation_date`, `reservation_status`, `vehicle_id`, `parkingspot_id`) VALUES
(1, '2025-01-06 01:06:31', 0, 7, 3),
(2, '2025-01-06 22:23:17', 0, 4, 5),
(3, '2025-01-06 22:24:20', 0, 2, 5),
(6, '2025-01-06 22:30:03', 0, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `parkingspot`
--

CREATE TABLE `parkingspot` (
  `parkingspot_id` int(11) NOT NULL,
  `spot_name` varchar(255) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `spot_status` int(11) NOT NULL DEFAULT 0,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `parkingspot`
--

INSERT INTO `parkingspot` (`parkingspot_id`, `spot_name`, `dept_id`, `spot_status`, `latitude`, `longitude`) VALUES
(3, '101', 1, 1, '16.930037', '42.622977'),
(4, '102', 1, 1, '16.930013', '42.622974'),
(5, '103', 1, 1, '16.929989', '42.622969'),
(6, '104', 1, 1, '16.929963', '42.622965'),
(7, '105', 1, 1, '16.929938', '42.622958'),
(8, '106', 1, 1, '16.929912', '42.622957'),
(9, '107', 1, 1, '16.929916', '42.622907'),
(10, '108', 1, 1, '16.929942', '42.622911'),
(11, '109', 1, 1, '16.929973', '42.622919'),
(12, '110', 1, 1, '16.929997', '42.622921'),
(13, '111', 1, 1, '16.930021', '42.622921'),
(14, '112', 1, 1, '16.930046', '42.622923');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `users_id` int(11) NOT NULL,
  `users_name` varchar(100) NOT NULL,
  `users_password` varchar(255) NOT NULL,
  `users_email` varchar(100) NOT NULL,
  `users_phone` varchar(100) NOT NULL,
  `users_avatar` varchar(255) DEFAULT NULL,
  `users_verfiycode` int(11) NOT NULL,
  `users_approve` tinyint(4) NOT NULL DEFAULT 0,
  `users_role` int(11) NOT NULL,
  `users_create` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`users_id`, `users_name`, `users_password`, `users_email`, `users_phone`, `users_avatar`, `users_verfiycode`, `users_approve`, `users_role`, `users_create`) VALUES
(1, 'Jamal Ali', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'test@gmail.com', '122122212', NULL, 95820, 1, 1, '2024-12-19 22:15:27'),
(2, 'Admin', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'admin@gmail.com', '1122334455', NULL, 91120, 1, 2, '2024-12-19 22:15:27'),
(5, 'Ahmed Mansor', '20eabe5d64b0e216796e834f52d61fd0b70332fc', 'ahmed@gmail.com', '3324234', NULL, 98816, 1, 1, '2025-01-03 05:10:54'),
(6, 'adda', 'dasasd', 'asdasd', 'asdas', 'dasasd', 12321, 0, 1, '2025-01-05 00:18:01');

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `vehicle_id` int(11) NOT NULL,
  `plate_number` varchar(255) NOT NULL,
  `vehicle_desc` varchar(255) NOT NULL,
  `vehicle_type` enum('Electric','Pickup','SUV','Hatchback','Sedan') NOT NULL,
  `vehicle_userid` int(11) NOT NULL,
  `vehicle_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vehicle_id`, `plate_number`, `vehicle_desc`, `vehicle_type`, `vehicle_userid`, `vehicle_status`) VALUES
(1, 'ABC123', 'Toyota Corolla', 'Sedan', 1, 0),
(2, 'XYZ789', 'Tesla Model 3', 'Electric', 5, 1),
(4, 'SKM445', 'Honda Civic', 'Hatchback', 5, 0),
(6, 'HNM876', 'Tesal model 3', 'Electric', 1, 0),
(7, 'TJZ1213', 'Toyota Yaris GR', 'Hatchback', 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `parkingreservation`
--
ALTER TABLE `parkingreservation`
  ADD PRIMARY KEY (`reservation_id`),
  ADD KEY `vehicle_id` (`vehicle_id`),
  ADD KEY `parkingreservation_ibfk_1` (`parkingspot_id`);

--
-- Indexes for table `parkingspot`
--
ALTER TABLE `parkingspot`
  ADD PRIMARY KEY (`parkingspot_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`users_id`),
  ADD UNIQUE KEY `users_phone` (`users_phone`),
  ADD UNIQUE KEY `users_email` (`users_email`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD KEY `vehicle_userid` (`vehicle_userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `dept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `parkingreservation`
--
ALTER TABLE `parkingreservation`
  MODIFY `reservation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `parkingspot`
--
ALTER TABLE `parkingspot`
  MODIFY `parkingspot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `parkingreservation`
--
ALTER TABLE `parkingreservation`
  ADD CONSTRAINT `parkingreservation_ibfk_1` FOREIGN KEY (`parkingspot_id`) REFERENCES `parkingspot` (`parkingspot_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `parkingreservation_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `parkingspot`
--
ALTER TABLE `parkingspot`
  ADD CONSTRAINT `parkingspot_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE CASCADE;

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`vehicle_userid`) REFERENCES `users` (`users_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
