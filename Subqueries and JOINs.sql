USE [SoftUni]
 
GO
 
-- Grouping Demo
  SELECT [JobTitle],
         AVG([Salary])
      AS [AverageSalary],
         COUNT([EmployeeID])
      AS [WorkersCount]
    FROM [Employees]
GROUP BY [JobTitle]
  HAVING AVG([Salary]) > 20000
 
-- Problem 01
   SELECT 
  TOP (5) [e].[EmployeeID],
          [e].[JobTitle],
          [e].[AddressID],
          [a].[AddressText]
     FROM [Employees]
       AS [e]
LEFT JOIN [Addresses]
       AS [a]
       ON [e].[AddressID] = [a].[AddressID]
 ORDER BY [e].[AddressID]

 -- Problem 02

	SELECT 
   TOP(50) [e].[FirstName],
		   [e].[LastName], 
		   [t].[Name], 
		   [a].[AddressText]
      FROM [Employees]
	    AS [e]
INNER JOIN [Addresses]
		AS [a]
		ON [e].[AddressID] = [a].[AddressID]
INNER JOIN [Towns]
		AS [t]
		ON [t].[TownID] = [a].[TownID]
  ORDER BY [e].[FirstName], [e].[LastName] 

 -- Problem 03 
    SELECT [e].[EmployeeID], 
		   [e].[FirstName], 
		   [e].[LastName], 
		   [d].[Name]
      FROM [Employees]
	    AS [e]
INNER JOIN [Departments]
		AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
	 WHERE [d].[Name] = 'Sales' 
  ORDER BY [e].[EmployeeID] ASC

  -- Problme 04

    SELECT
	TOP (5) [e].[EmployeeID], 
		    [e].[FirstName], 
		    [e].[Salary], 
		    [d].[Name]
		 AS [DepartmentName]
       FROM [Employees]
	     AS [e]
 INNER JOIN [Departments]
 		 AS [d]
		 ON [e].[DepartmentID] = [d].[DepartmentID]
	  WHERE [e].[Salary] > 15000
   ORDER BY [e].[DepartmentID] 


-- Problem 05
   SELECT 
  TOP (3) [e].[EmployeeID],
          [e].[FirstName]
     FROM [Employees]
       AS [e]
LEFT JOIN [EmployeesProjects]
       AS [ep]
       ON [e].[EmployeeID] = [ep].[EmployeeID]
    WHERE [ep].[ProjectID] IS NULL
 ORDER BY [e].[EmployeeID]

 -- Problem 06

    SELECT [e].[FirstName], 
		   [e].[LastName], 
		   [e].[HireDate], 
		   [d].[Name]
		AS [DeptName]
      FROM [Employees]
	    AS [e]
INNER JOIN [Departments]
		AS [d]
		ON [d].[DepartmentID] = [e].[DepartmentID]
	 WHERE [e].[HireDate] > '1.1.1999' AND
		   [d].[Name] IN ('Sales', 'Finance')

 
-- Problem 07
    SELECT 
   TOP (5) [e].[EmployeeID],
           [e].[FirstName],
           [p].[Name]
        AS [ProjectName]
      FROM [EmployeesProjects]
        AS [ep]
INNER JOIN [Employees]
        AS [e]
        ON [ep].[EmployeeID] = [e].[EmployeeID]
INNER JOIN [Projects]
        AS [p]
        ON [ep].[ProjectID] = [p].[ProjectID]
     WHERE [p].[StartDate] > '08/13/2002' AND [p].[EndDate] IS NULL
  ORDER BY [e].[EmployeeID]


-- Problem 08

    SELECT [e].[EmployeeID], 
		   [e].[FirstName], 
		   CASE 
				WHEN YEAR([p].[StartDate]) >= 2005 THEN NULL
				ELSE [p].[Name]
			END
		AS [ProjectName]
      FROM [Employees]
   	    AS [e]
INNER JOIN [EmployeesProjects]
		AS [ep]
		ON [e].[EmployeeID] = [ep].[EmployeeID]
INNER JOIN [Projects]
		AS [p]
		ON [p].[ProjectID] = [ep].[ProjectID]
	 WHERE [e].[EmployeeID] = 24

 
-- Problem 09
    SELECT [e].[EmployeeID],
           [e].[FirstName],
           [e].[ManagerID],
           [m].[FirstName]
        AS [ManagerName]
      FROM [Employees]
        AS [e]
INNER JOIN [Employees]
        AS [m]
        ON [e].[ManagerID] = [m].[EmployeeID]
     WHERE [e].[ManagerID] IN (3, 7)
  ORDER BY [e].[EmployeeID]

 -- Problem 10

    SELECT 
  TOP (50) [e].[EmployeeID],
           CONCAT([e].[FirstName], ' ', [e].[LastName])
		AS [EmployeeName], 
		   CONCAT([m].[FirstName], ' ', [m].[LastName])
		AS [ManagerName], 
		   [d].[Name] 
		AS [DepartmentName]
      FROM [Employees]
	    AS [e]
INNER JOIN [Employees]
        AS [m]
		ON [e].[ManagerID] = [m].[EmployeeID]
INNER JOIN [Departments]
		AS [d]
		ON [e].[DepartmentID] = [d].[DepartmentID]
  ORDER BY [e].[EmployeeID]

 -- Problem 11

