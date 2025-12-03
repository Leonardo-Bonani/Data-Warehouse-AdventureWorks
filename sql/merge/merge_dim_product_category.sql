MERGE dbo.DimProductCategory AS tgt
USING dbo.stg_DimProductCategory AS src
    ON tgt.ProductCategoryAlternateKey = src.ProductCategoryAlternateKey
WHEN MATCHED THEN
    UPDATE SET
        tgt.EnglishProductCategoryName = src.EnglishProductCategoryName,
        tgt.SpanishProductCategoryName = src.SpanishProductCategoryName,
        tgt.FrenchProductCategoryName = src.FrenchProductCategoryName
WHEN NOT MATCHED BY TARGET THEN
    INSERT 
    (
        ProductCategoryAlternateKey,
        EnglishProductCategoryName,
        SpanishProductCategoryName,
        FrenchProductCategoryName
    )
    VALUES
    (
        src.ProductCategoryAlternateKey,
        src.EnglishProductCategoryName,
        src.SpanishProductCategoryName,
        src.FrenchProductCategoryName
    );
