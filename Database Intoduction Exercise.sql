
--1
CREATE DATABASE Minions; 


--2
CREATE TABLE Minions
(
	Id INT, 
	[Name] VARCHAR(100), 
	Age INT, 
	PRIMARY KEY(Id)
);


CREATE TABLE Towns(
	Id INT, 
	[Name] VARCHAR(100),
	PRIMARY KEY(Id)
);

--3
ALTER TABLE Minions 
ADD TownId INT;

ALTER TABLE Minions
ADD FOREIGN KEY(TownId) REFERENCES Towns(Id); 

--4
INSERT INTO Towns 
VALUES  (1, 'Sofia'),
		(2, 'Plovdiv'),
		(3, 'Varna');

INSERT INTO Minions 
VALUES (1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2);


--5
TRUNCATE TABLE Minions;

--6
DROP TABLE Minions;

DROP TABLE Towns;

--7
CREATE TABLE People(
Id INT PRIMARY KEY IDENTITY, 
[Name] NVARCHAR(200) NOT NULL, 
Picture VARBINARY(MAX),
Height DECIMAL(15,2),
[Weight] DECIMAL(15,2),
Gender CHAR(1) NOT NULL,
Birthdate DATE NOT NULL, 
Biography NTEXT
);

INSERT INTO People
VALUES ('Teodor', null, 175.60, 77, 'm', '5-20-2005', 'nothing'), 
('Teodor2', null, 175.60, 77, 'm', '5-20-2005', 'nothing'), 
('Teodor3', null, 175.60, 77, 'm', '5-20-2005', 'nothing'), 
('Teodor4', null, 175.60, 77, 'm', '5-20-2005', 'nothing'), 
('Teodor5', null, 175.60, 77, 'm', '5-20-2005', 'nothing');

--8
CREATE TABLE Users
(
Id BIGINT PRIMARY KEY IDENTITY,
Username VARCHAR(30) UNIQUE NOT NULL, 
[Password] VARCHAR(26),
ProfilePicture VARBINARY(MAX), 
LastLoginTime DATETIME2, 
IsDeleted BIT
);

INSERT INTO Users 
VALUES ('Pesho', '12342', null, '10-2-2001', 0), 
('Pesho2', '168592', null, '11-5-2011', 0), 
('Pesho3', '12882', null, '12-2-2022', 1), 
('Pesho4', '16782', null, '10-2-2003', 1), 
('Pesho5', '1234', null, '9-6-2004', 0); 

--9

ALTER TABLE Users DROP CONSTRAINT PK__Users__3214EC07C53641F2;
ALTER TABLE Users ADD CONSTRAINT PK_IdUsername PRIMARY KEY(Id, Username);

--10 
ALTER TABLE [Users] ADD CONSTRAINT CHK_PasswordMinLen CHECK(LEN([Password])>=5);

--11

ALTER TABLE Users ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR [LastLoginTime];

--12
ALTER TABLE Users DROP CONSTRAINT PK_IdUsername;
ALTER TABLE Users ADD CONSTRAINT PK_Id PRIMARY KEY(Id);
ALTER TABLE Users ADD CONSTRAINT UC_Username UNIQUE(Username);

--13
CREATE DATABASE Movies;

CREATE TABLE Directors
(
Id INT PRIMARY KEY, 
DirectorName VARCHAR(30) NOT NULL, 
Notes TEXT
);

CREATE TABLE Genres
(
Id INT PRIMARY KEY, 
GenreName VARCHAR(30) NOT NULL, 
Notes TEXT
);
CREATE TABLE Categories
(
Id INT PRIMARY KEY, 
CategoryName VARCHAR(30) NOT NULL, 
Notes TEXT
);

CREATE TABLE Movies
(
Id INT PRIMARY KEY, 
Title VARCHAR(30) NOT NULL, 
DirectorId INT, 
CopyrightYear INT NOT NULL,
[Length] TIME,
GenreId INT, 
CategoryId INT, 
Rating DECIMAL(12,2), 
Notes TEXT, 
FOREIGN KEY(DirectorId) REFERENCES Directors(Id), 
FOREIGN KEY(Genreid) REFERENCES Genres(Id), 
FOREIGN KEY(CategoryId) REFERENCES Categories(Id)
)

