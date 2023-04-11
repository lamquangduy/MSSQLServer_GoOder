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

exec sp_ChiNhanhThongKeDonHang 1

delete ChiTietDDH where idDonDatHang = 5
delete DonDatHang where idDonDatHang = 5