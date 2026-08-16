-- Constraints: Primary Key, Foregin KEY, UNIQUE, NOT NULL, CHECK, DEFAULT

-- 1. PRIMARY KEY.

DESC membershiptiers;
ALTER TABLE membershiptiers DROP PRIMARY KEY;
DESC membershiptiers;

ALTER TABLE membershiptiers ADD CONSTRAINT PRIMARY KEY(TierName);
DESC membershiptiers;


-- 2. FK: referential itegrity
DESC movies;


ALTER TABLE movies
    ADD CONSTRAINT fk_movies_genres
    FOREIGN KEY (GenreID) REFERENCES genres (GenreID)
    ON DELETE SET NULL
    ON UPDATE CASCADE;


ALTER TABLE movies
DROP FOREIGN KEY fk_movies_directors;

ALTER TABLE movies
    ADD CONSTRAINT fk_movies_directors
    FOREIGN KEY (DirectorID) REFERENCES directors(DirectorID)
    ON DELETE SET NULL;


ALTER TABLE Rentals
    ADD CONSTRAINT FK_Rentals_Movies
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

ALTER TABLE Rentals
    ADD CONSTRAINT FK_Rentals_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);


ALTER TABLE Reviews
    ADD CONSTRAINT FK_Reviews_Movies
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

ALTER TABLE Reviews
    ADD CONSTRAINT FK_Reviews_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

ALTER TABLE Staff
    ADD CONSTRAINT FK_Staff_Manager
    FOREIGN KEY (ManagerID) REFERENCES Staff(StaffID);   -- self-referencing

-- 3. UNIQUE:
DESC customers; 
ALTER TABLE customers
    ADD CONSTRAINT uq_customer_email UNIQUE (Email);

ALTER TABLE reviews
    ADD CONSTRAINT uq_review_customer_movie UNIQUE (CustomerID, MovieID);

DESC reviews;

-- 4. CHECK: 
ALTER TABLE reviews
    ADD CONSTRAINT ck_review_score CHECK (Score BETWEEN 1 AND 10);

DESC reviews;

-- 1888 AND 2100;
ALTER TABLE movies 
    ADD CONSTRAINT ck_movie_releaseYear 
    CHECK (ReleaseYear BETWEEN 1888 AND 2100);

ReturnDate = NULL OR ReturnDate GTE RentalDate

ALTER TABLE rentals
    ADD CONSTRAINT ck_rental_dates
    CHECK (ReturnDate IS NULL 
        OR ReturnDate >= RentalDate
    );


-- 5. DEFAULT
ALTER TABLE customers
ALTER COLUMN JoinDate 
SET DEFAULT (CURRENT_DATE);

ALTER TABLE customers
ALTER COLUMN MembershipTier
SET DEFAULT 'Silver'

-- NOT NULL:
ALTER TABLE movies
MODIFY COLUMN Title
VARCHAR(250) NOT NULL;

ALTER TABLE customers
MODIFY COLUMN FullName 
VARCHAR(100) NOT NULL;

desc movies;

DESC directors
DESC movies;



SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA='db_44xddvebs'
AND TABLE_NAME='customers';

ALTER TABLE movies ADD COLUMN ContentRating VARCHAR(5);