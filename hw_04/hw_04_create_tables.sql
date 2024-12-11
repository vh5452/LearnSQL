-- 1. Створити базу даних за діаграмою (у вкладенні зображення)
CREATE TABLE Language (
    Id     SMALLINT IDENTITY(1, 1),
    Name   NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Language
        PRIMARY KEY (Id),
    CONSTRAINT UQ_Language
        UNIQUE (Name)
);

CREATE TABLE Continent
(
    Id   TINYINT IDENTITY (1, 1),
    Name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Continent
        PRIMARY KEY (Id),
    CONSTRAINT UQ_Continent
        UNIQUE (Name)
);

CREATE TABLE Currency
(
    Id   SMALLINT IDENTITY (1, 1),
    Name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Currency
        PRIMARY KEY (Id),
    CONSTRAINT UQ_Currency
        UNIQUE (Name)
);

CREATE TABLE Country
(
    Id          SMALLINT IDENTITY (1, 1),
    Name        NVARCHAR(100) NOT NULL,
    ContinentId TINYINT,
    Capital     NVARCHAR(100) NOT NULL,
    Territory   FLOAT NOT NULL,
    CurrencyId  SMALLINT,
    Debut       BIT,
    Champion    SMALLINT,
    CONSTRAINT PK_Country
        PRIMARY KEY (Id),
    CONSTRAINT UQ_Country_name
        UNIQUE (Name),
    CONSTRAINT UQ_Country_capital
        UNIQUE (Capital),
    FOREIGN KEY (ContinentId)
        REFERENCES Continent(Id),
    FOREIGN KEY (CurrencyId)
        REFERENCES Currency(Id)

);

CREATE TABLE CountryLanguage (
    Id          SMALLINT IDENTITY(1, 1),
    CountryId   SMALLINT,
    LanguageId  SMALLINT,
    FOREIGN KEY (CountryId)
        REFERENCES Country(Id),
    FOREIGN KEY (LanguageId)
        REFERENCES Language(Id)
);
