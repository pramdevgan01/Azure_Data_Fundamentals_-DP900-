CREATE TABLE Genres (
    GenreID   INT          PRIMARY KEY,
    GenreName VARCHAR(50)  NOT NULL
) COMMENT = 'Film categories';

CREATE TABLE Directors (
    DirectorID   INT          PRIMARY KEY,
    DirectorName VARCHAR(100) NOT NULL,
    Nationality  VARCHAR(50)
) COMMENT = 'People who direct films';

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
) COMMENT = 'CineVerse film catalogue, one row per title';

CREATE TABLE Customers (
    CustomerID     INT          PRIMARY KEY,
    FullName       VARCHAR(100) NOT NULL,
    Email          VARCHAR(150),
    City           VARCHAR(60),
    JoinDate       DATE,
    MembershipTier VARCHAR(20),
    LoyaltyPoints  INT DEFAULT 0
) COMMENT = 'Paying members';

CREATE TABLE Rentals (
    RentalID   INT AUTO_INCREMENT PRIMARY KEY,   -- [MSSQL] INT IDENTITY(1,1)
    CustomerID INT,                              -- [ORACLE] GENERATED AS IDENTITY
    MovieID    INT,
    CopyNumber INT DEFAULT 1,
    RentalDate DATETIME,
    ReturnDate DATETIME,
    AmountPaid DECIMAL(8,2),
    LateFee    DECIMAL(8,2)
) COMMENT = 'Who rented what, when';

CREATE TABLE Reviews (
    ReviewID   INT AUTO_INCREMENT PRIMARY KEY,
    MovieID    INT,
    CustomerID INT,
    Score      INT,
    ReviewText VARCHAR(500),
    PostedOn   DATETIME
) COMMENT = 'Customer ratings';

CREATE TABLE Staff (
    StaffID   INT PRIMARY KEY,
    StaffName VARCHAR(100) NOT NULL,
    ManagerID INT,                    -- self-referencing: see the SELF JOIN section
    StoreID   INT
) COMMENT = 'Store employees';

-- Supporting tables used later in the walkthrough
CREATE TABLE Movies_Staging (         -- nightly distributor feed, all text
    MovieID          INT,
    Title            VARCHAR(150),
    ReleaseYearText  VARCHAR(10),
    GenreID          INT,
    DirectorID       INT,
    RuntimeMinutes   INT,
    RentalRateText   VARCHAR(20)
) COMMENT = 'Raw feed, untyped -- cleaned on load';

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

CREATE TABLE MembershipTiers (        -- used by the CROSS JOIN example
    TierName VARCHAR(20) PRIMARY KEY
);


-- DROP: remove an object permantaly (Structure/Schema + Data/Record)

-- DROP TABLE <table_name>
DROP TABLE IF EXISTS movies_2019_archive;


--TRUNCATE: eampty a table fast, keep its sturtcure

select * from movies_staging;

DESC movies_staging;

INSERT INTO movies_staging VALUES (1, 'DemoMovie', '2026', 3, 2, 123, '260');
INSERT INTO movies_staging VALUES (2, 'DemoMovie2', '2016', 5, 1, 145, '260');
INSERT INTO movies_staging VALUES (3, 'DemoMovie3', '2018', 9, 4, 132, '260');


select * from movies_staging;

-- TRUNCATE TABLE <table_name>
TRUNCATE TABLE movies_staging;
select * from movies_staging;
DESC movies_staging;

-- RENAME: rename an object/schema/table
RENAME TABLE <existing_table_name> TO <new_table_name>

RENAME TABLE customers TO members;
RENAME TABLE members to customers;


-- COMMENT: store documentation in database iteself

ALTER TABLE movies COMMENT = 'CineVerse film catalogue, one row per title';

DESC movies;

ALTER TABLE movies
    MODIFY COLUMN RentalRate DECIMAL(6, 2)
    COMMENT 'PRICE per 48-hour rental, INR';

-- db_44xddvebs
SELECT TABLE_NAME, TABLE_COMMENT
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'db_44xddvebs' AND TABLE_NAME = 'movies';

SELECT COLUMN_NAME, COLUMN_COMMENT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'db_44xddvebs' AND TABLE_NAME = 'movies';