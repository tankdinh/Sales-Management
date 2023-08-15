# Sales-Management

## Business Objectives
* We need to improve our Internet sales reports and want to move from static reports to visual dashboard.
* Essentially, we want to focus it on how much we have sold of what products, to which clients and how it has been over time.
* Seeing as each sales person works on different products and customers, it would be benefical to be able to filter them also.
* We measure our numbers against budget so I added that in a spreadsheet and we can compare our values against performance.
* The budget is for 2022 and we ussually look 2 years back in time when we do analysis of sales.

## Business Demand Overview
* Reporter: Sales Manager
* Value of change: Visual dashboard, improve sales reporting and follow up sales force
* Necessary systems: Power BI and CRM System
* Other relevant info: Budgets have been delivered in Excel in 2022

## User Stories
| **No.** | **As a (role)**      | **I want (request / demand)**                      | **So that I (user value)**                                               | **Acceptance criteria**                                               |
|---------|----------------------|----------------------------------------------------|--------------------------------------------------------------------------|-----------------------------------------------------------------------|
| 1       | Sales Manager        | To get a dashboard overview of internet sales      | Can follow better which customers and products sells the best            | A Power BI dashboard which updates data once a day                    |
| 2       | Sales Representative | A detailed overview of internet sales per customer | Can follow up my customers that buy the most and who we can sell one to | A Power BI dashboard which allows me to filter data for each customer |
| 3       | Sales Representative | A detailed overview of internet sales per product  | Can follow up my products that sell the most                            | A Power BI dashboard which allows me to filter data for each product  |
| 4       | Sales Manager        | To get a dashboard overview of internet sales      | Follow sales over time against budget                                    | A Power BI dashboard with graphs and KPIs comparing against budget    |
## Data Cleaning
From the AdventureWork database, we use SQL to generate these tables below:
* DIM_Customers
* DIM_Products
* DIM_Calendar
* FACT_InternetSales

Then, save them as CSV files to import to Power BI later. View all the files [here]().

*Note: FACT_Budget is generated from a seperated Excel file.*

### > Table `DIM_Customers`
```TSQL
SELECT 
  c.[CustomerKey]
  ,c.[FirstName] + ' ' + c.[LastName] AS FullName
  ,CASE c.[Gender] WHEN 'M' THEN 'Male' ELSE 'Female' END AS Gender
  ,c.[DateFirstPurchase]
  ,g.City AS [Customer City]
FROM [AdventureWorksDW2019].[dbo].[DimCustomer] c
LEFT JOIN [dbo].[DimGeography] g ON c.GeographyKey = g.GeographyKey
ORDER BY c.CustomerKey
```
![image](https://github.com/tankdinh/Sales-Management/assets/126235420/b48938c7-b0a0-4982-9038-1c6d496ac59e)


### > Table `DIM_Products`
```TSQL
SELECT 
  p.[ProductKey]
  ,p.[ProductAlternateKey] AS ProductItemCode
  ,p.[EnglishProductName] AS [Product Name]
  ,ps.[EnglishProductSubcategoryName] AS [Sub Category] --joined with Sub Category Table
  ,pc.[EnglishProductCategoryName] AS [Product Category] --joined with Category Table
  ,p.[Color] AS [Product Color]
  ,p.[Size] AS [Product Size]
  ,p.[ProductLine] AS [Product Line]
  ,p.[ModelName] AS [Product Model Name]
  ,p.[EnglishDescription] AS [Product Description]
  ,ISNULL(p.[Status], 'Outdated') AS [Product Status]
FROM [AdventureWorksDW2019].[dbo].[DimProduct] p
LEFT JOIN [dbo].[DimProductSubcategory] ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
LEFT JOIN [dbo].[DimProductCategory] pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY p.[ProductKey]
```
![image](https://github.com/tankdinh/Sales-Management/assets/126235420/7262c268-e0b8-48b2-bca7-0d882a8d63f6)


### > Table `DIM_Calendar`
```TSQL
SELECT 
  [DateKey] 
  ,[FullDateAlternateKey] AS Date
  ,[EnglishDayNameOfWeek] AS Day
  ,[WeekNumberOfYear] AS WeekNo
  ,LEFT([EnglishMonthName], 3) AS MonthShort
  ,[MonthNumberOfYear] AS MonthNo
  ,[CalendarQuarter] AS Quarter 
  ,[CalendarYear] AS Year
FROM [AdventureWorksDW2019].[dbo].[DimDate]
WHERE [CalendarYear] >= 2020	--2 years back in time
```
![image](https://github.com/tankdinh/Sales-Management/assets/126235420/c916cc2c-ce31-465c-8d8e-2093856c25df)


### > Table `FACT_InternetSales`
```TSQL
SELECT [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      ,[SalesOrderNumber]
      ,[SalesAmount]
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE LEFT(OrderDateKey, 4) >= YEAR(GETDATE()) - 2 --ensures that we only bring 2 years of date from extraction
ORDER BY OrderDateKey
```
![image](https://github.com/tankdinh/Sales-Management/assets/126235420/0bd61094-484e-4b1a-bbb0-ccdc5fde622b)


## Entity Relationship Diagram
After importing all CSV files to Power BI, the data model will look like this:
<img src="https://user-images.githubusercontent.com/84619797/210082856-5ac6a1c8-b7f1-4b8b-a02c-9884b371e391.png" >

## Dashboard

View the Power BI file [here](https://github.com/tankdinh/Sales-Management/blob/main/Dashboard.pbix).


<img src="(https://github.com/tankdinh/Sales-Management/assets/126235420/28647884-14e8-4f6a-a02f-61a3c835db34)">


<img src="(https://github.com/tankdinh/Sales-Management/assets/126235420/9358f64d-563d-47c1-9409-04480a5c1295)" >


<img src="(https://github.com/tankdinh/Sales-Management/assets/126235420/0a620891-40f3-4238-bcdc-bb5f4c524f09)" >

