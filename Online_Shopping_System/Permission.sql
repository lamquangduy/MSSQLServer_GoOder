USE master
GO
IF DB_ID('QLSV') IS NOT NULL
	DROP DATABASE QLGH
GO
	CREATE DATABASE QLGH
GO
	USE QLGH
GO

create table DOI_TAC
(
	MaDoiTac char(5),
	NguoiDaiDien nvarchar(50),
	Email nvarchar(50),
	Sdt varchar(10),
	SoChiNhanh int,
	TongDonHang int,
	LoaiAmThuc nvarchar(50),
	NVQL char(5)
	constraint PK_DOITAC PRIMARY KEY (MaDoiTac)
)

create table CHI_NHANH
(
	MaChiNhanh char(5),
	TGHoatDong time(0),
	TinhTrang nvarchar(20),
	DiaChi nvarchar(50),
	Sdt varchar(10),
	DoanhThu int,
	DoiTac char(5)
	constraint PK_CHINHANH PRIMARY KEY(MaChiNhanh)
)
create table MON
(
	MaMon char(4),
	TenMon nvarchar(50),
	MieuTa nvarchar(50),
	Gia real,
	Tuychon nvarchar(20),
	TinhTrang nvarchar(30),
	ChiNhanh char(5)
	constraint PK_MON PRIMARY KEY(MaMon)
)

create table KHACH_HANG
(
	MaKhachHang char(5),
	TenKH nvarchar(50),
	Sdt varchar(10),
	DiaChi nvarchar(50),
	Email nvarchar(20),
	constraint PK_KHACHHANG PRIMARY KEY(MaKhachHang)
)

create table TAI_XE
(
	MaTaiXe char(5),
	TenTaiXe nvarchar(50),
	CMND char(10) NOT NULL UNIQUE,
	Sdt varchar(10),
	Quan nvarchar(20),
	ThanhPho nvarchar(20),
	Email nvarchar(20),
	TaiKhoan varchar(20),
	NganHang nvarchar(50)
	constraint PK_TAIXE PRIMARY KEY(MaTaiXe)
)

create table DON_DAT_HANG
(
	MaDDH char(5),
	TinhTrang nvarchar(20),
	DiaChiNhan varchar(50),
	PhiSanPham real,
	PhiVanChuyen real,
	TongThanhToan real,
	HinhThucThanhToan nvarchar(20),
	NgayLap date,
	TaiXe char(5),
	KhachHang char(5),
	ChiNhanh char(5)
	constraint PK_DDH PRIMARY KEY(MaDDH)
)

create table CHI_TIET_DDH
(
	MA_MON char(4),
	MA_DDH char(5),
	SoLuongDat int NOT NULL
	constraint PK_CHITIET PRIMARY KEY(MA_MON,MA_DDH)
)

create table HOP_DONG
(
	MaHopDong char(5),
	MaSoThue nvarchar(50) NOT NULL unique,
	NguoiDaiDien varchar(20),
	TGBatDau datetime,
	TGKetThuc datetime,
	PhiHoaHong real,
	TinhTrang nvarchar(20),
	SoChiNhanhDangKy int,
	SoTaiKhoan varchar(20),
	NganHang nvarchar(50),
	NVDuyet char(5),
	DoiTac char(5)
	constraint PK_HOPDONG PRIMARY KEY(MaHopDong)
)

create table NHAN_VIEN
(
	MaNhanVien char(5),
	TenNV nvarchar(50),
	Sdt varchar(10),
	NgaySinh date,
	constraint PK_NHANVIEN PRIMARY KEY(MaNhanVien)
)


ALTER TABLE DOI_TAC ADD CONSTRAINT FK_DOITAC_NHANVIEN FOREIGN KEY(NVQL)
REFERENCES NHAN_VIEN(MaNhanVien)

ALTER TABLE CHI_NHANH ADD CONSTRAINT FK_CHINHANH_DOITAC FOREIGN KEY(DoiTac)
REFERENCES DOI_TAC(MaDoiTac)

ALTER TABLE MON ADD CONSTRAINT FK_MON_CHINHANH FOREIGN KEY(ChiNhanh)
REFERENCES CHI_NHANH(MaChiNhanh)

ALTER TABLE DON_DAT_HANG ADD CONSTRAINT FK_DDH_TAIXE FOREIGN KEY(TaiXe)
REFERENCES TAI_XE(MaTaiXe)

ALTER TABLE DON_DAT_HANG ADD CONSTRAINT FK_DDH_KHACHHANG FOREIGN KEY(KhachHang)
REFERENCES KHACH_HANG(MaKhachHang)

