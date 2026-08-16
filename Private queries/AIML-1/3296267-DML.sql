-- DML: Manioulate the Table
-- INSERT / UPDATE / DELETE / MERGE


-- 1 INSERT
-- Single Record:

INSERT INTO genres (GenreID, GenreName) 
VALUES (1, 'Science Fiction');

SELECT * FROM genres;

-- Multiple rows in one statement


INSERT INTO genres (GenreID, GenreName) VALUES 
    (2, 'Drama'),
    (3, 'Comedy'),
    (4, 'Thriler'),
    (5, 'Documentary'),
    (6, 'Silent Film');
SELECT * FROM genres;

INSERT INTO directors (DirectorID, DirectorName, Nationality) VALUES
    (11, 'Christopher Nolan', 'British-American'),
    (12, 'Ritesh Batra',      'Indian'),
    (13, 'Bong Joon-ho',      'South Korean'),
    (14, 'Zoya Akhtar',       'Indian');

SELECT * FROM directors;

DESC movies;


INSERT INTO movies (MovieID, Title, ReleaseYear, GenreID, DirectorID,
                    RuntimeMinutes, RentalRate, CopiesAvailable, ContentRating) VALUES
    (101, 'Interstellar',        2014, 1,    11, 169, 149.00, 6, 'UA'),
    (102, 'The Lunchbox',        2013, 2,    12, 104,  99.00, 4, 'U'),
    (103, 'Parasite',            2019, 4,    13, 132, 149.00, 3, 'A'),
    (104, 'Ocean Deep',          2021, 5,  NULL,  92,  79.00, 5, 'U'),  -- no director
    (105, 'The Prestige',        2006, 4,    11, 130, 129.00, 4, 'UA'),
    (106, 'Gully Boy',           2019, 2,    14, 153, 119.00, 5, 'UA'),
    (107, 'Memento',             2000, 4,    11, 113,  89.00, 2, 'A'),
    (108, 'Zindagi Na Milegi Dobara', 2011, 3, 14, 155, 109.00, 6, 'U'),
    (109, 'Blue Planet Voyage',  2023, 5,  NULL, 101,  69.00, 8, 'U'),  -- never rented
    (110, 'Silent Echo',         2022, 1,    13, 118, 139.00, 3, 'UA'); -- never rented

SELECT * FROM movies;

INSERT INTO Customers (CustomerID, FullName, Email, City, JoinDate, MembershipTier,
                       LoyaltyPoints) VALUES
    (5001, 'Aarav Sharma', 'aarav@example.com', 'Kanpur',  '2026-01-15', 'Gold',   120),
    (5002, 'Neha Verma',   'neha@example.com',  'Lucknow', '2026-02-03', 'Silver',  45),
    (5003, 'Rohit Singh',  'rohit@example.com', 'Kanpur',  '2026-02-20', 'Silver',  30),
    (5004, 'Priya Nair',   'priya@example.com', 'Delhi',   '2026-03-11', 'Gold',    90),
    (5005, 'Kabir Das',    NULL,                'Kanpur',  '2026-04-02', 'Bronze',   0);
    -- 5005 has never rented anything -- used by the anti-join examples

INSERT INTO Customers (CustomerID, FullName, Email, City)
VALUES (5006, 'Ishaan Rao', 'ishaan@example.com', 'Kanpur');

SELECT * FROM Rentals;
INSERT INTO Rentals (CustomerID, MovieID, CopyNumber, RentalDate, ReturnDate, AmountPaid) VALUES
    (5001, 101, 1, '2026-01-20 10:00:00', '2026-01-22 09:00:00', 149.00),
    (5001, 103, 1, '2026-02-01 18:30:00', '2026-02-03 12:00:00', 149.00),
    (5001, 105, 1, '2026-03-05 11:00:00', '2026-03-07 10:00:00', 129.00),
    (5002, 102, 1, '2026-02-10 14:00:00', '2026-02-12 14:00:00',  99.00),
    (5002, 106, 1, '2026-03-15 16:00:00', '2026-03-18 09:00:00', 119.00),
    (5002, 101, 2, '2026-04-01 09:00:00', NULL,                  149.00),  -- still out
    (5003, 107, 1, '2026-02-25 12:00:00', '2026-02-27 12:00:00',  89.00),
    (5003, 108, 1, '2026-04-10 15:00:00', NULL,                  109.00),  -- still out
    (5004, 103, 2, '2026-03-20 10:00:00', '2026-03-22 10:00:00', 149.00),
    (5004, 101, 3, '2026-04-05 17:00:00', '2026-04-07 11:00:00', 149.00),
    (5004, 106, 2, '2026-05-01 13:00:00', '2026-05-03 13:00:00', 119.00);

