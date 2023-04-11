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



-------------------------------------------------------TÌNH HUỐNG 2----------------------------------------------------------------
-- Tài xế 001 vào xem thấy đơn hàng 001 tình trạng là 'Chờ nhận'
-- Chi nhánh 005 kiểm tra đơn hàng 001 thấy đã hết món nên cập nhật lại tình trạng là 'Đã hủy'
-- Tài xế đồng thời cập nhật tình trạng đơn hàng thành 'Đã nhận đơn hàng'
-- => Mất cập nhật của chi nhánh
-- => Lost Update

exec sp_ChiNhanhCapNhatDonHang 5, 1

-------------------------------------------------------TÌNH HUỐNG 3----------------------------------------------------------------
-- Chi nhánh 001 vào thống kế số lượng đơn hàng ở trạng thái chờ nhận của mình
-- Khách hàng 003 vào đặt thêm đơn hàng
-- Chi nhánh yêu cầu xuất ra thông tin những đơn hàng ở trạng thái chờ nhận để gửi cho đầu bếp làm món ăn
-- Chi nhánh thấy số dòng nhiều hơn != Số đơn hàng thống kê ban đầu
-- => Phantom

exec sp_KhachHangThemDonHang 5, N'Chờ nhận','2022-12-01', NULL,'Online', N'20 Đinh Bộ Lĩnh Quận 1', 260400, 1000, NULL, NULL, 1, NULL, 3, 3, 10, N'Không có'
