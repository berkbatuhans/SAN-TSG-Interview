--1. Sorgu
CREATE TABLE dbo.Users
(
[ID] (int) IDENTITY(1,1) NOT NULL,
[Name] varchar(20),
[Surname] varchar(20)
)
--2. Sorgu
CREATE TABLE dbo.UserAddresses
(
[ID] int IDENTITY(1,1) NOT NULL,
[User_ID] int
[AddressText] varchar(100),
[City] varchar(30),
[Country] varchar(30)
)
--3. Sorgu
INSERT INTO dbo.Users (Name,Surname) VALUES ("Talih", "Bayram")
--4. Sorgu
INSERT INTO dbo.UserAddresses (User_ID, AddressText, City, Country) VALUES ("1", "asel Sok, no:3 4.levent", "Istanbul", "Türkiye")
--5. Sorgu
SELECT Name, Surname
FROM Users U
WHERE Name = 'Berk' 
AND NOT EXISTS (
SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
)