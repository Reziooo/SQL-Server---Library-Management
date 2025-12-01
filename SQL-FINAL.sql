
--CREATE DATABASE-------------------------------------------------------------------------------------------------
CREATE DATABASE Library_Management
ON
( NAME = Library_Management_dat,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\library_management_dat.mdf',
SIZE = 20MB,
MAXSIZE = 50
)
LOG ON
( NAME = Library_Management_log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\library_management_log.ldf',
	SIZE = 20MB,
MAXSIZE = 50
)
-----------------------------------------------------------------------------------------------------------------

--CREATE TABLE---------------------------------------------------------------------------------------------------


--LIBRARIANS
CREATE TABLE Librarians( 
LibrariansID INT PRIMARY KEY IDENTITY(1,1), 
LibrariansFirstName VARCHAR(40),
LibrariansLastName VARCHAR(40),
DateOfBirth DATE, 
Address VARCHAR(100)
);

--BOOKS
CREATE TABLE Books (
BookId INT PRIMARY KEY IDENTITY(1,1),
BookName VARCHAR(50),
Category VARCHAR(100),
Author VARCHAR(50),
PublishedDate DATE
);

--AUTHORS
CREATE TABLE Authors (
AuthorName VARCHAR(50),
DateOfBirth DATE,
WrittenBooks VARCHAR(100),
Category VARCHAR(50),
Information VARCHAR(400),
Nationality VARCHAR(100)
);

--LIBRARY
CREATE TABLE Library ( 
LibrariansID INT,
BookID INT,
BorrowedDate DATE, 
ReturnedDate DATETIME
);

--SALES
CREATE TABLE Sales (
    LibrariansID INT,
    BookName VARCHAR(50),
    Price DECIMAL(4,2),
    Quantity INT CHECK (Quantity > 0)
	);
-----------------------------------------------------------------------------------------------------------------

--INSERT TABLE---------------------------------------------------------------------------------------------------

--LIBRARIANS
INSERT INTO Librarians (LibrariansFirstName, LibrariansLastName, DateOfBirth, Address) VALUES
('Vichhean', 'Sombath', '2000-02-05', 'Chbar Ampov'),
('Kom', 'Sophou', '2003-07-06', 'Chrouy Changvar'),
('Uk', 'Sopanha', '1999-01-09', 'Dangkao'),
('Oun', 'Sophanha', '2001-06-02', 'Doun Penh'),
('Sokha', 'Vichheka', '2000-08-03', 'Mean Chey'),
('Ra', 'Naroth', '1998-02-22', 'Russey Keo'),
('San', 'Dina', '1990-11-12', 'Mean Chey'),
('Ry', 'Narith', '2005-01-05', 'Chrouy Changvar'),
('Sovann', 'Rotha', '2000-08-12', 'Toul Kouk'),
('Vutha', 'Oudom', '2009-02-06', 'Sen Sok');

--BOOKS
INSERT INTO Books (BookName, Category, Author, PublishedDate) VALUES
('Introduction to C#', 'Programming', 'James Lee', '2018-04-01'),
('SQL for Beginners', 'Database', 'Sophia Kim', '2019-08-15'),
('World History 101', 'History', 'Olivia Wilson', '2016-06-10'),
('The Art of Cooking', 'Cooking', 'Emma Brown', '2020-01-01'),
('Physics Simplified', 'Science', 'Noah Davis', '2017-03-20'),
('Advanced Excel', 'Software', 'Lucas Hall', '2021-10-10'),
('Creative Writing', 'Literature', 'Mia Scott', '2015-11-05'),
('Digital Marketing', 'Business', 'Liam Johnson', '2022-07-07'),
('Modern Architecture', 'Design', 'Ava Clark', '2014-12-12'),
('Gardening Basics', 'Hobby', 'Elijah Green', '2013-09-09');

--LIBRARY
INSERT INTO Library (LibrariansID, BookID, BorrowedDate, ReturnedDate) VALUES
(1, 8, '2025-07-10', GETDATE()),
(2, 6, '2025-07-05', GETDATE()),
(3, 7, '2025-07-15', GETDATE()),
(4, 5, '2025-07-20', GETDATE()),
(5, 10, '2025-07-25', GETDATE()),
(6, 2, '2025-06-30', GETDATE()),
(7, 9, '2025-07-12', GETDATE()),
(8, 3, '2025-07-28', GETDATE()),
(9, 4, '2025-08-02', GETDATE()),
(10, 1, '2025-06-30', GETDATE());

