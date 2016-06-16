-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2016 at 10:11 PM
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
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`id_area`, `nama_area`, `alamat`, `telepon`, `foto`, `updated_at`, `created_at`) VALUES
(1, 'Madiun Kota', 'M  Haryono', '0834920123', 'imgarea/68489.jpg', '2016-06-07 19:23:02', NULL),
(3, 'Caruban', 'Jln Thamrin', '084239123', NULL, NULL, NULL),
(4, 'New York', 'Jln New York', '0980892341', NULL, NULL, NULL);

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
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `merek`, `tahun`, `nomor_inventaris`, `jumlah`, `satuan`, `fisik`, `keterangan`, `fid_ruang`, `gambar`, `updated_at`, `created_at`) VALUES
(1, 'OHP dengan Layar', '3 M', 2004, '210/UAD/CRB/04', 3, 'buah', 'baik', 'sfsdfdsfsd', 1, NULL, '2016-06-07 01:28:04', NULL),
(9, 'abc', 'aaaaa', 2313, NULL, 1, 'set', 'baik', 'aaaaa', 3, NULL, '2016-06-08 10:01:09', NULL),
(10, 'bbbbbbbb', 'sdddddd', 2313, NULL, 555, 'unit', 'baik', '', 1, NULL, NULL, NULL),
(12, 'vvvvvv', '3324', 12323, NULL, 123123, 'set', 'rusak', '21321312', 5, NULL, NULL, NULL),
(14, 'ffd', 'fdsfsf', 2147483647, NULL, 21313, 'set', 'kurang baik', 'good', 4, 'imgbarang/64008.png', '2016-06-07 09:30:04', NULL),
(15, 'Sandal', 'Swallow', 2016, NULL, 1, 'buah', 'baik', 'nyaman', 1, 'imgbarang/46571.png', NULL, NULL),
(16, 'Komputer', 'Alienware', 2016, NULL, 4, 'unit', 'baik', 'Test', 3, NULL, NULL, NULL),
(18, 'sdfds', 'dsfsdfa', 2313, NULL, 1, 'buah', 'rusak', '', 5, NULL, NULL, NULL);

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

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('rifqi_maula@yahoo.com', 'aa3b397a346e80e6ad57b239a62b26a765e2ed6744a101ad240f5515a93ee3a0', '2016-06-13 19:36:53'),
('rifqimaulaiqbal@gmail.com', 'e6958253c66b610a88104ad436f5a0bc6d8f96e647600fec5dcbb95ff8a6b497', '2016-06-13 19:55:55');

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
  `foto` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ruang`
--

INSERT INTO `ruang` (`id_ruang`, `nama_ruang`, `fid_area`, `updated_at`, `created_at`, `foto`) VALUES
(1, 'Aula', 1, NULL, NULL, NULL),
(2, 'Diskusi', 4, NULL, NULL, 'imgruang/49704.jpg'),
(3, 'Kerja', 1, NULL, NULL, NULL),
(4, 'Gudang', 1, NULL, NULL, NULL),
(5, 'Gudangan', 3, '2016-06-08 10:14:12', NULL, NULL),
(6, 'ccsdcsd', 3, NULL, NULL, 'imgruang/43345.png');

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
(1, 'iqbal rifqi', 'rifqimaulaiqbal@gmail.com', '$2y$10$wJfdw6gKzlH9mkDr9VniPeWQPMaP2CK623htrjQvXcWhAlshpSrri', 'ZHAhY54XckXE3SldaXXDAgtCOz3K5P2vWEoiZzk9zPxj6n1jqLfK6JzmgW90', '2016-06-09 05:42:28', '2016-06-15 02:04:07', 1, 1, 1, '2016-06-15 09:39:20', '1213', '9999', 'L', 'imguser/53287.png', 'iqbal', 'kkk'),
(3, 'rifqi maula', 'admin@admin.com', '$2y$10$O/wVxInDSOiomHmhTTnYPusAm0tSDBkp960d0DyIwFpFKy9Uegu/G', NULL, '2016-06-14 03:42:08', '2016-06-10 06:40:18', 2, 0, 1, NULL, '994', '000', 'P', 'imguser/48152.jpg', 'reza', NULL),
(4, 'ronaldo', 'dodo@gmail.com', '$2y$10$M7b5LNvtBk1wjZYIgdrw3.3Pls6rMA77eccZnUIichNRjNKh7TX8y', 'rfly7DxNWfUpWckl1TH0VA5McE6m5zXQh2OoQP661gzjrJQ0NYe9TS29KA3O', '2016-06-10 06:45:45', '2016-06-11 01:17:31', 2, 0, 1, NULL, '779', '997', 'L', 'imgbarang/83517.jpg', 'penaldo', 'wayut'),
(5, 'Bana Satriawan Ganteng Sekali', 'satriawan@gmail.com', '$2y$10$9iKSG6O2B/ezu.2CMHQqk.4HRFzyp2hgZtsiDfT2OJf4o1zO7YzVG', '9f82709990bb6ea7d4b9d44e47019e71', '2016-06-14 07:04:54', '2016-06-15 08:24:10', 2, 0, 0, NULL, '5113100050', '0857...', 'L', 'imguser/42390.jpg', 'b4na', 'Gubeng Surabaya'),
(6, 'Didit Ganteng Sepiyanto', 'didit@gmail.com', '$2y$10$x.JeeF68bw7DVsnrLJzB5O.RoW9m91TGv98juzSMmJ1d62jKJ5Xey', NULL, '2016-06-14 07:06:49', '2016-06-14 07:06:49', 2, 0, 0, NULL, '5113100090', '0856....', 'L', 'imguser/49934.png', 'diiiit', 'Probolinggo'),
(7, 'Ganteng', 'gurat@gmail.com', '$2y$10$MnNIyPkCeuEZnHj6GXlPzuPfGJOCj5dcCa9BTeHNSyNG1OTiP7Gm6', NULL, '2016-06-14 07:08:34', '2016-06-14 07:08:34', 2, 0, 0, NULL, 'Ganteng', '7751212', 'L', 'imguser/43058.jpg', 'leicester', 'Malang');

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
  ADD PRIMARY KEY (`id_barang`);

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
  ADD PRIMARY KEY (`id_ruang`);

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
  MODIFY `id_area` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `ruang`
--
ALTER TABLE `ruang`
  MODIFY `id_ruang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
