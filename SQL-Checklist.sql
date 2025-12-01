-- TABEL ---------------------------------------------------
SELECT * FROM Librarians;
SELECT * FROM Books;
SELECT * FROM Library;
SELECT * FROM Sales;
SELECT * FROM Authors;
------------------------------------------------------------

-- VIEWS ---------------------------------------------------
SELECT * FROM LibraryManagement;
SELECT * FROM AuthorsInformation;
SELECT * FROM SoldProduct;
------------------------------------------------------------

-- PROCEDURES ----------------------------------------------
Library Management
EXEC getLibraryManagement @LibrarianId = 6, @Category = 'Database';

Authors Info
EXEC GetAuthorsInformation @Nationality = 'American', @Category = 'Programming';

Products Sold
EXEC GetSoldProduct @MinPrice = 25, @MaxPrice = 30;
------------------------------------------------------------

-- FUNCTIONS -----------------------------------------------
 CHECK
SELECT dbo.LibrariansFullName(1) AS FullName;

 CHECK
SELECT dbo.SoldProducts(9) AS TotalSales;
------------------------------------------------------------

-- ERROR HANDLINGS -----------------------------------------
 Success case
EXEC librariansCheck 3, 'SQL for Beginners', 24.99, 5;

 Error case (Quantity <= 0 not allowed)
EXEC librariansCheck 3, 'SQL for Beginners', 24.99, 0;
------------------------------------------------------------

-- TRIGGERS ------------------------------------------------
CHECK INSERT
INSERT INTO Sales_tracking (LibrariansID, LibrariansName, OldQuantity, NewQuantity)
VALUES
(1, 'Vichhean Sombath', 10, 12),
(2, 'Kom Sophou', 5, 7),
(3, 'Uk Sopanha', 8, 9),
(4, 'Oun Dara', 3, 5),
(5, 'Chan Sopheap', 6, 8);

CHECK UPDATE
UPDATE Sales_tracking
SET NewQuantity = 15
WHERE LibrariansID = 1;

--CHECK DELETE
DELETE FROM Sales_tracking WHERE LoginID = 2;

SELECT * FROM Sales_tracking;
------------------------------------------------------------

-- USER LOGIN
EXECUTE AS USER = 'viewers';
DELETE FROM Sales WHERE BookName = 'SQL for Beginners';
SELECT * FROM Sales;
------------------------------------------------------------

EXECUTE AS USER = 'Saller';

-- TRIGGER
-- CHECK UPDATE
INSERT INTO Sales_tracking ( LibrariansID, LibrariansName, OldQuantity, NewQuantity )
VALUES (7, 'Ou Dara', 8, 15);
SELECT * FROM Sales_tracking;


-- ROLE AND PERMISSION
INSERT INTO Sales ( LibrariansID, BookName, Price, Quantity )
VALUES
(2, 'Introduction to C#', 29.99, 3),
(8, 'SQL for Beginner', 24.99, 5);

SELECT * FROM Sales;