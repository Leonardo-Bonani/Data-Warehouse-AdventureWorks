MERGE dbo.DimProductSubcategory AS tgt
USING dbo.stg_DimProductSubcategory AS src
    ON tgt.ProductSubcategoryAlternateKey = src.ProductSubcategoryAlternateKey
WHEN MATCHED THEN
    UPDATE SET
        tgt.EnglishProductSubcategoryName = src.EnglishProductSubcategoryName,
        tgt.SpanishProductSubcategoryName = src.SpanishProductSubcategoryName,
        tgt.FrenchProductSubcategoryName = src.FrenchProductSubcategoryName,
        tgt.ProductCategoryKey = src.ProductCategoryAlternateKey
WHEN NOT MATCHED BY TARGET THEN
    INSERT 
    (
        ProductSubcategoryAlternateKey,
        EnglishProductSubcategoryName,
        SpanishProductSubcategoryName,
        FrenchProductSubcategoryName,
        ProductCategoryKey
    )
    VALUES
    (
        src.ProductSubcategoryAlternateKey,
        src.EnglishProductSubcategoryName,
        src.SpanishProductSubcategoryName,
        src.FrenchProductSubcategoryName,
        src.ProductCategoryAlternateKey
    );
