-------------------------------------------------LÂM QUANG DUY _ 20120065----------------------------------------------------

go 
use QL_GIAOHANG_HQT
go

-------------------------------------------------------TÌNH HUỐNG 3----------------------------------------------------------------
--PROC 1: Chi nhánh thống kê số lượng đơn hàng

alter proc sp_ChiNhanhThongKeDonHang
	@MaCN int
as
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
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
						where  CN.idChiNhanh = DDH.idChiNhanh and CN.idChiNhanh = 1 and DDH.TinhTrang = N'Chờ nhận')
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
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
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

