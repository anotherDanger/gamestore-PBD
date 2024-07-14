-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Waktu pembuatan: 14 Jul 2024 pada 23.53
-- Versi server: 8.4.0
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamestore`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getGamePrice` (IN `gameTitle` VARCHAR(100), OUT `gamePrice` DECIMAL(10,2))   BEGIN
    SELECT price INTO gamePrice FROM games WHERE title = gameTitle;

    IF gamePrice IS NULL THEN
        SET gamePrice = 0.00;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listCustomers` ()   BEGIN
    SELECT * FROM customers;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getCustomerCount` () RETURNS INT  BEGIN
    DECLARE customer_count INT;
    SELECT COUNT(*) INTO customer_count FROM customers;
    RETURN customer_count;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getCustomerOrderTotal` (`customerId` INT, `orderId` INT) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE order_total DECIMAL(10, 2);
    SELECT total INTO order_total FROM orders WHERE customer_id = customerId AND order_id = orderId;
    RETURN order_total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `email`, `phone`) VALUES
(1, 'Andhika', 'updated_andhika@gmail.com', '555-1234'),
(2, 'Faqih', 'faqih@gmail.com', '555-5678'),
(3, 'Patri', 'patri@example.com', '555-9012'),
(4, 'Amrul', 'amrul@gmail.com', '555-3456'),
(5, 'Syahid', 'syahid@gmail.com', '555-7890'),
(14, 'Wisnu', 'wisnu@gmail.com', NULL);

--
-- Trigger `customers`
--
DELIMITER $$
CREATE TRIGGER `after_delete_customers` AFTER DELETE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO log_table (action_type, table_name, old_data)
    VALUES ('AFTER DELETE', 'customers', CONCAT('name=', OLD.name, ', email=', OLD.email, ', phone=', OLD.phone));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_customers` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
    INSERT INTO log_table (action_type, table_name, new_data)
    VALUES ('AFTER INSERT', 'customers', CONCAT('name=', NEW.name, ', email=', NEW.email, ', phone=', NEW.phone));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_customers` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO log_table (action_type, table_name, old_data, new_data)
    VALUES ('AFTER UPDATE', 'customers', CONCAT('name=', OLD.name, ', email=', OLD.email, ', phone=', OLD.phone),
            CONCAT('name=', NEW.name, ', email=', NEW.email, ', phone=', NEW.phone));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_customers` BEFORE DELETE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO log_table (action_type, table_name, old_data)
    VALUES ('BEFORE DELETE', 'customers', CONCAT('name=', OLD.name, ', email=', OLD.email, ', phone=', OLD.phone));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_customers` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
    INSERT INTO log_table (action_type, table_name, new_data)
    VALUES ('BEFORE INSERT', 'customers', CONCAT('name=', NEW.name, ', email=', NEW.email, ', phone=', NEW.phone));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_customers` BEFORE UPDATE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO log_table (action_type, table_name, old_data, new_data)
    VALUES ('BEFORE UPDATE', 'customers', CONCAT('name=', OLD.name, ', email=', OLD.email, ', phone=', OLD.phone),
            CONCAT('name=', NEW.name, ', email=', NEW.email, ', phone=', NEW.phone));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `customer_details`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `customer_details` (
`name` varchar(100)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `developers`
--

CREATE TABLE `developers` (
  `developer_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `game_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `developers`
--

INSERT INTO `developers` (`developer_id`, `name`, `game_id`) VALUES
(1, 'Nintendo', 1),
(2, 'Nintendo', 2),
(3, 'Mojang', 3),
(4, 'CD Projekt Red', 4),
(5, 'Epic Games', 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `employees`
--

CREATE TABLE `employees` (
  `employee_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `employees`
--

INSERT INTO `employees` (`employee_id`, `name`) VALUES
(1, 'Andhika'),
(2, 'Faqih'),
(3, 'Patri'),
(4, 'Amrul'),
(5, 'Sultan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `employee_details`
--

CREATE TABLE `employee_details` (
  `employee_id` int NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `employee_details`
--

INSERT INTO `employee_details` (`employee_id`, `address`, `salary`) VALUES
(1, 'Caturtunggal, Sleman', 50000.00),
(2, 'Maguwoharjo, Sleman', 60000.00),
(3, 'Maguwoharjo, Sleman', 55000.00),
(4, 'Condongcatur, Sleman', 55000.00),
(5, 'Condongcatur, Sleman', 55000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `games`
--

CREATE TABLE `games` (
  `game_id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `genre` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `games`
--

INSERT INTO `games` (`game_id`, `title`, `genre`, `price`) VALUES
(1, 'The Legend of Zelda', 'Adventure', 59.99),
(2, 'Super Mario Odyssey', 'Platformer', 49.99),
(3, 'Minecraft', 'Sandbox', 26.95),
(4, 'The Witcher 3', 'RPG', 39.99),
(5, 'Fortnite', 'Battle Royale', 0.00);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `game_developers`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `game_developers` (
`developer_name` varchar(100)
,`game_title` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `game_sales`
--

CREATE TABLE `game_sales` (
  `sale_id` int NOT NULL,
  `game_id` int NOT NULL,
  `sale_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `high_price_games`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `high_price_games` (
`title` varchar(100)
,`price` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_table`
--

CREATE TABLE `log_table` (
  `log_id` int NOT NULL,
  `action_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `action_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `table_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `old_data` text COLLATE utf8mb4_general_ci,
  `new_data` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_table`
--

INSERT INTO `log_table` (`log_id`, `action_type`, `action_timestamp`, `table_name`, `old_data`, `new_data`) VALUES
(1, 'BEFORE INSERT', '2024-07-14 19:53:15', 'customers', NULL, 'name=Rizky, email=rizky@gmail.com, phone=525-9876'),
(2, 'AFTER INSERT', '2024-07-14 19:53:15', 'customers', NULL, 'name=Rizky, email=rizky@gmail.com, phone=525-9876'),
(3, 'BEFORE UPDATE', '2024-07-14 19:54:27', 'customers', 'name=Rizky, email=rizky@gmail.com, phone=525-9876', 'name=Rizky, email=rizky@gmail.com, phone=155-4321'),
(4, 'AFTER UPDATE', '2024-07-14 19:54:27', 'customers', 'name=Rizky, email=rizky@gmail.com, phone=525-9876', 'name=Rizky, email=rizky@gmail.com, phone=155-4321'),
(5, 'BEFORE DELETE', '2024-07-14 19:55:31', 'customers', 'name=Rizky, email=rizky@gmail.com, phone=155-4321', NULL),
(6, 'AFTER DELETE', '2024-07-14 19:55:31', 'customers', 'name=Rizky, email=rizky@gmail.com, phone=155-4321', NULL),
(7, 'BEFORE UPDATE', '2024-07-14 20:00:26', 'customers', 'name=Andhika, email=andhika@gmail.com, phone=555-1234', 'name=Andhika, email=updated_andhika@gmail.com, phone=555-1234'),
(8, 'AFTER UPDATE', '2024-07-14 20:00:26', 'customers', 'name=Andhika, email=andhika@gmail.com, phone=555-1234', 'name=Andhika, email=updated_andhika@gmail.com, phone=555-1234'),
(9, 'BEFORE INSERT', '2024-07-14 20:01:44', 'customers', NULL, NULL),
(10, 'AFTER INSERT', '2024-07-14 20:01:44', 'customers', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `nintendo_games`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `nintendo_games` (
`developer_name` varchar(100)
,`game_title` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `employee_id`, `order_date`, `total`) VALUES
(1, 1, 2, '2024-07-14 18:34:32', 59.99),
(2, 2, 1, '2024-07-14 18:34:32', 49.99),
(3, 3, 3, '2024-07-14 18:34:32', 66.94),
(4, 4, 1, '2024-07-14 18:34:32', 39.99),
(5, 5, 1, '2024-07-14 18:34:32', 0.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int NOT NULL,
  `game_id` int NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `order_items`
--

INSERT INTO `order_items` (`order_id`, `game_id`, `quantity`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 1);

-- --------------------------------------------------------

--
-- Struktur untuk view `customer_details`
--
DROP TABLE IF EXISTS `customer_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_details`  AS SELECT `customers`.`name` AS `name`, `customers`.`email` AS `email` FROM `customers` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `game_developers`
--
DROP TABLE IF EXISTS `game_developers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `game_developers`  AS SELECT `d`.`name` AS `developer_name`, `g`.`title` AS `game_title` FROM (`developers` `d` join `games` `g` on((`d`.`game_id` = `g`.`game_id`))) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `high_price_games`
--
DROP TABLE IF EXISTS `high_price_games`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `high_price_games`  AS SELECT `games`.`title` AS `title`, `games`.`price` AS `price` FROM `games` WHERE (`games`.`price` > 30.00) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `nintendo_games`
--
DROP TABLE IF EXISTS `nintendo_games`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nintendo_games`  AS SELECT `game_developers`.`developer_name` AS `developer_name`, `game_developers`.`game_title` AS `game_title` FROM `game_developers` WHERE (`game_developers`.`developer_name` = 'Nintendo')WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_customer_email_phone` (`email`,`phone`);

--
-- Indeks untuk tabel `developers`
--
ALTER TABLE `developers`
  ADD PRIMARY KEY (`developer_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Indeks untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indeks untuk tabel `employee_details`
--
ALTER TABLE `employee_details`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indeks untuk tabel `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`game_id`);

--
-- Indeks untuk tabel `game_sales`
--
ALTER TABLE `game_sales`
  ADD PRIMARY KEY (`sale_id`),
  ADD KEY `game_id` (`game_id`,`sale_date`);

--
-- Indeks untuk tabel `log_table`
--
ALTER TABLE `log_table`
  ADD PRIMARY KEY (`log_id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `idx_customer_order` (`customer_id`,`order_date`),
  ADD KEY `fk_employee_id` (`employee_id`);

--
-- Indeks untuk tabel `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_id`,`game_id`),
  ADD KEY `game_id` (`game_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `developers`
--
ALTER TABLE `developers`
  MODIFY `developer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `games`
--
ALTER TABLE `games`
  MODIFY `game_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `game_sales`
--
ALTER TABLE `game_sales`
  MODIFY `sale_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `log_table`
--
ALTER TABLE `log_table`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `developers`
--
ALTER TABLE `developers`
  ADD CONSTRAINT `developers_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`);

--
-- Ketidakleluasaan untuk tabel `employee_details`
--
ALTER TABLE `employee_details`
  ADD CONSTRAINT `employee_details_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Ketidakleluasaan untuk tabel `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
