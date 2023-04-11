use QLHTGH
go



---tạo list đơn hàng hiển thị theo địa chỉ của user



go
create proc sp_OrderList
	@matx char(10)
as
begin
	select DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaTX is null and TX.MaTX = @matx and DH.ThanhPho = TX.TPHoatDong and DH.MaCN= CN.MaCN and (TX.QuanHoatDong = DH.Quan or TX.QuanHoatDong = CN.Quan) and CN.MaDT = DT.MaDT and DH.TinhTrangDH = N'Đã tiếp nhận'
end
go




----tạo list đơn hàng tài xế đã nhận giao
create proc sp_ReceivedOrderList
	@matx char(10)
as
begin
	select DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore ,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaTX = @matx and TX.MaTX = @matx and DH.ThanhPho = TX.TPHoatDong and DH.MaCN= CN.MaCN and CN.MaDT = DT.MaDT and DH.TinhTrangDH = N'Đã tiếp nhận'
end
go


---tạo list đơn hàng tài xế đã nhận hàng

create proc sp_DeliveringOrderList
	@matx char(10)
as
begin
	select DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaTX = @matx and TX.MaTX = @matx and DH.ThanhPho = TX.TPHoatDong and DH.MaCN= CN.MaCN and CN.MaDT = DT.MaDT and DH.TinhTrangDH = N'Đang giao'
end
go





--tạo list đơn hàng tài xế đã giao
create proc sp_DeliveredOrderList
	@matx char(10)
as
begin
	select DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaTX = @matx and TX.MaTX = @matx and DH.ThanhPho = TX.TPHoatDong and DH.MaCN= CN.MaCN and CN.MaDT = DT.MaDT and DH.TinhTrangDH = N'Đã giao'
end
go



---hiện thông tin chi tiết đơn hàng

create proc sp_OrderInfo
	@madh char(10)
as
begin
	select CTDH.MaDH as madh, CTDH.TenMon as foodname, CTDH.SoLuong as countfood, TD.Gia as price, TD.Gia * CTDH.SoLuong  as totalPrice
	from CHITIETDONHANG as CTDH, DONHANG as DH, THUCDON as TD
	where CTDH.MaDH = @madh and DH.MaDH = @madh and  CTDH.MaCN = TD.MaCN and CTDH.TenMon = TD.TenMon
end
go

---cập nhật thông tin tài xế vào đơn hàng


create proc sp_TaiXeNhanDon
	@matx char(10),
	@madh char(10)
as
begin
	update DONHANG
	set MaTX=@matx
	where MaTX is null and TinhTrangDH = N'Đã tiếp nhận' and MaDH = @madh
end
go



create proc sp_TaiXeDangGiao
	@matx char(10),
	@madh char(10)
as
begin
	update DONHANG
	set TinhTrangDH = N'Đang giao'
	where MaTX=@matx and TinhTrangDH = N'Đã tiếp nhận' and MaDH = @madh
end
go



create proc sp_TaiXeDaGiao
	@matx char(10),
	@madh char(10)
as
begin
	update DONHANG
	set TinhTrangDH = N'Đã giao'
	where MaTX=@matx and TinhTrangDH = N'Đang giao' and MaDH = @madh
end
go






------------doitac

create proc sp_DonHangDaXuLi
	@madh char(10)
 AS
 BEGIN TRAN
	update DONHANG
	set TinhTrangDH = N'Đã tiếp nhận'
	where  TinhTrangDH = N'Chờ xử lí' and MaDH = @madh
	if(exists (select * from DONHANG where MaDH = @madh and TinhTrangDH = N'Chờ xử lí'))
	begin
		WAITFOR DELAY '00:00:10'
		update DONHANG
		set TinhTrangDH = N'Đã tiếp nhận'
		where MaDH = @madh
	END
commit
go

create proc sp_DT_OrderDeliveringList
	@madt char(10)
