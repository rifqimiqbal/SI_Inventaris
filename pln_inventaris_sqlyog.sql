/*
SQLyog Ultimate v11.11 (32 bit)
MySQL - 5.5.5-10.1.9-MariaDB : Database - pln_inventaris
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pln_inventaris` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `pln_inventaris`;

/*Table structure for table `area` */

DROP TABLE IF EXISTS `area`;

CREATE TABLE `area` (
  `id_area` int(11) NOT NULL AUTO_INCREMENT,
  `nama_area` varchar(30) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  `foto` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `kode_area` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_area`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `area` */

insert  into `area`(`id_area`,`nama_area`,`alamat`,`telepon`,`foto`,`updated_at`,`created_at`,`kode_area`) values (1,'Madiun Kota','M  Haryono','0834920123','imgarea/68489.jpg','2016-06-08 02:23:02',NULL,'MDN'),(3,'Caruban','Jln Thamrin','084239123',NULL,NULL,NULL,'CRB'),(5,'Magetan','Jln Magetan','031234321',NULL,NULL,NULL,'MGT');

/*Table structure for table `barang` */

DROP TABLE IF EXISTS `barang`;

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL AUTO_INCREMENT,
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
  `nruang` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_barang`),
  KEY `fid_area_barang` (`fid_area`),
  KEY `fid_ruang_barang` (`fid_ruang`),
  CONSTRAINT `fid_area_barang` FOREIGN KEY (`fid_area`) REFERENCES `area` (`id_area`),
  CONSTRAINT `fid_ruang_barang` FOREIGN KEY (`fid_ruang`) REFERENCES `ruang` (`id_ruang`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

/*Data for the table `barang` */

insert  into `barang`(`id_barang`,`nama_barang`,`merek`,`tahun`,`nomor_inventaris`,`jumlah`,`satuan`,`fisik`,`keterangan`,`fid_ruang`,`gambar`,`updated_at`,`created_at`,`fid_area`,`noperarea`,`narea`,`nruang`) values (34,'Kursi Kerja Putar P Lengan','Brother',2003,'0001/MGR/MDN/03',1,'buah','baik','',7,NULL,NULL,NULL,1,1,NULL,NULL),(35,'Telephone','Tens',2005,'0001/MGR/CRB/05',1,'buah','baik','',9,NULL,'2016-06-15 14:33:47',NULL,3,1,NULL,NULL),(36,'Kursi Kerja Putar P Lengan','Brother',2003,'0001/MGR/MGT/03',1,'buah','baik','',10,NULL,NULL,NULL,5,1,NULL,NULL),(37,'Apar Powder 5 Kg','Wormald',2002,'0002/UAD/MDN/02',1,'buah','baik','',11,NULL,'2016-06-15 16:36:16',NULL,1,2,NULL,NULL),(38,'Sofa Tamu','Ikea',2003,'0003/AUL/MDN/03',1,'set','baik','',1,NULL,NULL,NULL,1,3,NULL,NULL),(39,'Credensa 3 Pintu','Vinociti',2004,'0004/MGR/MDN/04',1,'buah','baik','',7,NULL,NULL,NULL,1,4,NULL,NULL),(41,'Credensa 3 Pintu','Vinociti',2004,'0002/UAD/CRB/04',1,'buah','baik','',12,NULL,NULL,NULL,3,2,NULL,NULL),(42,'Apar BCF 4,5 Kg','',2004,'0005/MGR/MDN/04',1,'buah','baik','',7,NULL,NULL,NULL,1,5,NULL,NULL),(43,'Almari','Data Scrip',2004,'0002/UAD/MGT/04',1,'buah','baik','',13,NULL,NULL,NULL,5,2,NULL,NULL),(44,'Kaca Cermin','Alumunium',2004,'0003/GDG/MGT/04',1,'buah','baik','',14,NULL,NULL,NULL,5,3,NULL,NULL),(45,'Mesin Hitung Listrik','Casio',2004,'0006/UAD/MDN/04',1,'buah','baik','',11,NULL,NULL,NULL,1,6,NULL,NULL),(46,'OHP / Layar','3 M',2004,'0007/UAD/MDN/04',1,'buah','baik','',11,NULL,NULL,NULL,1,7,NULL,NULL),(47,'Proyektor','Sony',2012,'0008/AUL/MDN/12',1,'buah','baik','',1,NULL,'2016-06-16 01:56:08',NULL,1,8,NULL,NULL);

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`migration`,`batch`) values ('2014_10_12_000000_create_users_table',1),('2014_10_12_100000_create_password_resets_table',1);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `ruang` */