INSERT INTO Directors 
VALUES (1, 'Teodor1','The best of the best'), 
(2, 'Teodor2','The best of the best'), 
(3, 'Teodor3','The best of the best'), 
(4, 'Teodor4','The best of the best'), 
(5, 'Teodor5','The best of the best');

INSERT INTO Genres 
VALUES (1, 'Action', 'good genre'), 
(2, 'Drama', 'good genre'),
(3, 'Melodrama', 'good genre'),
(4, 'Soap opera', 'good genre'),
(5, 'Comedy', 'good genre');

INSERT INTO Categories 
VALUES (1, 'One', 'one is good'), 
(2, 'Two', 'two is better than one '), 
(3, 'Three', 'three is beteer than two'),
(4, 'Four', 'four is better than three'), 
(5, 'Five', 'five is the best');

INSERT INTO Movies 
VALUES (1, 'Star wars', 2, 1977, '2:20:29', 1, 5, 9.8, 'the best film ever'), 
(2, 'Star wars 2', 3, 1977, '2:20:29', 3, 4, 8.7, 'one of good films'), 
(3, 'Star wars 3', 4, 1977, '2:20:29', 2, 4, 8.3, 'one of good films'), 
(4, 'Star wars 4', 5, 1977, '2:20:29', 4, 3, 9.0, 'one of the best films'), 
(5, 'Star wars 5', 1, 1977, '2:20:29', 5, 4, 9.1, 'one of the best films');


GO

CREATE DATABASE CarRental;

GO;

USE CarRental;

CREATE TABLE Categories(
Id INT PRIMARY KEY,
CategoryName VARCHAR(40) NOT NULL, 
DailyRate DECIMAL(5,2) NOT NULL, 
WeeklyRate DECIMAL(5,2) NOT NULL, 
[MonthlyRate] DECIMAL(5,2) NOT NULL, 
[WeekendRate] DECIMAL(5,2) NOT NULL
)

CREATE TABLE Cars(
Id INT PRIMARY KEY, 
PlateNumber VARCHAR(30) NOT NULL, 
Manufacturer VARCHAR(40) NOT NULL, 
Model VARCHAR(30) NOT NULL, 
CarYear INT NOT NULL, 
CategoryId INT FOREIGN KEY REFERENCES Categories(Id), 
Doors INT NOT NULL, 
Picture VARBINARY(MAX), 
Codition VARCHAR(40), 
Available BIT NOT NULL
)

CREATE TABLE Employees (
Id INT PRIMARY KEY, 
[FirstName] VARCHAR(30) NOT NULL, 
[LastName] VARCHAR(30) NOT NULL, 
[Title] VARCHAR(50) NOT NULL,
[Notes] TEXT, 

)

CREATE TABLE Customers(
Id INT PRIMARY KEY, 
[DriverLicenceNumber] VARCHAR(30) NOT NULL, 
[FullName] VARCHAR(60) NOT NULL, 
[Address] VARCHAR(70) NOT NULL, 
[City] VARCHAR(40) NOT NULL, 
[ZIPCode] VARCHAR(10) NOT NULL, 
[Notes] TEXT

)

CREATE TABLE RentalOrders(
Id INT PRIMARY KEY, 
[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id), 
[CustomerId] INT FOREIGN KEY REFERENCES Customers(Id), 
[CarId] INT FOREIGN KEY REFERENCES Cars(Id), 
[TankLevel] INT NOT NULL, 
[KilometrageStart] INT, 
[KilometrageEnd] INT NOT NULL, 
[TotalKilometrage] INT NOT NULL, 
[StartDate] DATE NOT NULL, 
[EndDate] DATE NOT NULL, 
[TotalDays] INT NOT NULL, 
[RateApplied] DECIMAL(5,2) NOT NULL, 
[TaxRate] DECIMAL(5,2) NOT NULL, 
[OrderStatus] VARCHAR(30) NOT NULL, 
[Notes] TEXT NOT NULL

)