as
begin
	select distinct DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaCN=CN.MaCN and DT.MaDT=@madt and CN.MaDT = DT.MaDT and (DH.TinhTrangDH = N'Đang giao' or DH.TinhTrangDH =N'Đã tiếp nhận') 
end
go



create proc sp_DT_OrderDeliveredList
	@madt char(10)
as
begin
	select distinct DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaCN=CN.MaCN and DT.MaDT=@madt and CN.MaDT = DT.MaDT and DH.TinhTrangDH =N'Đã giao'
end
go


go
create proc sp_ThuNhap
		@timeFrom date,
		@timeTo date,
		@matx char(10)
as
begin
	set dateformat ymd
		select DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, TAIXE as TX, CHINHANH as CN, DOITAC as DT
	where DH.MaTX = @matx and TX.MaTX = @matx and DH.ThanhPho = TX.TPHoatDong and DH.MaCN= CN.MaCN and CN.MaDT = DT.MaDT and DH.TinhTrangDH = N'Đã giao' and DH.NgayDat >= @timeFrom and DH.NgayDat <= @timeTo
	set dateformat dmy
end
go


create proc sp_UpdateDriverInfo
		@matx	char(10),
		@hoten nvarchar(100),
		@sdt  char(11),
		@cmnd char(15),
		@diachi nvarchar(150),
		@biensoxe char(20),
		@email char(100),
		@nganhang char(50),
		@stk char(15),
		@tphoatdong nvarchar(100),
		@quanhoatdong nvarchar(100)
as 
begin
	update TAIXE
	set HoTen=@hoten, SDT = @sdt, CMND = @cmnd, DiaChi=@diachi, BienSoXe=@biensoxe,Email=@email,NganHang=@nganhang,STK=@sdt, TPHoatDong=@tphoatdong,QuanHoatDong=@quanhoatdong
	where MaTX = @matx
end
go



create proc sp_InsertOrder9
as
declare @madh varchar(5) ='DH000'
begin
	declare @soluong int
	set @soluong = (select count(MaDH) from DONHANG) + 1
	declare @soluongstr varchar(3) = (SELECT CAST(@soluong AS varchar(3)));
	declare @madhnew  varchar(6) = concat((SELECT SUBSTRING(@madh, 1, 5-LEN(@soluong))), @soluongstr);
	
	print @madhnew
	
end
go



create proc sp_StoreList
	@madt char(10)
as
begin
	select MaCN,MaDT,DiaChiChiTiet,Quan,ThanhPho,TinhTrangCH,TGHoatDong
	from CHINHANH
	where MaDT = @madt
end
go


create proc sp_MenuInfo
	@macn char(10)
as
begin
	select TenMon,MieuTa, Gia,TinhTrangMon
	from THUCDON
	where MaCN = @macn
end
go



create proc sp_DeleteFood
	@macn char(10),
	@tenmon nvarchar(80)
as
begin
	if not exists (select * from CHITIETDONHANG where MaCN = @macn and TenMon = @tenmon)
	begin
	delete THUCDON
	where MaCN = @macn and TenMon =@tenmon
	end
end
go


create proc sp_UpdateFood
	@macn char(10),
	@tenmon nvarchar(80),
	@mieuta nvarchar(100),
	@gia int,
	@status nvarchar(150)
	--@tuychon nvarchar(150)
as
begin
	if(@mieuta !='' and @gia !='' and @status !='' ) and not exists (select * from CHITIETDONHANG where MaCN = @macn and TenMon = @tenmon)
	begin
	update THUCDON
	set Gia = @gia, TinhTrangMon = @status, MieuTa = @mieuta
	where MaCN = @macn and TenMon =@tenmon
	end

end
go




create proc sp_InsertFood
	@tenmon nvarchar(80),
	@macn char(10),
	@mieuta nvarchar(100),
	@gia int,
	@status nvarchar(150),
	@tuychon nvarchar(150)
