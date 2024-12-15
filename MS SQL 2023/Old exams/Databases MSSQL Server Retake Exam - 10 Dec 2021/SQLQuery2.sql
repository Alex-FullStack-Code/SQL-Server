

-- Use the Airport database
USE Airport;

-- Create the Passengers table
CREATE TABLE Passengers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) UNIQUE NOT NULL,
    Email NVARCHAR(50) UNIQUE NOT NULL
);

-- Create the Pilots table
CREATE TABLE Pilots (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(30) UNIQUE NOT NULL,
    LastName NVARCHAR(30) UNIQUE NOT NULL,
    Age TINYINT CHECK (Age BETWEEN 21 AND 62) NOT NULL,
    Rating FLOAT CHECK (Rating BETWEEN 0.0 AND 10.0)
);

-- Create the AircraftTypes table
CREATE TABLE AircraftTypes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(30) UNIQUE NOT NULL
);

-- Create the Aircraft table
CREATE TABLE Aircraft (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Manufacturer NVARCHAR(25) NOT NULL,
    Model NVARCHAR(30) NOT NULL,
    Year INT NOT NULL,
    FlightHours INT,
    Condition CHAR(1) NOT NULL,
    TypeId INT NOT NULL,
    FOREIGN KEY (TypeId) REFERENCES AircraftTypes(Id)
);

-- Create the PilotsAircraft table
CREATE TABLE PilotsAircraft (
    AircraftId INT NOT NULL,
    PilotId INT NOT NULL,
    FOREIGN KEY (AircraftId) REFERENCES Aircraft(Id),
    FOREIGN KEY (PilotId) REFERENCES Pilots(Id),
	PRIMARY KEY(AircraftId, PilotId)
);

-- Create the Airports table
CREATE TABLE Airports (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AirportName NVARCHAR(70) UNIQUE NOT NULL,
    Country NVARCHAR(100) UNIQUE NOT NULL
);

-- Create the FlightDestinations table
CREATE TABLE FlightDestinations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    AirportId INT NOT NULL,
    Start DATETIME NOT NULL,
    AircraftId INT NOT NULL,
    PassengerId INT NOT NULL,
    TicketPrice DECIMAL(18, 2) DEFAULT 15.00 NOT NULL,
    FOREIGN KEY (AirportId) REFERENCES Airports(Id),
    FOREIGN KEY (AircraftId) REFERENCES Aircraft(Id),
    FOREIGN KEY (PassengerId) REFERENCES Passengers(Id)
);




INSERT INTO Passengers (FullName, Email)
SELECT
    CONCAT(P.FirstName, ' ', P.LastName) AS FullName,
    CONCAT(P.FirstName, P.LastName, '@gmail.com') AS Email
FROM Pilots P
WHERE P.Id BETWEEN 5 AND 15;



UPDATE Aircraft
SET Condition = 'A'
WHERE
(Condition IN ('C', 'B')AND FlightHours IS NULL)
OR (FlightHours <= 100 AND Year >= 2013);

DELETE FROM Passengers
WHERE LEN(FullName) <= 10;