ALTER TABLE DON_DAT_HANG ADD CONSTRAINT FK_DDH_CHINHANH FOREIGN KEY(ChiNhanh)
REFERENCES CHI_NHANH(MaChiNhanh)

ALTER TABLE CHI_TIET_DDH ADD CONSTRAINT FK_CHITIET_MON FOREIGN KEY(MA_MON)
REFERENCES MON(MaMon)

ALTER TABLE CHI_TIET_DDH ADD CONSTRAINT FK_CHITIET_DDH FOREIGN KEY(MA_DDH)
REFERENCES DON_DAT_HANG(MaDDH)

ALTER TABLE HOP_DONG ADD CONSTRAINT FK_HOPDONG_NHANVIEN FOREIGN KEY(NVDuyet)
REFERENCES NHAN_VIEN(MaNhanVien)

ALTER TABLE HOP_DONG ADD CONSTRAINT FK_HOPDONG_DOITAC FOREIGN KEY(DoiTac)
REFERENCES DOI_TAC(MaDoiTac)

INSERT INTO NHAN_VIEN
VALUES ('NV001',N'Mai Nhật Nam','0421331284','2001-05-03');
INSERT INTO NHAN_VIEN
VALUES ('NV002',N'Thái Minh Triết','0333412312','2000-02-11');
INSERT INTO NHAN_VIEN
VALUES ('NV003',N'Lâm Quang Duy','0301234121','2000-11-02');
INSERT INTO NHAN_VIEN
VALUES ('NV004',N'Nguyễn Đặng Nam Khánh','0333222111','2000-05-16');

INSERT INTO TAI_XE
VALUES('TX001',N'Đăng Phúc Hòa','3333444422','03123456',N'Quận 7','Hồ Chí Minh',NULL,'9123812384','VCB')
INSERT INTO TAI_XE
VALUES('TX002',N'Phó Tuấn Long','9999111133','021395234',N'Quận 5','Hồ Chí Minh',NULL,'123045123','SCB')
INSERT INTO TAI_XE
VALUES('TX003',N'Đỗ Việt Anh','8888444422','03215619',N'Quận Bình Thạnh','Hồ Chí Minh',NULL,'123123123','SCB')
INSERT INTO TAI_XE
VALUES('TX004',N'Lý Minh Hoàng','5555666677','02815123',N'Quận Bình Tân','Hồ Chí Minh',NULL,'321321321','SCB')

INSERT INTO KHACH_HANG
VALUES('KH001','Tạ Anh Khải','0123123445',N'Quận 1 Hồ Chí Minh',NULL)
INSERT INTO KHACH_HANG
VALUES('KH002','Nguyễn Chí Khang','068349453',N'Quận Bình Thạnh Hồ Chí Minh',NULL)
INSERT INTO KHACH_HANG
VALUES('KH003','Võ Bảo Hoàng','0123456789',N'Quận Bình Thạnh Hồ Chí Minh',NULL)
INSERT INTO KHACH_HANG
VALUES('KH004','Vũ Trường Giang','0987654321',N'Quận Gò Vấp Hồ Chí Minh',NULL)

INSERT INTO DOI_TAC
VALUES('DT001',N'Dương Thiệu Bảo',NULL,'0222221111',5,1000,N'Cơm','NV001')
INSERT INTO DOI_TAC
VALUES('DT002',N'Ngô Ðức Bảo',NULL,'0333344415',2,2000,N'Phở','NV001')
INSERT INTO DOI_TAC
VALUES('DT003',N'Mai Hữu Nam',NULL,'0333344215',2,2000,N'Bánh mì','NV003')
INSERT INTO DOI_TAC
VALUES('DT004',N'Phùng Ðình Nhân',NULL,'0999888111',2,2000,N'Trà sữa','NV002')

INSERT INTO HOP_DONG
VALUES ('HD001','7777799999',N'An Cao Minh','2022-10-19','2024-10-19',0.1,N'Còn hiệu lực',2,'111222333444','BIDV','NV002','DT001')
INSERT INTO HOP_DONG
VALUES ('HD002','7777788888',N'Vũ Việt Anh','2022-05-02','2023-05-02',0.15,N'Còn hiệu lực',1,'22221113334','SCB','NV002','DT002')
INSERT INTO HOP_DONG
VALUES ('HD003','7777755555',N'Tạ An Nam','2022-01-15','2023-01-15',0.15,N'Còn hiệu lực',1,'3333344444','SCB','NV002','DT003')
INSERT INTO HOP_DONG
VALUES ('HD004','7777744444',N'Trà Ðức Phú','2022-08-11','2023-08-11',0.15,N'Hết hiệu lực',1,'5555566666','SCB','NV004','DT004')