as
begin
	if(@tenmon !=N''  and @mieuta !=N''  and @gia != null  and @status !=N''  ) 
	begin
	if not exists (select * from THUCDON where MaCN = @macn and TenMon = @tenmon )
	begin
	insert into THUCDON
	values (@tenmon,@macn,@mieuta,@gia,@status,@tuychon)
	end
	end

end
go

create proc sp_InsertStore
	@madt char(10),
	@chitiet nvarchar(100),
	@quan nvarchar(100),
	@thanhpho nvarchar(100),
	@tinhtrang nvarchar(100),
	@timeactivity nvarchar(20)
as
declare @macn varchar(5) ='CN'
begin
	declare @soluong int
	set @soluong = (select count(*) from CHINHANH) + 1
	declare @soluongstr varchar(3) = (SELECT CAST(@soluong AS varchar(3)));
	declare @macnnew  varchar(10) = concat(@macn, @soluongstr);

	if(@chitiet !='' and @quan !='' and @thanhpho !='' and @tinhtrang !='' and @timeactivity !='')
	begin
		insert into CHINHANH
		values (@macnnew,@madt,@chitiet,@quan,@thanhpho,@tinhtrang,@timeactivity)
	end
end
go



create proc sp_HopDongInfo
		@madt char(10)
as
begin
		select MaHD,    MaSoThue,     MaDT  ,    NguoiDaiDien      ,    MaNV  ,    STK      ,    NganHang ,    TGHieuLuc  ,    HoaHong, SLChiNhanhDangKy  
		from HOPDONG
		where MaDT = @madt and TGHieuLuc > GETDATE()
end
go

create proc sp_TaoHopDong
	@madt char(10),
	@ndd nvarchar(50),
	@mst char(20),
	@tennh char(50),
	@stk char(15),
	@slcndk int,
	@chuoi varchar(100)
as
declare @mahd varchar(5) ='HD'
begin
	declare @soluong int
	set @soluong = (select count(*) from HOPDONG) + 1
	declare @soluongstr varchar(3) = (SELECT CAST(@soluong AS varchar(3)));
	declare @mahdnew  varchar(10) = concat(@mahd, @soluongstr);
	
	insert into HOPDONG
	values (@mahdnew, @mst,@madt,@ndd,null,@slcndk,@stk,@tennh,null,null,N'Chưa duyệt')
	declare @bien int = 1;
	while LEN(@chuoi) > @bien
	begin
		declare @chuoicon varchar(10) =  (SELECT SUBSTRING(@chuoi, @bien, 10));
		
		insert into CHITIETHOPDONG
		values (@mahdnew,@chuoicon)
		set @bien = @bien + 11
		
	end
end



go
create PROC sp_DangNhap @tk NCHAR(20),@pass NCHAR(20), @role NVARCHAR(20)
AS
BEGIN TRANSACTION
IF NOT EXISTS(SELECT * FROM TAIKHOAN t WHERE T.username=@tk AND T.pass=@pass AND T.user_role=@role)
BEGIN
PRINT N'Sai thông tin đăng nhập'
ROLLBACK
RETURN 1
END
IF @role=N'Khách hàng'
BEGIN
SELECT k.username,k.MaKH AS UserID FROM KHACHHANG k WHERE k.username=@tk
END
IF @role=N'Đối tác'
BEGIN
SELECT d.username,d.MaDT AS UserID FROM DOITAC d WHERE d.username=@tk
END
IF @role=N'Tài xế'
BEGIN
SELECT t.username,t.MaTX AS UserID FROM TAIXE t WHERE t.username=@tk
END
IF @role=N'Nhân viên'
BEGIN
SELECT n.username,n.MaNV AS UserID FROM NHANVIEN n WHERE n.username=@tk
end
COMMIT
RETURN 0



