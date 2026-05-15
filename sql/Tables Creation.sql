Create Table Customers (
Customer_ID Integer primary key,
Customer_Name Varchar(50),
Country Varchar(50) NOT NULL,
Signup_Date Date)

Create Table Products (
Product_ID Integer Primary key,
Product_Name Varchar(50),
Category Varchar(50) Not Null,
Price Decimal)

Create Table Sales (
Sale_ID Integer Primary Key,
Customer_ID Integer,
Product_ID Integer,
Quantity Integer,
Sale_Date Date,

Foreign Key (Customer_ID) References Customers(Customer_ID),
Foreign Key (Product_ID) References Products(Product_ID))