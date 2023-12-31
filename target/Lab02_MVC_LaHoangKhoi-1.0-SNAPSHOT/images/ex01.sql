USE [master]
GO
/****** Object:  Database [ex01]    Script Date: 10/18/2023 7:33:48 PM ******/
CREATE DATABASE [ex01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ex01', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ex01.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ex01_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ex01_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ex01] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ex01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ex01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ex01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ex01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ex01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ex01] SET ARITHABORT OFF 
GO
ALTER DATABASE [ex01] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ex01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ex01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ex01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ex01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ex01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ex01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ex01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ex01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ex01] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ex01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ex01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ex01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ex01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ex01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ex01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ex01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ex01] SET RECOVERY FULL 
GO
ALTER DATABASE [ex01] SET  MULTI_USER 
GO
ALTER DATABASE [ex01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ex01] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ex01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ex01] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ex01] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ex01] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ex01', N'ON'
GO
ALTER DATABASE [ex01] SET QUERY_STORE = ON
GO
ALTER DATABASE [ex01] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ex01]
GO
/****** Object:  Table [dbo].[account]    Script Date: 10/18/2023 7:33:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[account] [varchar](50) NOT NULL,
	[password] [varchar](32) NOT NULL,
 CONSTRAINT [PK_account] PRIMARY KEY CLUSTERED 
(
	[account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 10/18/2023 7:33:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[cat_id] [varchar](10) NOT NULL,
	[cat_name] [nvarchar](50) NOT NULL,
	[cat_desciption] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 10/18/2023 7:33:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[pro_id] [varchar](10) NOT NULL,
	[pro_name] [varchar](50) NOT NULL,
	[pro_price] [bigint] NOT NULL,
	[pro_quantity] [int] NOT NULL,
	[pro_picture] [varchar](500) NOT NULL,
	[pro_description] [nvarchar](1000) NOT NULL,
	[cat_id] [varchar](10) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[pro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[account] ([account], [password]) VALUES (N'lhk', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[account] ([account], [password]) VALUES (N'nva', N'0192023a7bbd73250516f069df18b500')
INSERT [dbo].[account] ([account], [password]) VALUES (N'ttt', N'e10adc3949ba59abbe56e057f20f883e')
GO
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_desciption]) VALUES (N'1', N'Iphone', N'new')
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_desciption]) VALUES (N'2', N'Samsung', N'Android')
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_desciption]) VALUES (N'3', N'Oppo', N'Android')
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_desciption]) VALUES (N'4', N'Xiaomi', N'Android')
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_desciption]) VALUES (N'5', N'Vivo', N'Adroid')
GO
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_price], [pro_quantity], [pro_picture], [pro_description], [cat_id]) VALUES (N'A05', N'Galaxy A05', 100, 5, N'galaxya05.jpg', N'new', N'2')
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_price], [pro_quantity], [pro_picture], [pro_description], [cat_id]) VALUES (N'Ip11', N'zzzzzzzzzzz', 33, 5, N'ip11.jpg', N'new', N'1')
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_price], [pro_quantity], [pro_picture], [pro_description], [cat_id]) VALUES (N'Ip12', N'Iphone 12', 200, 5, N'ip12.jpg', N'new', N'1')
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_price], [pro_quantity], [pro_picture], [pro_description], [cat_id]) VALUES (N'Ip13', N'Iphone 13', 300, 5, N'ip13.jpg', N'new', N'1')
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_price], [pro_quantity], [pro_picture], [pro_description], [cat_id]) VALUES (N'S23', N'Galaxy S23 Ulta', 200, 5, N'galaxys23.jpg', N'new', N'2')
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_price], [pro_quantity], [pro_picture], [pro_description], [cat_id]) VALUES (N'Zflip5', N'Galaxu Z Flip5', 300, 5, N'galaxyzflip5.jpg', N'new', N'2')
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([cat_id])
REFERENCES [dbo].[category] ([cat_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
USE [master]
GO
ALTER DATABASE [ex01] SET  READ_WRITE 
GO
