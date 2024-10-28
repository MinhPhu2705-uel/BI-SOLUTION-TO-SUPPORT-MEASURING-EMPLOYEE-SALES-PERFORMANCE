ALTER TABLE [gold].[Fact_EmployeeShifts]
ADD AveragePayroll DECIMAL(10,2)
UPDATE [gold].[Fact_EmployeeShifts] SET  AveragePayroll = (Select AVG(PayrollRate) from [gold].[Fact_EmployeeShifts])


ALTER TABLE [gold].[Fact_EmployeeShifts]
ADD Age smallint 
UPDATE [gold].[Fact_EmployeeShifts] SET Age = 2011 - YEAR(Birthdate)

ALTER TABLE [gold].[Fact_EmployeeShifts]
ADD MaleRate Decimal(10,2)
UPDATE [gold].[Fact_EmployeeShifts] SET MaleRate = (Select Count(Gender) from [gold].[Fact_EmployeeShifts] where Gender = 'M')*100 / (SELECT COUNT(EmployeeKey) from [gold].[Fact_EmployeeShifts])

ALTER TABLE [gold].[Fact_EmployeeShifts]
ADD AverageAge Decimal(10,2)
UPDATE [gold].[Fact_EmployeeShifts] SET AverageAge = (SELECT AVG(Age) from [gold].[Fact_EmployeeShifts])

