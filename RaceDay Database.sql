/*
    RaceDay System
    Section C: SQL Database Script
*/
CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO
-- =============================================
-- USERS TABLE
-- =============================================

CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Organizer', 'Participant'))
);
GO


-- =============================================
-- ORGANIZER TABLE
-- =============================================

CREATE TABLE Organizer
(
    OrganizerID INT IDENTITY(1,1) PRIMARY KEY,

    UserID INT NOT NULL UNIQUE,

    Organisation NVARCHAR(100) NOT NULL,

    Website NVARCHAR(255) NULL,

    CONSTRAINT FK_Organizer_User
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID)
);
GO

-- =============================================
-- PARTICIPANT TABLE
-- =============================================

CREATE TABLE Participant
(
    ParticipantID INT IDENTITY(1,1) PRIMARY KEY,

    UserID INT NOT NULL UNIQUE,

    DateOfBirth DATE NOT NULL,

    Gender NVARCHAR(30) NOT NULL,

    PhoneNumber NVARCHAR(20) NULL,

    EmergencyContact NVARCHAR(100) NOT NULL,

    CONSTRAINT FK_Participant_User
        FOREIGN KEY (UserID)
        REFERENCES Users(UserID)
);
GO

-- =============================================
-- EVENT TABLE
-- =============================================

CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,

    OrganizerID INT NOT NULL,

    Name NVARCHAR(150) NOT NULL,

    Description NVARCHAR(500) NULL,

    EventDate DATE NOT NULL,

    StartTime TIME NOT NULL,

    Location NVARCHAR(200) NOT NULL,

    EventType NVARCHAR(50) NOT NULL,

    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_Event_Status DEFAULT 'Upcoming',

    CONSTRAINT FK_Event_Organizer
        FOREIGN KEY (OrganizerID)
        REFERENCES Organizer(OrganizerID)
);
GO

-- =============================================
-- CATEGORY TABLE
-- =============================================

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    Name NVARCHAR(100) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL,

    AgeGroup NVARCHAR(50) NOT NULL,

    Price DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT CK_Category_Distance
        CHECK (Distance > 0),

    CONSTRAINT CK_Category_Price
        CHECK (Price >= 0),

    CONSTRAINT UQ_Category_Event_Name
        UNIQUE (EventID, Name),

    CONSTRAINT UQ_Category_CategoryID_EventID
        UNIQUE (CategoryID, EventID)
);
GO

-- =============================================
-- ENROLMENT TABLE
-- =============================================

CREATE TABLE Enrolment
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,

    ParticipantID INT NOT NULL,

    EventID INT NOT NULL,

    CategoryID INT NOT NULL,

    EnrolmentDate DATE NOT NULL
        CONSTRAINT DF_Enrolment_Date DEFAULT CAST(GETDATE() AS DATE),

    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_Enrolment_Status DEFAULT 'Confirmed',

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participant(ParticipantID),

    CONSTRAINT FK_Enrolment_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT FK_Enrolment_Category_Event
        FOREIGN KEY (CategoryID, EventID)
        REFERENCES Category(CategoryID, EventID),

    CONSTRAINT UQ_Participant_Event
        UNIQUE (ParticipantID, EventID)
);
GO

-- =============================================
-- RESULT TABLE
-- =============================================

CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,

    EnrolmentID INT NOT NULL UNIQUE,

    FinishTime TIME NULL,

    Position INT NULL,

    ResultStatus NVARCHAR(30) NOT NULL
        CONSTRAINT DF_Result_Status DEFAULT 'Completed',

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolment(EnrolmentID),

    CONSTRAINT CK_Result_Position
        CHECK (Position IS NULL OR Position > 0)
);
GO

-- =============================================
-- SEED DATA: USERS
-- =============================================

INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role, PhoneNumber)
VALUES
    ('Thabo', 'Mokoena', 'thabo.mokoena@gmail.com',
     'HASHED_PASSWORD_001', 'Organizer', '071739763'),

    ('Lerato', 'Dlamini', 'lerato.dlamini@icloud.com',
     'HASHED_PASSWORD_002', 'Organizer', '0728965423'),

    ('Sipho', 'Nkosi', 'sipho.nkosi@gmail.com',
     'HASHED_PASSWORD_003', 'Participant', '0739875643'),

    ('Amahle', 'Mthembu', 'amahle.mthembu@e.com',
     'HASHED_PASSWORD_004', 'Participant', '0749098763');
GO

-- =============================================
-- SEED DATA: ORGANIZERS
-- =============================================

INSERT INTO Organizer
    (UserID, Organisation, Website)
VALUES
    (1, 'Johannesburg Race Events',
     'https://www.jhbraces.example.com'),

    (2, 'Gauteng Athletics Events',
     'https://www.gautengathletics.example.com');
GO

-- =============================================
-- SEED DATA: PARTICIPANTS
-- =============================================

INSERT INTO Participant
    (UserID, DateOfBirth, Gender, PhoneNumber, EmergencyContact)
VALUES
    (3, '2001-05-14', 'Male',
     '0723647856', 'Nomsa Nkosi - 0828948764'),

    (4, '2002-09-22', 'Female',
     '0748998373', 'Sibusiso Mthembu - 0873625132');
GO

-- =============================================
-- SEED DATA: EVENTS
-- =============================================

INSERT INTO Event
    (OrganizerID, Name, Description, EventDate, StartTime,
     Location, EventType, Status)
VALUES
    (1,
     'Joburg City Run',
     'A running event for active and competitive runners.',
     '2026-10-18',
     '07:00',
     'Johannesburg CBD',
     'Road Race',
     'Upcoming'),

    (1,
     'Vaal River Trail Challenge',
     'A relaxed trail running event along the Vaal River.',
     '2026-11-08',
     '06:30',
     'Vanderbijlpark',
     'Trail Run',
     'Upcoming'),

    (2,
     'Pretoria Spring Run',
     'A community running event offering multiple race distances.',
     '2026-09-27',
     '07:00',
     'Pretoria',
     'Road Race',
     'Upcoming');
GO

-- =============================================
-- SEED DATA: CATEGORIES
-- =============================================

INSERT INTO Category
    (EventID, Name, Distance, AgeGroup, Price)
VALUES
    (1, '5 KM Fun Run', 5.00, 'All Ages', 80.00),
    (1, '10 KM Race', 10.00, '18+', 150.00),

    (2, '10 KM Trail', 10.00, '18+', 180.00),
    (2, '21 KM Trail', 21.00, '18+', 250.00),

    (3, '5 KM Fun Run', 5.00, 'All Ages', 70.00),
    (3, '10 KM Race', 10.00, '18+', 140.00);
GO

-- =============================================
-- SEED DATA: ENROLMENTS
-- =============================================

INSERT INTO Enrolment
    (ParticipantID, EventID, CategoryID, EnrolmentDate, Status)
VALUES
    (1, 1, 1, '2026-09-10', 'Confirmed'),

    (1, 2, 3, '2026-09-11', 'Confirmed'),

    (2, 1, 2, '2026-09-12', 'Confirmed'),

    (2, 3, 5, '2026-09-13', 'Confirmed');
GO

-- =============================================
-- SEED DATA: RESULTS
-- =============================================

INSERT INTO Result
    (EnrolmentID, FinishTime, Position, ResultStatus)
VALUES
    (1, '00:28:42', 14, 'Completed');
GO

-- =============================================
-- DATABASE VERIFICATION
-- =============================================

SELECT * FROM Users;

SELECT * FROM Organizer;

SELECT * FROM Participant;

SELECT * FROM Event;

SELECT * FROM Category;

SELECT * FROM Enrolment;

SELECT * FROM Result;
GO

