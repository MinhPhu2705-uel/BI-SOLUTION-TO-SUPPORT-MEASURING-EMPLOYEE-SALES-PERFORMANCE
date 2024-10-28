ALTER TABLE [gold].[Fact_SalesTransaction]
ADD SalesAmount money
UPDATE [gold].[Fact_SalesTransaction] SET SalesAmount = OrderQty * UnitPrice

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD Revenue money
UPDATE [gold].[Fact_SalesTransaction] SET Revenue = SalesAmount - StandardCost

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD ConversionRate Decimal(10,2)
UPDATE [gold].[Fact_SalesTransaction] SET ConversionRate = (SELECT COUNT(Status) FROM [gold].[Fact_SalesTransaction] WHERE Status = '3')*100/(SELECT COUNT(*) from [gold].[Fact_SalesTransaction])

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD AverageSalesEachEmp Decimal(10,2)

UPDATE [gold].[Fact_SalesTransaction]
SET AverageSalesEachEmp = (
    SELECT SUM(SalesAmount) / COUNT(DISTINCT YEAR(Date))
    FROM [gold].[Fact_SalesTransaction] AS sub
    WHERE sub.EmployeeKey = [gold].[Fact_SalesTransaction].EmployeeKey
);

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD AverageDealSize Decimal(10,2)
UPDATE [gold].[Fact_SalesTransaction]
SET AverageDealSize = (
    SELECT SUM(SalesAmount) / COUNT(DISTINCT SalesOrderID)
    FROM [gold].[Fact_SalesTransaction]
	)

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD SalesQuota money 
UPDATE [gold].[Fact_SalesTransaction]
SET SalesQuota = 6655000 WHERE Year(Date) = 2014

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD KPISales Decimal(10,2)
UPDATE [gold].[Fact_SalesTransaction]
SET KPISales = (SELECT SUM(SalesAmount) * 100 FROM [gold].[Fact_SalesTransaction] as sub
				WHERE sub.EmployeeKey = [gold].[Fact_SalesTransaction].EmployeeKey) / SalesQuota
				
UPDATE [gold].[Fact_SalesTransaction]
SET AverageSalesEachEmp = (
    SELECT SUM(SalesAmount) FROM [gold].[Fact_SalesTransaction] AS sub
    WHERE sub.EmployeeKey = [gold].[Fact_SalesTransaction].EmployeeKey / SalesAmount
);

ALTER TABLE [gold].[Fact_SalesTransaction]
ADD AverageNoCustomer Decimal(10,2)
UPDATE [gold].[Fact_SalesTransaction]
SET  AverageNoCustomer = (SELECT  COUNT(distinct CustomerID)/COUNT(distinct EmployeeKey) from [gold].[Fact_SalesTransaction])