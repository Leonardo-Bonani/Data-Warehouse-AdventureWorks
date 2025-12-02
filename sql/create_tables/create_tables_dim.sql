DROP TABLE IF EXISTS dbo.DimProduct;

CREATE TABLE dbo.DimProduct
    (
        ProductKey INT IDENTITY(1,1) PRIMARY KEY, -- surrogate key
        ProductAlternateKey NVARCHAR(25) NOT NULL, -- natural key
        ProductSubcategoryKey INT NULL,
        WeightUnitMeasureCode NCHAR(3) NULL,
        SizeUnitMeasureCode NCHAR(3) NULL,
        EnglishProductName NVARCHAR(50) NULL,
        SpanishProductName NVARCHAR(50) NULL,
        FrenchProductName NVARCHAR(50) NULL,
        StandardCost MONEY NULL,
        FinishedGoodsFlag BIT NULL,
        Color NVARCHAR(15) NULL,
        SafetyStockLevel SMALLINT NULL,
        ReorderPoint SMALLINT NULL,
        ListPrice MONEY NULL,
        Size NVARCHAR(50) NULL,
        SizeRange NVARCHAR(50) NULL,
        Weight FLOAT NULL,
        DaysToManufacture INT NULL,
        ProductLine NCHAR(2) NULL,
        DealerPrice MONEY NULL,
        Class NCHAR(2) NULL,
        Style NCHAR(2) NULL,
        ModelName NVARCHAR(50) NULL,
        LargePhoto VARBINARY(MAX) NULL,
        EnglishDescription NVARCHAR(400) NULL,
        FrenchDescription NVARCHAR(400) NULL,
        ChineseDescription NVARCHAR(400) NULL,
        ArabicDescription NVARCHAR(400) NULL,
        HebrewDescription NVARCHAR(400) NULL,
        ThaiDescription NVARCHAR(400) NULL,
        GermanDescription NVARCHAR(400) NULL,
        JapaneseDescription NVARCHAR(400) NULL,
        TurkishDescription NVARCHAR(400) NULL,

        StartDate DATETIME NULL,
        EndDate DATETIME NULL,
        Status NVARCHAR(20) NULL,

        CONSTRAINT UQ_DimProduct_ProductAltKey_Start UNIQUE (ProductAlternateKey, StartDate)
    );


DROP TABLE IF EXISTS dbo.DimProductSubcategory;

CREATE TABLE dbo.DimProductSubcategory
(
    ProductSubcategoryKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductSubcategoryAlternateKey INT NOT NULL,
    EnglishProductSubcategoryName NVARCHAR(50) NOT NULL,
    SpanishProductSubcategoryName NVARCHAR(50) NULL,
    FrenchProductSubcategoryName NVARCHAR(50) NULL,
    ProductCategoryKey INT NOT NULL
);


DROP TABLE IF EXISTS dbo.DimProductCategory;

CREATE TABLE dbo.DimProductCategory
(
    ProductCategoryKey             INT IDENTITY(1,1) NOT NULL,
    ProductCategoryAlternateKey    INT               NULL,
    EnglishProductCategoryName     NVARCHAR(50)      NULL,
    SpanishProductCategoryName     NVARCHAR(50)      NULL,
    FrenchProductCategoryName      NVARCHAR(50)      NULL,

    CONSTRAINT PK_DimProductCategory 
        PRIMARY KEY CLUSTERED (ProductCategoryKey)
);


