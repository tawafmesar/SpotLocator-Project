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
(5, 'Ahmed Mansor', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'tawafmesar@gmail.com', '3324234', 'test avatar', 64947, 0, 1, '2025-01-03 02:51:30'),;




--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`users_id`),
  ADD UNIQUE KEY `users_phone` (`users_phone`),
  ADD UNIQUE KEY `users_email` (`users_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




CREATE TABLE `vehicles` (
  `vehicle_id` int(11) NOT NULL,
  `plate_number` varchar(255) NOT NULL,
  `vehicle_desc` varchar(255) NOT NULL,
  `vehicle_type` enum('Electric','Hybrid','SUV','Hatchback','Sedan') NOT NULL,
  `vehicle_userid` int(11) NOT NULL,
  `vehicle_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`vehicle_id`, `plate_number`, `vehicle_desc`, `vehicle_type`, `vehicle_userid`, `vehicle_status`) VALUES
(1, 'ABC123', 'Toyota Corolla', 'Sedan', 1, 1),
(2, 'XYZ789', 'Tesla Model 3', 'Electric', 5, 1),
(3, 'JKL456', 'Ford Explorer', 'SUV', 1, 0),
(4, 'SKM445', 'Honda Civic', 'Hatchback', 5, 0);

ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD KEY `vehicle_userid` (`vehicle_userid`);


ALTER TABLE `vehicles`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD CONSTRAINT `vehicles_ibfk_1` FOREIGN KEY (`vehicle_userid`) REFERENCES `users` (`users_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
