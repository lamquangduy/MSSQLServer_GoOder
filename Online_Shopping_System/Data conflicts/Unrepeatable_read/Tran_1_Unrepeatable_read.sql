-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
ALTER DATABASE QL_GIAOHANG_HQT SET ALLOW_SNAPSHOT_ISOLATION ON
go

-------------------------------------------------------TÌNH HUỐNG 1----------------------------------------------------------------
-- B1: Chi nhánh 007 xem đơn hàng
-- B2: Khách hàng 003 xoá đơn hàng 003 ở trạng thái "chờ nhận" của mình
-- =>  Chi nhánh 007 không thể xem lại đầy đủ các đơn hàng chờ nhận
-- => Unrepeatable read

exec sp_ChiNhanhKiemTraDonHang 7
--Khôi phục đơn hàng đã bị xoá
SET IDENTITY_INSERT DonDatHang ON

INSERT INTO DonDatHang (idDonDatHang, TinhTrang, NgayLap, NgayThanhToan, HinhThucThanhToan, DiaChiNhan, PhiSanPham, PhiVanChuyen, Rating, Comment, idChiNhanh, idTaiXe, idKhachHang)
VALUES(3, N'Chờ nhận','2022-12-01',NULL,'Online',N'32 Hoàng Diệu 2, Quận Thủ Đức',140000,1000,NULL,NULL,7,NULL,3)
INSERT INTO ChiTietDDH (idMon, idDonDatHang, SoLuongDat, TuyChon)
VALUES(27,3,10, N'Không ớt')