go
----- Danh sách đơn hàng chờ xử lí
create PROC sp_customer_orderlist @makh CHAR(10)
AS
BEGIN
SELECT D.MaDH,D.MaCN,D.DonGia,D.PhiVanChuyen FROM DONHANG d
WHERE d.MaKH=@makh AND d.TinhTrangDH=N'Chờ xử lí'
END
GO
----- Danh sách đơn hàng đã nhận
create PROC sp_customer_ReceivedListOrderList @makh CHAR(10)
AS
BEGIN
SELECT D.MaDH,D.MaCN,D.DonGia,D.PhiVanChuyen FROM DONHANG d
WHERE d.MaKH=@makh AND d.TinhTrangDH=N'Đã tiếp nhận'
END
---- Danh sách đơn hàng đang giao
GO
CREATE PROC sp_customer_DeliveringListOrderList @makh CHAR(10)
AS
BEGIN
SELECT D.MaDH,D.MaCN,D.DonGia,D.PhiVanChuyen FROM DONHANG d
WHERE d.MaKH=@makh AND d.TinhTrangDH=N'Đang giao'
END
----- Danh sách đơn hàng đã giao
GO
CREATE PROC sp_customer_DeliveredListOrderList @makh CHAR(10)
AS
BEGIN
SELECT D.MaDH,D.MaCN,D.DonGia,D.PhiVanChuyen FROM DONHANG d
WHERE d.MaKH=@makh AND d.TinhTrangDH=N'Đã giao'
END
go
CREATE PROC sp_OrderInfo1 @madh CHAR(10)
AS
BEGIN
SELECT c.MaDH,c.TenMon,c.SoLuong,T.Gia,c.SoLuong*T.Gia AS ThanhTien FROM CHITIETDONHANG c,THUCDON t WHERE c.MaDH=@madh AND T.TenMon=c.TenMon AND c.MaCN=T.MaCN
END


go
CREATE PROC sp_LayDiaChi @madh CHAR(10)
AS

BEGIN
	SELECT DiaChiChiTiet+','+Quan+','+ThanhPho+',' AS DiaChi FROM DONHANG WHERE MaDH=@madh
END
 ----- Xoá đơn hàng
 go
 CREATE PROC sp_HuyDonHang @madh CHAR(10)
 AS
 BEGIN TRAN
 IF NOT EXISTS (SELECT * FROM DONHANG d WHERE D.MaDH=@madh)
 BEGIN 
 PRINT N'Mã đơn hàng không tồn tại'
 ROLLBACK
 RETURN 1
END
IF NOT EXISTS (SELECT * FROM DONHANG d WHERE D.MaDH=@madh AND D.TinhTrangDH=N'Chờ xử lí')
BEGIN
PRINT N'Đơn hàng đã được nhận. Không thể xoá'
ROLLBACK
RETURN 1
END
UPDATE DONHANG
SET TinhTrangDH=N'Đã huỷ'
WHERE MaDH=@madh
COMMIT TRAN
RETURN 0
----- Tạo hoá đơn
GO
CREATE proc [dbo].[sp_TaoHoaDon] 
@macn CHAR(10),
@makh CHAR(10),
@diachichitiet NVARCHAR(100),
@quan NVARCHAR(100),
@thanhpho NVARCHAR(100)
as
declare @madh varchar(5) ='DH000'
BEGIN tran
	declare @soluong int
	set @soluong = (select count(MaDH) from DONHANG) + 1
	declare @soluongstr varchar(3) = (SELECT CAST(@soluong AS varchar(3)));
	declare @madhnew  varchar(6) = concat((SELECT SUBSTRING(@madh, 1, 5-LEN(@soluong))), @soluongstr);
	IF NOT EXISTS (SELECT * FROM CHINHANH c WHERE c.MaCN=@macn)
	BEGIN
	PRINT N'Mã chi nhánh không tồn tại'
	ROLLBACK
	RETURN 1
	END
	IF NOT EXISTS (SELECT * FROM KHACHHANG k WHERE k.MaKH=@makh)
	BEGIN
	PRINT N'Mã khách hàng không tồn tại'
	ROLLBACK
	RETURN 1
	END
	IF @diachichitiet=NULL OR @quan=NULL OR @thanhpho=NULL
	BEGIN 
	PRINT N'Địa chỉ không  được để trống'
	ROLLBACK
	RETURN 1
	END
	INSERT INTO DONHANG VALUES(@madhnew,@macn,NULL,@makh,NULL,NULL,@diachichitiet,@quan,@thanhpho,N'Chờ xử lí',GETDATE())
	SELECT d.MaDH FROM DONHANG d WHERE D.MaDH=@madhnew
	COMMIT
	RETURN 0
