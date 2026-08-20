<style>
:root {
  --ink: #2b2b2b;
  --muted: #6b6b6b;
  --accent: #b5651d;
  --accent-dark: #8a4b12;
  --accent-soft: #fbe9d7;
  --surface: #faf7f2;
  --surface-alt: #f1ece3;
  --border: #ddd3c4;
  --code-bg: #2d2a26;
  --code-ink: #f5efe6;
  --success: #2f7d5f;
  --success-bg: #eaf6f0;
  --danger: #b3382c;
  --warn-bg: #fdf3d8;
}

body {
  font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
  color: var(--ink);
  line-height: 1.65;
  background: var(--surface);
  max-width: 960px;
  margin: 0 auto;
  padding: 2rem 1.5rem 4rem;
}

h1 {
  font-size: 2rem;
  color: var(--accent-dark);
  border-bottom: 3px solid var(--accent);
  padding-bottom: 0.4rem;
  letter-spacing: 0.02em;
}

h2 {
  margin-top: 2.5rem;
  font-size: 1.4rem;
  color: var(--accent-dark);
  border-left: 5px solid var(--accent);
  padding: 0.35rem 0 0.35rem 0.7rem;
  background: var(--accent-soft);
  border-radius: 0 6px 6px 0;
}

h3 {
  margin-top: 1.8rem;
  font-size: 1.15rem;
  color: var(--ink);
  border-bottom: 1px solid var(--border);
  padding-bottom: 0.3rem;
}

h4 { color: var(--accent-dark); font-size: 1rem; }

blockquote {
  margin: 0.6rem 0 1.2rem;
  padding: 0.6rem 1rem;
  border-left: 4px solid var(--accent);
  background: var(--surface-alt);
  color: var(--muted);
  font-style: italic;
  border-radius: 0 6px 6px 0;
}

p { margin: 0.6rem 0; }

a {
  color: var(--accent-dark);
  text-decoration: none;
  border-bottom: 1px dotted var(--accent);
}
a:hover { color: var(--accent); border-bottom-style: solid; }

code {
  background: var(--surface-alt);
  color: var(--accent-dark);
  padding: 0.1rem 0.4rem;
  border-radius: 4px;
  font-size: 0.9em;
  font-family: "Cascadia Code", "Fira Code", Consolas, monospace;
}