--SALES
INSERT INTO Sales (LibrariansID, BookName, Price, Quantity) VALUES
(6, 'Introduction to C#', 29.99, 5),
(3, 'SQL for Beginners', 24.99, 8),
(9, 'World History 101', 19.99, 3),
(10, 'The Art of Cooking', 21.99, 6),
(7, 'Physics Simplified', 29.99, 4),
(3, 'Advanced Excel', 27.99, 7),
(4, 'Creative Writing', 18.50, 2),
(8, 'Digital Marketing', 35.50, 10),
(10, 'Modern Architecture', 25.99, 1),
(5, 'Gardening Basics', 19.99, 9);

--AUTHOR
INSERT INTO Authors (AuthorName, DateOfBirth, WrittenBooks, Category, Information, Nationality) VALUES
('James Lee', '1983-09-17', 'Introduction to C#', 'Programming', 'Specializes in software development', 'American'),
('Sophia Kim', '1990-02-15', 'SQL for Beginners', 'Database', 'Expert in relational databases', 'South Korean'),
('Olivia Wilson', '1995-06-10', 'World History 101', 'History', 'Historian with focus on modern events', 'British'),
('Emma Brown', '1992-11-09', 'The Art of Cooking', 'Cooking', 'Chef and cooking instructor', 'Canadian'),
('Noah Davis', '1988-03-31', 'Physics Simplified', 'Science', 'Science educator and researcher', 'Australian'),
('Lucas Hall', '1991-12-12', 'Advanced Excel', 'Software', 'Excel and spreadsheet expert', 'American'),
('Mia Scott', '1993-05-23', 'Creative Writing', 'Literature', 'Author of several fiction novels', 'British'),
('Liam Johnson', '1985-07-22', 'Digital Marketing', 'Business', 'Marketing consultant and speaker', 'American'),
('Ava Clark', '1997-04-02', 'Modern Architecture', 'Design', 'Architect with modern design focus', 'Australian'),
('Elijah Green', '1989-08-19', 'Gardening Basics', 'Hobby', 'Gardening enthusiast and blogger', 'Canadian');
-------------------------------------------------------------------------------------------------------------------
SELECT * FROM Librarians;
SELECT * FROM Books;
SELECT * FROM Library;
SELECT * FROM Sales;
SELECT * FROM Authors;
--CREATE VIEWS---------------------------------------------------------------------------------------------------

--LIBRARY MANAGEMENT
GO
CREATE VIEW LibraryManagement AS
SELECT 
    L.LibrariansID AS LibrarianId,
    (LB.LibrariansFirstName + ' ' + LB.LibrariansLastName) AS LibrarianName,
    B.BookName,
    B.PublishedDate,
    B.Category,
    L.BorrowedDate,
    L.ReturnedDate
FROM Library AS L
JOIN Librarians AS LB ON L.LibrariansID = LB.LibrariansID
JOIN Books AS B ON L.BookID = B.BookId;

--AUTHORS INFORMATIONS
GO
CREATE VIEW AuthorsInformation AS
SELECT 
    A.AuthorName AS AuthorsName,
    A.DateOfBirth,
    CASE A.AuthorName
        WHEN 'James Lee' THEN 41
        WHEN 'Sophia Kim' THEN 35
        WHEN 'Olivia Wilson' THEN 30
        WHEN 'Emma Brown' THEN 32
        WHEN 'Noah Davis' THEN 37
        WHEN 'Lucas Hall' THEN 33
        WHEN 'Mia Scott' THEN 32
        WHEN 'Liam Johnson' THEN 40
        WHEN 'Ava Clark' THEN 28
        WHEN 'Elijah Green' THEN 35
    END AS Age,
    CASE A.AuthorName
        WHEN 'James Lee' THEN 'Male'
        WHEN 'Sophia Kim' THEN 'Female'
        WHEN 'Olivia Wilson' THEN 'Female'
        WHEN 'Emma Brown' THEN 'Female'
        WHEN 'Noah Davis' THEN 'Male'
        WHEN 'Lucas Hall' THEN 'Male'
        WHEN 'Mia Scott' THEN 'Female'
        WHEN 'Liam Johnson' THEN 'Male'
        WHEN 'Ava Clark' THEN 'Female'
        WHEN 'Elijah Green' THEN 'Male'
    END AS Gender,
    A.Nationality,
    A.WrittenBooks,
    B.PublishedDate,
    A.Category
FROM Authors AS A
JOIN Books AS B ON A.WrittenBooks = B.BookName AND A.AuthorName = B.Author;

