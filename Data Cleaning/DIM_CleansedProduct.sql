-- Cleansed DIM_Product Table --
SELECT [ProductKey]
      ,[ProductAlternateKey] AS ProductItemCode
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      ,[EnglishProductName] AS [Product Name]
	  ,ps.EnglishProductSubcategoryName AS [Sub Category]
	  ,pc.EnglishProductCategoryName AS [Product Category]
      --,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      ,[Color] AS [Product Color]
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      ,[Size] AS [Product Size]
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      ,[ProductLine] AS [Product Line]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,[ModelName] AS [Product Model Name]
      --,[LargePhoto] 
      ,[EnglishDescription] AS [Product Description]
      --,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,ISNULL ([Status],'Outdated') AS [Product Status]
  FROM [AdventureWorksDW2022].[dbo].[DimProduct] AS p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
  ORDER BY 1 ASC
