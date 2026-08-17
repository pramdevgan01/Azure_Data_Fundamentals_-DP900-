---DQL : Data Query Lang
-- SELECT 

-- 1. Projection: SELECT *, Column, 
   --aliases, expression

SELECT * FROM Movies; -- Exploring the data
SELECT MovieID, Title, ReleaseYear FROM Movies;
SELECT Title AS FilmTitle, 
        RuntimeMinutes as RuntimeHours, 
        CONCAT('INR ', CAST(RentalRate AS CHAR)) AS PriceLabel
FROM Movies as m;

-- 2 DISTINCT: Return Unique Record from Table

SELECT * FROM Customers;
SELECT DISTINCT CITY FROM Customers;
SELECT DISTINCT CITY, MembershipTier FROM Customers;

-- 3. WHERE
-- AND, OR, Comparison Op(=, >, <, >=, <=, <>)
SELECT Title, ReleaseYear, RentalRate, GenreID
FROM Movies
WHERE GenreID = 1 AND ReleaseYear >= 2015 AND RentalRate > 100;


-- No-sargable (Slow, it scan entire table) -- prevent using indexs
SELECT COUNT(*) AS RentalCountNonSarg FROM Rentals WHERE YEAR(RentalDate) = 2026; -- sacn entire table


-- Sargable (Fast, uses index)
SELECT COUNT(*) AS RentalCountSarg FROM Rentals -- Seeks the table
WHERE RentalDate >= '2026-01-01' AND RentalDate < '2027-01-01';


-- Predicates: BETWEEN , IN, LIKE, IS NULL, EXISTS, ANY , ALL

SELECT * FROM Movies
WHERE RentalRate BETWEEN 80 AND 150 -- INCLUSIVE

SELECT Title, GenreID FROM Movies
WHERE GenreID IN (1, 2, 4);

-- LIKE:
-- is used for pattern matching
-- WildCards:
    -- i) % : matches zeros or more char
    -- ii) _: matches extactly one char

SELECT Title FROM Movies
WHERE Title LIKE 'P_______';

SELECT Title FROM Movies
WHERE Title LIKE '%u%';

SELECT Title FROM Movies
WHERE Title LIKE 'The %';

-- IS NULL
SELECT Title, DirectorID FROM Movies WHERE DirectorID IS NULL;
SELECT RentalDate, ReturnDate FROM Rentals WHERE ReturnDate is null;

-- EXISTS: Excectue only when subquery return at 
        -- least one row and condition is True

INSERT INTO Genres (GenreID, GenreName) VALUES(7, 'ABCD');

SELECT * FROM Genres;
SELECT * FROM Movies;

SELECT g.GenreName FROM Genres g
WHERE EXISTS(
    SELECT 'A' FROM Movies m WHERE m.GenreID = g.GenreID 
    HAVING COUNT(*) >= 3
    -- 1: True 0: False
);

SELECT 2 FROM Movies ;