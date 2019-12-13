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
--3. Sorgu -- INSERT komutu ile dbo.Users tablosuna 
           -- veri yazacağımız alanları sıralayıp  (Name,Surname)
           -- VALUES komutuyle eklenecek verileri ("Talih", "Bayram") yazıyoruz. 
INSERT INTO dbo.Users (Name,Surname) VALUES ("Talih", "Bayram")
--4. Sorgu -- INSERT komutu ile dbo.UserAddresses tablosuna 
           -- veri yazacağımız alanları sıralayıp (User_ID, AddressText, City, Country) 
           -- VALUES komutuyle eklenecek verileri ("1", "asel Sok, no:3 4.levent", "Istanbul", "Türkiye") yazıyoruz. 
INSERT INTO dbo.UserAddresses (User_ID, AddressText, City, Country) VALUES ("1", "asel Sok, no:3 4.levent", "Istanbul", "Türkiye")
--5. Sorgu 
SELECT Name, Surname
FROM Users U
WHERE Name = 'Berk' 
AND NOT EXISTS (
SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
)

-- Soru 1: Sorgular sırasıyla ne işe yarıyor açıklar mısın ?
-- Soru 2: Yaratılan iki tablo arasında nasıl bir ilişki bulunmaktadır veya bulunmalıdır ?
-- Cevap: One to many (Bir'e çok) ilişki bulunmalıdır.
-- Soru 3: 5’inci sorgunun eğer daha performanslı çalışmasını istesek çözüm önerilerin neler olur ?
-- Cevap:  1.Tablolardaki ID alanına Primary Key verilmeli - CLUSTERED INDEX (FİZİKSEL OLARAK SIRALANIR) - Execute sp_helpindex tabloAdi
--         2.Index verilmeli.
--!(ARA)   3.SELECT * çekilmemeli ihtiyaç olan sütunları iste! 
--!(ARA)   4.Alt Sorgu yerine JOIN KULLAN
--!(ARA)   5.JOIN İÇEREN TABLODA boyutu sınırlamak için where kullan.




CREATE TABLE dbo.Users
(
[ID] INT IDENTITY(1,1) NOT NULL,
[Name] varchar(20),
[Surname] varchar(20)
)
CREATE TABLE dbo.UserAddresses
(
[ID] INT IDENTITY(1,1) NOT NULL,
[User_ID] INT,
[AddressText] varchar(100),
[City] varchar(30),
[Country] varchar(30)
)
INSERT INTO dbo.Users (Name,Surname) VALUES ('Talih', 'Bayram')
INSERT INTO dbo.UserAddresses (User_ID, AddressText, City, Country) VALUES (1, 'asel Sok, no:3 4.levent', 'Istanbul', 'Türkiye')

SELECT Name, Surname
FROM Users U
WHERE Name = 'Berk' 
AND NOT EXISTS (
SELECT TOP 1 * FROM UserAddresses UA WHERE U.ID = UA.User_ID
)