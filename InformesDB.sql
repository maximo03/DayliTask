CREATE DATABASE InformesDB
USE InformesDB
go

/**************************TABLE USER AND PROCEDURE******************************/
CREATE TABLE Users(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(256),
Email NVARCHAR(256),
EmailNormalized NVARCHAR(256),
PasswordHash NVARCHAR(MAX)
)
go

CREATE PROCEDURE SP_InsertUser
@Name NVARCHAR(256),
@Email NVARCHAR(256),
@EmailNormalized NVARCHAR(256),
@PasswordHash NVARCHAR(MAX)
as
 begin
   INSERT INTO Users(Name,Email,EmailNormalized,PasswordHash)
		VALUES(@Name,@Email,@EmailNormalized,@PasswordHash);
	SELECT SCOPE_IDENTITY();
end
go

/****************TABLE TASK AND PROCEDURE********************************************/
CREATE TABLE Task(
IdTask INT PRIMARY KEY,
TitleTask NVARCHAR(MAX),
IdUser INT,
DescriptionTask NVARCHAR(MAX),
HoursTask DECIMAL(18,1),
StartDate DATE,
CloseDate DATE,
Journey NVARCHAR(20),
TeamProject NVARCHAR(200),
MonthTask int,
YearTask int
)
go



CREATE PROCEDURE SP_InsertTask
@IdTask INT,
@TitleTask NVARCHAR(MAX),
@IdUser INT,
@DescriptionTask NVARCHAR(MAX),
@HoursTask DECIMAL(18,1),
@StartDate DATE,
@CloseDate DATE,
@Journey NVARCHAR(20),
@TeamProject NVARCHAR(200),
@MonthTask int,
@YearTask int
as
 begin
   INSERT INTO Task(IdTask,TitleTask,IdUser,DescriptionTask,HoursTask,StartDate,CloseDate,Journey,TeamProject,MonthTask,YearTask)
		VALUES(@IdTask,@TitleTask,@IdUser,@DescriptionTask,@HoursTask,@StartDate,@CloseDate,@Journey,@TeamProject,@MonthTask,@YearTask);
		SELECT SCOPE_IDENTITY();
end
go


CREATE PROCEDURE SP_UpdateTask
@IdTask INT,
@TitleTask NVARCHAR(MAX),
@IdUser INT,
@DescriptionTask NVARCHAR(MAX),
@HoursTask DECIMAL(18,1),
@StartDate DATE,
@CloseDate DATE,
@Journey NVARCHAR(20),
@TeamProject NVARCHAR(200),
@MonthTask int,
@YearTask int
as
 begin
UPDATE Task SET  TitleTask = @TitleTask,
                            IdUser = @IdUser,
							DescriptionTask = @DescriptionTask,
							HoursTask = @HoursTask,
							StartDate = @StartDate,
							CloseDate = @CloseDate,
							Journey = @Journey,
							TeamProject = @TeamProject,
							MonthTask = @MonthTask,
							YearTask = @YearTask WHERE IdTask=@IdTask
end
go



CREATE PROCEDURE SP_ListTaskDateNow
@IdUser INT,
@MonthTask int,
@YearTask int
as
 begin
    SELECT *FROM Task WHERE  MonthTask = @MonthTask AND YearTask = @YearTask AND  IdUser = @IdUser ORDER BY StartDate;
end
go


CREATE PROCEDURE SP_PrintTaskMonth
@IdUser INT,
@MonthTask int,
@YearTask int
as
 begin
SELECT t.IdTask as ID, t.TitleTask as TITULO, u.Name as RESPONSABLE,
t.DescriptionTask as DESCRIPCION, t.HoursTask as HORAS, 
dbo.DC(t.StartDate) as CREACION, dbo.DC(t.CloseDate) as CIERRE,
dbo.CJ(t.Journey) as JORNADA, t.TeamProject as TEAMPROJECT 
FROM Task t
INNER JOIN Users u
ON t.IdUser = u.Id 
WHERE  u.Id =@IdUser AND t.MonthTask = @MonthTask And t.YearTask = @YearTask ORDER BY T.StartDate
end
go

/***************FUNCTIONS**************************************/
CREATE FUNCTION DC
(
@date VARCHAR(11)
)
RETURNS VARCHAR(11)
AS
BEGIN
DECLARE @castin VARCHAR(11)
SET @castin = CONVERT(VARCHAR(11),@date,103)
RETURN @castin
END
go

CREATE FUNCTION CJ
(
@select int
)
RETURNS VARCHAR(15)
AS
BEGIN
DECLARE @castin VARCHAR(15)
SET @castin = ( CASE @select WHEN 1 THEN 'Ordinaria' ELSE 'Extraordinaria' END)
RETURN @castin
END
go

/*************************VALIDATORS*****************************************************/
DELETE FROM Users
SELECT * FROM Users
GO

SELECT *FROM Task
DELETE FROM Task
TRUNCATE TABLE Task
go

SELECT*FROM Task WHERE  MonthTask =0  AND YearTask =0  AND  IdUser = 5 ;
go

SELECT t.IdTask as ID, t.TitleTask as TITULO, u.Name as RESPONSABLE,
t.DescriptionTask as DESCRIPCION, t.HoursTask as HORAS, 
dbo.DC(t.StartDate) as CREACION, dbo.DC(t.CloseDate) as CIERRE,
dbo.CJ(t.Journey) as JORNADA, t.TeamProject as TEAMPROJECT 
FROM Task t
INNER JOIN Users u
ON t.IdUser = u.Id 
WHERE  u.Id =7 AND t.MonthTask = 6 And t.YearTask = 2022 ORDER BY T.StartDate
GO

EXEC SP_PrintTaskMonth 5,6,2022
go
exec SP_InsertTask 224578,'mas pruebas',5,'lalalalalalal noooooo',0.5,'2022-06-06','2022-06-06','1','Devops',0,0
go