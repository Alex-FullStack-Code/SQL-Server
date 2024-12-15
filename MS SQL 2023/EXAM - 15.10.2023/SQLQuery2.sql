--------1
CREATE TABLE Countries (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL
);


CREATE TABLE Destinations (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    CountryId INT NOT NULL FOREIGN KEY REFERENCES Countries(Id)
   
);


CREATE TABLE Rooms (
    Id INT IDENTITY PRIMARY KEY,
    Type NVARCHAR(40) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    BedCount INT NOT NULL CHECK (BedCount > 0 AND BedCount <= 10)
);


CREATE TABLE Hotels (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    DestinationId INT NOT NULL FOREIGN KEY REFERENCES Destinations(Id), 

);


CREATE TABLE Tourists (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(80) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    Email NVARCHAR(80),
    CountryId INT NOT NULL FOREIGN KEY REFERENCES Countries(Id)
  
);


CREATE TABLE Bookings (
    Id INT IDENTITY PRIMARY KEY,
    ArrivalDate DATETIME2 NOT NULL,
    DepartureDate DATETIME2 NOT NULL,
    AdultsCount INT NOT NULL CHECK (AdultsCount >= 1 AND AdultsCount <= 10),
    ChildrenCount INT NOT NULL CHECK (ChildrenCount >= 0 AND ChildrenCount <= 9),
    TouristId INT NOT NULL  FOREIGN KEY REFERENCES Tourists(Id),
    HotelId INT NOT NULL FOREIGN KEY  REFERENCES Hotels(Id),
    RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id)
);


CREATE TABLE HotelsRooms (
    HotelId INT NOT NULL FOREIGN KEY REFERENCES Hotels(Id),
    RoomId INT NOT NULL FOREIGN KEY REFERENCES Rooms(Id),
    PRIMARY KEY (HotelId, RoomId),
);

--------2
INSERT INTO Tourists
([Name], PhoneNumber, Email, CountryId)
VALUES
  ('John Rivers', '653-551-1555', 'john.rivers@example.com', 6),
  ('Adeline Aglaé', '122-654-8726', 'adeline.aglae@example.com', 2),
  ('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com', 3),
  ('Johan Müller', '322-876-9826', 'j.muller@example.com', 7),
  ('Eden Smith', '551-874-2234', 'eden.smith@example.com', 6);

  --------3
 UPDATE Bookings
SET DepartureDate = DATEADD(DAY, 1, DepartureDate)
WHERE YEAR(ArrivalDate) = 2023 AND MONTH(ArrivalDate) = 12;
UPDATE Tourists
SET Email = NULL
WHERE [Name] LIKE '%MA%';

-------4
DELETE FROM Bookings
WHERE TouristId IN 
(
   	SELECT Id 
	FROM Tourists 
	WHERE [Name] LIKE '%Smith%'
);

DELETE FROM Tourists
WHERE [Name] LIKE '%Smith%';

-------5
SELECT
    FORMAT(ArrivalDate, 'yyyy-MM-dd') 
	AS ArrivalDate,
    AdultsCount,
    ChildrenCount
FROM Bookings
AS B
JOIN Rooms 
AS R 
ON B.RoomId = R.Id
ORDER BY R.Price DESC, ArrivalDate ASC;

-------6
SELECT H.Id, H.[Name]
FROM Hotels 
AS H
WHERE H.Id IN 
(
    SELECT HR.HotelId
    FROM HotelsRooms 
	AS HR
    JOIN Rooms
	AS R 
	ON HR.RoomId = R.Id
    WHERE R.Type = 'VIP Apartment'
)
ORDER BY (
    SELECT COUNT(*)
    FROM Bookings
	AS B
    WHERE B.HotelId = H.Id
) DESC;

----------7
SELECT T.Id, 
       T.[Name],
       T.PhoneNumber
FROM Tourists
AS T
LEFT JOIN Bookings
AS B
ON T.Id = B.TouristId
WHERE B.Id IS NULL
ORDER BY T.[Name] ASC;

----------8
SELECT TOP 10
    H.[Name]
	AS HotelName,
    D.[Name] 
	AS DestinationName,
    C.[Name] 
	AS CountryName
FROM Bookings 
AS B
JOIN Hotels
AS H 
ON B.HotelId = H.Id
JOIN Destinations
AS D 
ON H.DestinationId = D.Id
JOIN Countries
AS C 
ON D.CountryId = C.Id
WHERE B.ArrivalDate < '2023-12-31' AND H.Id % 2 = 1 
ORDER BY C.[Name] ASC, B.ArrivalDate ASC;

-------9
SELECT H.[Name] 
AS HotelName, 
R.Price 
AS RoomPrice
FROM Bookings 
AS B
JOIN Hotels
AS H 
ON B.HotelId = H.Id
JOIN Rooms 
AS R 
ON B.RoomId = R.Id
JOIN Tourists 
AS T 
ON B.TouristId = T.Id
WHERE T.[Name] NOT LIKE '%EZ'
ORDER BY R.Price DESC;

-------------10
SELECT H.[Name]
AS HotelName,
       SUM((DATEDIFF(day, B.ArrivalDate, B.DepartureDate)) * R.Price) 
	   AS TotalRevenue
FROM Bookings
AS B
JOIN Hotels
AS H
ON B.HotelId = H.Id
JOIN Rooms
AS R
ON B.RoomId = R.Id
GROUP BY H.[Name]
ORDER BY TotalRevenue DESC;

------11
CREATE FUNCTION udf_RoomsWithTourists(@roomType VARCHAR(40))
RETURNS INT
AS
BEGIN
    DECLARE @TotalTourists INT;
    
    SELECT @TotalTourists = SUM(B.AdultsCount + B.ChildrenCount)
    FROM Bookings
	AS B
    JOIN Rooms AS
	R 
	ON B.RoomId = R.Id
    WHERE R.Type = @roomType;

    IF @TotalTourists IS NULL
        SET @TotalTourists = 0;

    RETURN @TotalTourists;
END;

------------12
CREATE PROCEDURE usp_SearchByCountry
    @country NVARCHAR(50)
AS
BEGIN
    SELECT
        T.Name 
		AS Name,
        T.PhoneNumber 
		AS PhoneNumber,
        T.Email 
		AS Email,
        COUNT(B.Id)
		AS CountOfBookings
    FROM
        Tourists
		AS T
    JOIN
        Bookings
		AS B
		ON T.Id = B.TouristId
    JOIN
        Countries
		AS C
		ON T.CountryId = C.Id
    WHERE
        C.[Name] = @country
    GROUP BY
        T.Name, T.PhoneNumber, T.Email
    ORDER BY
        T.Name ASC, CountOfBookings DESC;
END;