DROP TABLE IF EXISTS `ruang`;

CREATE TABLE `ruang` (
  `id_ruang` int(11) NOT NULL AUTO_INCREMENT,
  `nama_ruang` varchar(30) DEFAULT NULL,
  `fid_area` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `foto` varchar(20) DEFAULT NULL,
  `kode_ruang` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_ruang`),
  KEY `fid_area` (`fid_area`),
  CONSTRAINT `fid_area` FOREIGN KEY (`fid_area`) REFERENCES `area` (`id_area`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `ruang` */

insert  into `ruang`(`id_ruang`,`nama_ruang`,`fid_area`,`updated_at`,`created_at`,`foto`,`kode_ruang`) values (1,'Aula',1,NULL,NULL,NULL,'AUL'),(3,'Kerja',1,NULL,NULL,NULL,'KER'),(4,'Gudang',1,NULL,NULL,NULL,'GDG'),(5,'Gudangan',3,'2016-06-08 17:14:12',NULL,NULL,'GD1'),(7,'Manajer',1,NULL,NULL,NULL,'MGR'),(9,'Manajer',3,NULL,NULL,NULL,'MGR'),(10,'Manajer',5,NULL,NULL,NULL,'MGR'),(11,'ADM & KEU',1,NULL,NULL,NULL,'UAD'),(12,'ADM & KEU',3,NULL,NULL,NULL,'UAD'),(13,'ADM & KEU',5,NULL,NULL,NULL,'UAD'),(14,'Gudang',5,NULL,NULL,NULL,'GDG');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `alamat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`password`,`remember_token`,`created_at`,`updated_at`,`role`,`status_login`,`status_reg`,`last_login`,`id_pegawai`,`telepon`,`jenis_kelamin`,`foto`,`username`,`alamat`) values (1,'iqbal rifqi','rifqimaulaiqbal@gmail.com','$2y$10$BjZWIkjIVgr/Bdl9SfYmDuH9O6HDR7ceZ8FUEL7PZOVjthSvHsEX2','czSMQvSaVb1r5kl16Py0QRj5f9kHeUNUARjbd3XJYtXXTfsZPIvMoL3tfSE0','2016-06-09 12:42:28','2016-06-16 01:50:25',1,1,1,'2016-06-16 12:17:00','1213','9999','L','imguser/53287.png','iqbal','kkk'),(3,'rifqi maula','admin@admin.com','$2y$10$O/wVxInDSOiomHmhTTnYPusAm0tSDBkp960d0DyIwFpFKy9Uegu/G',NULL,'2016-06-14 10:42:08','2016-06-10 13:40:18',2,0,1,NULL,'994','000','P','imguser/48152.jpg','reza',NULL),(4,'ronaldo','dodo@gmail.com','$2y$10$M7b5LNvtBk1wjZYIgdrw3.3Pls6rMA77eccZnUIichNRjNKh7TX8y','rfly7DxNWfUpWckl1TH0VA5McE6m5zXQh2OoQP661gzjrJQ0NYe9TS29KA3O','2016-06-10 13:45:45','2016-06-11 08:17:31',2,0,1,NULL,'779','997','L','imgbarang/83517.jpg','penaldo','wayut'),(7,'Ganteng','gurat@gmail.com','$2y$10$MnNIyPkCeuEZnHj6GXlPzuPfGJOCj5dcCa9BTeHNSyNG1OTiP7Gm6',NULL,'2016-06-14 14:08:34','2016-06-14 14:08:34',2,0,0,NULL,'Ganteng','7751212','L','imguser/43058.jpg','leicester','Malang'),(8,'bana','abc@gmail.com','$2y$10$B8V5t6w6uKFXb0YXVkM/9uJxnn7.6BCW5.4DLWh.wkNhaCxCmUoMa','r5Xe7bc7QaH7QmdNb9tgLcC97wo9UgCiEOKlyW4KeMM8aTaCf8Pby8Xs7vTz','2016-06-14 23:16:07','2016-06-16 03:33:50',1,1,1,'2016-06-16 12:16:00','34342341','0843413123','L','imguser/78285.png','bana','Jln Thamrin');

