
TRUNCATE TABLE dbo.stg_DimProduct;

DECLARE @LoadDate DATETIME = GETDATE();

INSERT INTO dbo.stg_DimProduct
(
    ProductAlternateKey,
    ProductSubcategoryKey,
    WeightUnitMeasureCode,
    SizeUnitMeasureCode,
    EnglishProductName,
    SpanishProductName,
    FrenchProductName,
    StandardCost,
    FinishedGoodsFlag,
    Color,
    SafetyStockLevel,
    ReorderPoint,
    ListPrice,
    Size,
    SizeRange,
    Weight,
    DaysToManufacture,
    ProductLine,
    DealerPrice,
    Class,
    Style,
    ModelName,
    LargePhoto,
    EnglishDescription,
    FrenchDescription,
    ChineseDescription,
    ArabicDescription,
    HebrewDescription,
    ThaiDescription,
    GermanDescription,
    JapaneseDescription,
    TurkishDescription,
    SellStartDate,
    SellEndDate,
    Status
)
SELECT
    p.ProductNumber AS ProductAlternateKey,
    p.ProductSubcategoryID,
    p.WeightUnitMeasureCode,
    p.SizeUnitMeasureCode,
    p.Name AS EnglishProductName,
    NULL AS SpanishProductName,
    NULL AS FrenchProductName,
    p.StandardCost,
    p.FinishedGoodsFlag,
    p.Color,
    p.SafetyStockLevel,
    p.ReorderPoint,
    p.ListPrice,
    p.Size,
    NULL AS SizeRange,
    p.Weight,
    p.DaysToManufacture,
    p.ProductLine,
    NULL AS DealerPrice,
    p.Class,
    p.Style,
    pm.Name AS ModelName,
    ph.LargePhoto,
    NULL AS EnglishDescription,
    NULL AS FrenchDescription,
    NULL AS ChineseDescription,
    NULL AS ArabicDescription,
    NULL AS HebrewDescription,
    NULL AS ThaiDescription,
    NULL AS GermanDescription,
    NULL AS JapaneseDescription,
    NULL AS TurkishDescription,
    p.SellStartDate,
    p.SellEndDate,
    CASE
        WHEN p.SellEndDate IS NOT NULL AND p.SellEndDate < @LoadDate THEN 'Discontinued'
        ELSE 'Current'
    END AS Status
FROM
    AdventureWorks2022.Production.Product p
LEFT JOIN
    AdventureWorks2022.Production.ProductModel pm
    ON p.ProductModelID = pm.ProductModelID
LEFT JOIN
    (
      SELECT pp.ProductID, pph.LargePhoto
      FROM AdventureWorks2022.Production.ProductProductPhoto pp
      JOIN AdventureWorks2022.Production.ProductPhoto pph
        ON pp.ProductPhotoID = pph.ProductPhotoID
    ) ph ON p.ProductID = ph.ProductID;

