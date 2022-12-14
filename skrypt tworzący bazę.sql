USE [master]
GO
/****** Object:  Database [KJ_Żłobek]    Script Date: 28.01.2021 20:59:31 ******/
CREATE DATABASE [KJ_Żłobek]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Żłobek', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVERKLAUDIA\MSSQL\DATA\Żłobek.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Żłobek_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVERKLAUDIA\MSSQL\DATA\Żłobek_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [KJ_Żłobek] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KJ_Żłobek].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KJ_Żłobek] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET ARITHABORT OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KJ_Żłobek] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KJ_Żłobek] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KJ_Żłobek] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KJ_Żłobek] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [KJ_Żłobek] SET  MULTI_USER 
GO
ALTER DATABASE [KJ_Żłobek] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KJ_Żłobek] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KJ_Żłobek] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KJ_Żłobek] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KJ_Żłobek] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [KJ_Żłobek] SET QUERY_STORE = OFF
GO
USE [KJ_Żłobek]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [KJ_Żłobek]
GO
/****** Object:  UserDefinedFunction [dbo].[GrupaTest]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GrupaTest] (@Grupa_dziecka nvarchar(20))
returns int
as begin
declare @grupa nvarchar (20)
select @grupa=Spis_grup.Grupa 
from Dane_Dziecka inner join
Spis_grup on Dane_Dziecka.Grupa_dziecka=Spis_grup.Grupa
where Dane_Dziecka.Grupa_dziecka=@Grupa_dziecka
if (@grupa='Maluszki') return 7
if (@grupa='Średniaczki') return 8
if (@grupa='Starszaczki') return 9
return 0
end
GO
/****** Object:  Table [dbo].[Dane_Dziecka]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dane_Dziecka](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Imię_dziecka] [nvarchar](20) NOT NULL,
	[Nazwisko_dziecka] [nvarchar](20) NOT NULL,
	[Ilość_miesięcy] [int] NOT NULL,
	[Adres] [nvarchar](50) NULL,
	[Dieta] [nvarchar](30) NULL,
	[Zajęcia_dodatkowe] [nvarchar](30) NULL,
	[Grupa_dziecka] [nvarchar](20) NOT NULL,
	[Szafka_nr] [int] NOT NULL,
 CONSTRAINT [PK_Dane_Dziecka] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Dzieci]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Dzieci]
AS
SELECT * FROM Dane_Dziecka
GO
/****** Object:  Table [dbo].[Dane_Rodziców]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dane_Rodziców](
	[Dziecko_ID] [int] NOT NULL,
	[Imię_Dziecka] [nvarchar](20) NOT NULL,
	[Imię_Matki] [nvarchar](20) NOT NULL,
	[Imię_Ojca] [nvarchar](20) NOT NULL,
	[Nazwisko] [nvarchar](20) NOT NULL,
	[Adres] [nvarchar](50) NULL,
	[Telefon] [char](9) NOT NULL,
 CONSTRAINT [PK_Dane_Rodziców] PRIMARY KEY CLUSTERED 
(
	[Dziecko_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Rodzice]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Rodzice]
AS
select * from Dane_Rodziców
GO
/****** Object:  Table [dbo].[Spis_grup]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Spis_grup](
	[Spis_ID] [int] NOT NULL,
	[Grupa] [nvarchar](20) NOT NULL,
	[Wiek_dzieci_w_grupie] [nvarchar](30) NOT NULL,
	[Id_opiekunki] [int] NOT NULL,
	[Nr_sali] [int] NOT NULL,
 CONSTRAINT [PK_Spis_grup] PRIMARY KEY CLUSTERED 
(
	[Grupa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Grupy]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grupy]
AS
select * from Spis_grup
GO
/****** Object:  Table [dbo].[Opiekunki]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opiekunki](
	[Opiekunka_ID] [int] NOT NULL,
	[Imię_opiekunki] [nvarchar](20) NOT NULL,
	[Nazwisko_opiekunki] [nvarchar](20) NOT NULL,
	[Grupa_opiekunki] [nvarchar](20) NOT NULL,
	[Telefon_opiekunki] [char](9) NOT NULL,
	[Adres_opiekunki] [nvarchar](50) NULL,
 CONSTRAINT [OK_Grupa] PRIMARY KEY CLUSTERED 
(
	[Opiekunka_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Opiekunki_Dzieci]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Opiekunki_Dzieci] AS
SELECT Opiekunki.Opiekunka_ID, Opiekunki.Imię_opiekunki, Opiekunki.Nazwisko_opiekunki, Opiekunki.Grupa_opiekunki, Spis_grup.Wiek_dzieci_w_grupie, Spis_grup.Nr_sali
FROM   Spis_grup INNER JOIN
             Opiekunki ON Spis_grup.Id_opiekunki = Opiekunki.Opiekunka_ID
GO
/****** Object:  View [dbo].[DzieciID_Rodzice]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[DzieciID_Rodzice] AS
SELECT Dane_Dziecka.ID, Dane_Dziecka.Imię_dziecka, Dane_Rodziców.Imię_Matki, Dane_Rodziców.Imię_Ojca, Dane_Rodziców.Nazwisko
FROM   Dane_Dziecka INNER JOIN
             Dane_Rodziców ON Dane_Dziecka.ID = Dane_Rodziców.Dziecko_ID
GO
/****** Object:  View [dbo].[Dzieci_Grupy]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	 create view [dbo].[Dzieci_Grupy] as
select Imię_dziecka,Nazwisko_dziecka, Grupa_dziecka from Dane_Dziecka
GO
/****** Object:  Table [dbo].[Zachowanie]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zachowanie](
	[dziecko_ID] [int] NOT NULL,
	[Uwaga] [nvarchar](30) NULL,
	[Aktywność] [nvarchar](30) NULL,
 CONSTRAINT [PK_Zachowanie] PRIMARY KEY CLUSTERED 
(
	[dziecko_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Zachowanie_Dzieci]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Zachowanie_Dzieci] as
SELECT Dane_Dziecka.ID, Dane_Dziecka.Imię_dziecka, Dane_Dziecka.Nazwisko_dziecka, Zachowanie.Uwaga, Zachowanie.Aktywność
FROM   Dane_Dziecka INNER JOIN
             Zachowanie ON Dane_Dziecka.ID = Zachowanie.dziecko_ID
GO
/****** Object:  View [dbo].[Grupa1]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grupa1]
AS
SELECT Imię_dziecka, Nazwisko_dziecka, Ilość_miesięcy
FROM Dane_Dziecka INNER JOIN Spis_grup on
Dane_Dziecka.Grupa_dziecka=Spis_grup.Grupa
WHERE Grupa='Maluszki'
GROUP BY Imię_dziecka , Nazwisko_dziecka, ID, Grupa_dziecka, Ilość_miesięcy
GO
/****** Object:  View [dbo].[Opiekunki1]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[Opiekunki1] as
select * from Opiekunki
GO
/****** Object:  View [dbo].[Grupa2]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grupa2]
AS
SELECT Imię_dziecka, Nazwisko_dziecka, Ilość_miesięcy
FROM Dane_Dziecka INNER JOIN Spis_grup on
Dane_Dziecka.Grupa_dziecka=Spis_grup.Grupa
WHERE Grupa='Średniaczki'
GROUP BY Imię_dziecka , Nazwisko_dziecka, ID, Grupa_dziecka, Ilość_miesięcy
GO
/****** Object:  Table [dbo].[Szatnia]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Szatnia](
	[Nr_szafki] [int] NOT NULL,
	[id_dziecka] [int] NOT NULL,
	[Rodzaj_szafki] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Szatnia_1] PRIMARY KEY CLUSTERED 
(
	[Nr_szafki] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Dzieci_Szafki]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Dzieci_Szafki] as
SELECT Dane_Dziecka.ID, Dane_Dziecka.Imię_dziecka, Dane_Dziecka.Nazwisko_dziecka, Szatnia.Nr_szafki, Szatnia.Rodzaj_szafki
FROM   Szatnia INNER JOIN
             Dane_Dziecka ON Szatnia.Nr_szafki = Dane_Dziecka.Szafka_nr
GO
/****** Object:  View [dbo].[Grupa3]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grupa3]
AS
SELECT Imię_dziecka, Nazwisko_dziecka, Ilość_miesięcy
FROM Dane_Dziecka INNER JOIN Spis_grup on
Dane_Dziecka.Grupa_dziecka=Spis_grup.Grupa
WHERE Grupa='Starszaczki'
GROUP BY Imię_dziecka , Nazwisko_dziecka, ID, Grupa_dziecka, Ilość_miesięcy
GO
/****** Object:  Table [dbo].[Płatności]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Płatności](
	[Zaległa_kwota] [int] NOT NULL,
	[Za_miesiąc] [nvarchar](20) NULL,
	[Za_dziecko] [int] NOT NULL,
	[Imię_dziecka] [nvarchar](10) NOT NULL,
	[Nazwisko_dziecka] [nvarchar](20) NOT NULL,
	[Telefon_rodzica] [char](9) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Płatności_Rodzice]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create view [dbo].[Płatności_Rodzice] as
SELECT Płatności.Zaległa_kwota, Płatności.Za_miesiąc, Płatności.Za_dziecko, Płatności.Imię_dziecka,
Dane_Rodziców.Imię_Matki, Dane_Rodziców.Imię_Ojca, Dane_Rodziców.Nazwisko, Dane_Rodziców.Telefon
FROM   Płatności INNER JOIN
Dane_Rodziców ON Płatności.Za_dziecko = Dane_Rodziców.Dziecko_ID
        
GO
/****** Object:  Table [dbo].[Wypożyczenia_zabawek]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wypożyczenia_zabawek](
	[Id_zabawki] [int] NOT NULL,
	[Wypozyczona_Ilość] [int] NOT NULL,
	[Dziecko_Id] [int] NOT NULL,
	[Data_Wypozyczenia] [datetime] NOT NULL,
	[Data_Oddania] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zabawki]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zabawki](
	[ID_zabawki] [int] NOT NULL,
	[Rodzaj] [nvarchar](30) NOT NULL,
	[Ilość] [int] NOT NULL,
 CONSTRAINT [PK_Zabawki] PRIMARY KEY CLUSTERED 
(
	[ID_zabawki] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Wypozyczone]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Wypozyczone] as
SELECT Zabawki.ID_zabawki, Zabawki.Rodzaj, Wypożyczenia_zabawek.Wypozyczona_Ilość, Wypożyczenia_zabawek.Data_Wypozyczenia, Wypożyczenia_zabawek.Data_Oddania, Dane_Dziecka.Imię_dziecka, Dane_Dziecka.Nazwisko_dziecka
FROM   Dane_Dziecka INNER JOIN
             Wypożyczenia_zabawek ON Dane_Dziecka.ID = Wypożyczenia_zabawek.Dziecko_Id INNER JOIN
             Zabawki ON Wypożyczenia_zabawek.Id_zabawki = Zabawki.ID_zabawki
GO
/****** Object:  View [dbo].[Wypozyczone_zabawki]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[Wypozyczone_zabawki] as
SELECT Wypozyczona_Ilość, Data_Wypozyczenia, Id_zabawki, Data_Oddania
FROM   Wypożyczenia_zabawek
GO
/****** Object:  View [dbo].[NieWypożyczali]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[NieWypożyczali] AS
SELECT Imię_dziecka, Nazwisko_dziecka
FROM   Dane_Dziecka
except 
SELECT Imię_dziecka, Nazwisko_dziecka
FROM   Dane_Dziecka INNER JOIN
             Wypożyczenia_zabawek ON Dane_Dziecka.ID = Wypożyczenia_zabawek.Dziecko_Id
			 where (Wypożyczenia_zabawek.Data_Wypozyczenia is not null)
GO
/****** Object:  Table [dbo].[Cennik]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cennik](
	[Zajęcia_dodatkowe] [int] NOT NULL,
	[Wizyty_lekarskie] [int] NOT NULL,
	[Środki_higieniczne] [int] NOT NULL,
	[Wyzywienie] [int] NOT NULL,
	[Łącznie_za_miesiąc] [int] NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Cennik] ([Zajęcia_dodatkowe], [Wizyty_lekarskie], [Środki_higieniczne], [Wyzywienie], [Łącznie_za_miesiąc]) VALUES (175, 250, 150, 815, 1390)
GO
SET IDENTITY_INSERT [dbo].[Dane_Dziecka] ON 

INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (1, N'Mikołaj', N'Adamowicz', 6, N'Żelistrzewo', N'Standardowa', N'Gimnastyka', N'Maluszki', 20)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (2, N'Wojtek', N'Kuras', 19, N'Swarzewo', N'Wegetariańska', N'Zajęcia muzyczne', N'Średniaczki', 21)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (3, N'Małgorzata', N'Walas', 30, N'Puck', N'Standardowa', N'Gimnastyka', N'Starszaczki', 22)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (4, N'Kacper', N'Guzior', 16, N'Puck', N'Standardowa', N'Gimnastyka', N'Maluszki', 23)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (5, N'Karol', N'Bator', 23, N'Mrzezino', N'Bezglutenowa', N'Zajęcia malarskie', N'Średniaczki', 24)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (6, N'Anna', N'Bator', 34, N'Mrzezino', N'Standardowa', N'Zajęcia muzyczne', N'Starszaczki', 25)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (7, N'Damian', N'Grodzki', 35, N'Mrzezino', N'Standardowa', N'Język angielski', N'Starszaczki', 26)
INSERT [dbo].[Dane_Dziecka] ([ID], [Imię_dziecka], [Nazwisko_dziecka], [Ilość_miesięcy], [Adres], [Dieta], [Zajęcia_dodatkowe], [Grupa_dziecka], [Szafka_nr]) VALUES (8, N'Borys', N'Kwiatek', 18, N'Swarzewo', N'Standardowa', N'Język migowy', N'Maluszki', 27)
SET IDENTITY_INSERT [dbo].[Dane_Dziecka] OFF
GO
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (1, N'Mikołaj', N'Marta', N'Adam', N'Adamowicz', N'Żelistrzewo', N'753975183')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (2, N'Wojtek', N'Karolina', N'Piotr', N'Kuras', N'Swarzewo', N'735467287')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (3, N'Małgorzata', N'Natalia', N'Tomasz', N'Kruszyński', N'Puck', N'445673989')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (4, N'Kacper', N'Katarzyna', N'Dominik', N'Jędruszewski', N'Puck', N'907432978')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (5, N'Karol', N'Wiktoria', N'Marcel', N'Bator', N'Mrzezino', N'763973452')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (6, N'Anna', N'Wiktoria', N'Marcel', N'Bator', N'Mrzezino', N'763973452')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (7, N'Damian', N'Monika', N'Karol', N'Grodzki', N'Mrzezino', N'930475645')
INSERT [dbo].[Dane_Rodziców] ([Dziecko_ID], [Imię_Dziecka], [Imię_Matki], [Imię_Ojca], [Nazwisko], [Adres], [Telefon]) VALUES (8, N'Borys', N'Ewa', N'Adam', N'Kwiatek', N'Swarzewo', N'654324567')
GO
INSERT [dbo].[Opiekunki] ([Opiekunka_ID], [Imię_opiekunki], [Nazwisko_opiekunki], [Grupa_opiekunki], [Telefon_opiekunki], [Adres_opiekunki]) VALUES (11, N'Klaudia', N'Kostkiewicz', N'Maluszki', N'637284930', N'Puck')
INSERT [dbo].[Opiekunki] ([Opiekunka_ID], [Imię_opiekunki], [Nazwisko_opiekunki], [Grupa_opiekunki], [Telefon_opiekunki], [Adres_opiekunki]) VALUES (12, N'Marta', N'Walec', N'Średniaczki', N'634244930', N'Puck')
INSERT [dbo].[Opiekunki] ([Opiekunka_ID], [Imię_opiekunki], [Nazwisko_opiekunki], [Grupa_opiekunki], [Telefon_opiekunki], [Adres_opiekunki]) VALUES (13, N'Nadia', N'Stromska', N'Starszaczki', N'638293045', N'Swarzewo')
GO
INSERT [dbo].[Płatności] ([Zaległa_kwota], [Za_miesiąc], [Za_dziecko], [Imię_dziecka], [Nazwisko_dziecka], [Telefon_rodzica]) VALUES (1390, N'styczeń', 1, N'Mikołaj', N'Adamowicz', N'753975183')
INSERT [dbo].[Płatności] ([Zaległa_kwota], [Za_miesiąc], [Za_dziecko], [Imię_dziecka], [Nazwisko_dziecka], [Telefon_rodzica]) VALUES (815, N'styczeń', 2, N'Wojtek', N'Kuras', N'735467287')
INSERT [dbo].[Płatności] ([Zaległa_kwota], [Za_miesiąc], [Za_dziecko], [Imię_dziecka], [Nazwisko_dziecka], [Telefon_rodzica]) VALUES (1390, N'styczeń', 5, N'Karol', N'Bator', N'763973452')
INSERT [dbo].[Płatności] ([Zaległa_kwota], [Za_miesiąc], [Za_dziecko], [Imię_dziecka], [Nazwisko_dziecka], [Telefon_rodzica]) VALUES (175, N'styczeń', 6, N'Anna', N'Bator', N'763973452')
GO
INSERT [dbo].[Spis_grup] ([Spis_ID], [Grupa], [Wiek_dzieci_w_grupie], [Id_opiekunki], [Nr_sali]) VALUES (1, N'Maluszki', N'od 5 do 17 msc', 11, 7)
INSERT [dbo].[Spis_grup] ([Spis_ID], [Grupa], [Wiek_dzieci_w_grupie], [Id_opiekunki], [Nr_sali]) VALUES (3, N'Starszaczki', N'od 25 do 36 msc', 13, 9)
INSERT [dbo].[Spis_grup] ([Spis_ID], [Grupa], [Wiek_dzieci_w_grupie], [Id_opiekunki], [Nr_sali]) VALUES (2, N'Średniaczki', N'od 18 do 24 msc', 12, 8)
GO
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (20, 1, N'mała      ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (21, 2, N'mała      ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (22, 3, N'duża      ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (23, 4, N'średnia   ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (24, 5, N'mała      ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (25, 6, N'mała      ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (26, 7, N'duża      ')
INSERT [dbo].[Szatnia] ([Nr_szafki], [id_dziecka], [Rodzaj_szafki]) VALUES (27, 8, N'duża      ')
GO
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (101, 1, 2, CAST(N'2020-11-30T00:00:00.000' AS DateTime), CAST(N'2020-12-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (100, 1, 1, CAST(N'2020-12-10T00:00:00.000' AS DateTime), CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (105, 1, 1, CAST(N'2020-01-05T00:00:00.000' AS DateTime), CAST(N'2020-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (104, 1, 3, CAST(N'2020-01-20T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (102, 1, 6, CAST(N'2020-01-25T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (101, 2, 1, CAST(N'2020-01-26T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Wypożyczenia_zabawek] ([Id_zabawki], [Wypozyczona_Ilość], [Dziecko_Id], [Data_Wypozyczenia], [Data_Oddania]) VALUES (105, 1, 8, CAST(N'2020-01-26T00:00:00.000' AS DateTime), NULL)
GO
INSERT [dbo].[Zabawki] ([ID_zabawki], [Rodzaj], [Ilość]) VALUES (100, N'Gry_edukacyjne', 10)
INSERT [dbo].[Zabawki] ([ID_zabawki], [Rodzaj], [Ilość]) VALUES (101, N'Instrumenty', 8)
INSERT [dbo].[Zabawki] ([ID_zabawki], [Rodzaj], [Ilość]) VALUES (102, N'Pluszaki', 25)
INSERT [dbo].[Zabawki] ([ID_zabawki], [Rodzaj], [Ilość]) VALUES (103, N'Gry_planszowe', 10)
INSERT [dbo].[Zabawki] ([ID_zabawki], [Rodzaj], [Ilość]) VALUES (104, N'Zestaw_do_malowania', 7)
INSERT [dbo].[Zabawki] ([ID_zabawki], [Rodzaj], [Ilość]) VALUES (105, N'Lalki', 9)
GO
INSERT [dbo].[Zachowanie] ([dziecko_ID], [Uwaga], [Aktywność]) VALUES (1, N'Dokucza koleżance', N'')
INSERT [dbo].[Zachowanie] ([dziecko_ID], [Uwaga], [Aktywność]) VALUES (3, N'', N'Udział w przedstawieniu')
INSERT [dbo].[Zachowanie] ([dziecko_ID], [Uwaga], [Aktywność]) VALUES (5, N'', N'Udział w przedstawieniu')
INSERT [dbo].[Zachowanie] ([dziecko_ID], [Uwaga], [Aktywność]) VALUES (7, N'', N'Pomaga koleżance')
INSERT [dbo].[Zachowanie] ([dziecko_ID], [Uwaga], [Aktywność]) VALUES (8, N'Marudzi przy obiedzie', N'')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Rodzaj]    Script Date: 28.01.2021 20:59:32 ******/
ALTER TABLE [dbo].[Zabawki] ADD  CONSTRAINT [UQ_Rodzaj] UNIQUE NONCLUSTERED 
(
	[Rodzaj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dane_Dziecka]  WITH CHECK ADD  CONSTRAINT [FK_Dane_Dziecka_Spis_grup1] FOREIGN KEY([Grupa_dziecka])
REFERENCES [dbo].[Spis_grup] ([Grupa])
GO
ALTER TABLE [dbo].[Dane_Dziecka] CHECK CONSTRAINT [FK_Dane_Dziecka_Spis_grup1]
GO
ALTER TABLE [dbo].[Dane_Dziecka]  WITH CHECK ADD  CONSTRAINT [FK_Dane_Dziecka_Szatnia1] FOREIGN KEY([Szafka_nr])
REFERENCES [dbo].[Szatnia] ([Nr_szafki])
GO
ALTER TABLE [dbo].[Dane_Dziecka] CHECK CONSTRAINT [FK_Dane_Dziecka_Szatnia1]
GO
ALTER TABLE [dbo].[Dane_Rodziców]  WITH CHECK ADD  CONSTRAINT [FK_Dane_Rodziców_Dane_Dziecka] FOREIGN KEY([Dziecko_ID])
REFERENCES [dbo].[Dane_Dziecka] ([ID])
GO
ALTER TABLE [dbo].[Dane_Rodziców] CHECK CONSTRAINT [FK_Dane_Rodziców_Dane_Dziecka]
GO
ALTER TABLE [dbo].[Płatności]  WITH CHECK ADD  CONSTRAINT [FK_Płatności_Dane_Rodziców1] FOREIGN KEY([Za_dziecko])
REFERENCES [dbo].[Dane_Rodziców] ([Dziecko_ID])
GO
ALTER TABLE [dbo].[Płatności] CHECK CONSTRAINT [FK_Płatności_Dane_Rodziców1]
GO
ALTER TABLE [dbo].[Spis_grup]  WITH CHECK ADD  CONSTRAINT [FK_Spis_grup_Opiekunki] FOREIGN KEY([Id_opiekunki])
REFERENCES [dbo].[Opiekunki] ([Opiekunka_ID])
GO
ALTER TABLE [dbo].[Spis_grup] CHECK CONSTRAINT [FK_Spis_grup_Opiekunki]
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek]  WITH CHECK ADD  CONSTRAINT [FK_Wypożyczenia_zabawek_Dane_Dziecka] FOREIGN KEY([Dziecko_Id])
REFERENCES [dbo].[Dane_Dziecka] ([ID])
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek] CHECK CONSTRAINT [FK_Wypożyczenia_zabawek_Dane_Dziecka]
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek]  WITH CHECK ADD  CONSTRAINT [FK_Wypożyczenia_zabawek_Zabawki] FOREIGN KEY([Id_zabawki])
REFERENCES [dbo].[Zabawki] ([ID_zabawki])
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek] CHECK CONSTRAINT [FK_Wypożyczenia_zabawek_Zabawki]
GO
ALTER TABLE [dbo].[Zachowanie]  WITH CHECK ADD  CONSTRAINT [FK_Zachowanie_Dane_Dziecka] FOREIGN KEY([dziecko_ID])
REFERENCES [dbo].[Dane_Dziecka] ([ID])
GO
ALTER TABLE [dbo].[Zachowanie] CHECK CONSTRAINT [FK_Zachowanie_Dane_Dziecka]
GO
ALTER TABLE [dbo].[Dane_Dziecka]  WITH CHECK ADD  CONSTRAINT [CW_Wiek] CHECK  (([Ilość_miesięcy]>=(5) AND [Ilość_miesięcy]<=(36)))
GO
ALTER TABLE [dbo].[Dane_Dziecka] CHECK CONSTRAINT [CW_Wiek]
GO
ALTER TABLE [dbo].[Dane_Dziecka]  WITH CHECK ADD  CONSTRAINT [JK_ID] CHECK  (([ID]>(0) AND [ID]<(60)))
GO
ALTER TABLE [dbo].[Dane_Dziecka] CHECK CONSTRAINT [JK_ID]
GO
ALTER TABLE [dbo].[Szatnia]  WITH CHECK ADD  CONSTRAINT [RS_Rodzaj_szafki] CHECK  (([Rodzaj_szafki]='mała' OR [Rodzaj_szafki]='średnia' OR [Rodzaj_szafki]='duża'))
GO
ALTER TABLE [dbo].[Szatnia] CHECK CONSTRAINT [RS_Rodzaj_szafki]
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek]  WITH CHECK ADD  CONSTRAINT [CK_Daty] CHECK  (([Data_Wypozyczenia]<[Data_Oddania]))
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek] CHECK CONSTRAINT [CK_Daty]
GO
/****** Object:  Trigger [dbo].[BlokadaWypozyczen]    Script Date: 28.01.2021 20:59:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[BlokadaWypozyczen] ON [dbo].[Wypożyczenia_zabawek]
AFTER INSERT AS
DECLARE @wi int, @Dziecko_Id int
SELECT @Dziecko_Id=inserted.Dziecko_Id FROM INSERTED
SELECT @wi=Wypozyczona_Ilość from dbo.Wypożyczenia_zabawek WHERE Dziecko_Id=@Dziecko_Id
 PRINT 'Dziecko_Id' + CAST(@Dziecko_id as varchar)+
 ' ma wypożyczone ' + CAST(@wi as varchar) + ' zabawek'
IF @wi=0
 PRINT 'Może wypożyczyć zabawkę'
ELSE
BEGIN
PRINT 'Niestety, nie może wypożyczyć zabawki'
 RAISERROR ( 'Najpierw musi oddać wypożyczone',2,1)
 ROLLBACK
END
GO
ALTER TABLE [dbo].[Wypożyczenia_zabawek] ENABLE TRIGGER [BlokadaWypozyczen]
GO
USE [master]
GO
ALTER DATABASE [KJ_Żłobek] SET  READ_WRITE 
GO
