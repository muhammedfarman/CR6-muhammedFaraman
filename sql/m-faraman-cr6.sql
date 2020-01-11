-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2020 at 08:44 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tests`
--

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `class_id` int(11) NOT NULL,
  `className` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `className`) VALUES
(1, '1a'),
(2, '2a'),
(3, '3a'),
(4, '4a');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `student_name` varchar(55) DEFAULT NULL,
  `student_surname` varchar(55) DEFAULT NULL,
  `student_email` varchar(55) DEFAULT NULL,
  `fk_class_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `student_name`, `student_surname`, `student_email`, `fk_class_id`) VALUES
(1, 'Tony', 'Stark', 'ts@domain.com', 1),
(2, 'Steve', 'Rogers', 'sr@domain.com', 1),
(3, 'Bruce', 'Banner', 'bb@domain.com', 1),
(4, 'Harry', 'Potter', 'hp@domain.com', 2),
(5, 'Ronald', 'Weasley', 'rw@domain.com', 2),
(6, 'Hermione', 'Granger', 'hg@domain.com', 2),
(7, 'Micheal', 'Townley', 'mt@domain.com', 3),
(8, 'Trevor', 'Philips', 'tp@domain.com', 3),
(9, 'Franklin', 'Clinton', 'fc@domain.com', 3),
(10, 'Jack', 'Sparrow', 'js@domain.com', 4),
(11, 'William', 'Turner', 'wt@domain.com', 4),
(12, 'Elizabeth', 'Swann', 'es@domain.com', 4);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL,
  `teacher_name` varchar(55) DEFAULT NULL,
  `teacher_surname` varchar(55) DEFAULT NULL,
  `teacher_emal` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`teacher_id`, `teacher_name`, `teacher_surname`, `teacher_emal`) VALUES
(1, 'John', 'Doe', 'jd@domain.com'),
(2, 'Jane', 'Doe', 'jd@domain.com'),
(3, 'James', 'Doe', 'jd@domain.com'),
(4, 'Jake', 'Doe', 'jd@domain.com');

-- --------------------------------------------------------

--
-- Table structure for table `teaching`
--

CREATE TABLE `teaching` (
  `teaching_id` int(11) NOT NULL,
  `fk_teacher_id` int(11) DEFAULT NULL,
  `fk_class_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `teaching`
--

INSERT INTO `teaching` (`teaching_id`, `fk_teacher_id`, `fk_class_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 4),
(4, 2, 3),
(5, 2, 4),
(6, 3, 1),
(7, 3, 3),
(8, 4, 1),
(9, 4, 3),
(10, 4, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD KEY `fk_class_id` (`fk_class_id`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`);

--
-- Indexes for table `teaching`
--
ALTER TABLE `teaching`
  ADD PRIMARY KEY (`teaching_id`),
  ADD KEY `fk_teacher_id` (`fk_teacher_id`),
  ADD KEY `fk_class_id` (`fk_class_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `teaching`
--
ALTER TABLE `teaching`
  MODIFY `teaching_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`fk_class_id`) REFERENCES `class` (`class_id`);

--
-- Constraints for table `teaching`
--
ALTER TABLE `teaching`
  ADD CONSTRAINT `teaching_ibfk_1` FOREIGN KEY (`fk_teacher_id`) REFERENCES `teacher` (`teacher_id`),
  ADD CONSTRAINT `teaching_ibfk_2` FOREIGN KEY (`fk_class_id`) REFERENCES `class` (`class_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
