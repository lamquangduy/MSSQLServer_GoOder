-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
ALTER DATABASE QL_GIAOHANG_HQT SET ALLOW_SNAPSHOT_ISOLATION ON
go
-------------------------------------------------------TÌNH HUỐNG 2----------------------------------------------------------------
-- Tài xế 001 vào xem thấy đơn hàng 001 tình trạng là 'Chờ nhận'
-- Chi nhánh 005 kiểm tra đơn hàng 001 thấy đã hết món nên cập nhật lại tình trạng là 'Đã hủy'
-- Tài xế đồng thời cập nhật tình trạng đơn hàng thành 'Đã nhận đơn hàng'
-- => Mất cập nhật của chi nhánh
-- => Lost Update

exec sp_TaiXeCapNhatDonHang 1, 1

select * from DonDatHang where idDonDatHang = 1
--Chuyển DDH về lại trạng thái chờ nhận
update DonDatHang set TinhTrang = N'Chờ nhận' where idDonDatHang = 1
update DonDatHang set idTaiXe = NULL where idDonDatHang = 1