GO
INSERT INTO Categories 
VALUES (1, 'Category1', 3.4, 7.6, 10.8, 3.2), 
(2, 'Category2', 3.1, 7.5, 10.2, 2.9), 
(3, 'Category3', 3.3, 7.2, 10.0, 3.1);

GO

INSERT INTO Cars 
VALUES (1, 'ST1256HA', 'Audi', 'A8', 2020, 1, 4, null, 'perfect', 1),
 (2, 'ST7852HA', 'BMV', 'X5', 2019, 3, 4, null, 'extremaly bad', 0),
  (3, 'ST1478HA', 'Mercedes', 'AMG', 2021, 2, 4, null, 'perfect', 1);


INSERT INTO Employees 
VALUES (1, 'Ivan', 'Petrov', 'Engineer', 'the best worker'), 
(2, 'Petur', 'Petrov', 'Cleaner', 'good worker'), 
(3, 'George', 'Petrov', 'Plumber', 'good worker');

INSERT INTO Customers
VALUES (1, '03802084', 'Geogi Ivanov', 'ul. Ne znam 3', 'OtKudeDaGoZnam', 6969, null), 
(2, '93469104', 'Petko Ivanov', 'ul. Znam 3', 'OtKudeDaGoZnam', 3214, null), 
(3, '04856952', 'Pomak Koprinka', 'ul. Pomak 3', 'Koprinka', 5050, null);


INSERT INTO RentalOrders
VALUES (1, 1, 3, 2, 4, 2000, 50000, 12000, '12-10-2020', '10-9-2021', 350, 3, 100.5, 'APPLIED', 'BAD CAR')
,(2, 1, 3, 2, 4, 2000, 50000, 12000, '12-10-2020', '10-9-2021', 350, 3, 100.5, 'APPLIED', 'BAD CAR'),
(3, 1, 3, 2, 4, 2000, 50000, 12000, '12-10-2020', '10-9-2021', 350, 3, 100.5, 'APPLIED', 'BAD CAR');


CREATE DATABASE Hotel; 

USE Hotel;
CREATE TABLE Employees (
Id INT PRIMARY KEY, 
[FirstName] VARCHAR(30) NOT NULL, 
[LastName] VARCHAR(30) NOT NULL, 
[Title] VARCHAR(50) NOT NULL,
[Notes] TEXT, 

)

CREATE TABLE [Customers]
(
[AccountNumber] INT PRIMARY KEY, 
[FirstName] VARCHAR(30) NOT NULL, 
[LastName] VARCHAR(30) NOT NULL, 
[PhoneNumber] VARCHAR(10) NOT NULL, 
[EmergencyName] VARCHAR(30) NOT NULL, 
[EmergencyNumber] VARCHAR(30) NOT NULL, 
[Notes] TEXT

)

CREATE TABLE RoomStatus
(
[RoomStatus] VARCHAR(30) NOT NULL, 
[Notes] TEXT 
)

CREATE TABLE RoomTypes
(
[RoomType]VARCHAR(30) NOT NULL, 
[Notes] TEXT
)
CREATE TABLE BedTypes
(
[BedType] VARCHAR(40) NOT NULL, 
[Notes] TEXT
)
CREATE TABLE Rooms
(
[RoomNumber] INT PRIMARY KEY, 
[RoomType] VARCHAR(30) NOT NULL, 
[BedType] VARCHAR(30) NOT NULL, 
[Rate] SMALLINT, 
[RoomStatus] VARCHAR(30) NOT NULL, 
[Notes] TEXT
)

CREATE TABLE Payments
(
	Id INT PRIMARY KEY,
    EmployeeId INT NOT NULL,
    PaymentDate DATETIME2 NOT NULL,
    AccountNumber INT NOT NULL,
    FirstDateOccupied DATETIME2 NOT NULL,
    LastDateOccupied DATETIME2 NOT NULL,
    TotalDays INT,
    AmountCharged DECIMAL(15,2),
    TaxRate INT,
    TaxAmount DECIMAL,
    PaymentTotal DECIMAL(15,2),
    Notes NVARCHAR(MAX)
)

