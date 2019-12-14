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
[User_ID] INT CONSTRAINT FK_UserAddresses_Users FOREIGN KEY(User_ID) REFERENCES Users(ID),                  
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
SET STATISTICS IO ON -- Sorgu istatistiklerini getirir
SET STATISTICS TIME ON -- Sorgunun ne kadar sürede geldiğini gösterir.
SELECT Name, Surname
FROM Users U
WHERE Name = 'Berk' 
AND NOT EXISTS (
SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
)
-- SQL Server Execution Times:
-- CPU time 10 ms, elapsed time 10ms 

-- JOIN ile sorgunun yazılımı aynı sonuçları döndürüyor
SELECT Name,Surname
    FROM Users U 
        LEFT OUTER JOIN UserAddresses UA ON UA.User_ID = U.ID
WHERE U.Name = 'Berk' AND UA.User_ID IS NULL

-- Soru 1: Sorgular sırasıyla ne işe yarıyor açıklar mısın ?
-- Cevap: Sorguların sırasıyla yukarıda açıklamalarını yaptım.

-- Soru 2: Yaratılan iki tablo arasında nasıl bir ilişki bulunmaktadır veya bulunmalıdır ?
-- Cevap: One to many (Bir'e çok) ilişki bulunmalıdır.

-- Soru 3: 5’inci sorgunun eğer daha performanslı çalışmasını istesek çözüm önerilerin neler olur ?
-- Cevap: 
    -- 1. Tablolardaki ID alanına Primary Key verilmeli - CLUSTERED INDEX (FİZİKSEL OLARAK SIRALANIR)
    -- 2. Primary key verdiğimizde Clustered Index olmuş oluyor.
    -- 3. Bir tabloda 1 Clustered Index bulunabilir.
    -- 4. SELECT * çekilmemeli ihtiyaç olan sütunları yazmalıyız!
    -- 5. Execution Plan incelenmeli
    -- 6. İnceleme ile birlikte Non Clustered Indexler vererek performans artışı sağlayabiliriz.
    -- Performans denemelerindeki sonuçlarım,
    -- Index tanımlanmış Users ve UserAddresses SELECT sorgusu için;
    
    -- SQL Server Execution Times:
    -- CPU time 10 ms, elapsed time 10ms 
    
    -- Index tanımlanmamış Users2 ve UserAddresses2 SELECT sorgusu için;

    -- SQL Server Execution Times: 
    -- CPU time 27 ms, elapsed time = 27ms

    -- Index Tanımlaması ile daha performanslı çalışması sağlandı
    -- 7. Index'lerde zamanla bozulmalar olabilir bununla ilgili incelemeler yapılıp iyileştirme çalışmaları yapılmalı 


 -- 5.SORGU PERFORMANS FARKINI İNCELEMEK ÜZERE AŞAĞIDAKİ İŞLEMLERİ DENEDİM;
    
    -- First Case: UserAddresses tablosundaki User_ID kolonuna IX_User_ID adında Non Clustered Index verdim.
    -- CREATE NONCLUSTERED INDEX [IX_User_ID] ON [dbo].[UserAddresses] ([User_ID] ASC)
    -- INDEX SORGULAMA
    -- EXECUTE sp_helpindex UserAddresses
    -- Second Case: Users tablosundaki Name kolonuna IX_Name adında Non Clustered Index verdim.
    -- CREATE NONCLUSTERED INDEX [IX_Name] ON [dbo].[Users] ([Name] ASC)
    -- EXECUTE sp_helpindex Users

    -- INDEX SILME
    -- DROP INDEX IX_User_ID ON UserAddresses
    -- DROP INDEX IX_Name ON Users

-- Users tablosuna 5000 adet kayıt ekleyen döngü!
-- DECLARE @ID INT = 1
-- WHILE (@ID < 5000)
-- BEGIN
--     INSERT INTO dbo.Users SELECT 'Berk','ŞAKAR'+CAST(@ID as [varchar](20))
--     SET @ID+=1
-- END

-- UserAddresses tablosuna 199 adet kayıt ekleyen döngü!
-- DECLARE @ID INT = 1
-- WHILE (@ID < 200)
-- BEGIN
--     INSERT INTO dbo.UserAddresses SELECT @ID,'asel Sok, no:'++CAST(@ID as [varchar](20))+' 4.levent','Istanbul','Turkiye'
--     SET @ID+=1
-- END


------ INDEX verilen tablolar ile Index verilmeyen tabloları karşılaştırmak için;
------ CLUSTERED INDEX TANIMLANMAMIŞ TABLOLAR START ----
-- CREATE TABLE dbo.Users2
-- (
-- [ID] INT IDENTITY(1,1) NOT NULL,
-- [Name] varchar(20),
-- [Surname] varchar(20)
-- )
-- CREATE TABLE dbo.UserAddresses2
-- (
-- [ID] INT IDENTITY(1,1) NOT NULL,
-- [User_ID] INT,
-- [AddressText] varchar(100),
-- [City] varchar(30),
-- [Country] varchar(30)
-- )
------ CLUSTERED INDEX TANIMLANMAMIŞ TABLOLAR END ----

-- INSERT INTO dbo.Users2 (Name,Surname) VALUES ('Talih', 'Bayram')
-- INSERT INTO dbo.UserAddresses2 (User_ID, AddressText, City, Country) VALUES (1, 'asel Sok, no:3 4.levent', 'Istanbul', 'Türkiye')
-- SET STATISTICS IO ON
-- SET STATISTICS TIME ON
-- SELECT Name, Surname
-- FROM Users2 U
-- WHERE Name = 'Berk' 
-- AND NOT EXISTS (
-- SELECT TOP 1 * FROM UserAddresses2 UA WHERE U.ID = UA.User_ID
-- )

-- SQL Server Execution Times: 
-- CPU time 27 ms, elapsed time = 27ms

-- Users2 tablosuna 4999 adet kayıt ekleyen döngü!
-- DECLARE @ID INT = 1
-- WHILE (@ID < 5000)
-- BEGIN
--     INSERT INTO dbo.Users2 SELECT 'Berk','ŞAKAR'+CAST(@ID as [varchar](20))
--     SET @ID+=1
-- END

-- UserAddresses2 tablosuna 199 adet kayıt ekleyen döngü!
-- DECLARE @ID INT = 1
-- WHILE (@ID < 200)
-- BEGIN
--     INSERT INTO dbo.UserAddresses2 SELECT @ID,'asel Sok, no:'++CAST(@ID as [varchar](20))+' 4.levent','Istanbul','Turkiye'
--     SET @ID+=1
-- END



-- Index Bozulmaları ()
-- http://www.ahmetkaymaz.com/2008/03/06/sql-serverde-ne-zaman-defrag-yapmaliyiz/
-- Eklenen, değiştirilen ve silinen kayıtlar ile bozulur
-- showcontig('tabloAdı') -> ile tablonun bozulma oranı kontrol edilir.
-- DBCC showcontig('Users')
-- DBCC showcontig('Users',1) WITH FAST
-- DBCC SHOWCONTIG('Users',IX_Name)
-- DBCC showcontig('UserAddresses')
-- DBCC SHOWCONTIG WITH TABLERESULTS, ALL_INDEXES
-- indexdefrag('VeritabanıAdı','TabloAdı','IndexAdı') -> 
-- DBCC indexdefrag('SANTSG','Users','IX_Name')
-- --INDEX BOZMAK İÇİN UPDATE SORGUSU İLE DEĞİŞTİR!
-- --REBUILD: Yeniden İnşa et
-- ALTER INDEX Users_PK ON Users REBUILD WITH(online=off)
-- ALTER INDEX IX_Name ON Users REBUILD WITH(online=off)
-- --REORGANIZE: Yeniden Düzenle
-- ALTER INDEX Users_PK ON Users REORGANIZE
-- ALTER INDEX IX_Name ON Users REORGANIZE
-- DBCC CHECKDB