
--Xét quan hệ THUCDON
----tạo index cho bảng THUCDON_Index
CREATE NONCLUSTERED INDEX TDIndex_Gia
ON THUCDON_Index (TenMon,Gia);

CREATE CLUSTERED INDEX TDIndex_MaCN
ON THUCDON_Index (MaCN);

----Mẫu truy vấn tìm món ăn theo tên và giá
select * from THUCDON_NoIndex where  MaCN = 'CN66666'  and  Gia <=35000 and TenMon like N'%Khoai%'  
select * from THUCDON_Index where MaCN = 'CN66666'  and  Gia <=35000 and TenMon like N'%Khoai%'  
----Mẫu truy vấn tìm món ăn theo giá
select * from THUCDON_NoIndex where MaCN = 'CN66666'  and Gia <=35000
select * from THUCDON_Index where MaCN = 'CN66666'  and Gia <=35000
----Mẫu truy vấn tìm món ăn theo tên
select * from THUCDON_NoIndex where  MaCN = 'CN66666' and  TenMon like N'%Khoai%' 
select * from THUCDON_Index where MaCN = 'CN66666' and  TenMon like N'%Khoai%'  

--Xét quan hệ CHITIETDONHANG
----tạo index cho bảng CHITIETDONHANG_Index
CREATE NONCLUSTERED INDEX CTDHIndex_MaCN
ON CHITIETDONHANG_Index (MaCN);

----Mẫu truy vấn tìm món ăn bán chạy
	SELECT CTDH.TenMon, TD.MieuTa,TD.Gia,TD.TinhTrangMon,TD.TuyChon
	FROM CHITIETDONHANG_NoIndex CTDH
	INNER JOIN THUCDON_Index TD
	ON CTDH.TenMon = TD.TenMon and CTDH.MaCN = TD.MaCN
	where CTDH.MaCN = 'CN001'
	group by CTDH.TenMon, TD.MieuTa,TD.Gia,TD.TinhTrangMon,TD.TuyChon
	having sum(SoLuong) >=1

	SELECT CTDH.TenMon, TD.MieuTa,TD.Gia,TD.TinhTrangMon,TD.TuyChon
	FROM CHITIETDONHANG_Index CTDH
	INNER JOIN THUCDON_Index TD
	ON CTDH.TenMon = TD.TenMon and CTDH.MaCN = TD.MaCN
	where CTDH.MaCN = 'CN001'
	group by CTDH.TenMon, TD.MieuTa,TD.Gia,TD.TinhTrangMon,TD.TuyChon
	having sum(SoLuong) >=1


--Xét quan hệ HOPDONG
----tạo index cho bảng HOPDONG_Index
CREATE CLUSTERED INDEX HDIndex
ON HOPDONG_Index (MaHD);

	select * from HOPDONG_NoIndex
	where MaHD = 'HD77777'
	select *  from HOPDONG_Index
	where MaHD = 'HD77777'