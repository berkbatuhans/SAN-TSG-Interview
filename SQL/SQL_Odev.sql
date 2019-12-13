--1. Sorgu - 
CREATE TABLE dbo.Users -- dbo.Users adında yeni bir tablo oluşturmak istediğini belirtilmiş 
                       -- [dbo] yeni oluşturulan bir veritabanı için varsayılan şemadır.
(
[ID] (int) IDENTITY(1,1) NOT NULL, -- ID alanı int veri tipinde ile sayısal değer içerir (). 
                                   -- IDENTITY(başlama degeri,artış miktarı) ile 1'er 1'er otomatik artması sağlanmış 
                                   -- NOT NULL ile boş bırakılamaz olduğu belirtilmiş.
[Name] varchar(20),   -- Name alanı 20 karakter ile sınırlandırılmış. 
                      -- En fazla 20 karakter alabilir 20 karakterden daha az ise verinin boyutu kadar yer kaplar 
                      -- (char'daki gibi boşlukları dahil etmez). 
                      -- harf ve sayı alabilir. 1 - 8000 karakter arasında karakter tutabilir. 
                      -- Her karakter 1 byte alan kaplar.
[Surname] varchar(20) -- Surname alanı 20 karakter ile sınırlandırılmış. 
                      -- En fazla 20 karakter alabilir 20 karakterden daha az ise verinin boyutu kadar yer kaplar. 
                      -- (char'daki gibi boşlukları dahil etmez.). 
                      -- harf ve sayı alabilir. 
                      -- 1 - 8000 karakter arasında karakter tutabilir. 
                      -- Her karakter 1 byte alan kaplar.
)
--2. Sorgu
CREATE TABLE dbo.UserAddresses -- dbo.UserAddresses adında yeni bir tablo oluşturmak istediğini belirtilmiş. 
                               -- [dbo] yeni oluşturulan bir veritabanı için varsayılan şemadır.
(
[ID] int IDENTITY(1,1) NOT NULL, -- ID alanı int ile sayısal değer içerir. 
                                 -- IDENTITY(başlama degeri,artış miktarı) ile 1'er 1'er otomatik artması sağlanmış 
                                 -- NOT NULL ile boş bırakılamaz olduğu belirtilmiş.
[User_ID] int, -- TODO: EKSIK FOREIGN KEY TANIMLAMASI YAPILMALI!
[AddressText] varchar(100), -- AddressText alanı 100 karakter ile sınırlandırılmış. 
                            -- En fazla 100 karakter alabilir. 
                            -- 100 karakterden daha az ise verinin boyutu kadar yer kaplar. 
                            -- (char'daki gibi boşlukları dahil etmez.). 
                            -- harf ve sayı alabilir. 
                            -- 1 - 8000 karakter arasında karakter tutabilir. 
                            -- Her karakter 1 byte alan kaplar.
[City] varchar(30),         -- City alanı 100 karakter ile sınırlandırılmış. 
                            -- En fazla 30 karakter alabilir. 
                            -- 30 karakterden daha az ise verinin boyutu kadar yer kaplar. 
                            -- (char'daki gibi boşlukları dahil etmez). 
                            -- harf ve sayı alabilir. 
                            -- 1 - 8000 karakter arasında karakter tutabilir. 
                            -- Her karakter 1 byte alan kaplar.
[Country] varchar(30) -- Country alanı 30 karakter ile sınırlandırılmış. 
                      -- En fazla 30 karakter alabilir. 
                      -- 30 karakterden daha az ise verinin boyutu kadar yer kaplar. 
                      -- (char'daki gibi boşlukları dahil etmez). 
                      -- harf ve sayı alabilir. 
                      -- 1 - 8000 karakter arasında karakter tutabilir. 
                      -- Her karakter 1 byte alan kaplar.
)

-- CLUSTERED INDEX - TANIMLANMAMIŞ TABLOLAR

CREATE TABLE dbo.Users2
(
[ID] INT IDENTITY(1,1) NOT NULL,
[Name] varchar(20),
[Surname] varchar(20)
)
CREATE TABLE dbo.UserAddresses2
(
[ID] INT IDENTITY(1,1) NOT NULL,
[User_ID] INT,
[AddressText] varchar(100),
[City] varchar(30),
[Country] varchar(30)
)
INSERT INTO dbo.Users2 (Name,Surname) VALUES ('Talih', 'Bayram')
INSERT INTO dbo.UserAddresses2 (User_ID, AddressText, City, Country) VALUES (1, 'asel Sok, no:3 4.levent', 'Istanbul', 'Türkiye')
SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT Name, Surname
FROM Users2 U
WHERE Name = 'Berk' 
AND NOT EXISTS (
SELECT TOP 1 * FROM UserAddresses2 UA WHERE U.ID = UA.User_ID
)

DECLARE @ID INT = 1
WHILE (@ID < 5000)
BEGIN
    INSERT INTO dbo.Users2 SELECT 'Berk','ŞAKAR'+CAST(@ID as [varchar](20))
    SET @ID+=1
END