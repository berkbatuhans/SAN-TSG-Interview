-- CREATE DATABASE SANTSG;
-- GO

-- CREATE TABLE dbo.Users (
--     ID INT IDENTITY(1,1) NOT NULL,
--     Name VARCHAR(20),
--     Surname VARCHAR(20)
-- )
-- SELECT * FROM Users


-- ALTER TABLE Users 
-- ADD CONSTRAINT Users_PK PRIMARY KEY (ID);

-- Create a new table called '[UserAddresses]' in schema '[dbo]'
-- Drop the table if it already exists
-- IF OBJECT_ID('[dbo].[UserAddresses]', 'U') IS NOT NULL
-- DROP TABLE [dbo].[UserAddresses]
-- GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[UserAddresses]
(
    [ID] INT NOT NULL IDENTITY(1,1), -- Primary Key column
    [User_ID] INT,
    [AddressText] VARCHAR(100),
    [City] VARCHAR(30),
    [Country] VARCHAR(30)
);
GO

-- -- Insert rows into table 'Users' in schema '[dbo]'
-- INSERT INTO [dbo].[Users]
-- ( -- Columns to insert data into
--  Name,Surname
-- )
-- VALUES
-- ( -- First row: values for the columns in the list above
--  'Talih','Bayram'
-- ),
-- ( -- Second row: values for the columns in the list above
--  'Oğuz','Çetin'
-- )
-- -- Add more rows here
-- GO

-- -- Insert rows into table 'UserAdress' in schema '[dbo]'
-- INSERT INTO [dbo].[UserAddresses]
-- ( -- Columns to insert data into
--  [User_ID], [AddressText], [City], [Country]
-- )
-- VALUES
-- ( -- First row: values for the columns in the list above
--  1, 'asel Sok, no:3 4.levent', 'Istanbul', 'Türkiye'
-- )
-- -- Add more rows here
-- GO

SET STATISTICS IO ON
SELECT Name, Surname
FROM Users U
WHERE Name = 'Talih' AND NOT EXISTS(
SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
)

SET STATISTICS IO ON
IF (SELECT Count(*)
FROM Users U
WHERE Name = 'Berk' AND NOT EXISTS(
SELECT TOP 1 1 FROM UserAddresses UA WHERE U.ID = UA.User_ID
)) > 0 BEGIN
PRINT 'Adres Tablosunda kaydı yok!' END
ELSE BEGIN
PRINT 'Adres tablosunda kaydı var!'
END

SET STATISTICS IO ON
SELECT Name, Surname 
    FROM Users U 
           INNER JOIN UserAddresses UA on U.ID = UA.User_ID
WHERE UA.User_ID is null AND U.Name = 'Talih'


ALTER TABLE UserAddresses 
ADD CONSTRAINT FK_UserAddresses_Users FOREIGN KEY(User_ID) REFERENCES Users(ID);

ALTER TABLE UserAddresses 
ADD CONSTRAINT UserAddresses_PK PRIMARY KEY (ID);



EXEC sys.sp_helpindex Users
EXEC sys.sp_helpindex UserAddresses

CREATE NONCLUSTERED INDEX [IX_UserAddresses] ON [dbo].[UserAddresses]
        (
        [User_ID] ASC
        )

