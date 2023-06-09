USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 4/12/2023 4:55:46 PM ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.HIEUSQL\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.HIEUSQL\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCafe', N'ON'
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE = OFF
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[ChiTietHoaDonID] [int] IDENTITY(1,1) NOT NULL,
	[ID_HoaDon] [int] NOT NULL,
	[ID_SanPham] [int] NOT NULL,
	[TongSanPham] [int] NOT NULL,
 CONSTRAINT [PK__ChiTietH__6BB6711588592C31] PRIMARY KEY CLUSTERED 
(
	[ChiTietHoaDonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[HoaDonID] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[SoBanDaDung] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
	[totalPrice] [float] NULL,
 CONSTRAINT [PK__HoaDon__6956CE69001F22F3] PRIMARY KEY CLUSTERED 
(
	[HoaDonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[KhachHangID] [int] IDENTITY(1,1) NOT NULL,
	[HoVaTen] [nvarchar](50) NOT NULL,
	[SoDienThoai] [nvarchar](15) NOT NULL,
	[DiemTichLuy] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KhachHangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHangThanThiet]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHangThanThiet](
	[KhachHangID] [int] IDENTITY(1,1) NOT NULL,
	[MucGiamGia] [float] NOT NULL,
	[ID_KhachHang] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KhachHangID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[id_KM] [int] IDENTITY(1,1) NOT NULL,
	[MucKhuyenMai] [float] NULL,
	[NgayBatDau] [date] NOT NULL,
	[NgayKetThuc] [date] NOT NULL,
 CONSTRAINT [PK_KhuyenMai] PRIMARY KEY CLUSTERED 
(
	[id_KM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[LoaiSanPhamID] [int] IDENTITY(1,1) NOT NULL,
	[LoaiSanPham] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[LoaiSanPhamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[NhanVienID] [int] IDENTITY(1,1) NOT NULL,
	[HoVaTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[GioiTinh] [nvarchar](10) NOT NULL,
	[SoDienThoai] [nvarchar](15) NOT NULL,
	[NgayVaoLam] [date] NOT NULL,
	[ChucVu] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NhanVienID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[SanPhamID] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](100) NOT NULL,
	[DonViTinh] [nvarchar](20) NOT NULL,
	[DonGia] [float] NOT NULL,
	[ID_LoaiSanPham] [int] NOT NULL,
	[Size] [nchar](10) NULL,
 CONSTRAINT [PK__SanPham__05180FF42DFE9FEA] PRIMARY KEY CLUSTERED 
(
	[SanPhamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[Username] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[ID_NhanVien] [int] NOT NULL,
	[ChucVu] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongTinBan]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinBan](
	[BanID] [int] IDENTITY(1,1) NOT NULL,
	[SoBan] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](100) NULL,
 CONSTRAINT [PK__ThongTin__991CE7659B8566F1] PRIMARY KEY CLUSTERED 
(
	[BanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChiTietHoaDon] ON 

INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (17, 85, 1, 2)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (18, 85, 10, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (19, 85, 4, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (20, 85, 20, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (21, 86, 20, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (22, 86, 1, 2)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (23, 86, 17, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (24, 87, 4, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (25, 87, 30, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (26, 88, 16, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (27, 88, 19, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (28, 88, 17, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (29, 89, 10, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (30, 89, 34, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (31, 89, 39, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (32, 89, 36, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (33, 90, 20, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (34, 90, 44, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (35, 90, 21, 2)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (36, 90, 1, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (37, 91, 10, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (38, 91, 34, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (39, 91, 14, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (40, 93, 16, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (51, 98, 1, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1051, 1098, 1, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1052, 1098, 3, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1053, 1099, 1, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1054, 1099, 3, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1055, 1100, 27, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1056, 1100, 28, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1057, 1101, 10, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1058, 1101, 4, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1059, 1102, 1, 1)
INSERT [dbo].[ChiTietHoaDon] ([ChiTietHoaDonID], [ID_HoaDon], [ID_SanPham], [TongSanPham]) VALUES (1060, 1103, 1, 1)
SET IDENTITY_INSERT [dbo].[ChiTietHoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (85, CAST(N'2023-07-25' AS Date), CAST(N'2023-07-25' AS Date), 30, 1, 110000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (86, CAST(N'2023-03-25' AS Date), CAST(N'2023-03-25' AS Date), 29, 1, 115000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (87, CAST(N'2023-06-25' AS Date), CAST(N'2023-06-25' AS Date), 32, 1, 50000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (88, CAST(N'2023-03-25' AS Date), CAST(N'2023-03-25' AS Date), 24, 1, 110000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (89, CAST(N'2023-03-25' AS Date), CAST(N'2023-03-25' AS Date), 39, 1, 105000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (90, CAST(N'2023-03-25' AS Date), CAST(N'2023-03-25' AS Date), 33, 1, 185000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (91, CAST(N'2023-05-25' AS Date), CAST(N'2023-05-25' AS Date), 30, 1, 85000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (93, CAST(N'2023-04-25' AS Date), CAST(N'2023-04-25' AS Date), 71, 1, 30000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (98, CAST(N'2023-03-25' AS Date), CAST(N'2023-04-02' AS Date), 27, 1, 15000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (1098, CAST(N'2023-04-02' AS Date), CAST(N'2023-04-02' AS Date), 27, 1, 36000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (1099, CAST(N'2023-04-02' AS Date), CAST(N'2023-04-02' AS Date), 31, 1, 36000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (1100, CAST(N'2023-04-02' AS Date), CAST(N'2023-04-02' AS Date), 24, 1, 40500)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (1101, CAST(N'2023-04-02' AS Date), CAST(N'2023-04-02' AS Date), 25, 1, 45000)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (1102, CAST(N'2023-04-04' AS Date), NULL, 27, 0, NULL)
INSERT [dbo].[HoaDon] ([HoaDonID], [DateCheckIn], [DateCheckOut], [SoBanDaDung], [TrangThai], [totalPrice]) VALUES (1103, CAST(N'2023-04-04' AS Date), NULL, 31, 0, NULL)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([KhachHangID], [HoVaTen], [SoDienThoai], [DiemTichLuy]) VALUES (1, N'Ngô Thị Kim Tài', N'0349658954', 20)
INSERT [dbo].[KhachHang] ([KhachHangID], [HoVaTen], [SoDienThoai], [DiemTichLuy]) VALUES (2, N'Cao Nguyên Thụy', N'0346598745', 12)
INSERT [dbo].[KhachHang] ([KhachHangID], [HoVaTen], [SoDienThoai], [DiemTichLuy]) VALUES (3, N'Lê Quang Tới', N'0346598562', 10)
INSERT [dbo].[KhachHang] ([KhachHangID], [HoVaTen], [SoDienThoai], [DiemTichLuy]) VALUES (4, N'Phạm Gia Tiến', N'0356498567', 13)
INSERT [dbo].[KhachHang] ([KhachHangID], [HoVaTen], [SoDienThoai], [DiemTichLuy]) VALUES (5, N'Trần Đức Hiếu', N'0349452165', 5)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON 

INSERT [dbo].[LoaiSanPham] ([LoaiSanPhamID], [LoaiSanPham]) VALUES (1, N'Cà phê')
INSERT [dbo].[LoaiSanPham] ([LoaiSanPhamID], [LoaiSanPham]) VALUES (2, N'Trà sữa')
INSERT [dbo].[LoaiSanPham] ([LoaiSanPhamID], [LoaiSanPham]) VALUES (3, N'Trà trái cây')
INSERT [dbo].[LoaiSanPham] ([LoaiSanPhamID], [LoaiSanPham]) VALUES (4, N'Đá xay')
INSERT [dbo].[LoaiSanPham] ([LoaiSanPhamID], [LoaiSanPham]) VALUES (6, N'Sinh tố')
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([NhanVienID], [HoVaTen], [NgaySinh], [GioiTinh], [SoDienThoai], [NgayVaoLam], [ChucVu]) VALUES (18, N'huy2', CAST(N'2023-03-28' AS Date), N'Nam', N'0545456512', CAST(N'2023-03-28' AS Date), N'Nhân viên')
INSERT [dbo].[NhanVien] ([NhanVienID], [HoVaTen], [NgaySinh], [GioiTinh], [SoDienThoai], [NgayVaoLam], [ChucVu]) VALUES (19, N'Đoàn Gia Huy', CAST(N'2002-01-03' AS Date), N'Nam', N'0349452398', CAST(N'2023-03-28' AS Date), N'Nhân viên')
INSERT [dbo].[NhanVien] ([NhanVienID], [HoVaTen], [NgaySinh], [GioiTinh], [SoDienThoai], [NgayVaoLam], [ChucVu]) VALUES (20, N'Trần Đức Hiếu', CAST(N'2002-01-25' AS Date), N'Nam', N'0349452397', CAST(N'2023-03-16' AS Date), N'Nhân viên')
INSERT [dbo].[NhanVien] ([NhanVienID], [HoVaTen], [NgaySinh], [GioiTinh], [SoDienThoai], [NgayVaoLam], [ChucVu]) VALUES (21, N'Ngô Minh Thành', CAST(N'2002-01-14' AS Date), N'Nam', N'0349452397', CAST(N'2023-03-16' AS Date), N'Nhân viên')
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (1, N'Cà phê đá', N'ly', 15000, 1, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (2, N'Cà phê sữa đá/nóng', N'ly', 20000, 1, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (3, N'Bạc xỉu', N'ly', 25000, 1, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (4, N'Trà sữa trân châu', N'ly', 25000, 2, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (6, N'Trà sữa socola', N'ly', 25000, 2, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (7, N'Trà sữa matcha', N'ly', 30000, 2, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (8, N'Trà sữa bạc hà', N'ly', 30000, 2, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (9, N'Trà sữa SP TEAM', N'ly', 35000, 2, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (10, N'Trà đào', N'ly', 25000, 3, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (11, N'Trà vải', N'ly', 25000, 3, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (12, N'Trà dâu', N'ly', 30000, 3, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (13, N'Trà tắc', N'ly', 20000, 3, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (14, N'Trà dâu tằm', N'ly', 35000, 3, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (15, N'Trà chanh sữa', N'ly', 25000, 3, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (16, N'Socola đá xay', N'ly', 30000, 4, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (17, N'Matcha đá xay', N'ly', 40000, 4, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (18, N'Oreo đá xay', N'ly', 30000, 4, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (19, N'Dâu tây đá xay', N'ly', 40000, 4, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (20, N'Sinh tố bơ', N'ly', 45000, 6, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (21, N'Sinh tố mãng cầu', N'ly', 40000, 6, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (22, N'Sinh tố dâu', N'ly', 45000, 6, N'M         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (26, N'Cà phê đá', N'ly', 15000, 1, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (27, N'Cà phê sữa đá/nóng', N'ly', 20000, 1, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (28, N'Bạc xỉu', N'ly', 25000, 1, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (29, N'Trà sữa trân châu', N'ly', 25000, 2, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (30, N'Trà sữa socola', N'ly', 25000, 2, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (31, N'Trà sữa matcha', N'ly', 30000, 2, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (32, N'Trà sữa bạc hà', N'ly', 30000, 2, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (33, N'Trà sữa SP TEAM', N'ly', 35000, 2, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (34, N'Trà đào', N'ly', 25000, 3, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (35, N'Trà vải', N'ly', 25000, 3, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (36, N'Trà dâu', N'ly', 30000, 3, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (37, N'Trà tắc', N'ly', 20000, 3, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (38, N'Trà dâu tằm', N'ly', 35000, 3, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (39, N'Trà chanh sữa', N'ly', 25000, 3, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (40, N'Socola đá xay', N'ly', 30000, 4, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (41, N'Matcha đá xay', N'ly', 40000, 4, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (42, N'Oreo đá xay', N'ly', 30000, 4, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (43, N'Dâu tây đá xay', N'ly', 40000, 4, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (44, N'Sinh tố bơ', N'ly', 45000, 6, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (45, N'Sinh tố mãng cầu', N'ly', 40000, 6, N'L         ')
INSERT [dbo].[SanPham] ([SanPhamID], [TenSanPham], [DonViTinh], [DonGia], [ID_LoaiSanPham], [Size]) VALUES (46, N'Sinh tố dâu', N'ly', 45000, 6, N'L         ')
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
INSERT [dbo].[TaiKhoan] ([Username], [PassWord], [ID_NhanVien], [ChucVu]) VALUES (N'Hieu', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 20, 1)
INSERT [dbo].[TaiKhoan] ([Username], [PassWord], [ID_NhanVien], [ChucVu]) VALUES (N'HUY', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 19, 1)
INSERT [dbo].[TaiKhoan] ([Username], [PassWord], [ID_NhanVien], [ChucVu]) VALUES (N'huy2', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 18, 0)
INSERT [dbo].[TaiKhoan] ([Username], [PassWord], [ID_NhanVien], [ChucVu]) VALUES (N'Thanh', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 21, 1)
GO
SET IDENTITY_INSERT [dbo].[ThongTinBan] ON 

INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (24, N'Bàn 3', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (25, N'Bàn 4', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (26, N'Bàn 5', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (27, N'Bàn 6', N'Có người')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (28, N'Bàn 7', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (29, N'Bàn 8', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (30, N'Bàn 9', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (31, N'Bàn 10', N'Có người')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (32, N'Bàn 11', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (33, N'Bàn 12', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (34, N'Bàn 13', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (35, N'Bàn 14', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (36, N'Bàn 15', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (37, N'Bàn 16', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (38, N'Bàn 17', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (39, N'Bàn 18', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (40, N'Bàn 19', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (41, N'Bàn 20', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (62, N'Bàn 21', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (63, N'Bàn 22', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (64, N'Bàn 23', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (65, N'Bàn 24', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (66, N'Bàn 25', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (67, N'Bàn 26', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (68, N'Bàn 27', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (69, N'Bàn 28', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (70, N'Bàn 29', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (71, N'Bàn 30', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (72, N'Bàn 31', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (73, N'Bàn 32', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (74, N'Bàn 33', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (75, N'Bàn 34', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (76, N'Bàn 35', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (77, N'Bàn 36', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (78, N'Bàn 37', N'Trống')
INSERT [dbo].[ThongTinBan] ([BanID], [SoBan], [TrangThai]) VALUES (79, N'Bàn 38', N'Trống')
SET IDENTITY_INSERT [dbo].[ThongTinBan] OFF
GO
ALTER TABLE [dbo].[ChiTietHoaDon] ADD  CONSTRAINT [DF__ChiTietHo__TongS__403A8C7D]  DEFAULT ((0)) FOR [TongSanPham]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF__HoaDon__DateChec__398D8EEE]  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF__HoaDon__TrangTha__3A81B327]  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ((0)) FOR [ChucVu]
GO
ALTER TABLE [dbo].[ThongTinBan] ADD  CONSTRAINT [DF__ThongTinB__Trang__2C3393D0]  DEFAULT (N'Trống') FOR [TrangThai]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietHo__ID_Sa__4222D4EF] FOREIGN KEY([ID_SanPham])
REFERENCES [dbo].[SanPham] ([SanPhamID])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK__ChiTietHo__ID_Sa__4222D4EF]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietHo__TongS__412EB0B6] FOREIGN KEY([ID_HoaDon])
REFERENCES [dbo].[HoaDon] ([HoaDonID])
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [FK__ChiTietHo__TongS__412EB0B6]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK__HoaDon__TrangTha__3B75D760] FOREIGN KEY([SoBanDaDung])
REFERENCES [dbo].[ThongTinBan] ([BanID])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK__HoaDon__TrangTha__3B75D760]
GO
ALTER TABLE [dbo].[KhachHangThanThiet]  WITH CHECK ADD FOREIGN KEY([ID_KhachHang])
REFERENCES [dbo].[KhachHang] ([KhachHangID])
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK__SanPham__ID_Khuy__286302EC] FOREIGN KEY([ID_LoaiSanPham])
REFERENCES [dbo].[LoaiSanPham] ([LoaiSanPhamID])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK__SanPham__ID_Khuy__286302EC]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NhanVien] ([NhanVienID])
GO
/****** Object:  StoredProcedure [dbo].[Update_PasswordAccountStaff]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Update_PasswordAccountStaff]
@username NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0

	SELECT @isRightPass = COUNT(*) FROM dbo.TaiKhoan WHERE Username = @username AND PassWord = @password

	IF(@isRightPass = 1) 
	BEGIN
		IF (@newPassword != null or @newPassword != '')
		BEGIN
			UPDATE dbo.TaiKhoan SET PassWord = @newPassword WHERE Username = @username
		END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTable]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTable]
AS SELECT * FROM dbo.ThongTinBan
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTaiKhoanByUsername]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTaiKhoanByUsername]
@username nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.TaiKhoan WHERE Username = @username
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	INSERT INTO dbo.HoaDon(DateCheckIn, DateCheckOut, SoBanDaDung, TrangThai)
	VALUES ( GETDATE(), NULL, @idTable, 0);
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idProduct INT, @count INT
AS
BEGIN
	
	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExitsBillInfo = ChiTietHoaDonID, @foodCount = TongSanPham 
	From dbo.ChiTietHoaDon 
	Where @idBill = ID_HoaDon AND @idProduct = ID_SanPham
	
	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.ChiTietHoaDon SET TongSanPham = @foodCount + @count WHERE @idProduct = ID_SanPham
		ELSE
			DELETE dbo.ChiTietHoaDon WHERE @idBill = ID_HoaDon AND @idProduct = ID_SanPham
	END
	ELSE
	BEGIN
		INSERT INTO dbo.ChiTietHoaDon(ID_HoaDon, ID_SanPham, TongSanPham)
		VALUES (@idBill, @idProduct, @count);
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@username nvarchar(100), @password nvarchar(1000)
AS
BEGIN
	SELECT * FROM dbo.TaiKhoan WHERE Username = @username AND PassWord = @password
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 4/12/2023 4:55:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTable]
@IDTable1 INT, @IDTable2 INT
AS
BEGIN
	DECLARE @idFirstBill INT
	DECLARE @idSecondBill INT

	DECLARE @idFirstTableEmty INT = 1
	DECLARE @idSecondTableEmty INT = 1

	SELECT @idSecondBill = HoaDonID FROM dbo.HoaDon WHERE SoBanDaDung = @IDTable2 AND TrangThai = '0'	
	SELECT @idFirstBill = HoaDonID FROM dbo.HoaDon WHERE SoBanDaDung = @IDTable1 AND TrangThai = '0'

	IF (@idFirstBill IS NULL) 
	BEGIN
		INSERT INTO dbo.HoaDon(DateCheckIn, DateCheckOut, SoBanDaDung, TrangThai)
		VALUES ( GETDATE(), NULL, @IDTable1, 0);

		SELECT @idFirstBill = MAX(HoaDonID) FROM dbo.HoaDon WHERE SoBanDaDung = @IDTable1 AND TrangThai = '0'

	END

	SELECT @idFirstTableEmty = COUNT(*) FROM dbo.ChiTietHoaDon WHERE ID_HoaDon = @idFirstBill

	IF (@idSecondBill IS NULL) 
	BEGIN
		INSERT INTO dbo.HoaDon(DateCheckIn, DateCheckOut, SoBanDaDung, TrangThai)
		VALUES ( GETDATE(), NULL, @IDTable2, 0);

		SELECT @idSecondBill = MAX(HoaDonID) FROM dbo.HoaDon WHERE SoBanDaDung = @IDTable1 AND TrangThai = '0'


	END
	SELECT @idSecondTableEmty = COUNT(*) FROM dbo.ChiTietHoaDon WHERE ID_HoaDon = @idSecondBill

	SELECT ChiTietHoaDonID INTO IDBillInfoTable FROM dbo.ChiTietHoaDon WHERE ID_HoaDon = @idSecondBill

	UPDATE dbo.ChiTietHoaDon SET ID_HoaDon = @idSecondBill WHERE ID_HoaDon = @idFirstBill

	UPDATE dbo.ChiTietHoaDon SET ID_HoaDon = @idFirstBill WHERE ChiTietHoaDonID IN (SELECT * FROM dbo.IDBillInfoTable)

	DROP TABLE IDBillInfoTable

	IF (@idFirstTableEmty = 0)
		UPDATE dbo.ThongTinBan SET TrangThai = N'Trống' WHERE BanID = @IDTable2
	IF (@idSecondTableEmty = 0)
		UPDATE dbo.ThongTinBan SET TrangThai = N'Trống' WHERE BanID = @IDTable1
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.ChiTietHoaDon FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = ID_HoaDon FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = SobanDaDung  FROM dbo.HoaDon WHERE HoaDonID = @idBill AND TrangThai = 0
	
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM dbo.ChiTietHoaDon WHERE ID_HoaDon = @idBill

	IF (@count > 0)
		UPDATE dbo.ThongTinBan SET TrangThai = N'Có người' WHERE BanID = @idTable
	ELSE
		UPDATE dbo.ThongTinBan SET TrangThai = N'Trống' WHERE BanID = @idTable
END
GO

CREATE TRIGGER UTG_UpdateBill
ON dbo.HoaDon FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = HoaDonID FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = SobanDaDung  FROM dbo.HoaDon WHERE HoaDonID = @idBill

	DECLARE @count INT = 0

	SELECT @count = COUNT(*) FROM dbo.HoaDon as hd WHERE SoBanDaDung = @idTable AND hd.TrangThai = 0

	If (@count = 0)
		UPDATE dbo.ThongTinBan SET TrangThai = N'Trống' WHERE BanID = @idTable
END
GO
CREATE TRIGGER UTG_DeleteBillInfo
ON dbo.ChiTietHoaDon FOR DELETE
AS
BEGIN
	DECLARE @idBillInfo INT
	DECLARE @idBill INT

	SELECT @idBillInfo = ChiTietHoaDonID, @idBill = deleted.ID_HoaDon FROM deleted

	DECLARE @idTable INT
	SELECT @idTable = SoBanDaDung FROM DBO.HoaDon WHERE @idBill = HoaDonID
	
	DECLARE @count INT = 0

	SELECT @count = COUNT(*) FROM dbo.ChiTietHoaDon as cthd, dbo.HoaDon as hd
	WHERE hd.HoaDonID = cthd.ID_HoaDon AND  hd.HoaDonID = @idBill AND hd.TrangThai = 0

	IF(@count = 0)
		UPDATE dbo.ThongTinBan SET TrangThai = N'Trống' WHERE @idTable = BanID
END
GO
