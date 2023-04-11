-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
go

-------------------------------------------------------TÌNH HUỐNG 3----------------------------------------------------------------
-- Chi nhánh 001 vào thống kế số lượng đơn hàng ở trạng thái chờ nhận của mình
-- Khách hàng 003 vào đặt thêm đơn hàng
-- Chi nhánh yêu cầu xuất ra thông tin những đơn hàng ở trạng thái chờ nhận để gửi cho đầu bếp làm món ăn
-- Chi nhánh thấy số dòng nhiều hơn != Số đơn hàng thống kê ban đầu
-- => Phantom

exec sp_KhachHangThemDonHang 5, N'Chờ nhận','2022-12-01', NULL,'Online', N'20 Đinh Bộ Lĩnh Quận 1', 260400, 1000, NULL, NULL, 1, NULL, 3, 3, 10, N'Không có'
