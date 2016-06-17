-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2016 at 04:35 AM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 7.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pln_inventaris`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `chgpassword` (`var_password` VARCHAR(60), `var_id` INT(10))  BEGIN
update users set password=var_password, updated_at= NOW() where id=var_id;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmed` (`var_id` INT(10))  BEGIN
   update users set status_reg=1,created_at=NOW() where id=var_id;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editakun` (`var_nama` VARCHAR(255), `var_hp` VARCHAR(30), `var_alamat` VARCHAR(50), `var_id` INT(10))  BEGIN
 update users set name=var_nama, telepon=var_hp, alamat=var_alamat, updated_at=NOW() where id=var_id;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editfoto` (`var_foto` VARCHAR(40), `var_id` INT(10))  BEGIN
    update users set foto=var_foto, updated_at=NOW() where id=var_id;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (`var_id` INT(10))  BEGIN
update users set last_login=NOW(), status_login=1 where id=var_id;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `logout` (`var_id` INT(10))  BEGIN
update users set  status_login=0 where id=var_id;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register_native_user` (`var_name` VARCHAR(255), `var_email` VARCHAR(255), `var_password` VARCHAR(60), `var_remember_token` VARCHAR(100), `var_id_pegawai` VARCHAR(30), `var_telepon` VARCHAR(30), `var_jk` VARCHAR(1), `var_foto` VARCHAR(40), `var_username` VARCHAR(20), `var_alamat` VARCHAR(50))  BEGIN
        insert into users (name,email,password,remember_token,created_at,updated_at,role,status_login,status_reg,last_login,id_pegawai,telepon,jenis_kelamin,foto, username,alamat)
          values(var_name,var_email,var_password,var_remember_token,NOW(),NULL,2,0,0,NULL,var_id_pegawai,var_telepon,var_jk,var_foto,var_username, var_alamat);
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sent_remember_token` (`var_email` VARCHAR(225))  BEGIN
        update users set remember_token=var_email,updated_at=NOW() where email=var_email;
    END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `cek_confirmed` (`var_id` INT(10)) RETURNS INT(11) BEGIN
    set @s=(select status_reg from users where id=var_id);
    if(@s=1) then
    return 1;
    else
    return 0;
    end if;
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `cek_username` (`username1` VARCHAR(20), `email1` VARCHAR(255)) RETURNS INT(11) BEGIN
    set @a= (select count(*) from users where username=username1);
    set @b= (select count(*) from users where email=email1);
    set @c = @a+@b;
    return @c;    
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE `area` (
  `id_area` int(11) NOT NULL,
  `nama_area` varchar(30) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  `foto` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `kode_area` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`id_area`, `nama_area`, `alamat`, `telepon`, `foto`, `updated_at`, `created_at`, `kode_area`) VALUES
(1, 'Madiun Kota', 'M  Haryono', '0834920123', 'imgarea/68489.jpg', '2016-06-07 19:23:02', NULL, 'MDN'),
(3, 'Caruban', 'Jln Thamrin', '084239123', NULL, NULL, NULL, 'CRB'),
(5, 'Magetan', 'Jln Magetan', '031234321', NULL, NULL, NULL, 'MGT');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(30) DEFAULT NULL,
  `merek` varchar(20) DEFAULT NULL,
  `tahun` int(11) DEFAULT NULL,
  `nomor_inventaris` varchar(30) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `fisik` varchar(20) DEFAULT NULL,
  `keterangan` text,
  `fid_ruang` int(11) DEFAULT NULL,
  `gambar` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `fid_area` int(11) DEFAULT NULL,
  `noperarea` int(11) DEFAULT NULL,
  `narea` varchar(20) DEFAULT NULL,
  `nruang` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `merek`, `tahun`, `nomor_inventaris`, `jumlah`, `satuan`, `fisik`, `keterangan`, `fid_ruang`, `gambar`, `updated_at`, `created_at`, `fid_area`, `noperarea`, `narea`, `nruang`) VALUES