--PRODUCT SOLD
GO
CREATE VIEW SoldProduct AS
SELECT 
    S.LibrariansID,
    (L.LibrariansFirstName + ' ' + L.LibrariansLastName) AS LibrariansName,
    S.BookName,
    B.Author AS WrittenBy,
    S.Price,
    S.Quantity,
    CASE 
        WHEN S.Price * S.Quantity <= 100 THEN 'Membership'
        ELSE NULL
    END AS Status,
    CASE 
        WHEN S.Price * S.Quantity <= 100 THEN (S.Price * S.Quantity) * 0.20
        ELSE 0
    END AS Discount,
    CASE 
        WHEN S.Price * S.Quantity <= 100 THEN (S.Price * S.Quantity) * 0.80
        ELSE S.Price * S.Quantity
    END AS GrandPrice
FROM Sales AS S
JOIN Librarians AS L ON S.LibrariansID = L.LibrariansID
JOIN Books b ON S.BookName = B.BookName;

-------------------------------------------------------------------------------------------------------------------
SELECT * FROM LibraryManagement;
SELECT * FROM AuthorsInformation;
SELECT * FROM SoldProduct;

--PROCEDURES ----------------------------------------------------------------------------------------------------
--LibraryManagement
USE Library_Management;
GO
CREATE PROCEDURE getLibraryManagement
    @LibrarianId INT,
    @Category VARCHAR(50)
AS
BEGIN
    SELECT 
        LibrarianId,
        LibrarianName,
        BookName,
        PublishedDate,
        Category,
        BorrowedDate,
        ReturnedDate
    FROM LibraryManagement
    WHERE (@LibrarianId IS NULL OR LibrarianId = @LibrarianId)
      AND (@Category IS NULL OR Category = @Category)
    ORDER BY BorrowedDate DESC;
END;
GO


--AuthorsInformation
GO
CREATE PROCEDURE getAuthorsInformation
    @Nationality VARCHAR(50) = NULL,
    @Category VARCHAR(50) = NULL
AS
BEGIN
    SELECT *
    FROM AuthorsInformation
    WHERE (@Nationality IS NULL OR Nationality = @Nationality)
      AND (@Category IS NULL OR Category = @Category);
END;
GO


--GetSoldProduct
GO
CREATE PROCEDURE getSoldProduct
    @MinPrice DECIMAL(10,2) = NULL,
    @MaxPrice DECIMAL(10,2) = NULL
AS
BEGIN
    SELECT *
    FROM SoldProduct
    WHERE (@MinPrice IS NULL OR Price >= @MinPrice)
      AND (@MaxPrice IS NULL OR Price <= @MaxPrice);
END;
GO
 
--CHECK PROCEDURES
--Library Management
EXEC getLibraryManagement @LibrarianId = 6, @Category = 'Database';

--Authors Info
EXEC GetAuthorsInformation @Nationality = 'American', @Category = 'Programming';

--Products Sold
EXEC GetSoldProduct @MinPrice = 25, @MaxPrice = 30;
-------------------------------------------------------------------------------------------------------------------

--FUNCTIONS -----------------------------------------------------------------------------------------------------
-- FULLNAME
GO
CREATE FUNCTION dbo.LibrariansFullName(@LibrarianID INT)
RETURNS VARCHAR(81)
AS
BEGIN
    DECLARE @FullName VARCHAR(81);
    SELECT @FullName = LibrariansFirstName + ' ' + LibrariansLastname
    FROM Librarians
    WHERE LibrariansID = @LibrarianID;
    RETURN @FullName;
END

