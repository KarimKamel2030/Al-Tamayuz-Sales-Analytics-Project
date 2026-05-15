--1.Full Transaction Report

With FullTransactionReport As(
select
C.Customer_Name,
P.Product_Name,
P.Category,
P.Price,
S.Quantity,
S.Sale_Date
From Sales S
Join Customers C
On C.Customer_ID = S.Customer_ID
Join Products P
On P.Product_ID = S.Product_ID
)

Select *
From FullTransactionReport


--2. Revenue Calculation

With FullTransactionReport As(
select
C.Customer_Name,
P.Product_Name,
P.Category,
P.Price,
S.Quantity,
P.Price * S.Quantity AS Total_Value,
S.Sale_Date
From Sales S
Join Customers C
On C.Customer_ID = S.Customer_ID
Join Products P
On P.Product_ID = S.Product_ID
)

Select *
From FullTransactionReport


--3. Category Performance

With CategoryPerformance AS(
SELECT
	P.Category,
	S.Quantity,
	S.Quantity * P.Price AS Total_Value
	From Products P
	Join Sales S
	On P.Product_ID = S.Product_ID
)
Select
	Category,
	Sum(Total_Value) AS Total_Revenue,
	Sum(Quantity) AS Total_Quantity_Sold
	From CategoryPerformance
	Group by Category;

--4. Customer Targeting

With TechCustomers AS(
Select
C.Customer_Name,
P.Category
From Customers C
Join Sales S
On C.Customer_ID = S.Customer_ID
Join Products P
On P.Product_ID = S.Product_ID
Where P.Category = 'Tech')

Select Distinct
Customer_Name
From TechCustomers;

--5. High-Value Products

Select
Product_ID,
Product_Name,
Category,
Price
From Products
Where Price >(
Select AVG(Price)
From Products)

--6. Data Cleaning

Select UPPER(TRIM(Product_Name)) AS ProductName
From Products

--7. Time Analysis

Select
Sale_ID,
Product_ID,
Customer_ID,
Sale_Date,
Datediff(Day, Sale_Date, getdate()) AS Days_Passed
From Sales


--8. Customer Ranking

With CustomerSpending AS(
Select
C.Customer_Name,
Sum(P.Price * S.Quantity) AS Total_Spending
From Sales S
Join Customers C
On S.Customer_ID = C.Customer_ID
Join Products P
ON p.product_ID = S.Product_ID
Group by C.Customer_Name)

Select 
Customer_Name,
Total_spending,
Dense_Rank() Over (
Order By Total_Spending Desc) AS Customer_Ranking
From CustomerSpending

--9. Handling Missing Data

Select
Product_ID,
Product_Name,
Coalesce(Category, 'General') AS Category
From Products 


--10. Optimization Plan

--If the Sales table grows to 10 million rows, the database may become slower, especially when joining
--tables or filtering  sales records. To improve performance, I would add indexes on important columns
--such as Customer_ID, Product_ID, and Sale_Date.

--Create Index IX_Sales_Customer_ID
--ON Sales(Customer_ID)

--Create Index IX_Sales_Product_ID
--ON Sales(Product_ID)

--Create Index IX_Sales_Sale_Date
--ON Sales(Sale_Date)