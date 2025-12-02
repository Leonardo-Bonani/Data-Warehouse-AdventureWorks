DROP TABLE IF EXISTS dbo.FactProductInventory;

CREATE TABLE dbo.FactProductInventory
(
    ProductKey INT NOT NULL,
    DateKey INT NOT NULL,
    MovementDate DATE NOT NULL,
    UnitCost money  NULL,				
	UnitsIn	int	 NULL,			
	UnitsOut int  NULL,				
	UnitsBalance int  NULL
    CONSTRAINT PK_FactProductInventory
        PRIMARY KEY (ProductKey, DateKey)
);