CREATE TABLE Occupancies 
(
	Id INT PRIMARY KEY,
    EmployeeId INT NOT NULL,
    DateOccupied DATETIME2,
    AccountNumber CHAR(16),
    RoomNumber INT NOT NULL,
    RateApplied INT ,
    PhoneCharge DECIMAL(15,2),
    Notes NVARCHAR(MAX)
)

INSERT INTO Employees 
VALUES 
(1, 'Ivan', 'Grigorov', 'Engineer', 'good worker'), 
(2, 'Antim', 'Pomaka', 'Fiddler', 'the worst worker'), 
(3, 'Petur', 'Grigorov', 'Engioneer', 'good worker')

INSERT INTO Customers
VALUES 
(12, 'Alive', 'Aliev', '08889782', 'Ali', 43, 'custom'), 
(13, 'Pomakis', 'Koprinkov', '0888443782', 'Pomak', 53, 'custom pomak'), 
(14, 'Mangal', 'Yamak', '0888925', 'Mango',33, 'custom mangal')

INSERT INTO RoomStatus
VALUES ('taken', null), 
	   ('available', null), 
	   ('under repair', null) 


INSERT INTO RoomTypes
VALUES ('single', null), 
('double', null), 
('appartment', null)

INSERT INTO BedTypes
VALUES ('single', null), 
('big', null), 
('double', null)

INSERT INTO Rooms
VALUES (203, 'apartment', 'double', 5, 'available', null), 
(105, 'single', 'single', 4, 'available', null), 
(103, 'double', 'double', 4, 'taken', null)

INSERT INTO Payments
VALUES (1, 2, GETDATE(), 34532, GETDATE(), GEtDATE(), 350, 323, 45, 32, 594, null) ,
(2, 1, GETDATE(), 37532, GETDATE(), GEtDATE(), 350, 330, 45, 32, 594, null) , 
(3, 3, GETDATE(), 32532, GETDATE(), GEtDATE(), 350, 325, 45, 32, 594, null)


INSERT INTO Occupancies
VALUES (1, 2, GETDATE(), 395803, 103, 45, 90, NULL), 
(2, 2, GETDATE(), 39403, 105, 40, 40, NULL), 
(3, 1, GETDATE(), 3978, 203, 43, 91, NULL)



CREATE DATABASE SoftUni;

USE SoftUni; 



CREATE TABLE Towns
(
Id INT PRIMARY KEY IDENTITY, 
[Name] VARCHAR(30) NOT NULL, 

)

CREATE TABLE Addresses
(
Id INT PRIMARY KEY IDENTITY, 
[AddressText] VARCHAR(40) NOT NULL, 
[TownId] INT FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments
(
[Id] INT PRIMARY KEY IDENTITY, 
[Name] VARCHAR(40) NOT NULL, 

)

CREATE TABLE Employees
(
Id INT PRIMARY KEY IDENTITY, 
[FirstName] VARCHAR(40) NOT NULL, 
[MiddleName] VARCHAR(40) NOT NULL,
[LastName] VARCHAR(40) NOT NULL, 
[JobTitle] VARCHAR(40) NOT NULL,
[DepartmentId] INT FOREIGN KEY REFERENCES Departments(Id),
[HireDate] DATE NOT NULL, 
[Salary] DECIMAL, 
[AddressId] INT FOREIGN KEY REFERENCES Addresses(Id)

)

INSERT INTO Towns
VALUES ('Sofia'), 
('Plovdiv'), 
('Varna'), 
('Burgas')

INSERT INTO Departments
VALUES ('Engineering'), 
('Sales'), 
('Marketing'), 
('Software Development'), 
('Quality Assurance')

INSERT INTO Addresses
VALUES ('nowhere' ,1), 
('nowhere' ,2),
('nowhere' ,3)

INSERT INTO Employees
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4,'01/02/2013', 3500.00, 1), 
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1,'02/03/2004', 4000.00, 2), 
('Maria ', 'Petrova', 'Ivanova', 'Intern', 5,'28/08/2016', 525.25, 3), 
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2,'09/12/2007', 3000.00, 1), 
('Peter', 'Pan', 'Pan', 'Intern', 3,'28/08/2016', 599.88, 3)