-- STORE
GO
CREATE OR ALTER FUNCTION dbo.SoldProducts(@LibrariansID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    SELECT @Total = SUM(Quantity * Price)
    FROM Sales
    WHERE LibrariansID = @LibrariansID;
    RETURN @Total;
END
GO

-- CHECK
SELECT dbo.LibrariansFullName(1) AS FullName;

-- CHECK
SELECT dbo.SoldProducts(9) AS TotalSales;
---------------------------------------------------------------------------------------------------------

--ERROR HANDLING---------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE librariansCheck
(
    @librariansID INT,
    @bookName VARCHAR(50),
    @price DECIMAL(4,2),
    @quantity INT
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Sales (LibrariansID, BookName, Price, Quantity)
        VALUES (@librariansID, @bookName, @price, @quantity);
        COMMIT TRANSACTION;
        SELECT 'Inserted into Sales without any error.' AS ResultMessage;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT  
            ERROR_NUMBER()   AS ERROR_NUMBER,
            ERROR_MESSAGE()  AS ERROR_MESSAGE,
            ERROR_LINE()     AS ERROR_LINE;
    END CATCH
END
GO

-- Success case
EXEC librariansCheck 3, 'SQL for Beginners', 24.99, 5;

-- Error case (Quantity <= 0 not allowed)
EXEC librariansCheck 3, 'SQL for Beginners', 24.99, 0;

---------------------------------------------------------------------------------------------------------

--COMMIT AND ROLLBACK ----------------------------------------------------------------------------------
CREATE LOGIN viewtableSales WITH PASSWORD = 'salesViewers',
CHECK_POLICY = ON;
GO
CREATE USER viewers FOR LOGIN viewtableSales;
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::[dbo].[Sales] TO viewer;
GO

SET IMPLICIT_TRANSACTIONS ON;
SET IMPLICIT_TRANSACTIONS OFF;

BEGIN TRANSACTION
DELETE FROM Sales where BookName = 'SQL for Beginners';

ROLLBACK TRANSACTION;
---------------------------------------------------------------------------------------------------------

--TIGGER ----------------------------------------------------------------------------------------------

CREATE TABLE Sales_tracking(LoginID INT IDENTITY(1,1) PRIMARY KEY, LibrariansID INT,
LibrariansName VARCHAR(100), OldQuantity INT, NewQuantity INT,
UserChange VARCHAR(100) DEFAULT SUSER_SNAME(),TimeEdit DATETIME DEFAULT GETDATE());

GO
CREATE TRIGGER sales_tracking_log
ON dbo.Sales_tracking
AFTER UPDATE
AS
BEGIN
INSERT INTO Sales_tracking(LibrariansID, LibrariansName, OldQuantity, NewQuantity)
SELECT
D.LibrariansID, D.LibrariansName, D.OldQuantity, I.NewQuantity
FROM
deleted AS D
INNER JOIN
inserted AS I
on D.LibrariansID = I.LibrariansID
END;

--CHECK INSERT
INSERT INTO Sales_tracking (LibrariansID, LibrariansName, OldQuantity, NewQuantity)
VALUES
(1, 'Vichhean Sombath', 10, 12),
(2, 'Kom Sophou', 5, 7),
(3, 'Uk Sopanha', 8, 9),
(4, 'Oun Dara', 3, 5),
(5, 'Chan Sopheap', 6, 8);

--CHECK UPDATE
UPDATE Sales_tracking
SET NewQuantity = 15
WHERE LibrariansID = 1;

--CHECK DELETE
DELETE FROM Sales_tracking WHERE LoginID = 2;

SELECT * FROM Sales_tracking;
---------------------------------------------------------------------------------------------------------

--ROLE AND PERMISSION----------------------------------------------------------------------------------

CREATE LOGIN Library_Manager WITH PASSWORD = 'manager@153!',
CHECK_POLICY=ON;
CREATE USER Manager FOR LOGIN Library_Manager;

CREATE LOGIN Library_Saller WITH PASSWORD = 'saller@153!',
CHECK_POLICY=ON;
CREATE USER Saller FOR LOGIN Library_Saller;

--GRANT PERMISSION
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::[dbo].[Sales] TO Saller;
GRANT SELECT, INSERT, UPDATE, DELETE ON OBJECT::[dbo].[Librarians] TO Saller;
GRANT SELECT ON OBJECT::[dbo].[Sales] TO Manager;
GRANT SELECT ON OBJECT::[dbo].[Librarians] TO Manager;
GRANT SELECT, UPDATE, DELETE ON OBJECT::[dbo].[Authors] TO Manager;
GRANT SELECT, UPDATE, DELETE ON OBJECT::[dbo].[Books] TO Manager;
GO
---------------------------------------------------------------------------------------------------------
--USE Product_MGM;
--BACKUP AND RESTORE-----------------------------------------------------------------------------------
--FULL BACKUP
BACKUP DATABASE Library_Management
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\Library_Management.bak';

--RESTORE
RESTORE DATABASE Library_Management
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\Library_Management.bak'
WITH RECOVERY;


USE Product_MGM;
--DIFFERENTIAL
BACKUP DATABASE Library_Management
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\Library_Management.bak'
WITH DIFFERENTIAL,  
NAME = 'Differential Backup of Library_Management',  
SKIP,
NOREWIND,
NOUNLOAD,
STATS = 10;

--RESTORE
RESTORE DATABASE Library_Management
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\Library_Management.bak'
WITH
MOVE 'Library_Management_dat' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Library_Management_dat.mdf',
MOVE 'Library_Management_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Library_Management_log.ldf',
NORECOVERY, 
REPLACE, 
STATS = 10;

--DROP DB
ALTER DATABASE [Library_Management] set single_user WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE [Library_Management];
GO
---------------------------------------------------------------------------------------------------------