----- Thêm chi tiết đơn hàng
GO
CREATE PROC [dbo].[sp_ThemChiTietHoaDon] @madh CHAR(10),@macn CHAR(10),@tenmon NVARCHAR(80),@soluong INT,@ghichu NVARCHAR(100)
AS
BEGIN TRAN
INSERT INTO CHITIETDONHANG VALUES(@madh,@macn,@tenmon,@soluong,@ghichu)
COMMIT
RETURN 0
GO
CREATE PROC sp_CapNhatDonHang @madh CHAR(10), @dongia INT, @phivanchuyen int
AS
BEGIN TRAN
IF NOT EXISTS (SELECT * FROM DONHANG WHERE MaDH=@madh)
BEGIN
PRINT N'Mã đơn hàng không tồn tại'
ROLLBACK
RETURN 1
END
UPDATE DONHANG
SET DonGia=@dongia,PhiVanChuyen=@phivanchuyen
WHERE MaDH=@madh
COMMIT
RETURN 0

----- Xem menu
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_ThucDon] @macn CHAR(10)
AS
BEGIN
SELECT T.TenMon,T.MieuTa,T.Gia,T.TinhTrangMon FROM THUCDON t
WHERE t.MaCN=@macn
END
--- xem thong tin

go
CREATE PROC sp_CustomerInf @makh CHAR(10)
AS
BEGIN
SELECT k.HoTen,k.SDT,k.DiaChi,k.Email FROM KHACHHANG k WHERE k.MaKH=@makh
END

---- xem danh sách đối tác
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_dsDoiTac]
AS
BEGIN
SELECT D.MaDT,D.LoaiAmThuc,c.DiaChiChiTiet+','+c.Quan+','+c.ThanhPho AS DiaChi,D.TenCuaHang,c.MaCN FROM DOITAC d,CHINHANH c
WHERE d.MaDT=c.MaDT
END
go


-----
CREATE proc sp_PartnerList 
as
begin
	select * from DOITAC
end
go

create proc sp_LoadContractNotAgreeList
as
begin
	select *
	from HOPDONG
	where TinhTrang = N'Chưa duyệt'
end
go

create proc sp_LoadContractAgreeList
as
begin
	select *
	from HOPDONG
	where TinhTrang = N'Đã duyệt' and TGHieuLuc > GETDATE()
end

go

create proc USP_AgreeContract
@manv char(10), @maHD char(10), @date date
as
begin
	update HOPDONG
	set TinhTrang = N'Đã duyệt', TGHieuLuc = @date, MaNV = @manv
	where MaHD = @mahd 
end
go

--exec USP_AgreeContract 'HD004'

go

create proc USP_SetTimeContract
@mahd char(10), @dateTo date
as
begin
	update HOPDONG
	set TGHieuLuc = @dateTo
	where MaHD = @mahd
end

go

--exec USP_SetTimeContract 'HD004', '2024-01-01'

go

create --alter 
proc USP_CancelContract
@mahd char(10)
as
begin
	delete from CHITIETHOPDONG
	where MaHD = @mahd

	delete from HOPDONG
	where MaHD = @mahd
end
go

create proc [dbo].[sp_ReloadMenu]
		@macn char(10)
as 
begin tran

	select *
	from THUCDON
	where MaCN = @macn

commit
GO

