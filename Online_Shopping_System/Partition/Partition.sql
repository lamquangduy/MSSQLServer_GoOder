ALTER DATABASE QLHTGH
ADD FILEGROUP FG1
ALTER DATABASE QLHTGH
ADD FILEGROUP FG2
ALTER DATABASE QLHTGH
ADD FILEGROUP FG3
ALTER DATABASE QLHTGH
ADD FILEGROUP FG4
---- 
go
ALTER DATABASE QLHTGH ADD FILE (NAME = 'Quarter_1',FILENAME = 'D:\Partition\DBPartition_1.ndf',SIZE = 1MB,
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