(34, 'Kursi Kerja Putar P Lengan', 'Brother', 2003, '0001/MGR/MDN/03', 1, 'buah', 'baik', '', 7, NULL, NULL, NULL, 1, 1, NULL, NULL),
(35, 'Telephone', 'Tens', 2005, '0001/MGR/CRB/05', 1, 'buah', 'baik', '', 9, NULL, '2016-06-15 07:33:47', NULL, 3, 1, NULL, NULL),
(36, 'Kursi Kerja Putar P Lengan', 'Brother', 2003, '0001/MGR/MGT/03', 1, 'buah', 'baik', '', 10, NULL, NULL, NULL, 5, 1, NULL, NULL),
(37, 'Apar Powder 5 Kg', 'Wormald', 2002, '0002/UAD/MDN/02', 1, 'buah', 'baik', '', 11, NULL, '2016-06-15 09:36:16', NULL, 1, 2, NULL, NULL),
(38, 'Sofa Tamu', 'Ikea', 2003, '0003/AUL/MDN/03', 1, 'set', 'baik', '', 1, NULL, NULL, NULL, 1, 3, NULL, NULL),
(39, 'Credensa 3 Pintu', 'Vinociti', 2004, '0004/MGR/MDN/04', 1, 'buah', 'baik', '', 7, NULL, NULL, NULL, 1, 4, NULL, NULL),
(41, 'Credensa 3 Pintu', 'Vinociti', 2004, '0002/UAD/CRB/04', 1, 'buah', 'baik', '', 12, NULL, NULL, NULL, 3, 2, NULL, NULL),
(42, 'Apar BCF 4,5 Kg', '', 2004, '0005/MGR/MDN/04', 1, 'buah', 'baik', '', 7, NULL, NULL, NULL, 1, 5, NULL, NULL),
(43, 'Almari', 'Data Scrip', 2004, '0002/UAD/MGT/04', 1, 'buah', 'baik', '', 13, NULL, NULL, NULL, 5, 2, NULL, NULL),
(44, 'Kaca Cermin', 'Alumunium', 2004, '0003/GDG/MGT/04', 1, 'buah', 'baik', '', 14, NULL, NULL, NULL, 5, 3, NULL, NULL),
(45, 'Mesin Hitung Listrik', 'Casio', 2004, '0006/UAD/MDN/04', 1, 'buah', 'baik', '', 11, NULL, NULL, NULL, 1, 6, NULL, NULL),
(46, 'OHP / Layar', '3 M', 2004, '0007/UAD/MDN/04', 1, 'buah', 'baik', '', 11, NULL, NULL, NULL, 1, 7, NULL, NULL),
(47, 'Proyektor', 'Sony', 2012, '0008/AUL/MDN/12', 1, 'buah', 'baik', '', 1, NULL, '2016-06-15 18:56:08', NULL, 1, 8, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ruang`
--

CREATE TABLE `ruang` (
  `id_ruang` int(11) NOT NULL,
  `nama_ruang` varchar(30) DEFAULT NULL,
  `fid_area` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `foto` varchar(20) DEFAULT NULL,
  `kode_ruang` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruang`
--

INSERT INTO `ruang` (`id_ruang`, `nama_ruang`, `fid_area`, `updated_at`, `created_at`, `foto`, `kode_ruang`) VALUES
(1, 'Aula', 1, NULL, NULL, NULL, 'AUL'),
(3, 'Kerja', 1, NULL, NULL, NULL, 'KER'),
(4, 'Gudang', 1, NULL, NULL, NULL, 'GDG'),
(5, 'Gudangan', 3, '2016-06-08 10:14:12', NULL, NULL, 'GD1'),
(7, 'Manajer', 1, NULL, NULL, NULL, 'MGR'),
(9, 'Manajer', 3, NULL, NULL, NULL, 'MGR'),
(10, 'Manajer', 5, NULL, NULL, NULL, 'MGR'),
(11, 'ADM & KEU', 1, NULL, NULL, NULL, 'UAD'),
(12, 'ADM & KEU', 3, NULL, NULL, NULL, 'UAD'),
(13, 'ADM & KEU', 5, NULL, NULL, NULL, 'UAD'),
(14, 'Gudang', 5, NULL, NULL, NULL, 'GDG');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `role` int(11) DEFAULT NULL COMMENT '1 utk admin, 2 untuk native',
  `status_login` int(10) DEFAULT NULL COMMENT '0 jika belum , 1 jika login',
  `status_reg` int(10) DEFAULT NULL COMMENT '0 jika belum , 1 jika terdaftar',
  `last_login` timestamp NULL DEFAULT NULL COMMENT 'waktu terakhir login',
  `id_pegawai` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telepon` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jenis_kelamin` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Laki2 atau perempuan di if',
  `foto` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'path ke lokasi photo',
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alamat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `role`, `status_login`, `status_reg`, `last_login`, `id_pegawai`, `telepon`, `jenis_kelamin`, `foto`, `username`, `alamat`) VALUES
(1, 'iqbal rifqi', 'rifqimaulaiqbal@gmail.com', '$2y$10$BjZWIkjIVgr/Bdl9SfYmDuH9O6HDR7ceZ8FUEL7PZOVjthSvHsEX2', '5rjPvEf654xhgNuVIstmC8f4TJ7IrqAqazbUcdfgfn8rngHYLEoY6wCoQ0Cx', '2016-06-09 05:42:28', '2016-06-16 19:00:10', 1, 1, 1, '2016-06-17 02:00:42', '1213', '9999', 'L', 'imguser/53287.png', 'iqbal', 'kkk'),
(3, 'rifqi maula', 'admin@admin.com', '$2y$10$O/wVxInDSOiomHmhTTnYPusAm0tSDBkp960d0DyIwFpFKy9Uegu/G', NULL, '2016-06-14 03:42:08', '2016-06-10 06:40:18', 2, 0, 1, NULL, '994', '000', 'P', 'imguser/48152.jpg', 'reza', NULL),
(4, 'ronaldo', 'dodo@gmail.com', '$2y$10$M7b5LNvtBk1wjZYIgdrw3.3Pls6rMA77eccZnUIichNRjNKh7TX8y', 'rfly7DxNWfUpWckl1TH0VA5McE6m5zXQh2OoQP661gzjrJQ0NYe9TS29KA3O', '2016-06-10 06:45:45', '2016-06-11 01:17:31', 2, 0, 1, NULL, '779', '997', 'L', 'imgbarang/83517.jpg', 'penaldo', 'wayut'),
(7, 'Ganteng', 'gurat@gmail.com', '$2y$10$MnNIyPkCeuEZnHj6GXlPzuPfGJOCj5dcCa9BTeHNSyNG1OTiP7Gm6', NULL, '2016-06-14 07:08:34', '2016-06-14 07:08:34', 2, 0, 0, NULL, 'Ganteng', '7751212', 'L', 'imguser/43058.jpg', 'leicester', 'Malang'),
(8, 'bana', 'abc@gmail.com', '$2y$10$B8V5t6w6uKFXb0YXVkM/9uJxnn7.6BCW5.4DLWh.wkNhaCxCmUoMa', 'r5Xe7bc7QaH7QmdNb9tgLcC97wo9UgCiEOKlyW4KeMM8aTaCf8Pby8Xs7vTz', '2016-06-14 16:16:07', '2016-06-15 20:33:50', 1, 1, 1, '2016-06-16 05:16:00', '34342341', '0843413123', 'L', 'imguser/78285.png', 'bana', 'Jln Thamrin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id_area`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `fid_area_barang` (`fid_area`),
  ADD KEY `fid_ruang_barang` (`fid_ruang`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `ruang`
--
ALTER TABLE `ruang`
  ADD PRIMARY KEY (`id_ruang`),
  ADD KEY `fid_area` (`fid_area`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `area`
--
ALTER TABLE `area`
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT for table `ruang`
--
ALTER TABLE `ruang`
  MODIFY `id_ruang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `fid_area_barang` FOREIGN KEY (`fid_area`) REFERENCES `area` (`id_area`),
  ADD CONSTRAINT `fid_ruang_barang` FOREIGN KEY (`fid_ruang`) REFERENCES `ruang` (`id_ruang`);

--
-- Constraints for table `ruang`
--
ALTER TABLE `ruang`
  ADD CONSTRAINT `fid_area` FOREIGN KEY (`fid_area`) REFERENCES `area` (`id_area`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
