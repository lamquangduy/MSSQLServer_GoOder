go
CREATE DATABASE QLHTGH
go
USE QLHTGH
go
/* 
 * TABLE: CHINHANH 
 */
 


CREATE TABLE [dbo].[TAIKHOAN](
	[username] [nchar](20) NOT NULL,
	[pass] [nchar](20) NULL,
	[user_role] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


 IF OBJECT_ID('TAIKHOAN') IS NOT NULL
    PRINT '<<< CREATED TABLE TAIKHOAN >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TAIKHOAN >>>'
go




CREATE TABLE CHINHANH(
    MaCN             char(10)         NOT NULL,
    MaDT             char(10)         NOT NULL,
    DiaChiChiTiet    nvarchar(100)    NULL,
    Quan             nvarchar(100)    NULL,
    ThanhPho         nvarchar(100)    NULL,
    TinhTrangCH      nvarchar(50)     NULL,
    TGHoatDong       char(20)         NULL,
    PRIMARY KEY (MaCN)
)
go



IF OBJECT_ID('CHINHANH') IS NOT NULL
    PRINT '<<< CREATED TABLE CHINHANH >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CHINHANH >>>'
go

/* 
 * TABLE: CHITIETDONHANG 
 */

CREATE TABLE CHITIETDONHANG(
    MaDH       char(10)         NOT NULL,
	MaCN       char(10)         NOT NULL,
    TenMon     nvarchar(80)     NOT NULL,
    SoLuong    int              NULL,
    GhiChu     nvarchar(100)    NULL,
    PRIMARY KEY (MaDH, TenMon, MaCN)
)
go



IF OBJECT_ID('CHITIETDONHANG') IS NOT NULL
    PRINT '<<< CREATED TABLE CHITIETDONHANG >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CHITIETDONHANG >>>'
go

/* 
 * TABLE: CHITIETHOPDONG 
 */

CREATE TABLE CHITIETHOPDONG(
    MaHD    char(10)    NOT NULL,
    MaCN    char(10)    NOT NULL,
    PRIMARY KEY (MaHD, MaCN)
)
go



IF OBJECT_ID('CHITIETHOPDONG') IS NOT NULL
    PRINT '<<< CREATED TABLE CHITIETHOPDONG >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CHITIETHOPDONG >>>'
go

/* 
 * TABLE: DOITAC 
 */

CREATE TABLE DOITAC(
    MaDT            char(10)         NOT NULL,
    Email           char(50)         NULL,
    TenCuaHang      nvarchar(50)     NULL,
    NguoiDaiDien    nvarchar(50)     NULL,
    DiaChi          nvarchar(100)    NULL,
    SLChiNhanh      int              NULL,
    LoaiAmThuc      nvarchar(200)             NULL,
    SLDonHang       char(10)         NULL,
    NgayCapNhat     date         NULL,
    SDT             char(11)         NULL,
	username		nchar(20)		NULL,
     PRIMARY KEY  (MaDT)
)
go



IF OBJECT_ID('DOITAC') IS NOT NULL
    PRINT '<<< CREATED TABLE DOITAC >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DOITAC >>>'
go

/* 
 * TABLE: DONHANG 
 */

CREATE TABLE DONHANG(
    MaDH             char(10)         NOT NULL,
    MaCN             char(10)         NOT NULL,
    MaTX             char(10)         NULL,
    MaKH             char(10)         NOT NULL,
    DonGia           int            NULL,
    PhiVanChuyen     int            NULL,
    DiaChiChiTiet    nvarchar(100)    NULL,
    Quan             nvarchar(100)    NULL,
    ThanhPho         nvarchar(100)    NULL,
    TinhTrangDH      nvarchar(50)     NULL,
    NgayDat          date         NULL,
    PRIMARY KEY (MaDH)
)
go



IF OBJECT_ID('DONHANG') IS NOT NULL
    PRINT '<<< CREATED TABLE DONHANG >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DONHANG >>>'
go

/* 
 * TABLE: HOPDONG 
 */

CREATE TABLE HOPDONG(
    MaHD                char(10)        NOT NULL,
    MaSoThue            char(10)        NOT NULL,
    MaDT                char(10)        NULL,
    NguoiDaiDien        nvarchar(50)    NULL,
    MaNV                char(10)        NULL,
    SLChiNhanhDangKy    int             NULL,
    STK                 nchar(50)        NULL,
    NganHang            char(50)        NULL,
    TGHieuLuc           date        NULL,
    HoaHong             float           NULL,
	TinhTrang			nvarchar(20),
    PRIMARY KEY  (MaHD)
)
go




IF OBJECT_ID('HOPDONG') IS NOT NULL
    PRINT '<<< CREATED TABLE HOPDONG >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE HOPDONG >>>'
go

/* 
 * TABLE: KHACHHANG 
 */

CREATE TABLE KHACHHANG(
    MaKH      char(10)         NOT NULL,
    HoTen     nvarchar(50)     NOT NULL,
    SDT       char(11)         NULL,
    DiaChi    nvarchar(100)    NULL,
    Email     char(50)         NULL,
	username	nchar(20)	NULL,
    PRIMARY KEY  (MaKH)
)
go



IF OBJECT_ID('KHACHHANG') IS NOT NULL
    PRINT '<<< CREATED TABLE KHACHHANG >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE KHACHHANG >>>'
go

/* 
 * TABLE: NHANVIEN 
 */

CREATE TABLE NHANVIEN(
    MaNV     char(10)        NOT NULL,
    HoTen    nvarchar(50)    NULL,
    Email    char(50)        NULL,
	username nchar(20)		NULL,
   PRIMARY KEY (MaNV)
)
go



IF OBJECT_ID('NHANVIEN') IS NOT NULL
    PRINT '<<< CREATED TABLE NHANVIEN >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE NHANVIEN >>>'
go

/* 
 * TABLE: TAIXE 
 */

CREATE TABLE TAIXE(
    MaTX            char(10)          NOT NULL,
    HoTen           nvarchar(50)      NULL,
    CMND            char(15)          NULL,
    SDT             char(11)          NULL,
    DiaChi          nvarchar(100)     NULL,
    BienSoXe        char(15)          NULL,
    QuanHoatDong    nvarchar(100)    NULL,
    TPHoatDong      nvarchar(100)     NULL,
    Email           char(50)          NULL,
    STK             nchar(50)          NULL,
    NganHang        char(50)          NULL,
	username nchar(20)		NULL,
    PRIMARY KEY  (MaTX)
)
go



IF OBJECT_ID('TAIXE') IS NOT NULL
    PRINT '<<< CREATED TABLE TAIXE >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TAIXE >>>'
go

/* 
 * TABLE: THUCDON 
 */

CREATE TABLE THUCDON(
    TenMon          nvarchar(80)     NOT NULL,
    MaCN            char(10)         NOT NULL,
    MieuTa          nvarchar(100)    NULL,
    Gia             int            NULL,
    TinhTrangMon    nvarchar(50)     NULL,
    TuyChon         nvarchar(150)             NULL,
    PRIMARY KEY  (TenMon, MaCN)
)
go

ALTER TABLE THUCDON
  ALTER COLUMN  Gia int

IF OBJECT_ID('THUCDON') IS NOT NULL
    PRINT '<<< CREATED TABLE THUCDON >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE THUCDON >>>'
go

/* 
 * TABLE: DOITAC
 */

 ALTER TABLE DOITAC ADD CONSTRAINT FK_DOITAC_TAIKHOAN 
    FOREIGN KEY (username)
    REFERENCES TAIKHOAN(username)
go

/* 
 * TABLE: KHACHHANG
 */
  ALTER TABLE KHACHHANG ADD CONSTRAINT FK_KHACHHANG_TAIKHOAN 
    FOREIGN KEY (username)
    REFERENCES TAIKHOAN(username)
go

/* 
 * TABLE: NHANVIEN
 */
  ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_TAIKHOAN 
    FOREIGN KEY (username)
    REFERENCES TAIKHOAN(username)
go
/* 
 * TABLE: TAIXE
 */
  ALTER TABLE TAIXE ADD CONSTRAINT FK_TAIXE_TAIKHOAN 
    FOREIGN KEY (username)
    REFERENCES TAIKHOAN(username)
go

/* 
 * TABLE: CHINHANH 
 */

ALTER TABLE CHINHANH ADD CONSTRAINT RefDOITAC1 
    FOREIGN KEY (MaDT)
    REFERENCES DOITAC(MaDT)
go


/* 
 * TABLE: CHITIETDONHANG 
 */

ALTER TABLE CHITIETDONHANG ADD CONSTRAINT RefDONHANG4 
    FOREIGN KEY (MaDH)
    REFERENCES DONHANG(MaDH)
go

ALTER TABLE CHITIETDONHANG ADD CONSTRAINT RefTHUCDON19 
    FOREIGN KEY (TenMon, MaCN)
    REFERENCES THUCDON(TenMon, MaCN)
go




/* 
 * TABLE: CHITIETHOPDONG 
 */

ALTER TABLE CHITIETHOPDONG ADD CONSTRAINT RefHOPDONG28 
    FOREIGN KEY (MaHD)
    REFERENCES HOPDONG(MaHD)
go

ALTER TABLE CHITIETHOPDONG ADD CONSTRAINT RefCHINHANH30 
    FOREIGN KEY (MaCN)
    REFERENCES CHINHANH(MaCN)
go


/* 
 * TABLE: DONHANG 
 */

ALTER TABLE DONHANG ADD CONSTRAINT RefCHINHANH26 
    FOREIGN KEY (MaCN)
    REFERENCES CHINHANH(MaCN)
go

ALTER TABLE DONHANG ADD CONSTRAINT RefKHACHHANG5 
    FOREIGN KEY (MaKH)
    REFERENCES KHACHHANG(MaKH)
go

ALTER TABLE DONHANG ADD CONSTRAINT RefTAIXE6 
    FOREIGN KEY (MaTX)
    REFERENCES TAIXE(MaTX)
go


/* 
 * TABLE: HOPDONG 
 */

ALTER TABLE HOPDONG ADD CONSTRAINT RefDOITAC2 
    FOREIGN KEY (MaDT)
    REFERENCES DOITAC(MaDT)
go

ALTER TABLE HOPDONG ADD CONSTRAINT RefNHANVIEN20 
    FOREIGN KEY (MaNV)
    REFERENCES NHANVIEN(MaNV)
go


/* 
 * TABLE: THUCDON 
 */

ALTER TABLE THUCDON ADD CONSTRAINT RefCHINHANH27 
    FOREIGN KEY (MaCN)
    REFERENCES CHINHANH(MaCN)
go




insert into TAIKHOAN
values
('phananh','123',N'Tài xế'),
('anh123','111',N'Tài xế'),
('linhlung','123456',N'Tài xế'),
('dochet123','0901',N'Tài xế'),
('phat123','111111',N'Khách hàng'),
('duongle','111111',N'Khách hàng'),
('kimchi','111111',N'Khách hàng'),
('huutai','111111',N'Khách hàng'),
('huuphuc','111111',N'Khách hàng'),
('hanng','111111',N'Khách hàng'),
('kien222','111111',N'Khách hàng'),
('doitac1','111111',N'Đối tác'),
('doitac2','111111',N'Đối tác'),
('doitac3','111111',N'Đối tác'),
('doitac4','111111',N'Đối tác'),
('nhanhvien1','111111',N'Nhân viên'),
('nhanhvien2','111111',N'Nhân viên'),
('nhanhvien3','111111',N'Nhân viên'),
('nhanhvien4','111111',N'Nhân viên')




insert into DOITAC
values 
('DT001',	'miumiu@contact.com',	N'Miu Fastfood',	N'Phạm Hưng',	N'Tp HCM',	1,	N'Đồ ăn nhanh',	'20-50',	'12/22/2020',	'0923112351','doitac1'),
('DT002',	'phuchong@gmail.com',	N'Trà sữa Phúc Hong',	N'Nguyễn Ngọc Hân',	N'Tp HCM',	2,	N'Trà sữa',	'100-120',	'01/22/2021',	'0923746518','doitac1'),
('DT003',	'pewpew@gmail.com',	N'Bánh mì Pew Pew',	N'Phạm Hoàng Khoa',	N'Tp HCM',	1,	N'Bánh mì',	'80-100',	'10/22/2022',	'0923875419','doitac1'),
('DT004',	'lae@gmail.com',	N'Lẩu gà lá é',	N'Trần Bảo Trân',	N'Tp HCM',	4,	N'Lẩu gà',	'10-20',	'05/14/2022',	'0928765432','doitac1')

insert into KHACHHANG
values 
('KH001',	N'Vương Tấn Phát',	'0925432167',	N'KTX 135B Trần Hưng Đạo, P. Cầu Ông Lãnh, Quận 1, TP.HCM',	'vuongtanphat139@gmail.com','phat123'),
('KH002',	N'Lê Thị Thùy Dương',	'0973243514',	N' 45-47 Lê Duẩn, Bến Nghé, Quận 1, Hồ Chí Minh',	'lttd@gmail.com','duongle'),
('KH003',	N'Hồ Thị Kim Chi',	'0966254316',	N'59 Hồ Hảo Hớn, Phường Cô Giang, Quận Bình Thạnh, Hồ Chí Minh',	'kimchiho123@gmail.com','kimchi'),
('KH004',	N'Nguyễn Hữu Tài',	'0873453765',	N'58b Nguyễn Đình Chiểu, Đa Kao, Hồ Chí Minh, Đa Kao Quận 3, Hồ Chí Minh',	'huutaing111@gmail.com','huutai'),
('KH005',	N'Ngô Hữu Phúc',	'0877979242',	N'227 Trần Quang Khải, Tân Định, Quận 5, Hồ Chí Minh',	'phucngo.contact@gmail.com','huuphuc'),
('KH006',	N'Nguyễn Ngọc Hân',	'0783251634',	N'238-240 Đường Đề Thám, Phường Phạm Ngũ Lão, Quận 12, Hồ Chí Minh',	'ngochan@gmail.com','hanng'),
('KH007',	N'Phạm Trung Kiên',	'0973654736',	N'92, Nguyễn Trãi, Phường Bến Thành, Quận 1, Tp Hồ Chí Minh',	'trungkienpham@gmail.com','kien222')









insert into TAIXE
values 
('TX001',	N'Nguyễn Phan Anh',	'254678136',	'0973456765',	N'Tp HCM',	'59-B1 12345',N'Quận 1',	N'Tp Hồ Chí Minh',	'phananh@gmail.com',	'0601000541412',	'VietComBank','phananh'),
('TX002',	N'Nguyễn Đức Anh',	'298764321',	'0923546271',	N'Long An',	'62-D1 65443',N'Quận 5',	N'Tp Hồ Chí Minh',	'ducanh@gmail.com',	'0601000547699',	'Agribank','anh123'),
('TX003',	N'Trần Thái Linh',	'342006348',	'0928653187',	N'Tp HCM',	'59-X2 98712',N'Quận Bình Thạnh',	N'Tp Hồ Chí Minh',	'thailinhhuong@gmail.com',	'0601000123411',	'VietComBank','linhlung'),
('TX004',	N'Phùng Thanh Độ',	'342009564',	'0966243564',	N'Tp HCM',	'11-A1 1111',N'Quận 7',	N'Tp Hồ Chí Minh',	'dochet@gmail.com',	'0601000123732',	'Techcombank','dochet123')





insert into NHANVIEN
values
('NV001',	N'Lâm Văn Quý',	'lvanquy@gmail.com','nhanhvien1'),
('NV002',	N'Phan Văn Khải',	'khaiphan@gmail.com','nhanhvien2'),
('NV003',	N'Nguyễn Thị Lan Anh',	'lananh102@gmail.com','nhanhvien3'),
('NV004',	N'Nguyễn Huy Hùng',	'hungcool@gmail.com','nhanhvien4')

insert into HOPDONG
values
('HD001',	'23456789',	'DT001',	N'Phạm Hưng',	'NV001',	1,	'0601000579463',	'Vietcombank',	'12/01/2021',	10,N'Đã duyệt'),
('HD002',	'24475579',	'DT001',	N'Phạm Hưng',	'NV002',	2,	'0601000579463',	'Vietcombank',	'12/20/2022',	10,N'Đã duyệt'),
('HD003',	'45982317',	'DT002',	N'Nguyễn Ngọc Hân',	'NV004',	2,	'0601000178965',	'Agribank',	'06/12/2023',	10,N'Đã duyệt'),
('HD004',	'12569874',	'DT003',	N'Phạm Hoàng Khoa',	'NV003',	1,	'0601000478516',	'Techcombank',	'01/21/2023',	10,N'Đã duyệt'),
('HD005',	'54733654',	'DT004',	N'Trần Bảo Trân',	'NV001',	3,	'0601000346757',	'Vietcombank',	'04/23/2021',	10,N'Đã duyệt'),
('HD006',	'54733654',	'DT004',	N'Trần Bảo Trân',	'NV004',	2,	'0601000346757',	'Vietcombank',	'02/24/2023',	10,N'Đã duyệt'),
('HD007',	'54733654',	'DT004',	N'Trần Bảo Trân',	null,	1,	'0601000346757',	'Vietcombank',	null,	null,N'Chưa duyệt')




insert into CHINHANH
values
('CN001','DT001',	N'68 Nguyễn Huệ, Phường Bến Nghé',	N'Quận 1',	N'Tp Hồ Chí Minh',	N'Bình thường',	'8h-22h'),
('CN002','DT001',	N' 96/179C Bạch Vân, Phường 05',	N'Quận 5',	N'Tp Hồ Chí Minh',	N'Tạm nghỉ',	'8h-22h'),
('CN003','DT002',	N'386/52B Lê Văn Sỹ, Phường 14',	N'Quận 3',	N'Tp Hồ Chí Minh',	N'Bình thường',	'6h-17h'),
('CN004','DT002',	N'270 Trần Hưng Đạo, Phường 11',	N'Quận 5',	N'Tp Hồ Chí Minh',	N'Bình thường',	'6h-17h'),
('CN005','DT003',	N'195/10/9 Điện Biên Phủ, Phường 15',	N'Quận Bình Thạnh',	N'Tp Hồ Chí Minh',	N'Bình thường',	'6h-14h'),
('CN006','DT004',	N'210A Nguyễn Thị Minh Khai, Phường Võ Thị Sáu',	N'Quận 3',	N'Tp Hồ Chí Minh',	N'Bình thường',	'10h-22h'),
('CN007','DT004',	N'75 Nguyễn Bỉnh Khiêm, Phường Đa Kao',	N'Quận 1',	N'Tp Hồ Chí Minh',	N'Bình thường',	'10h-22h'),
('CN008','DT004',	N'Số 16, Đường số 4, Phường Tân Phú',	N'Quận 7',	N'Tp Hồ Chí Minh',	N'Bình thường',	'10h-22h'),
('CN009','DT004',	N'100 Hải Thượng Lãn Ông, Phường 10',	N'Quận 5',	N'Tp Hồ Chí Minh',	N'Bình thường',	'10h-22h')


insert into CHITIETHOPDONG
values
('HD001','CN001'),
('HD002','CN001'),
('HD002','CN002'),
('HD003','CN003'),
('HD003','CN004'),
('HD004','CN005'),
('HD005','CN006'),
('HD005','CN007'),
('HD005','CN008'),
('HD006','CN006'),
('HD006','CN008'),
('HD007','CN009')


insert into THUCDON
values
(N'Khoai Lang Chiên Giòn Lắc Phomai',	'CN001',	N'Thơm vị phomai, giòn tan trong miệng',	35000,	N'Có bán',	N'Giòn vừa,Giòn tan,Ít phomai, Nhiều phomai'),
(N'Mì Trộn Gà Sốt Cay Phô Mai',	'CN001',	N'Ngon đậm đà, cay bùng vị',	40000,	N'Có bán',	N'Ít mì, Nhiều mì, Nhiều tương, Ít tương'),
(N'Mỳ Ý Đùi Gà Sốt Cay',	'CN001',	N'Đùi gà chọn lọc, sốt trộn đậm vị',	45000,	N'Hết hàng',	N'Ít mì, Nhiều mì, Nhiều tương, Ít tương'),
(N'Mì Tương Đen Sốt Phô Mai Hàn Quốc',	'CN001',	N'Chuẩn vị Hàn Quốc',	45000,	N'Có bán',	N'Ít mì, Nhiều mì, Nhiều tương, Ít tương'),
(N'Combo Xiên Que',	'CN001',	N'Xúc xích /cá / bò /tôm / thanh cua / viên sốt / hồ lô / phô mai viên',	35000,	N'Có bán',	N'Nhiều tương, Ít tương'),
(N'Khoai Lang Chiên Giòn Lắc Phomai',	'CN002',	N'Thơm vị phomai, giòn tan trong miệng',	35000,	N'Có bán',	N'Giòn vừa,Giòn tan,Ít phomai, Nhiều phomai'),
(N'Mì Trộn Gà Sốt Cay Phô Mai',	'CN002',	N'Ngon đậm đà, cay bùng vị',	40000,	N'Có bán',	N'Ít mì, Nhiều mì, Nhiều tương, Ít tương'),
(N'Mỳ Ý Đùi Gà Sốt Cay',	'CN002',	N'Đùi gà chọn lọc, sốt trộn đậm vị',	45000,	N'Tạm ngưng',	N'Ít mì, Nhiều mì, Nhiều tương, Ít tương'),
(N'Mì Tương Đen Sốt Phô Mai Hàn Quốc',	'CN002',	N'Chuẩn vị Hàn Quốc',	45000,	N'Có bán',	N'Ít mì, Nhiều mì, Nhiều tương, Ít tương'),
(N'Combo Xiên Que',	'CN002',	N'Xúc xích /cá / bò /tôm / thanh cua / viên sốt / hồ lô / phô mai viên',	35000,	N'Có bán',	N'Nhiều tương, Ít tương'),
(N'Phin Đen Đá',	'CN003',	N'Đậm đà',	35000,	N'Có bán',	N'Ít đá,Nhiều đá,Ít đường,Không đường'),
(N'Sữa Chua Phúc Bồn Tử Đác Cam',	'CN003',	N'Hương liệu tự nhiên 100%',	70000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Lài Đác Thơm',	'CN003',	N'Ngọt thanh, thơm mát',	50000,	N'Hết hàng',	N'Ít đá,Nhiều đá'),
(N'Trà Thảo Mộc',	'CN003',	N'Thanh mát cơ thể',	50000,	N'Có bán',	N'Ít đá,Nhiều đá,Ít đường,Không đường'),
(N'Trà Đào Phúc Long',	'CN003',	N'Hương thơm tự nhiên từ đào chọn lọc',	50000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Sữa Phúc Long',	'CN003',	N'Nguyên liệu được chọn lọc kĩ càng',	45000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Hoa Hồng',	'CN003',	N'Thơm, ngọt tự nhiên',	50000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Xanh Đá Xay',	'CN003',	N'Béo, ngon, mát lạnh',	60000,	N'Tạm ngưng',	N'Ít đá,Nhiều đá'),
(N'Phin Đen Đá',	'CN004',	N'Đậm đà',	35000,	N'Có bán',	N'Ít đá,Nhiều đá,Ít đường,Không đường'),
(N'Sữa Chua Phúc Bồn Tử Đác Cam',	'CN004',	N'Hương liệu tự nhiên 100%',	70000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Lài Đác Thơm',	'CN004',	N'Ngọt thanh, thơm mát',	50000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Thảo Mộc',	'CN004',	N'Thanh mát cơ thể',	50000,	N'Có bán',	N'Ít đá,Nhiều đá,Ít đường,Không đường'),
(N'Trà Đào Phúc Long',	'CN004',	N'Hương thơm tự nhiên từ đào chọn lọc',	50000,	N'Hết hàng',	N'Ít đá,Nhiều đá'),
(N'Trà Sữa Phúc Long',	'CN004',	N'Nguyên liệu được chọn lọc kĩ càng',	45000,	N'Có bán',	N'Ít đá,Nhiều đá'),
(N'Trà Hoa Hồng',	'CN004',	N'Thơm, ngọt tự nhiên',	50000,	N'Tạm ngưng',	N'Ít đá,Nhiều đá'),
(N'Bánh Mì Heo Cajun',	'CN005',	N'Cajun là hỗn hợp nhiều loại gia vị khác nhau và đem xay nhuyễn tạo thành',	30000,	N'Có bán',	N'Không rau, Nhiều rau, Không ớt, Nhiều ớt, Ít ớt,...'),
(N'Bánh Mì Trứng',	'CN005',	N'2 trứng',	20000,	N'Có bán',	N'Không rau/Nhiều rau,Không ớt/Nhiều ớt/Ít ớt'),
(N'Bánh Mì Bò Tiêu Đen',	'CN005',	N'Bò nướng tiêu mềm, nóng hổi, vừa thổi vừa ăn',	30000,	N'Có bán',	N'Không rau, Nhiều rau, Không ớt, Nhiều ớt, Ít ớt,...'),
(N'Bánh Mì Chả Cá',	'CN005',	N'Chả cá đặc sản từ Nha Trang, nêm nếm vừa ăn.',	30000,	N'Có bán',	N'Không rau, Nhiều rau, Không ớt, Nhiều ớt, Ít ớt'),
(N'Bánh Mì Gà Sốt Nhật',	'CN005',	N'Để lại hương vị đặc trưng ngay đầu lưỡi.',	30000,	N'Có bán',	N'Không rau,Nhiều rau,Không ớt,Nhiều ớt,Ít ớt'),
(N'Bánh Mì Gà Cay',	'CN005',	N'Vị cay bùng hương vị',	30000,	N'Tạm ngưng',	N'Không rau,Nhiều rau,Không ớt,Nhiều ớt,Ít ớt'),
(N'Lẩu Gà Lá É Nhỏ',	'CN006',	N'Vừa 2-3 người ăn',	200000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Vừa',	'CN006',	N'Vừa 4 người ăn',	250000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Lẩu',	'CN006',	N'vừa 5-6 người ăn',	300000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Ngọc Kê Sống Thả Lẩu',	'CN006',	N'Tươi ngon',	60000,	N'Có bán',	Null),
(N'Lòng Gà Xào Mướp Không Gan',	'CN006',	N'Mướp tươi, lòng gà chọn lọc sạch sẽ',	70000,	N'Có bán',	N'Ít cay, Nhiều mướp/Ít mướp'),
(N'Lẩu Gà Lá É Nhỏ',	'CN007',	N'Vừa 2-3 người ăn',	200000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Vừa',	'CN007',	N'Vừa 4 người ăn',	250000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Lớn',	'CN007',	N'vừa 5-6 người ăn',	300000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Ngọc Kê Sống Thả Lẩu',	'CN007',	N'Tươi ngon',	60000,	N'Hết hàng',	Null),
(N'Lòng Gà Xào Mướp Không Gan',	'CN007',	N'Mướp tươi, lòng gà chọn lọc sạch sẽ',	70000,	N'Có bán',	N'Ít cay, Nhiều mướp/Ít mướp'),
(N'Lẩu Gà Lá É Nhỏ',	'CN008',	N'Vừa 2-3 người ăn',	200000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Vừa',	'CN008',	N'Vừa 4 người ăn',	250000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Lớn',	'CN008',	N'vừa 5-6 người ăn',	300000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Ngọc Kê Sống Thả Lẩu',	'CN008',	N'Tươi ngon',	60000,	N'Có bán',	Null),
(N'Lẩu Gà Lá É Nhỏ',	'CN009',	N'Vừa 2-3 người ăn',	200000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Vừa',	'CN009',	N'Vừa 4 người ăn',	250000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Lẩu Gà Lá É Lớn',	'CN009',	N'vừa 5-6 người ăn',	300000,	N'Có bán',	N'Thêm nước,Thêm rau,Thêm bún'),
(N'Ngọc Kê Sống Thả Lẩu',	'CN009',	N'Tươi ngon',	60000,	N'Tạm ngưng',	Null)




insert into DONHANG
values
('DH001',	'CN001',	'TX001',	'KH001',	320000,	15000,	N' 45-47 Lê Duẩn, Bến Nghé', N'Quận 5', N'Tp Hồ Chí Minh',	N'Đang giao',	'1/9/2022'),
('DH002',	'CN004',	null,	'KH002',	455000,	25000,	N'227 Trần Quang Khải, Tân Định', N'Quận 5', N'Tp Hồ Chí Minh',	N'Chờ xử lí',	'4/29/2022'),
('DH003',	'CN001',	null,	'KH003',	175000,	20000,	N'92, Nguyễn Trãi, Phường Bến Thành', N'Quận 1', N'Tp Hồ Chí Minh',	N'Đã tiếp nhận',	'5/11/2021'),
('DH004',	'CN008',	'TX004',	'KH006',	200000,	50000,	N'133,Tạ Quang Bửu', N'Quận 7', N'Tp Hồ Chí Minh',	N'Đã giao',	'12/13/2021'),
('DH005',	'CN005',	'TX001',	'KH005',	120000,	18000,	N'59 Hồ Hảo Hớn, Phường Cô Giang', N'Quận Bình Thạnh', N'Tp Hồ Chí Minh',	N'Đang giao',	'10/29/2022'),
('DH006',	'CN009',	null,	'KH003',	840000,	26000,	N'Lý Long Tường, Phường Tân Phong', N'Quận Bình Thạnh', N'Tp Hồ Chí Minh',	N'Đã tiếp nhận',	'10/29/2021'),
('DH007',	'CN003',	'TX001',	'KH003',	520000,	15000,	N'99-99A Trần Quốc Thảo, phường Võ Thị Sáu', N'Quận 3', N'Tp Hồ Chí Minh',	N'Đã giao',	'6/9/2022'),
('DH008',	'CN009',	null,	'KH003',	840000,	26000,	N'Lý Long Tường, Phường Tân Phong', N'Quận Bình Thạnh', N'Tp Hồ Chí Minh',	N'Đã hủy',	'10/30/2021')


insert into CHITIETDONHANG
values
('DH001',	'CN001',	N'Khoai Lang Chiên Giòn Lắc Phomai',	3,	N'Nhiều tương'),
('DH001',	'CN001',	N'Mì Trộn Gà Sốt Cay Phô Mai',	2,	Null),
('DH001',	'CN001',	N'Mỳ Ý Đùi Gà Sốt Cay',	3,	N'Ít mỳ'),
('DH002',	'CN004',	N'Trà Sữa Phúc Long',	3,	Null),
('DH002',	'CN004',	N'Trà Thảo Mộc',	5,	N'Ít đường'),
('DH002',	'CN004',	N'Sữa Chua Phúc Bồn Tử Đác Cam',	1,	N'Ít đá'),
('DH003',	'CN001',	N'Combo Xiên Que',	5,	Null),
('DH004',	'CN008',	N'Lẩu Gà Lá É Nhỏ',	1,	N'Thêm nước lẩu'),
('DH005',	'CN005',	N'bánh Mì Bò Tiêu Đen',	2,	Null),
('DH005',	'CN005',	N'Bánh Mì Heo Cajun',	2,	N'Một phần không bỏ rau'),
('DH006',	'CN009',	N'Lẩu Gà Lá É Lớn',	2,	Null),
('DH006',	'CN009',	N'Ngọc Kê Sống Thả Lẩu',	4,	Null),
('DH007',	'CN003',	N'Sữa Chua Phúc Bồn Tử Đác Cam',	1,	N'Ít đá'),
('DH007',	'CN003',	N'Trà Lài Đác Thơm',	2,	Null),
('DH007',	'CN003',	N'Trà Thảo Mộc',	3,	Null),
('DH007',	'CN003',	N'Trà Đào Phúc Long',	4,	N'Ít đường'),
('DH008',	'CN009',	N'Lẩu Gà Lá É Lớn',	2,	Null),
('DH008',	'CN009',	N'Ngọc Kê Sống Thả Lẩu',	4,	Null)