INSERT INTO CHI_NHANH
VALUES('CN001','07:00',N'Bình thường','Quận 1 TPHCM','088812345',2000000,'DT001')
INSERT INTO CHI_NHANH
VALUES('CN002','07:00',N'Tạm nghỉ','Quận 2 TPHCM','088887777',3000000,'DT001')
INSERT INTO CHI_NHANH
VALUES('CN003','07:00',N'Bình thường','Quận 3 TPHCM','099991111',5000000,'DT002')
INSERT INTO CHI_NHANH
VALUES('CN004','07:00',N'Bình thường','Quận 4 TPHCM','022221111',4000000,'DT003')
INSERT INTO CHI_NHANH
VALUES('CN005','07:00',N'Bình thường','Quận 5 TPHCM','066665555',8000000,'DT004')

INSERT INTO MON
VALUES('M001',N'Cơm chiên dương châu',NULL,40000.0,NULL,N'Có bán','CN001')
INSERT INTO MON
VALUES('M002',N'Cơm sườn',NULL,50000.0,NULL,N'Có bán','CN001')
INSERT INTO MON
VALUES('M003',N'Phở tái',NULL,70000.0,NULL,N'Có bán','CN003')
INSERT INTO MON
VALUES('M004',N'Bánh mì thịt',NULL,20000.0,NULL,N'Tạm ngưng','CN004')

INSERT INTO DON_DAT_HANG
VALUES('DH001',N'Đã nhận',N'Phạm Văn Đồng Bình Thạnh',40000,3000,43000,'Online','2022-11-03','TX001','KH002','CN001')
INSERT INTO DON_DAT_HANG
VALUES('DH002',N'Đã nhận',N'3/2 Quận 5',50000,3000,53000,'Online','2022-11-04','TX002','KH001','CN001')
INSERT INTO DON_DAT_HANG
VALUES('DH003',N'Đã nhận',N'Linh Trung Thủ Đức',140000,1000,141000,'Online','2022-11-05','TX003','KH001','CN003')
INSERT INTO DON_DAT_HANG
VALUES('DH004',N'Đã nhận',N'Quận 1',120000,1000,121000,'Online','2022-11-06','TX004','KH003','CN001')

INSERT INTO CHI_TIET_DDH
VALUES('M001','DH001',1)
INSERT INTO CHI_TIET_DDH
VALUES('M002','DH002',1)
INSERT INTO CHI_TIET_DDH
VALUES('M003','DH003',2)
INSERT INTO CHI_TIET_DDH
VALUES('M001','DH004',3)




--1. Create login [Admin]
USE [master]
GO
CREATE LOGIN [Admin] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--2. Create role [Admin]
USE [QLGH]
GO
CREATE ROLE [Role_Admin]
GO

--3. Create user [Admin]
USE [QLGH]
GO
CREATE USER [Admin] FOR LOGIN [Admin]
GO
USE [QLGH]
GO
ALTER ROLE [Role_Admin] ADD MEMBER [Admin]
GO

--4. Set Permission [Admin]
use [QLGH]
GO
GRANT DELETE ON [dbo].[DON_DAT_HANG] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[DON_DAT_HANG] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[DON_DAT_HANG] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[DON_DAT_HANG] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[CHI_TIET_DDH] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[CHI_TIET_DDH] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[CHI_TIET_DDH] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[CHI_TIET_DDH] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[CHI_NHANH] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[CHI_NHANH] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[CHI_NHANH] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[CHI_NHANH] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[TAI_XE] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[TAI_XE] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[TAI_XE] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[TAI_XE] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[DOI_TAC] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[DOI_TAC] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[DOI_TAC] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[DOI_TAC] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[NHAN_VIEN] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[NHAN_VIEN] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[NHAN_VIEN] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[NHAN_VIEN] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[LOAI_AM_THUC] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[LOAI_AM_THUC] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[LOAI_AM_THUC] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[LOAI_AM_THUC] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[MON] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[MON] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[MON] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[MON] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[KHACH_HANG] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[KHACH_HANG] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[KHACH_HANG] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[KHACH_HANG] TO [Admin]
GO

use [QLGH]
GO
GRANT DELETE ON [dbo].[HOP_DONG] TO [Admin]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[HOP_DONG] TO [Admin]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[HOP_DONG] TO [Admin]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[HOP_DONG] TO [Admin]
GO


--1. Create login [NhanVien]
USE [master]
GO
CREATE LOGIN [NhanVien] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--2. Create role [NhanVien]
USE [QLGH]
GO
CREATE ROLE [Role_NhanVien]
GO

