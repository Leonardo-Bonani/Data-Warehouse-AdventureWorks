ALTER TABLE dbo.FactProductInventory
ADD CONSTRAINT FK_FactProductInventory_Product
    FOREIGN KEY (ProductKey) REFERENCES dbo.DimProduct(ProductKey);

ALTER TABLE dbo.FactProductInventory
ADD CONSTRAINT FK_FactProductInventory_Date
    FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey);