go
create function fbanchay (@macn char(10))
returns table
as
return
	SELECT CTDH.TenMon, TD.MieuTa,TD.Gia,TD.TinhTrangMon,TD.TuyChon
	FROM CHITIETDONHANG CTDH
	INNER JOIN THUCDON TD
	ON CTDH.TenMon = TD.TenMon and CTDH.MaCN = TD.MaCN
	where CTDH.MaCN = @macn
	group by CTDH.TenMon, TD.MieuTa,TD.Gia,TD.TinhTrangMon,TD.TuyChon
go

go
create proc sp_Searchby3Options
		@macn char(10),
		@miengia nvarchar(50),
		@banchay nchar(100),
		@ten nvarchar(100)
as
begin
	if( not exists (select * from CHINHANH where MaCN = @macn))
		begin
			print N'Mã chi nhánh không tồn tại!'
			return 1
		end
	if(@banchay ='' )
	begin
		if(@miengia =N'')
		begin
			if(@ten =N'')
			begin
				select * from THUCDON where MaCN = @macn
				return 0
			end
			select * from THUCDON where MaCN = @macn and TenMon like N'%@ten%'
			return 0
		end
		if (@miengia = N'0 - 50,000đ') 
		begin
			if(@ten =N'')
			begin
			select * from THUCDON where MaCN = @macn and Gia >0 and Gia <=50000
			return 0
			end
			select * from THUCDON where MaCN = @macn and Gia >0 and Gia <=50000 and TenMon like N'%@ten%'
			return 0
		end 
		if (@miengia = N'50,000đ - 100,000đ') 
		begin
			if(@ten =N'')
			begin
			select * from THUCDON where MaCN = @macn and Gia <=100000 and Gia >=50000
			return 0
			end
			select * from THUCDON where MaCN = @macn and Gia <=100000 and Gia >=50000 and TenMon like N'%@ten%'
			return 0
		end 
		if(@ten ='')
		begin
		select * from THUCDON where MaCN = @macn and Gia >=100000
		return 0
		end
		select * from THUCDON where MaCN = @macn and Gia >=100000 and TenMon like N'%@ten%'
		return 0
	end
	if(@miengia ='')
		begin
			if(@ten ='')
			begin
				select * from fbanchay(@macn)
				return 0
			end
			select * from fbanchay(@macn) where TenMon like N'%@ten%'
			return 0
		end
	if (@miengia = N'0 - 50,000đ') 
		begin
			if(@ten ='')
			begin
			select * from fbanchay(@macn) where  Gia >0 and Gia <=50000
			return 0
			end
			select * from fbanchay(@macn) where Gia >0 and Gia <=50000 and TenMon like N'%@ten%'
			return 0
		end 
	if (@miengia = N'50,000đ - 100,000đ') 
		begin
			if(@ten ='')
			begin
			select * from fbanchay(@macn) where Gia <=100000 and Gia >=50000
			return 0
			end
			select * from fbanchay(@macn) where Gia <=100000 and Gia >=50000 and TenMon like N'%@ten%'
			return 0
		end 
	if(@ten ='')
		begin
		select * from fbanchay(@macn) where Gia >=100000
		return 0
		end
	select * from fbanchay(@macn) where Gia >=100000 and TenMon like N'%@ten%'
	return 0
end


------------doitac
go

create proc sp_WaititngOrderList
	@madt char(10)
as
begin
	select DH.MaDH as madh,DH.DiaChiChiTiet as addrTo1, DH.Quan as addrTo2, DH.ThanhPho as addrTo3, CN.DiaChiChiTiet as addrFrom1, CN.Quan as addrFrom2, CN.ThanhPho as addrFrom3,
			DT.TenCuaHang as nameStore,   DH.PhiVanChuyen as shippingfee, DH.DonGia as price, DH.NgayDat as dateOrder,DH.MaCN as macn, DH.MaTX as matx
	from DONHANG DH, CHINHANH as CN, DOITAC as DT
	where DH.MaTX is null and DT.MaDT = @madt and CN.MaDT = DT.MaDT and CN.MaCN = DH.MaCN and DH.TinhTrangDH = N'Chờ xử lí'
end
go