--3. Create user [NhanVien]
USE [QLGH]
GO
CREATE USER [NhanVien] FOR LOGIN [NhanVien]
GO
USE [QLGH]
GO
ALTER ROLE [Role_NhanVien] ADD MEMBER [NhanVien]
GO

--4. Set Permission [NhanVien]
use [QLGH]
GO
GRANT DELETE ON [dbo].[DOI_TAC] TO [NhanVien]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[DOI_TAC] TO [NhanVien]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[DOI_TAC] TO [NhanVien]
GO
use [QLGH]
GO
GRANT DELETE ON [dbo].[HOP_DONG] TO [NhanVien]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[HOP_DONG] TO [NhanVien]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[HOP_DONG] TO [NhanVien]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[HOP_DONG] TO [NhanVien]
GO

--1. Create login [DoiTac]
USE [master]
GO
CREATE LOGIN [DoiTac] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--2. Create role [DoiTac]
USE [QLGH]
GO
CREATE ROLE [Role_DoiTac]
GO

--3. Create user [DoiTac]
USE [QLGH]
GO
CREATE USER [DoiTac] FOR LOGIN [DoiTac]
GO
USE [QLGH]
GO
ALTER ROLE [Role_DoiTac] ADD MEMBER [DoiTac]
GO

--4. Set Permission [DoiTac]
use [QLGH]
GO
GRANT SELECT ON [dbo].[HOP_DONG] TO [DoiTac]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[CHI_NHANH] TO [DoiTac]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[CHI_NHANH] TO [DoiTac]
GO



--1. Create login [ChiNhanh]
USE [master]
GO
CREATE LOGIN [ChiNhanh] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--2. Create role [ChiNhanh]
USE [QLGH]
GO
CREATE ROLE [Role_ChiNhanh]
GO

--3. Create user [ChiNhanh]
USE [QLGH]
GO
CREATE USER [ChiNhanh] FOR LOGIN [ChiNhanh]
GO
USE [QLGH]
GO
ALTER ROLE [Role_ChiNhanh] ADD MEMBER [ChiNhanh]
GO

--4. Set Permission [ChiNhanh]
use [QLGH]
GO
GRANT DELETE ON [dbo].[MON] TO [ChiNhanh]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[MON] TO [ChiNhanh]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[MON] TO [ChiNhanh]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[MON] TO [ChiNhanh]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[DON_DAT_HANG] TO [ChiNhanh]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[DON_DAT_HANG] TO [ChiNhanh]
GO



--1. Create login [KhachHang]
USE [master]
GO
CREATE LOGIN [KhachHang] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--2. Create role [KhachHang]
USE [QLGH]
GO
CREATE ROLE [Role_KhachHang]
GO

--3. Create user [KhachHang]
USE [QLGH]
GO
CREATE USER [KhachHang] FOR LOGIN [KhachHang]
GO
USE [QLGH]
GO
ALTER ROLE [Role_KhachHang] ADD MEMBER [KhachHang]
GO

--4. Set Permission [KhachHang]
use [QLGH]
GO
GRANT SELECT ON [dbo].[DOI_TAC] TO [KhachHang]
GO
use [QLGH]
GO
GRANT DELETE ON [dbo].[DON_DAT_HANG] TO [KhachHang]
GO
use [QLGH]
GO
GRANT INSERT ON [dbo].[DON_DAT_HANG] TO [KhachHang]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[DON_DAT_HANG] TO [KhachHang]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[DON_DAT_HANG] TO [KhachHang]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[MON] TO [KhachHang]
GO
use [QLGH]
GO
GRANT SELECT ON [dbo].[CHI_NHANH] TO [KhachHang]
GO



--1. Create login [TaiXe]
USE [master]
GO
CREATE LOGIN [TaiXe] WITH PASSWORD=N'1', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

--2. Create role [TaiXe]
USE [QLGH]
GO
CREATE ROLE [Role_TaiXe]
GO

--3. Create user [TaiXe]
USE [QLGH]
GO
CREATE USER [TaiXe] FOR LOGIN [TaiXe]
GO
USE [QLGH]
GO
ALTER ROLE [Role_TaiXe] ADD MEMBER [TaiXe]
GO

--4. Set Permission [TaiXe]
use [QLGH]
GO
GRANT SELECT ON [dbo].[DON_DAT_HANG] TO [TaiXe]
GO
use [QLGH]
GO
GRANT UPDATE ON [dbo].[DON_DAT_HANG] TO [TaiXe]
GO