pre {
  background: var(--code-bg);
  color: var(--code-ink);
  padding: 1rem 1.2rem;
  border-radius: 8px;
  overflow-x: auto;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

pre code { background: none; color: inherit; padding: 0; }

table {
  width: 100%;
  border-collapse: collapse;
  margin: 1rem 0 1.6rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  border-radius: 6px;
  overflow: hidden;
}

thead th {
  background: var(--accent-dark);
  color: #fff;
  text-align: left;
  padding: 0.5rem 0.8rem;
}

tbody td { padding: 0.45rem 0.8rem; border-bottom: 1px solid var(--border); }
tbody tr:nth-child(even) { background: var(--surface-alt); }
tbody tr:hover { background: var(--accent-soft); }

img {
  max-width: 100%;
  border-radius: 8px;
  border: 1px solid var(--border);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
  margin: 0.6rem 0 1.2rem;
}

hr { border: none; border-top: 2px dashed var(--border); margin: 2.4rem 0; }

ul, ol { padding-left: 1.4rem; }
li { margin: 0.25rem 0; }

strong { color: var(--accent-dark); }

.note-box {
  border: 2px solid var(--success);
  padding: 12px 16px;
  border-radius: 8px;
  background: var(--success-bg);
  margin: 1rem 0;
}
.highlight-yes { color: var(--success); font-weight: bold; }
.highlight-no { color: var(--danger); font-weight: bold; }
.warning {
  display: inline-block;
  background: var(--warn-bg);
  padding: 6px 10px;
  border-radius: 4px;
  font-weight: bold;
  margin-top: 0.4rem;
}
</style>

# Experiment No. 4
> Create Tables and Perform Basic SQL Queries in Azure SQL Database

## Aim / Objective:
To provision an Azure SQL Database through the Azure Portal, connect to it using the browser-based Query editor, create tables with a defined schema, and perform basic SQL (DDL/DML) queries against them.

## Requirements / Tools Used:
An active Azure subscription, a web browser, and access to the Azure Portal (portal.azure.com). No local software installation is required — the built-in **Query editor (preview)** is used to run SQL directly from the browser.

## Theory / Background:
**Azure SQL Database** is a fully managed Platform-as-a-Service (PaaS) relational database built on the SQL Server engine. Microsoft handles patching, backups, and high availability, so the user only manages the **logical server** (the administrative/connection endpoint, e.g. `streamflixdbserver`) and the **database(s)** hosted on it (e.g. `StreamFlixDB`) — a one-to-many relationship where one server can host multiple databases.

A relational database organizes data into **tables**, each with a fixed set of **columns** (name + data type, e.g. `VARCHAR(100)`, `INT`) and any number of **rows**. A **primary key** (e.g. `CustomerID`) uniquely identifies each row and enforces entity integrity. SQL statements fall into two broad categories:
- **DDL (Data Definition Language)** — `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE` — defines the schema/structure.
- **DML (Data Manipulation Language)** — `INSERT`, `SELECT`, `UPDATE`, `DELETE` — reads and modifies the data inside that structure.

Network access to an Azure SQL logical server is controlled by **server-level firewall rules**: by default no public IP can connect, so the client's own IP (and optionally other Azure services) must be explicitly allowed before any tool — including the Query editor — can reach the database.

![Azure SQL Database architecture — server, databases, and DDL vs DML](resources/lab4/azure-sql-architecture.png "Azure SQL Database Architecture")

## Procedure / Steps:

1.  In the Azure Portal search bar, search for **"SQL Database"** and select the **Azure SQL Database** service.

    ![Search for Azure SQL Database](images/lab4/Step_1.jpg)

2.  On the **Azure SQL \| SQL databases** blade, click **+ Create**, then choose **SQL database** from the dropdown.

    ![Create SQL database](images/lab4/Step_2.jpg)
    ![Choose SQL database option](images/lab4/Step_3.jpg)

3.  On the **Basics** tab, under *Project details*, click **Create new** for Resource group and name it (e.g. `AIML_4_SQL_RG`). Under *Database details*, set the **Database name** (e.g. `StreamFlixDB`), then click **Create new** under Server to provision a new logical server.

    ![Create resource group and start server creation](images/lab4/Step_4.jpg)

4.  In the **Create SQL Database Server** panel: enter a globally unique, all-lowercase **Server name** (e.g. `streamflixdbserver`), pick the **Location** nearest to you (e.g. Central India), set **Authentication method** to *Use both SQL and Microsoft Entra authentication*, enter a **Server admin login** (e.g. `sqladmin`) and a strong **Password** (remember both), then click **OK**.

    ![Configure the SQL Database server](images/lab4/Step_5.png)

5.  Back on **Basics**: set *Want to use SQL elastic pool?* to **No**, *Workload environment* to **Development** (cost-optimized defaults), keep the default **Compute + storage** (General Purpose – Serverless) and **Locally-redundant backup storage**, then click **Next: Networking**.

    ![Basics tab — database and workload settings](images/lab4/Step_6.png)

6.  On the **Networking** tab: set *Connectivity method* to **Public endpoint**, turn on **Allow Azure services and resources to access this server** and **Add current client IP address**, keep the *Default* connection policy and **TLS 1.2**, then click **Next: Security**.

    ![Networking configuration](images/lab4/Step_7.png)

7.  On the **Security** tab: leave *Microsoft Defender for SQL* as **Not now**, *Ledger* as **Not configured**, *Server identity* as **Not enabled**, keep the default **Service-managed** transparent data encryption key, and leave *Enable secure enclaves* **OFF** (none of these are needed for a basic lab database). Click **Next: Additional settings**.

    ![Security tab defaults](images/lab4/Step_8.png)

8.  On **Additional settings**: keep *Use existing data* as **None** (blank database) and the default **Collation** (`SQL_Latin1_General_CP1_CI_AS`) and **Maintenance window**. Tags are optional — proceed to **Tags** and, if desired, add descriptive Name/Value pairs (e.g. `AIML-4-DB : SQL-Database` scoped to the database, `AIML-4-Server : SQL Server` scoped to the server) to help organize and track cost.

    ![Additional settings — collation and maintenance window](images/lab4/Step_9.png)
    ![Optional resource tags](images/lab4/Step_10.png)

9.  On **Review + create**, verify the configuration summary and estimated cost, then click **Create** to deploy.

    ![Review and create the SQL database](images/lab4/Step_11.png)

10. Wait for the deployment to complete, then click **Go to resource** to open the new database.

    ![Deployment complete](images/lab4/Step_12.png)

11. Open the SQL **server** resource's **Networking** blade (under Security). Confirm *Public network access* is set to **Selected networks**, and use **Add your client IPv4 address** (or manually **Add a firewall rule** with a Rule name, Start IP, and End IP) to allow your machine to reach the server, then **Save**.

    ![Configure server firewall rules](images/lab4/Step_13.jpg)

12. On the SQL **database** resource's **Overview** page, click **Query editor (preview)** in the left-hand menu.

    ![Open Query editor from the database Overview](images/lab4/Step_14.jpg)

13. In the Query editor sign-in screen, select the **SQL authentication** tab, enter the **Username** (`sqladmin`) and **Password** set during server creation, then click **Connect**.

    ![Query editor login options](images/lab4/Step_15.jpg)
    ![Signing in with SQL authentication](images/lab4/Step_16.jpg)

14. Once connected, use the **Explorer** pane to browse database objects: the `dbo` schema contains **Tables**, **Views**, **Stored Procedures**, and **Functions** (Scalar / Table-valued); the **Queries** node lists saved/open SQL files. Click **New query** to open a blank SQL editor tab.

    ![Query editor Explorer and toolbar](images/lab4/Step_17.jpg)

15. Type a `CREATE TABLE` statement (see Sample Code below) into the query tab and click **Run**. Check the **Messages** pane for the execution status ("Query executed successfully") and confirm the new table appears under **Tables** in the Explorer.

    ![Running CREATE TABLE in the Query editor](images/lab4/Step_18.jpg)

16. Repeat step 15 to create the second table, then run basic DML queries (`INSERT`, `SELECT`, `UPDATE`, `DELETE`) to populate and query the data — see Sample Code below.

## Sample Code / Data Used:

### Create Tables (DDL) *build the objects. Parents before children.*

```sql
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

CREATE TABLE Movies_2019_Archive (    -- dropped again
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
```

### ALTER Tables (DDL) *Change an object without dropping it*

```sql

-- Add a column
ALTER TABLE Movies ADD COLUMN ContentRating VARCHAR(5);
-- [MSSQL] ALTER TABLE Movies ADD ContentRating VARCHAR(5);   (no COLUMN keyword)

-- Modify a column
ALTER TABLE Movies MODIFY COLUMN Title VARCHAR(250) NOT NULL;
-- [MSSQL] ALTER TABLE Movies ALTER COLUMN Title VARCHAR(250) NOT NULL;

-- Drop a column
ALTER TABLE Movies DROP COLUMN OldCatalogueCode;

-- Rename a column (MySQL 8.0+)
ALTER TABLE Movies RENAME COLUMN ContentRating TO AgeRating;
ALTER TABLE Movies RENAME COLUMN AgeRating TO ContentRating;   -- and back again
-- [MSSQL] EXEC sp_rename 'Movies.ContentRating', 'AgeRating', 'COLUMN';

-- Add a constraint
ALTER TABLE Movies
    ADD CONSTRAINT CK_Movies_RentalRate CHECK (RentalRate >= 0);
-- NOTE: CHECK is only ENFORCED from MySQL 8.0.16. Older MySQL parses and
--       ignores it silently -- a classic source of bad data.

-- Drop a constraint
ALTER TABLE Movies DROP CHECK CK_Movies_RentalRate;
-- [MSSQL]/[ORACLE]/[PGSQL] ALTER TABLE Movies DROP CONSTRAINT CK_Movies_RentalRate;
ALTER TABLE Movies                                    -- put it straight back
    ADD CONSTRAINT CK_Movies_RentalRate CHECK (RentalRate >= 0);

```

### DROP (DDL) *Remove an object permanently (structure AND data)*

```sql
DROP TABLE IF EXISTS Movies_2019_Archive;
-- NOTE: DROP TABLE Movies would fail later, once Rentals and Reviews hold
```

### TRUNCATE *Empty a table fast, keep its structure*
- No WHERE clause is possible -- it is all or nothing.
- Resets `AUTO_INCREMENT`.        [MSSQL] `resets IDENTITY`.
- Does NOT fire `DELETE` triggers in any engine.

```sql
TRUNCATE TABLE Movies_Staging;
```


### RENAME *Rename an object*
```sql
RENAME TABLE Customers TO Members;
RENAME TABLE Members TO Customers;      -- renamed back: everything below
```

### COMMENT -- *store documentation in the database itself*
```sql
-- Table Comment
ALTER TABLE Movies COMMENT = 'CineVerse film catalogue, one row per title';

-- Column Comment
ALTER TABLE Movies
    MODIFY COLUMN RentalRate DECIMAL(6,2)
    COMMENT 'Price per 48-hour rental, INR';
```
- `[MSSQL]` **uses extended properties instead:**
```sql
EXEC sp_addextendedproperty @name = N'MS_Description',
@value = N'Price per 48-hour rental, INR',
@level0type = N'SCHEMA', @level0name = N'dbo',
@level1type = N'TABLE',  @level1name = N'Movies',
@level2type = N'COLUMN', @level2name = N'RentalRate';
```

- **Read the comments back:**
```sql
SELECT TABLE_NAME, TABLE_COMMENT
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_SCHEMA = 'CineVerseDB' AND TABLE_NAME = 'Movies';
```

## CONSTRAINTS  (applied before loading data, so the rules bite):
- PRIMARY KEY 
- FOREIGN KEY
- UNIQUE
- CHECK 
- DEFAULT
- NOT NULL

### PRIMARY KEY: *already declared inline above. Adding one after the fact*
```sql
ALTER TABLE MembershipTiers DROP PRIMARY KEY;
ALTER TABLE MembershipTiers ADD CONSTRAINT PRIMARY KEY (TierName);
-- [MSSQL] ALTER TABLE MembershipTiers ADD CONSTRAINT PK_Tiers PRIMARY KEY (TierName);
```
- *MySQL* always names the primary key `"PRIMARY"` -- your name is ignored.
- **[MSSQL]:**
    ```sql 
    ALTER TABLE MembershipTiers ADD CONSTRAINT PK_Tiers PRIMARY KEY (TierName);
    ```

### FOREIGN KEY: **referential integrity**
```sql
ALTER TABLE Movies
    ADD CONSTRAINT FK_Movies_Genres
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

ALTER TABLE Movies
    ADD CONSTRAINT FK_Movies_Directors
    FOREIGN KEY (DirectorID) REFERENCES Directors(DirectorID)
    ON DELETE SET NULL;

ALTER TABLE Rentals
    ADD CONSTRAINT FK_Rentals_Movies
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

ALTER TABLE Rentals
    ADD CONSTRAINT FK_Rentals_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
-- Deliberately NOT ON DELETE CASCADE: deleting a member must not erase their rental history and with it the revenue figures.

ALTER TABLE Reviews
    ADD CONSTRAINT FK_Reviews_Movies
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID);

ALTER TABLE Reviews
    ADD CONSTRAINT FK_Reviews_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);

ALTER TABLE Staff
    ADD CONSTRAINT FK_Staff_Manager
    FOREIGN KEY (ManagerID) REFERENCES Staff(StaffID);   -- self-referencing
```

### UNIQUE: *ensures that all values in a column or a set of columns are distinct, with no duplicates allowed.*
- One customer may review a given film only once.
- MySQL and MSSQL both allow multiple NULLs in a UNIQUE column, so one customer may have no email - but not two.

```sql
ALTER TABLE Customers
    ADD CONSTRAINT UQ_Customers_Email UNIQUE (Email);

ALTER TABLE Reviews
    ADD CONSTRAINT UQ_Reviews_Customer_Movie UNIQUE (CustomerID, MovieID);
```

### CHECK: **is used to enforce a condition on column values so that only data meeting the rule can be inserted**

```sql
ALTER TABLE Reviews
    ADD CONSTRAINT CK_Reviews_Score CHECK (Score BETWEEN 1 AND 10);

ALTER TABLE Movies
    ADD CONSTRAINT CK_Movies_ReleaseYear CHECK (ReleaseYear BETWEEN 1888 AND 2100);

ALTER TABLE Rentals
    ADD CONSTRAINT CK_Rentals_Dates
    CHECK (ReturnDate IS NULL OR ReturnDate >= RentalDate);
```
- Note the explicit *"IS NULL"*: a CHECK that evaluates to NULL PASSES, in every engine. Never rely on that accidentally.

### DEFAULT: *automatically assigns a predefined value to a column when no value is specified during `INSERT`*
```sql
ALTER TABLE Customers ALTER COLUMN JoinDate       SET DEFAULT (CURRENT_DATE);
ALTER TABLE Customers ALTER COLUMN MembershipTier SET DEFAULT 'Silver';
```

- `[MSSQL]`:
    ```sql
    ALTER TABLE Customers
    ADD CONSTRAINT DF_Customers_Tier DEFAULT 'Silver' FOR MembershipTier;
    ```


### NOT NULL: *ensures that a column cannot contain NULL values*
```sql
ALTER TABLE Movies    MODIFY COLUMN Title    VARCHAR(250) NOT NULL;
ALTER TABLE Customers MODIFY COLUMN FullName VARCHAR(100) NOT NULL;
```

- `Movies.DirectorID` and `Rentals.ReturnDate` stay nullable ON PURPOSE: those NULLs are meaningful (unknown director / still on loan), not missing.

## DML: DATA MANIPULATION LANGUAGE
- **INSERT**
- **UPDATE**
- **DELETE**
- **MERGE**

### INSERT: *used to add new rows of data into a table.*
- **Single row:**
```sql
INSERT INTO Genres (GenreID, GenreName) VALUES (1, 'Science Fiction');
```

- **Multiple rows in one statement:**
```sql
INSERT INTO Genres (GenreID, GenreName) VALUES
    (2, 'Drama'),
    (3, 'Comedy'),
    (4, 'Thriller'),
    (5, 'Documentary'),
    (6, 'Silent Film');


INSERT INTO Directors (DirectorID, DirectorName, Nationality) VALUES
    (11, 'Christopher Nolan', 'British-American'),
    (12, 'Ritesh Batra',      'Indian'),
    (13, 'Bong Joon-ho',      'South Korean'),
    (14, 'Zoya Akhtar',       'Indian');

INSERT INTO Movies (MovieID, Title, ReleaseYear, GenreID, DirectorID,
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

INSERT INTO Customers (CustomerID, FullName, Email, City, JoinDate, MembershipTier,
                       LoyaltyPoints) VALUES
    (5001, 'Aarav Sharma', 'aarav@example.com', 'Kanpur',  '2026-01-15', 'Gold',   120),
    (5002, 'Neha Verma',   'neha@example.com',  'Lucknow', '2026-02-03', 'Silver',  45),
    (5003, 'Rohit Singh',  'rohit@example.com', 'Kanpur',  '2026-02-20', 'Silver',  30),
    (5004, 'Priya Nair',   'priya@example.com', 'Delhi',   '2026-03-11', 'Gold',    90),
    (5005, 'Kabir Das',    NULL,                'Kanpur',  '2026-04-02', 'Bronze',   0);


-- Insert relying on DEFAULT values (JoinDate and MembershipTier omitted)
INSERT INTO Customers (CustomerID, FullName, Email, City)
VALUES (5006, 'Ishaan Rao', 'ishaan@example.com', 'Kanpur');

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
```


### UPDATE: *used to modify existing records in a table.*
- **One row, one column:**
```sql
UPDATE Customers
SET    MembershipTier = 'Platinum'
WHERE  CustomerID = 5001;
```

- **Many rows, many columns:**
```sql
UPDATE Movies
SET    RentalRate    = RentalRate * 1.10,
       ContentRating = 'UA'
WHERE  GenreID = 1;                       -- all science fiction
```

- **UPDATE driven by a JOIN: add a late fee to overdue loans**
```sql
UPDATE Rentals r
JOIN   Movies  m ON m.MovieID = r.MovieID
SET    r.LateFee = 50.00
WHERE  r.ReturnDate IS NULL
  AND  r.RentalDate < DATE_SUB(NOW(), INTERVAL 7 DAY);
```

- `[MSSQL]`:
    ```sql
    UPDATE r SET r.LateFee = 50 FROM Rentals r JOIN Movies m ON ...;
    ```
- MySQL puts SET after the JOIN
- **WARNING** leaving off the WHERE reprices the entire catalogue:
    ```sql
    UPDATE Movies SET RentalRate = RentalRate * 1.10;     -- valid, and a disaster
    ```

### DELETE: 
- Add a review, then retract it
```sql
INSERT INTO Reviews (MovieID, CustomerID, Score, ReviewText, PostedOn)
VALUES (105, 5003, 1, 'Abusive text to be removed', NOW());
```

```sql
DELETE FROM Reviews
WHERE  MovieID = 105 AND CustomerID = 5003;

DELETE FROM Rentals_Archive
WHERE  RentalDate < '2026-01-01';
```

- **WARNING:** `DELETE FROM Reviews;`  is valid SQL and empties the table silently.
- Unlike `TRUNCATE`, `DELETE` logs each row, fires triggers, keeps `AUTO_INCREMENT` and can be filtered and rolled back.

### MERGE / UPSERT: *used to insert new rows or update existing ones in a table based on a matching condition.* (optional)

```sql
INSERT INTO Movies_Staging (MovieID, Title, ReleaseYearText, GenreID, DirectorID,
                            RuntimeMinutes, RentalRateText) VALUES
    (101, 'Interstellar',   '2014', 1,   11, 169, '159.00'),  -- existing: price change
    (111, 'Dune',           '2021', 1,   11, 155, '169.00'),  -- new film
    (112, 'The Wind Rises', 'n/a',  2, NULL, 126, 'not-set');  -- junk data on purpose
```

- MySQL has NO MERGE statement. The equivalent is:
```sql
INSERT INTO Movies (MovieID, Title, ReleaseYear, GenreID, DirectorID,
                    RuntimeMinutes, RentalRate)
SELECT s.MovieID,
       s.Title,
       CAST(NULLIF(s.ReleaseYearText, 'n/a') AS UNSIGNED),
       s.GenreID,
       s.DirectorID,
       s.RuntimeMinutes,
       CAST(NULLIF(s.RentalRateText, 'not-set') AS DECIMAL(6,2))
FROM   Movies_Staging s
ON DUPLICATE KEY UPDATE
       Title      = VALUES(Title),
       RentalRate = VALUES(RentalRate),
       GenreID    = VALUES(GenreID);
```
- **`MSSQL`**:
    ```sql
    MERGE Movies AS T
    USING Movies_Staging AS S
    ON T.MovieID = S.MovieID
    WHEN MATCHED THEN
        UPDATE SET T.Title = S.Title, T.RentalRate = S.RentalRate
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (MovieID, Title, RentalRate)
        VALUES (S.MovieID, S.Title, S.RentalRate);
    ```

## DQL: DATA QUERY LANGUAGE (SELECT)

### Projection: `SELECT *`, `columns`, `aliases`, `expressions`

#### `SELECT *`
```sql
SELECT * FROM Movies;                          -- fine while exploring
```
- **Output:**

| MovieID | Title                       | ReleaseYear | GenreID | DirectorID | RuntimeMinutes | RentalRate | CopiesAvailable | ContentRating |
|---------|-----------------------------|-------------|---------|------------|----------------|------------|-----------------|---------------|
| 101     | Interstellar                | 2014        | 1       | 11         | 169            | 163.90     | 6               | A             |
| 102     | The Lunchbox                | 2013        | 2       | 12         | 104            | 99.00      | 4               | U             |
| 103     | Parasite                    | 2019        | 4       | 13         | 132            | 149.00     | 3               | A             |
| 104     | Ocean Deep                  | 2021        | 5       |            | 92             | 79.00      | 5               | U             |
| 105     | The Prestige                | 2006        | 4       | 11         | 130            | 129.00     | 4               | UA            |
| 106     | Gully Boy                   | 2019        | 2       | 14         | 153            | 119.00     | 5               | UA            |
| 107     | Memento                     | 2000        | 4       | 11         | 113            | 89.00      | 2               | A             |
| 108     | Zindagi Na Milegi Dobara    | 2011        | 3       | 14         | 155            | 109.00     | 6               | U             |
| 109     | Blue Planet Voyage          | 2023        | 5       |            | 101            | 69.00      | 8               | U             |
| 110     | Silent Echo                 | 2022        | 1       | 13         | 118            | 152.90     | 3               | A             |


#### ` SELECT columns`
```sql
SELECT Title, ReleaseYear FROM Movies;         -- what production code should do
```

- **Output:**

| Title                     | ReleaseYear |
|---------------------------|-------------|
| Interstellar              | 2014        |
| The Lunchbox              | 2013        |
| Parasite                  | 2019        |
| Ocean Deep                | 2021        |
| The Prestige              | 2006        |
| Gully Boy                 | 2019        |
| Memento                   | 2000        |
| Zindagi Na Milegi Dobara  | 2011        |
| Blue Planet Voyage        | 2023        |
| Silent Echo               | 2022        |

#### `aliases`
```sql
SELECT Title                          AS FilmTitle,
       RuntimeMinutes / 60.0          AS RuntimeHours,
       CONCAT('INR ', CAST(RentalRate AS CHAR)) AS PriceLabel
FROM   Movies AS m;
```
- **Output:**

| FilmTitle                  | RuntimeHours | PriceLabel  |
|----------------------------|--------------|-------------|
| Interstellar               | 2.8167       | INR 163.90  |
| The Lunchbox               | 1.7333       | INR 99.00   |
| Parasite                   | 2.2000       | INR 149.00  |
| Ocean Deep                 | 1.5333       | INR 79.00   |
| The Prestige               | 2.1667       | INR 129.00  |
| Gully Boy                  | 2.5500       | INR 119.00  |
| Memento                    | 1.8833       | INR 89.00   |
| Zindagi Na Milegi Dobara   | 2.5833       | INR 109.00  |
| Blue Planet Voyage         | 1.6833       | INR 69.00   |
| Silent Echo                | 1.9667       | INR 152.90  |


#### `expression`:

```sql
SELECT 2+2 AS ADDITION, 2*3 AS MULTIPLICATION;
```

- **Output:**

| ADDITION | MULTIPLICATION |
|----------|----------------|
| 4        | 6              |

### DISTINCT: *return only unique values, removing duplicates from the result set*

#### Single Column: 
```sql
SELECT DISTINCT City FROM Customers;
```
- **Output:**

| City     |
|----------|
| Kanpur   |
| Lucknow  |
| Delhi    |


#### Multple Columns:
```sql
SELECT DISTINCT City, MembershipTier FROM Customers;   -- distinct COMBINATIONS
```

- **Output:**

| City    | MembershipTier |
|---------|----------------|
| Kanpur  | Platinum       |
| Lucknow | Silver         |
| Kanpur  | Silver         |
| Delhi   | Gold           |
| Kanpur  | Bronze         |


### WHERE: *The **`WHERE` clause** is used to filter records in a query, returning only rows that meet a specified condition*
#### Logical Predicates with `WHERE`:
- **`AND`:** All conditions must be true
- **`OR`:** At least one condition must be true
- **`NOT`:** Negates a condition
- **`BETWEEN`:** Checks if a value is within a range
- **`LIKE`:** Pattern matching with wildcards (`%`, `_`)
- **`IN`:** Matches any value in a list
- **`IS NULL` / `IS NOT NULL`:** Checks for missing values

```sql
SELECT Title, ReleaseYear, RentalRate
FROM   Movies
WHERE  GenreID = 1 AND ReleaseYear >= 2015 AND RentalRate > 100;
```
- **Output:**

| Title       | ReleaseYear | RentalRate |
|-------------|-------------|------------|
| Silent Echo | 2022        | 152.90     |


```sql
SELECT Title, ReleaseYear, RentalRate
FROM Movies
WHERE ReleaseYear BETWEEN 2000 AND 2020              -- range filter
  AND GenreID IN (1, 2, 3)                          -- matches list
  AND Title LIKE 'P%'                               -- pattern match
  AND DirectorID IS NOT NULL                        -- exclude missing directors
  AND NOT (RentalRate < 100)                        -- negate condition
  OR CopiesAvailable = 2;                           -- alternative condition
```

- **Output:**

| Title   | ReleaseYear | RentalRate |
|---------|-------------|------------|
| Memento | 2000        | 89.00      |

#### Sargable vs Non-Sargable in SQL

- **Sargable** → A query condition that allows the database engine to use indexes efficiently (e.g., `WHERE RentalDate >= '2026-01-01' AND RentalDate < '2027-01-01'`).  
- **Non-Sargable** → A query condition that prevents index usage, forcing full table scans (e.g., `WHERE YEAR(RentalDate) = 2026`).

```sql
SELECT COUNT(*) FROM Rentals WHERE YEAR(RentalDate) = 2026;                -- scans
SELECT COUNT(*) FROM Rentals
WHERE  RentalDate >= '2026-01-01' AND RentalDate < '2027-01-01';           -- seeks
```

### Predicates: 
- `BETWEEN`, `IN`, 
- `LIKE`, `IS NULL`, 
- `EXISTS`, `ANY`, `ALL`

#### BETWEEN:
```sql
SELECT Title, RentalRate FROM Movies WHERE RentalRate BETWEEN 80 AND 150;   -- inclusive
```

- **Output:**

| Title                     | RentalRate |
|---------------------------|------------|
| The Lunchbox              | 99.00      |
| Parasite                  | 149.00     |
| The Prestige              | 129.00     |
| Gully Boy                 | 119.00     |
| Memento                   | 89.00      |
| Zindagi Na Milegi Dobara  | 109.00     |

#### IN:
```sql
SELECT Title, GenreID FROM Movies WHERE GenreID IN (1, 2, 4);
```

- **Output:**

| Title       | GenreID |
|-------------|---------|
| Interstellar| 1       |
| Silent Echo | 1       |
| The Lunchbox| 2       |
| Gully Boy   | 2       |
| Parasite    | 4       |
| The Prestige| 4       |
| Memento     | 4       |

#### LIKE:

- **using** `%`
```sql
SELECT Title, GenreID
FROM Movies
WHERE Title LIKE '%Boy';
```

- **output:**

| Title     | GenreID |
|-----------|---------|
| Gully Boy | 2       |


<br>

- **using** `_`
```sql
SELECT Title, GenreID
FROM Movies
WHERE Title LIKE 'M_mento';
```

- **Output:**

| Title   | GenreID |
|---------|---------|
| Memento | 4       |


<br>

- **using** `%` and `_`
```sql
SELECT Title, GenreID
FROM Movies
WHERE Title LIKE 'P_r%';
```

- **Output:**

| Title    | GenreID |
|----------|---------|
| Parasite | 4       |

#### `IS NULL`

```sql
SELECT Title, DirectorID FROM Movies WHERE DirectorID IS NULL;
```

- **Ouput:**

| Title              | DirectorID |
|--------------------|------------|
| Ocean Deep         | `null`       |
| Blue Planet Voyage | `null`       |


#### EXISTS:
- **EXISTS**: A logical operator used in `WHERE` clauses to test whether a subquery returns any rows.  
- If the subquery returns at least one row, `EXISTS` evaluates to **TRUE**; otherwise, it evaluates to **FALSE**.

    - **PS:** *genres that actually have at least one film*
    ```sql
    SELECT g.GenreName
    FROM   Genres g
    WHERE  EXISTS (SELECT 1 FROM Movies m WHERE m.GenreID = g.GenreID);
    ```

    - **Output:**

    | GenreName       |
    |-----------------|
    | Science Fiction |
    | Drama           |
    | Comedy          |
    | Thriller        |
    | Documentary     |


#### NOT EXISTS:
- **NOT EXISTS** : A logical operator used in `WHERE` clauses to check if a subquery returns **no rows**.  
- If the subquery returns nothing, `NOT EXISTS` evaluates to **TRUE**; otherwise, it evaluates to **FALSE**
    - **PS:** *films nobody has ever rented*
    ```sql
    SELECT m.Title
    FROM   Movies m
    WHERE  NOT EXISTS (SELECT 1 FROM Rentals r WHERE r.MovieID = m.MovieID);
    ```
    - **Ouput:**

    | Title              |
    |--------------------|
    | Ocean Deep         |
    | Blue Planet Voyage |
    | Silent Echo        |

    <div class="note-box">
    <p class="highlight-yes">Prefer <code>NOT EXISTS</code></p>
    <p class="highlight-no">Avoid <code>NOT IN</code></p>
    <p class="warning">If the subquery returns a single <code>NULL</code>, <code>NOT IN</code> returns NO ROWS AT ALL.</p>
    <p>True in every SQL engine — <code>NOT EXISTS</code> is safer and NULL‑friendly.</p>
    </div>

#### ANY
- **ANY** : Compares a value to each value returned by a subquery.  
- Condition is **TRUE** if it matches at least one value in the subquery result 
    - **PS:** *Retrieve all movie titles whose `RentalRate` is greater than **any rental rate** of movies belonging to `GenreID = 5`.*

    ```sql
    SELECT Title FROM Movies
    WHERE  RentalRate > ANY (SELECT RentalRate FROM Movies WHERE GenreID = 5);
    ```
    - **Output:**

    | Title                     |
    |----------------------------|
    | Interstellar               |
    | The Lunchbox               |
    | Parasite                   |
    | Ocean Deep                 |
    | The Prestige               |
    | Gully Boy                  |
    | Memento                    |
    | Zindagi Na Milegi Dobara   |
    | Silent Echo                |

#### ALL
- **ALL** → Compares a value to **every value** returned by a subquery.  
- Condition is **TRUE** only if it satisfies the comparison against **all rows** in the subquery result 
    - **PS**: *Retrieve all movie titles whose `RentalRate` is greater than **every rental rate** of movies belonging to `GenreID = 5`*
    ```sql
    SELECT Title FROM Movies
    WHERE  RentalRate > ALL (SELECT RentalRate FROM Movies WHERE GenreID = 5);
    ```
    - **Output:**

    | Title                   |
    |--------------------------|
    | Interstellar             |
    | The Lunchbox             |
    | Parasite                 |
    | The Prestige             |
    | Gully Boy                |
    | Memento                  |
    | Zindagi Na Milegi Dobara |
    | Silent Echo              |
    
    - `SOME` is a synonym for `ANY` in *MySQL*, *MSSQL* and *PostgreSQL* alike

### CASE: Used to apply conditional logic in queries, returning values based on **IF‑THEN‑ELSE** style 

```sql
SELECT Title,
       CASE WHEN RentalRate >= 140 THEN 'Premium'
            WHEN RentalRate >=  90 THEN 'Standard'
            ELSE 'Budget'
       END AS PriceBand
FROM Movies;
```
- **Output:**

| Title                   | PriceBand |
|--------------------------|-----------|
| Interstellar             | Premium   |
| The Lunchbox             | Standard  |
| Parasite                 | Premium   |
| Ocean Deep               | Budget    |
| The Prestige             | Standard  |
| Gully Boy                | Standard  |
| Memento                  | Budget    |
| Zindagi Na Milegi Dobara | Standard  |
| Blue Planet Voyage       | Budget    |
| Silent Echo              | Premium   |


- **PS** *Count the number of long films (>120 minutes) and short films (≤120 minutes) in each `GenreID` group.*
    ```sql
    SELECT   GenreID,
            SUM(CASE WHEN RuntimeMinutes >  120 THEN 1 ELSE 0 END) AS LongFilms,
            SUM(CASE WHEN RuntimeMinutes <= 120 THEN 1 ELSE 0 END) AS ShortFilms
    FROM     Movies
    GROUP BY GenreID;
    ```
    - **Output:**

    | GenreID | LongFilms | ShortFilms |
    |---------|-----------|------------|
    | 1       | 1         | 1          |
    | 2       | 1         | 1          |
    | 3       | 1         | 0          |
    | 4       | 2         | 1          |
    | 5       | 0         | 2          |

    


## Expected Output / Observations:
## Result / Conclusion:
## Learning Outcomes:
## Precautions / Cost Notes:
