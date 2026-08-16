CREATE TABLE Genres (
    GenreID   INT          PRIMARY KEY,
    GenreName VARCHAR(50)  NOT NULL
) COMMENT = "Film categories";

CREATE TABLE Directors (
    DirectorID   INT          PRIMARY KEY,
    DirectorName VARCHAR(100) NOT NULL,
    Nationality  VARCHAR(50)
) COMMENT = "People who direct films";

CREATE TABLE Movies (
    MovieID         INT           PRIMARY KEY,
    Title           VARCHAR(150)  NOT NULL,
    ReleaseYear     INT,
    GenreID         INT,
    DirectorID      INT,
    RuntimeMinutes  INT,
    RentalRate      DECIMAL(6,2),
    CopiesAvailable INT DEFAULT 5,
    OldCatalogueCode VARCHAR(20)          -- dropped again in section 1.2
) COMMENT = "CineVerse film catalogue, one row per title";

CREATE TABLE Customers (
    CustomerID     INT          PRIMARY KEY,
    FullName       VARCHAR(100) NOT NULL,
    Email          VARCHAR(150),
    City           VARCHAR(60),
    JoinDate       DATE,
    MembershipTier VARCHAR(20),
    LoyaltyPoints  INT DEFAULT 0
) COMMENT = "Paying members";

CREATE TABLE Rentals (
    RentalID   INT AUTO_INCREMENT PRIMARY KEY,   -- [MSSQL] INT IDENTITY(1,1)
    CustomerID INT,                              -- [ORACLE] GENERATED AS IDENTITY
    MovieID    INT,
    CopyNumber INT DEFAULT 1,
    RentalDate DATETIME,
    ReturnDate DATETIME,
    AmountPaid DECIMAL(8,2),
    LateFee    DECIMAL(8,2)
) COMMENT = "Who rented what, when";

CREATE TABLE Reviews (
    ReviewID   INT AUTO_INCREMENT PRIMARY KEY,
    MovieID    INT,
    CustomerID INT,
    Score      INT,
    ReviewText VARCHAR(500),
    PostedOn   DATETIME
) COMMENT = "Customer ratings";

CREATE TABLE Staff (
    StaffID   INT PRIMARY KEY,
    StaffName VARCHAR(100) NOT NULL,
    ManagerID INT,                    -- self-referencing: see the SELF JOIN section
    StoreID   INT
) COMMENT = "Store employees";

-- Supporting tables used later in the walkthrough
CREATE TABLE Movies_Staging (         -- nightly distributor feed, all text
    MovieID          INT,
    Title            VARCHAR(150),
    ReleaseYearText  VARCHAR(10),
    GenreID          INT,
    DirectorID       INT,
    RuntimeMinutes   INT,
    RentalRateText   VARCHAR(20)
) COMMENT = "Raw feed, untyped -- cleaned on load";

CREATE TABLE Movies_Legacy (          -- catalogue of the acquired rival
    MovieID INT PRIMARY KEY,
    Title   VARCHAR(150) NOT NULL
);

CREATE TABLE Movies_2019_Archive (    -- dropped again in section 1.3
    MovieID INT PRIMARY KEY,
    Title   VARCHAR(150)
);

CREATE TABLE Rentals_Archive (
    RentalID   INT PRIMARY KEY,
    CustomerID INT,
    MovieID    INT,
    RentalDate DATETIME,
    ReturnDate DATETIME,
    AmountPaid DECIMAL(8,2)
);

CREATE TABLE Movies_PriceAudit (
    AuditID   INT AUTO_INCREMENT PRIMARY KEY,
    MovieID   INT,
    OldRate   DECIMAL(6,2),
    NewRate   DECIMAL(6,2),
    ChangedBy VARCHAR(100),
    ChangedOn DATETIME
);

CREATE TABLE MembershipTiers (
    TierName VARCHAR(20) PRIMARY KEY
);

-- Add a column
ALTER TABLE Movies ADD COLUMN ContentRating VARCHAR(5);

-- Modify a column
ALTER TABLE Movies MODIFY COLUMN Title VARCHAR(250) NOT NULL;

-- Drop a column
ALTER TABLE Movies DROP COLUMN OldCatalogueCode;
DESC Movies;

-- Rename a column (MySQL 8.0+)
ALTER TABLE Movies RENAME COLUMN ContentRating TO AgeRating;
ALTER TABLE Movies RENAME COLUMN AgeRating to Contentrating;


-- Add a constraint (see the CONSTRAINTS chapter for the full set)
ALTER TABLE Movies
	ADD constraint ck_Movie_RentalRate CHECK (RentalRate >= 0);
DESC Movies;
-- Drop a constraint
ALTER TABLE Movies
	DROP CHECK ck_Movie_RentalRate;

ALTER TABLE Movies
	ADD constraint ck_Movie_RentalRate CHECK (RentalRate >= 0);

-- DROP removean object permanently (Structure/Schema and Data/records)

-- <DROP TABLE table_name>

SELECT * FROM movies_2019_archive;
INSERT INTO movies_2019_archive VALUES (121, 'RandomTitle');

DROP TABLE movies_2019_archive;

DROP TABLE IF EXISTS movies_2019_archive;

-- TRUNCATE: empty a table fast , keep its structure
-- TRUNCATE TABLE <table_name>
DESC movies_staging;
INSERT INTO movies_staging VALUES(1, 'ABCD', '2016', 2, 3, 123, '140');
INSERT INTO movies_staging VALUES(2, 'ABCDEF', '2018', 1, 4, 130, '160');

SELECT * FROm movies_staging

TRUNCATE TABLE movies_staging;

DESC movies_staging;

-- RENAME: rename an Object/Table/Schema;
RENAME TABLE customers to members;
RENAME TABLE members to customers;

-- COMMENT: 
ALTER TABLE movies comment = 'CineVerse film catalogue, one row per title';

desc movies;

ALTER TABLE movies 
    MODIFY COLUMN RentalRate DECIMAL(6,2)
    COMMENT 'Price per 48-hour rental, INR';

DESC movies;
SELECT * FROM movies;

SELECT TABLE_NAME, TABLE_COMMENT
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'db_44xh5ngsf' AND TABLE_NAME='movies';

SELECT COLUMN_NAME, COLUMN_COMMENT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'db_44xh5ngsf' AND TABLE_NAME='movies';