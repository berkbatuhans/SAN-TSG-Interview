CREATE DATABASE SANTSG; -- SANTSG adında bir veritabanı oluşturduk.
GO

USE SANTSG; -- SANTSG veritabanını kullanmak istediğimizi belirttik.
GO

--1. Sorgu
CREATE TABLE dbo.Users -- dbo.Users adında yeni bir tablo oluşturmak istediğini belirtilmiş 
                       -- [dbo] yeni oluşturulan bir veritabanı için varsayılan şemadır.
(
[ID] INT IDENTITY(1,1) NOT NULL,--DÜZELTME: veri tipi parantez içinde yazılma hatası düzeltildi. (int) --> INT
                                -- ID alanı int veri tipinde ile sayısal değer içerir. 
                                -- IDENTITY(başlama degeri,artış miktarı) ile 1'er 1'er otomatik artması sağlanmış 
                                -- NOT NULL ile boş bırakılamaz olduğu belirtilmiş.
[Name] varchar(20), -- Name alanı 20 karakter ile sınırlandırılmış. 
                    -- En fazla 20 karakter alabilir 20 karakterden daha az ise verinin boyutu kadar yer kaplar 
                    -- (char'daki gibi boşlukları dahil etmez). 
                    -- harf ve sayı alabilir. 1 - 8000 karakter arasında karakter tutabilir. 
                    -- Her karakter 1 byte alan kaplar.
[Surname] varchar(20)
                    -- Surname alanı 20 karakter ile sınırlandırılmış. 
                    -- En fazla 20 karakter alabilir 20 karakterden daha az ise verinin boyutu kadar yer kaplar. 
                    -- (char'daki gibi boşlukları dahil etmez.). 
                    -- harf ve sayı alabilir. 
                    -- 1 - 8000 karakter arasında karakter tutabilir. 
                    -- Her karakter 1 byte alan kaplar.
)
GO

--2. Sorgu
CREATE TABLE dbo.UserAddresses -- dbo.UserAddresses adında yeni bir tablo oluşturmak istediğini belirtilmiş. 
                               -- [dbo] yeni oluşturulan bir veritabanı için varsayılan şemadır.
(
[ID] INT IDENTITY(1,1) NOT NULL,-- DÜZELTME: Performans için PRIMARY KEY!
                                -- ID alanı int ile sayısal değer içerir. 
                                -- IDENTITY(başlama degeri,artış miktarı) ile 1'er 1'er otomatik artması sağlanmış 
                                -- NOT NULL ile boş bırakılamaz olduğu belirtilmiş.
[User_ID] int CONSTRAINT FK_UserAddresses_Users FOREIGN KEY(User_ID) REFERENCES Users(ID),                  
                                -- TODO: FOREIGN KEY EKSIK TANIMLAMASI YAPILMALI!
                                -- One-to-many (Bir'e çok) ilişki bulunmalıdır.
[AddressText] varchar(100), -- AddressText alanı 100 karakter ile sınırlandırılmış. 
                            -- En fazla 100 karakter alabilir. 
                            -- 100 karakterden daha az ise verinin boyutu kadar yer kaplar. 
                            -- (char'daki gibi boşlukları dahil etmez.). 
                            -- harf ve sayı alabilir. 
                            -- 1 - 8000 karakter arasında karakter tutabilir. 
                            -- Her karakter 1 byte alan kaplar.
[City] varchar(30), -- City alanı 30 karakter ile sınırlandırılmış. 
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
--3. Sorgu -- DÜZELTME: VALUES İÇERİSİNDE STRİNG değer giriyorsak ' tek tırnak kullanmalıyız.
           -- INSERT komutu ile dbo.Users tablosuna 
           -- veri yazacağımız alanları sıralayıp  (Name,Surname)
           -- VALUES komutuyle eklenecek verileri ('Talih', 'Bayram') yazıyoruz. 
INSERT INTO dbo.Users (Name,Surname) VALUES ('Talih', 'Bayram')
--4. Sorgu -- DÜZELTME: VALUES İÇERİSİNDE STRİNG değer giriyorsak ' tek tırnak kullanmalıyız.
           -- Sayısal değerler için tırnak kullanmamıza gerek yok
           -- INSERT komutu ile dbo.UserAddresses tablosuna 
           -- veri yazacağımız alanları sıralayıp (User_ID, AddressText, City, Country) 
           -- VALUES komutuyle eklenecek verileri (1, 'asel Sok, no:3 4.levent', 'Istanbul', 'Türkiye') yazıyoruz. 
INSERT INTO dbo.UserAddresses (User_ID, AddressText, City, Country) VALUES (1, 'asel Sok, no:3 4.levent', 'Istanbul', 'Türkiye')
--5. Sorgu
-- Adı Berk ve adres kaydı olmayan kullanıcıların Name, Surname bilgilerini listele.

SELECT Name, Surname
FROM Users U
WHERE Name = 'Berk' 
AND NOT EXISTS (
SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
)

-- Soru 1: Sorgular sırasıyla ne işe yarıyor açıklar mısın ?
-- Cevap: Sorguların sırasıyla yukarıda açıklamalarını yaptım.
-- Soru 2: Yaratılan iki tablo arasında nasıl bir ilişki bulunmaktadır veya bulunmalıdır ?
-- Cevap: One to many (Bir'e çok) ilişki bulunmalıdır.

-- Soru 3: 5’inci sorgunun eğer daha performanslı çalışmasını istesek çözüm önerilerin neler olur ?
-- Cevap: 
    -- 1. Tablolardaki ID alanına Primary Key verilmeli - CLUSTERED INDEX (FİZİKSEL OLARAK SIRALANIR)
    -- 2. Primary key verdiğimizde Clustered Index olmuş oluyor.
    -- 3. Bir tabloda 1 Clustered Index bulunabilir.
    -- TODO: User_ID Non Clustered Index ver dene!
    -- CREATE INDEX [IX_User_ID] ON [dbo].[UserAddresses] ([User_ID] ASC)
    -- INDEX SORGULAMA
    -- EXECUTE sp_helpindex UserAddresses
    EXECUTE sp_helpindex Users
    -- CREATE NONCLUSTERED INDEX [IX_Name] ON [dbo].[Users] ([Name] ASC)
    -- INDEX SILME
    -- DROP INDEX IX_User_ID ON UserAddresses
IF NOT EXISTS(SELECT TOP 1 Name, Surname
            FROM Users U
            WHERE Name = 'Berk' 
            AND 
            NOT EXISTS(
                SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
                )
                )
BEGIN
PRINT 'Adres Kaydı Yok';
END
ELSE
BEGIN
PRINT 'Adres Kaydı Var';
END