SELECT * FROM Reviews;

INSERT INTO Reviews (MovieID, CustomerID, Score, ReviewText, PostedOn) VALUES
    (101, 5001,  9, 'Stunning visuals.',      '2026-01-23 08:00:00'),
    (103, 5001, 10, 'Deserved every award.',  '2026-02-04 08:00:00'),
    (102, 5002,  8, 'Quietly beautiful.',     '2026-02-13 08:00:00'),
    (106, 5002,  7, 'Great soundtrack.',      '2026-03-19 08:00:00'),
    (107, 5003,  9, 'Watched it twice.',      '2026-02-28 08:00:00'),
    (103, 5004,  9, 'Tense throughout.',      '2026-03-23 08:00:00');

INSERT INTO Staff (StaffID, StaffName, ManagerID, StoreID) VALUES
    (1, 'Meera Joshi',   NULL, 1),   -- regional head, no manager
    (2, 'Arjun Mehta',      1, 1),
    (3, 'Sana Qureshi',     1, 2),
    (4, 'Vikram Patel',     2, 1),
    (5, 'Divya Iyer',       3, 2);

INSERT INTO MembershipTiers (TierName) VALUES ('Bronze'), ('Silver'), ('Gold');

INSERT INTO Movies_Legacy (MovieID, Title) VALUES
    (101, 'Interstellar'),           -- also in our catalogue
    (103, 'Parasite'),               -- also in our catalogue
    (201, 'Rear Window'),            -- only the rival has it
    (202, 'Tokyo Story');

-- INSERT INTO ... SELECT : copy rows from one table into another
INSERT INTO Rentals_Archive (RentalID, CustomerID, MovieID,
                             RentalDate, ReturnDate, AmountPaid)
SELECT RentalID, CustomerID, MovieID, RentalDate, ReturnDate, AmountPaid
FROM   Rentals
WHERE  RentalDate < '2026-03-01';


-- 2. UPDATE
SELECT CustomerID, MembershipTier FROM Customers;

-- 2.1 One Row one col
UPDATE Customers
SET MembershipTier = 'Platinum'
WHERE CustomerID = 5001;

SELECT CustomerID, MembershipTier FROM Customers;


-- MovieID	Title	RentalRate	GenreID	ContentRating
-- 101	Interstellar	149.00	1	UA
-- 102	The Lunchbox	99.00	2	U
-- 103	Parasite	149.00	4	A
-- 104	Ocean Deep	79.00	5	U
-- 105	The Prestige	129.00	4	UA
-- 106	Gully Boy	119.00	2	UA
-- 107	Memento	89.00	4	A
-- 108	Zindagi Na Milegi Dobara	109.00	3	U

-- 2.2 Many rows, many coluns
SELECT MovieID, Title, RentalRate,  GenreID, ContentRating FROM Movies;

UPDATE movies
SET RentalRate = RentalRate * 1.10, ContentRating = 'UA'
WHERE GenreID = 1;

SELECT MovieID, Title, RentalRate,  GenreID, ContentRating FROM Movies;


--- UPDATE driven by JOIN: ADD a late FEES to Overdue loans

DESC Rentals;
DESC Movies;



UPDATE Rentals r
JOIN Movies m ON m.MovieID = r.MovieID
SET r.LateFee = 50.00
WHERE r.ReturnDate IS NULL
    -- NOW(): current date and time 
    AND r.RentalDate < DATE_SUB(NOW(), INTERVAL 7 DAY);

SELECT * FROm Rentals;


-- 3. DELETE

SELECT * FROM Reviews;

INSERT INTO Reviews (MovieID, CustomerID, Score, ReviewText, PostedOn)
VALUES (105, 5003, 1, 'Abusive text to be removed', NOW());

DELETE FROM Reviews
WHERE MovieID = 105 AND CustomerID = 5003;

SELECT * FROM Reviews;