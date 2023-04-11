-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
go

-------------------------------------------------------TÌNH HUỐNG 2----------------------------------------------------------------
--PROC 1: Tài xế nhận đơn hàng

alter proc sp_TaiXeCapNhatDonHang
	@MaTX int,
	@idDonDatHang int
as
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
begin transaction
	-- Kiểm tra mã tài xế có tồn tại
	if(not exists(select * from TaiXe where idTaiXe = @MaTX))
	begin
		raiserror(N'Mã tài xế không tồn tại', 16,1)
		raiserror(N'Cập nhật không thành công',16,1)
		rollback tran
		return
	end
	-- Kiểm tra đơn đặt hàng có tồn tại
	if(not exists(select * from DonDatHang where idDonDatHang = @idDonDatHang))
	begin
		raiserror(N'Mã đơn hàng không tồn tại',16,1)
		raiserror(N'Cập nhật không thành công',16,1)
		rollback tran
		return
	end

	-- Kiểm tra đơn hàng có ai nhận chưa
	if((select TinhTrang from DonDatHang where idDonDatHang = @idDonDatHang) = N'Chờ nhận')
	begin
		raiserror('Đơn đặt hàng có trong hệ thống', 16,1)
		WAITFOR DELAY '00:00:5'
		update DonDatHang set TinhTrang = N'Đã nhận đơn hàng' where idDonDatHang = @idDonDatHang
		update DonDatHang set idTaiXe = @MaTX where idDonDatHang = @idDonDatHang
	end
	else
	begin
		raiserror(N'Cập nhật không thành công',16,1)
		rollback tran
		return
	end

	--KIỂM TRA
	if(not exists(select * from DonDatHang where idDonDatHang = @idDonDatHang))
	begin
		raiserror(N'Đơn đặt hàng hiện không có trong hệ thống', 16,1)
		rollback tran
		return
	end
	else
	begin
		select * from DonDatHang where idDonDatHang = @idDonDatHang
	end
commit transaction
go

-------------------------------------------------------TÌNH HUỐNG 2----------------------------------------------------------------
--PROC 2: Chi nhánh cập nhật đơn hàng

alter proc sp_ChiNhanhCapNhatDonHang
	@MaCN int,
	@idDonDatHang int
as
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
begin transaction
	-- Kiểm tra chi nhánh có tồn tại
	if(not exists(select * from ChiNhanh where idChiNhanh = @MaCN))
	begin
		raiserror(N'Mã chi nhánh không tồn tại', 16, 1)
		raiserror(N'Cập nhật không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra đơn đặt hàng có tồn tại
	if(not exists(select * from DonDatHang where idDonDatHang = @idDonDatHang))
	begin
		raiserror(N'Mã đơn đặt hàng không tồn tại', 16, 1)
		raiserror(N'Cập nhật không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra đơn đặt hàng này có thuộc chi nhánh này không
	if(not exists(select * from DonDatHang where idDonDatHang = @idDonDatHang and idChiNhanh = @MaCN))
	begin 
		raiserror('Chi nhánh không có đơn đặt hàng này', 16, 1)
		raiserror(N'Cập nhật không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra Trạng thái đơn đặt hàng có chờ nhận
	if((select TinhTrang from DonDatHang where idDonDatHang = @idDonDatHang) = N'Chờ nhận')
	begin
		update DonDatHang set TinhTrang = N'Đã huỷ' where idDonDatHang = @idDonDatHang
		update DonDatHang set idChiNhanh = @MaCN where idDonDatHang = @idDonDatHang
		raiserror(N'Cập nhật thành công', 16,1)
	end
	else
	begin
		raiserror(N'Đơn hàng của bạn hiện không thể xóa', 16, 1)
		raiserror(N'Cập nhật không thành công', 16,1)
		rollback tran
		return
	end
commit transaction
go