SELECT MIN(AverageSalary) 
  FROM
	  (
			  SELECT AVG([e].[Salary])
				AS [AverageSalary]
			  FROM [Employees]
				AS [e]
		INNER JOIN [Departments]
				AS [d]
				ON [e].[DepartmentID] = [d].[DepartmentID]
		  GROUP BY [e].[DepartmentID] 
	   ) AS [DepartmentsAVGSalary]
	   
   
	

 
GO
 
USE [Geography]
 
GO
 
-- Problem 12
    SELECT [mc].[CountryCode],
           [m].[MountainRange],
           [p].[PeakName],
           [p].[Elevation]
      FROM [MountainsCountries]
        AS [mc]
INNER JOIN [Countries]
        AS [c]
        ON [mc].[CountryCode] = [c].[CountryCode]
INNER JOIN [Mountains]
        AS [m]
        ON [mc].[MountainId] = [m].[Id]
INNER JOIN [Peaks]
        AS [p]
        ON [p].[MountainId] = [m].[Id]
     WHERE [c].[CountryName] = 'Bulgaria' AND 
           [p].[Elevation] > 2835
  ORDER BY [p].[Elevation] DESC
 
-- Problem 13
  SELECT [CountryCode],
         COUNT([MountainId])
      AS [MountainRanges]
    FROM [MountainsCountries]
   WHERE [CountryCode] IN (
                                SELECT [CountryCode]
                                  FROM [Countries]
                                 WHERE [CountryName] IN ('United States', 'Russia', 'Bulgaria')
                          )
GROUP BY [CountryCode]

-- Prolem 14

    SELECT
   TOP (5) [c].[CountryName], 
		   [r].[RiverName]
      FROM [Countries]
	    AS [c]
 LEFT JOIN [CountriesRivers]
		AS [cr]
		ON [c].[CountryCode] = [cr].[CountryCode]
 LEFT JOIN [Rivers]
		AS [r]
		ON [r].[Id] = [cr].[RiverId]
INNER JOIN [Continents]
		AS [cn]
		ON [c].[ContinentCode] = [cn].[ContinentCode]
	 WHERE [cn].[ContinentName] = 'Africa'
  ORDER BY [c].[CountryName]


	

 
-- Problem 15
SELECT [ContinentCode],
       [CurrencyCode],
       [CurrencyUsage]
  FROM (
            SELECT *,
                   DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY [CurrencyUsage] DESC)
                AS [CurrencyRank]
              FROM (
                        SELECT [ContinentCode],
                               [CurrencyCode],
                               COUNT(*)
                            AS [CurrencyUsage]
                          FROM [Countries]
                      GROUP BY [ContinentCode], [CurrencyCode]
                        HAVING COUNT(*) > 1
                   )
                AS [CurrencyUsageSubquery]
       )
    AS [CurrencyRankingSubquery]
 WHERE [CurrencyRank] = 1

 -- Problem 16

   SELECT COUNT(*)
	   AS [Count]
     FROM [Countries]
	   AS [c]
LEFT JOIN [MountainsCountries]
	   AS [mc]
	   ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Rivers]
       AS [r]
	   ON [r].[Id] = [mc].[MountainId]
    WHERE [mc].[MountainId] IS NULL 

 
-- Problem 17
   SELECT 
  TOP (5) [c].[CountryName],
          MAX([p].[Elevation])
       AS [HighestPeakElevation],
          MAX([r].[Length])
       AS [LongestRiverLength]
     FROM [Countries]
       AS [c]
LEFT JOIN [CountriesRivers]
       AS [cr]
       ON [cr].[CountryCode] = [c].[CountryCode]
LEFT JOIN [Rivers]
       AS [r]
       ON [cr].[RiverId] = [r].[Id]
LEFT JOIN [MountainsCountries]
       AS [mc]
       ON [mc].[CountryCode] = [c].[CountryCode]
LEFT JOIN [Mountains]
       AS [m]
       ON [mc].[MountainId] = [m].[Id]
LEFT JOIN [Peaks]
       AS [p]
       ON [p].[MountainId] = [m].[Id]
 GROUP BY [c].[CountryName]
 ORDER BY [HighestPeakElevation] DESC,
          [LongestRiverLength] DESC,
          [CountryName]
 
-- Problem 18
  SELECT 
 TOP (5) [CountryName]
      AS [Country],
         ISNULL([PeakName], '(no highest peak)')
      AS [Highest Peak Name],
         ISNULL([Elevation], 0)
      AS [Highest Peak Elevation],
         ISNULL([MountainRange], '(no mountain)')
      AS [Mountain]
    FROM (
               SELECT [c].[CountryName],
                      [p].[PeakName],
                      [p].[Elevation],
                      [m].[MountainRange],
                      DENSE_RANK() OVER(PARTITION BY [c].[CountryName] ORDER BY [p].[Elevation] DESC)
                   AS [PeakRank]
                 FROM [Countries]
                   AS [c]
            LEFT JOIN [MountainsCountries]
                   AS [mc]
                   ON [mc].[CountryCode] = [c].[CountryCode]
            LEFT JOIN [Mountains]
                   AS [m]
                   ON [mc].[MountainId] = [m].[Id]
            LEFT JOIN [Peaks]
                   AS [p]
                   ON [p].[MountainId] = [m].[Id]
         ) 
      AS [PeakRankingSubquery]
   WHERE [PeakRank] = 1
ORDER BY [Country],
         [Highest Peak Name]