/* Function  structure for function  `cek_confirmed` */

/*!50003 DROP FUNCTION IF EXISTS `cek_confirmed` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `cek_confirmed`(var_id int(10)) RETURNS int(11)
BEGIN
    set @s=(select status_reg from users where id=var_id);
    if(@s=1) then
    return 1;
    else
    return 0;
    end if;
    END */$$
DELIMITER ;

/* Function  structure for function  `cek_username` */

/*!50003 DROP FUNCTION IF EXISTS `cek_username` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `cek_username`(username1 varchar(20), email1 varchar(255)) RETURNS int(11)
BEGIN
    set @a= (select count(*) from users where username=username1);
    set @b= (select count(*) from users where email=email1);
    set @c = @a+@b;
    return @c;    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `chgpassword` */

/*!50003 DROP PROCEDURE IF EXISTS  `chgpassword` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `chgpassword`(var_password varchar(60), var_id int(10))
BEGIN
update users set password=var_password, updated_at= NOW() where id=var_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `confirmed` */

/*!50003 DROP PROCEDURE IF EXISTS  `confirmed` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmed`(var_id int(10))
BEGIN
   update users set status_reg=1,created_at=NOW() where id=var_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `editakun` */

/*!50003 DROP PROCEDURE IF EXISTS  `editakun` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `editakun`(var_nama varchar(255), var_hp varchar(30),  var_alamat varchar(50), var_id int(10))
BEGIN
 update users set name=var_nama, telepon=var_hp, alamat=var_alamat, updated_at=NOW() where id=var_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `editfoto` */

/*!50003 DROP PROCEDURE IF EXISTS  `editfoto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `editfoto`(var_foto varchar(40),var_id int(10))
BEGIN
    update users set foto=var_foto, updated_at=NOW() where id=var_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `login` */

/*!50003 DROP PROCEDURE IF EXISTS  `login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `login`(var_id int(10))
BEGIN
update users set last_login=NOW(), status_login=1 where id=var_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `logout` */

/*!50003 DROP PROCEDURE IF EXISTS  `logout` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `logout`(var_id int(10))
BEGIN
update users set  status_login=0 where id=var_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `register_native_user` */

/*!50003 DROP PROCEDURE IF EXISTS  `register_native_user` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `register_native_user`(var_name varchar(255),var_email varchar(255),var_password varchar(60),var_remember_token varchar(100),var_id_pegawai varchar(30),var_telepon varchar(30),var_jk varchar(1),var_foto varchar(40),var_username varchar(20),var_alamat varchar(50))
BEGIN
        insert into users (name,email,password,remember_token,created_at,updated_at,role,status_login,status_reg,last_login,id_pegawai,telepon,jenis_kelamin,foto, username,alamat)
          values(var_name,var_email,var_password,var_remember_token,NOW(),NULL,2,0,0,NULL,var_id_pegawai,var_telepon,var_jk,var_foto,var_username, var_alamat);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sent_remember_token` */

/*!50003 DROP PROCEDURE IF EXISTS  `sent_remember_token` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sent_remember_token`(var_email varchar(225))
BEGIN
        update users set remember_token=var_email,updated_at=NOW() where email=var_email;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
