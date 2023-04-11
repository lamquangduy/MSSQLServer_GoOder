go
alter function f_thunhap (@matx char(10),@ngaybatdau date,@ngayketthuc date)
returns money
AS
begin
declare @thunhap MONEY
IF NOT EXISTS (SELECT * FROM TAIXE t WHERE t.MaTX=@matx)
begin
RETURN -1
end

SELECT @thunhap=sum(PhiVanChuyen) from DONHANG WHERE datediff(DAY,@ngaybatdau,NgayDat)>0 and datediff(DAY,NgayDat,@ngayketthuc)>0 and MaTX=@matx and TinhTrangDH=N'Đã giao'
RETURN @thunhap
END
DROP INDEX FI_INCOME ON DONHANG
CREATE NONCLUSTERED INDEX FI_INCOME ON DONHANG(MaTX,NgayDat,TinhTrangDH)
GO
DECLARE @a float
exec @a = dbo.f_thunhap 'TX10','4/23/2022','12/23/2022'
SELECT @a
-------
go
CREATE PROC ds_donhang @ngay DATE,@madt CHAR(10)
AS
BEGIN
IF NOT EXISTS (SELECT * FROM DOITAC WHERE MaDT=@madt)
BEGIN
PRINT N'Mã đối tác không tồn tại'
RETURN 1
END
SELECT D.MaDH,D.MaCN,D.MaKH,d.NgayDat FROM DONHANG d,CHINHANH c WHERE c.MaDT=@madt AND c.MaCN=D.MaCN and datediff(DAY,NgayDat,@ngay)=0
RETURN 0
END
EXEC ds_donhang '11/14/2022','DT2'
DROP INDEX FI_INCOME ON DONHANG
SELECT * FROM DONHANG_NoIndex WHERE NgayDat='5/12/2022'
------
ALTER DATABASE QLHTGH2
ADD FILEGROUP FG1
ALTER DATABASE QLHTGH2
ADD FILEGROUP FG2
ALTER DATABASE QLHTGH2
ADD FILEGROUP FG3
ALTER DATABASE QLHTGH2
ADD FILEGROUP FG4
---- 
go
ALTER DATABASE QLHTGH2 ADD FILE (NAME = 'Quarter_1',FILENAME = 'D:\Partition\DBPartition_1.ndf',SIZE = 1MB,
MAXSIZE = UNLIMITED,FILEGROWTH = 1)
 TO FILEGROUP FG1
ALTER DATABASE QLHTGH2 ADD FILE (NAME = 'Quarter_2',FILENAME = 'D:\Partition\DBPartition_2.ndf',SIZE = 1MB,
MAXSIZE = UNLIMITED,FILEGROWTH = 1)
 TO FILEGROUP FG2
 ALTER DATABASE QLHTGH2 ADD FILE (NAME = 'Quarter_3',FILENAME = 'D:\Partition\DBPartition_3.ndf',SIZE = 1MB,
MAXSIZE = UNLIMITED,FILEGROWTH = 1)
 TO FILEGROUP FG3
 ALTER DATABASE QLHTGH2 ADD FILE (NAME = 'Quarter_4',FILENAME = 'D:\Partition\DBPartition_4.ndf',SIZE = 1MB,
MAXSIZE = UNLIMITED,FILEGROWTH = 1)
 TO FILEGROUP FG4
 ----
 CREATE PARTITION FUNCTION P_Quarters_Function(DATE) AS RANGE LEFT
FOR VALUES('3/1/2022','6/1/2022','9/1/2022','12/1/2022')

----
CREATE PARTITION SCHEME P_Quarters_Schema AS PARTITION P_Quarters
TO (FG1,FG2,FG3,FG4,[PRIMARY])
-----


CREATE CLUSTERED INDEX IX_NgayDat
ON DONHANG
(
 NgayDat
) ON P_Quarters1(NgayDat)
------
SELECT DISTINCT
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'DONHANG'
order by partition_number;