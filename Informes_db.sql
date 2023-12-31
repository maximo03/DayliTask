USE [master]
GO
/****** Object:  Database [InformesDB]    Script Date: 3/28/2023 9:30:04 AM ******/
CREATE DATABASE [InformesDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InformesDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InformesDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InformesDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InformesDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [InformesDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InformesDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InformesDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InformesDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InformesDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InformesDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InformesDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [InformesDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InformesDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InformesDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InformesDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InformesDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InformesDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InformesDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InformesDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InformesDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InformesDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [InformesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InformesDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InformesDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InformesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InformesDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InformesDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InformesDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InformesDB] SET RECOVERY FULL 
GO
ALTER DATABASE [InformesDB] SET  MULTI_USER 
GO
ALTER DATABASE [InformesDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InformesDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InformesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InformesDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InformesDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InformesDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'InformesDB', N'ON'
GO
ALTER DATABASE [InformesDB] SET QUERY_STORE = OFF
GO
USE [InformesDB]
GO
/****** Object:  UserDefinedFunction [dbo].[CJ]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CJ]
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
GO
/****** Object:  UserDefinedFunction [dbo].[DC]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DC]
(
@date VARCHAR(11)
)
RETURNS VARCHAR(11)
AS
BEGIN
DECLARE @castin VARCHAR(11)
SET @castin = CONVERT(VARCHAR(11),CONVERT(date,@date),103)
RETURN @castin
END
GO
/****** Object:  Table [dbo].[Task]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[IdTask] [int] NOT NULL,
	[TitleTask] [nvarchar](max) NULL,
	[IdUser] [int] NULL,
	[DescriptionTask] [nvarchar](max) NULL,
	[HoursTask] [numeric](18, 1) NULL,
	[StartDate] [date] NULL,
	[CloseDate] [date] NULL,
	[Journey] [nvarchar](20) NULL,
	[TeamProject] [nvarchar](200) NULL,
	[MonthTask] [int] NULL,
	[YearTask] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTask] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailNormalized] [nvarchar](256) NULL,
	[PasswordHash] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Users] FOREIGN KEY([IdUser])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Users]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertTask]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertTask]
@IdTask INT,
@TitleTask NVARCHAR(MAX),
@IdUser INT,
@DescriptionTask NVARCHAR(MAX),
@HoursTask NUMERIC(18,1),
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
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUser]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertUser]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_ListTaskCalendar]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ListTaskCalendar]
@IdUser INT,
@Start DATE,
@End DATE
as
 begin
    SELECT *FROM Task WHERE  StartDate BETWEEN @Start AND @End AND IdUser = @IdUser ORDER BY StartDate;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListTaskDateNow]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ListTaskDateNow]
@IdUser INT,
@MonthTask int,
@YearTask int
as
 begin
    SELECT *FROM Task WHERE  MonthTask = @MonthTask AND YearTask = @YearTask AND  IdUser = @IdUser ORDER BY StartDate;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ListTaskIDCalendar]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ListTaskIDCalendar]
@IdUser INT,
@IdTask Int
as
 begin
    SELECT *FROM Task WHERE  IdTask=@IdTask AND IdUser = @IdUser ;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_PrintTaskFindExel]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PrintTaskFindExel]
@IdUser INT,
@Start DATE,
@End DATE
as
 begin
SELECT t.IdTask as ID, t.TitleTask as TITULO, u.Name as RESPONSABLE,
t.DescriptionTask as DESCRIPCION, t.HoursTask as HORAS, 
dbo.DC(t.StartDate) as CREACION, dbo.DC(t.CloseDate) as CIERRE,
dbo.CJ(t.Journey) as JORNADA, t.TeamProject as TEAMPROJECT 
FROM Task t
INNER JOIN Users u
ON t.IdUser = u.Id 
WHERE  StartDate BETWEEN @Start AND @End AND IdUser = @IdUser ORDER BY StartDate;
end
GO
/****** Object:  StoredProcedure [dbo].[SP_PrintTaskMonth]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PrintTaskMonth]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateTask]    Script Date: 3/28/2023 9:30:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UpdateTask]
@IdTask INT,
@TitleTask NVARCHAR(MAX),
@IdUser INT,
@DescriptionTask NVARCHAR(MAX),
@HoursTask NUMERIC(18,1),
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
GO
USE [master]
GO
ALTER DATABASE [InformesDB] SET  READ_WRITE 
GO
