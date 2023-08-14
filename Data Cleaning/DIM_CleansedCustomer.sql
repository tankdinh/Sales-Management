-- Cleansed DIM_Customers Table
SELECT [CustomerKey]
      --,[GeographyKey]
      --,[CustomerAlternateKey]
      --,[Title]
      ,[FirstName] AS [First Name]
      --,[MiddleName]
      ,[LastName] AS [Last Name]
      --,[NameStyle]
      --,[BirthDate]
      --,[MaritalStatus]
      --,[Suffix]
      ,CASE [Gender] WHEN 'M' THEN 'Male' ELSE 'Female' END AS Gender
      --,[EmailAddress]
      --,[YearlyIncome]
      --,[TotalChildren]
      --,[NumberChildrenAtHome]
      --,[EnglishEducation]
      --,[SpanishEducation]
      --,[FrenchEducation]
      --,[EnglishOccupation]
      --,[SpanishOccupation]
      --,[FrenchOccupation]
      --,[HouseOwnerFlag]
      --,[NumberCarsOwned]
      --,[AddressLine1]
      --,[AddressLine2]
      --,[Phone]
      ,[DateFirstPurchase]
      --,[CommuteDistance]
	  ,g.City AS [Customer City] -- Joined in Customer City from DimGeography Table
  FROM [AdventureWorksDW2022].[dbo].[DimCustomer] AS c
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey
  ORDER BY 1 ASC -- Ordered List by Customer Key
