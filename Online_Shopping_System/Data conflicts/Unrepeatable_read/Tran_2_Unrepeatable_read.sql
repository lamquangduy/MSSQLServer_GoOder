-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
ALTER DATABASE QL_GIAOHANG_HQT SET ALLOW_SNAPSHOT_ISOLATION ON
go

-------------------------------------------------------TÌNH HUỐNG 1----------------------------------------------------------------
-- B1: Chi nhánh 003 xem đơn hàng
-- B2: Khách hàng 003 xoá đơn hàng 003 ở trạng thái "chờ nhận" của mình
-- =>  Chi nhánh 007 không thể xem lại đầy đủ các đơn hàng chờ nhận
-- => Unrepeatable read
exec sp_KhachHangDeleteDDH 3, 3