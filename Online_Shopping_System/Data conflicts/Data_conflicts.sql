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

-------------------------------------------------------TÌNH HUỐNG 3----------------------------------------------------------------
--PROC 1: Chi nhánh thống kê số lượng đơn hàng

alter proc sp_ChiNhanhThongKeDonHang
	@MaCN int
as
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
begin transaction
	
	--Kiểm tra chi nhánh tồn tại
	if(not exists(select * from ChiNhanh where idChiNhanh = @MaCN))
	begin
		raiserror(N'Mã chi nhánh không tồn tại', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end
	-- In số lượng đơn hàng ở trạng thái chờ nhận của cửa hàng  
	declare @SL_DonHang int
	set @SL_DonHang = (select count(*)
						from ChiNhanh CN, DonDatHang DDH 
						where  CN.idChiNhanh = DDH.idChiNhanh and DDH.TinhTrang = N'Chờ nhận')
	print(N'Số lượng đơn hàng ở trạng thái chờ nhận của cửa hàng ' + cast(@MaCN as varchar(4)) + N' là: ' + cast(@SL_DonHang as varchar(4)))
	WAITFOR DELAY '00:00:05'

	-- In ra những đơn hàng ở trạng thái chờ nhận của cửa hàng
	select DDH.idDonDatHang, DDH.TinhTrang, DDH.DiaChiNhan, DDH.HinhThucThanhToan, DDH.NgayLap, DDH.idTaiXe, DDH.idChiNhanh
	from ChiNhanh CN, DonDatHang DDH
	where CN.idChiNhanh = DDH.idChiNhanh and CN.idChiNhanh = @MaCN and DDH.TinhTrang = N'Chờ nhận'

commit transaction
go

-------------------------------------------------------TÌNH HUỐNG 3----------------------------------------------------------------
--PROC 2: Khách hàng thêm đơn đặt hàng

alter proc sp_KhachHangThemDonHang
	@idDonDatHang int,
	@TinhTrang nvarchar(20),
	@NgayLap datetime,
	@NgayThanhToan datetime,
	@HinhThucThanhToan nvarchar(20),
	@DiaChiNhan nvarchar(50),
	@PhiSanPham float,
	@PhiVanChuyen float,
	@Rating int,
	@Comment nvarchar(100),
	@idChiNhanh int,	
	@idTaiXe int,
	@MaKH int,
	@MaMon int,
	@SLSanPham int,
	@TuyChon nvarchar(50)
as
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
begin transaction
	-- Kiểm tra thông tin khách hàng
	if(not exists(select * from KhachHang where idKhachHang = @MaKH))
	begin
		raiserror(N'Mã khách hàng không tồn tại', 16, 1)
		raiserror(N'Xóa không thành công', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra đơn đặt hàng có tồn tại
	if(exists(select * from DonDatHang where idDonDatHang = @idDonDatHang))
	begin
		raiserror(N'Đơn đặt hàng đã tồn tại', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra phí vận chuyển có hợp lệ
	if(@PhiVanChuyen < 0)
	begin
		raiserror(N'Phí vận chuyển không hợp lệ', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra chi nhánh bạn đặt có trong hệ thống
	if(not exists(select * from ChiNhanh where idChiNhanh = @idChiNhanh))
	begin
		raiserror(N'Chi nhánh không tồn tại trong hệ thống', 16,1)
		rollback tran
		return
	end

	-- Kiểm tra món bạn đặt có trong chi nhánh bạn đặt không
	if(@MaMon NOT IN(select M.idMon from ChiNhanh CN, Mon M where CN.idChiNhanh = @idChiNhanh AND CN.idChiNhanh = M.idChiNhanh ))
	begin
		print(N'Chi nhánh ' + cast(@idChiNhanh as varchar(4)) + N' không tồn tại món ' + cast(@MaMon as varchar(4)) + N' mà bạn chọn')
		rollback tran
		return
	end

	-- Kiểm tra số lượng sản phẩm bạn đặt
	if(@SLSanPham <= 0)
	begin
		raiserror(N'Số lượng đặt mua sản phẩm của bạn không hợp lệ', 16,1)
		rollback tran
		return
	end

	--Khôi phục đơn hàng đã bị xoá
	SET IDENTITY_INSERT DonDatHang ON
	insert into DonDatHang (idDonDatHang, TinhTrang, NgayLap, NgayThanhToan, HinhThucThanhToan, DiaChiNhan, PhiSanPham, PhiVanChuyen, Rating, Comment, idChiNhanh, idTaiXe, idKhachHang)
	values(@idDonDatHang, @TinhTrang, @NgayLap, @NgayThanhToan , @HinhThucThanhToan, @DiaChiNhan, @PhiSanPham, @PhiVanChuyen, @Rating, @Comment, @idChiNhanh, @idTaiXe, @MaKH)
	insert into ChiTietDDH values(@MaMon, @idDonDatHang, @SLSanPham, @TuyChon)

	print('Khách hàng thêm đơn hàng thành công')

commit transaction
go

