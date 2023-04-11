-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
go

-------------------------------------------------------TÌNH HUỐNG 1----------------------------------------------------------------
--PROC 1: Chi nhánh kiểm tra số lượng đơn hàng trạng thái chờ nhận

alter proc sp_ChiNhanhKiemTraDonHang
	@MaCN int
as
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin transaction
	-- Kiểm tra chi nhánh có tồn tại
	if(not exists(select * from ChiNhanh where idChiNhanh = @MaCN))
	begin
		raiserror(N'Mã chi nhánh không tồn tại', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end

	--Kiểm tra các đơn hàng của chi nhánh
	if(not exists(select * from DonDatHang where idChiNhanh = @MaCN))
	begin 
		raiserror('Chi nhánh không có đơn đặt hàng', 16, 1)
		rollback tran
		return
	end

	WAITFOR DELAY '00:00:5'
	-- Xem đơn hàng ở trạng thái chờ nhận
	select * from DonDatHang where TinhTrang = N'Chờ nhận' and idChiNhanh = @MaCN
commit transaction
go

-------------------------------------------------------TÌNH HUỐNG 1----------------------------------------------------------------
 --PROC2: Khách hàng xóa đơn đặt hàng
alter proc sp_KhachHangDeLeteDDH
	@MaKH int,
	@idDonDatHang int
as
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
begin transaction
	-- Kiểm tra Khách hàng có tồn tại
	if(not exists(select * from KhachHang where idKhachHang = @MaKH))
	begin
		raiserror(N'Mã khách hàng không tồn tại', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra đơn đặt hàng có tồn tại
	if(not exists(select * from DonDatHang where idDonDatHang = @idDonDatHang))
	begin
		raiserror(N'Mã đơn đặt hàng không tồn tại', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra đơn đặt hàng này có tồn tại với khách hàng này không
	if(not exists(select * from DonDatHang where idDonDatHang = @idDonDatHang and idKhachHang = @MaKH))
	begin 
		raiserror('Khách hàng không có đơn đặt hàng này', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra Trạng thái đơn đặt hàng có chờ nhận
	if((select TinhTrang from DonDatHang where idDonDatHang = @idDonDatHang) = N'Chờ nhận')
	begin
		delete ChiTietDDH where idDonDatHang = @idDonDatHang -- Do ràng buộc khóa chính khóa ngoại
		delete DonDatHang where idDonDatHang = @idDonDatHang
		raiserror(N'Xóa thành công', 16,1)
	end
	else
	begin
		raiserror(N'Đơn hàng của bạn hiện không thể xóa', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end
commit transaction
go