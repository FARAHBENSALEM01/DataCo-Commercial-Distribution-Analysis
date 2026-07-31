/*==============================================================
PHASE 1: EXPLORATORY DATA ANALYSIS (EDA)

Objective:
Develop a comprehensive understanding of DataCo's commercial
distribution business by exploring its operations, financial
performance, customers, products, logistics, and trends before
defining the main business problem.
==============================================================*/

/*==============================================================
1. BUSINESS OVERVIEW

Business Question:
What is the size and operational scope of DataCo's business?

- Total Order Items
- Total Orders
- Total Customers
- Total Products
- Total Categories
- Total Departments
- Total Markets
- Total Countries
- Dataset Time Span
- Average Items per Order
- Average Orders per Customer
==============================================================*/

SELECT
    COUNT(*) AS Total_Order_Items,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    COUNT(DISTINCT Product_Card_ID) AS Total_Products,
    COUNT(DISTINCT Category_ID) AS Total_Categories,
    COUNT(DISTINCT Department_ID) AS Total_Departments,
    COUNT(DISTINCT Market) AS Total_Markets,
    COUNT(DISTINCT Order_Country) AS Total_Countries,
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date,
    CAST(
        COUNT(*) * 1.0 /
        COUNT(DISTINCT Order_ID)
        AS DECIMAL(10,2)
    ) AS Average_Items_Per_Order,
    CAST(
        COUNT(DISTINCT Order_ID) * 1.0 /
        COUNT(DISTINCT Customer_ID)
        AS DECIMAL(10,2)
    ) AS Average_Orders_Per_Customer
FROM DataCo_Clean;



/*==============================================================
2. FINANCIAL PERFORMANCE

Business Question:
How is the business performing in terms of revenue and profit?

Revenue
- Total Sales
- Average Order Value
- Average Customer Spend

Profit
- Total Profit
- Average Profit per Order
- Profit Margin

Financial Distribution
- Top 10 Highest-Value Orders
- Top 10 Lowest-Value Orders
- Top 10 Most Profitable Orders
- Top 10 Least Profitable Orders
- Sales Distribution
- Profit Distribution
- Percentage of Loss-Making Orders
==============================================================*/


/*--------------------------------------------------------------
Revenue
--------------------------------------------------------------*/

SELECT
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 1.0 /
        COUNT(DISTINCT Order_ID)
        AS DECIMAL(10,2)
    ) AS Average_Order_Value,
    CAST(
        SUM(Sales) * 1.0 /
        COUNT(DISTINCT Customer_ID)
        AS DECIMAL(10,2)
    ) AS Average_Customer_Spend
FROM DataCo_Clean;


/*--------------------------------------------------------------
Profit
--------------------------------------------------------------*/

SELECT
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 1.0 /
        COUNT(DISTINCT Order_ID)
        AS DECIMAL(10,2)
    ) AS Average_Profit_Per_Order,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        SUM(Sales)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percentage
FROM DataCo_Clean;


/*--------------------------------------------------------------
Top 10 Highest-Value Orders
--------------------------------------------------------------*/

SELECT TOP 10
    Order_ID,
    SUM(Sales) AS Total_Order_Value
FROM DataCo_Clean
GROUP BY Order_ID
ORDER BY Total_Order_Value DESC;


/*--------------------------------------------------------------
Top 10 Lowest-Value Orders
--------------------------------------------------------------*/

SELECT TOP 10
    Order_ID,
    SUM(Sales) AS Total_Order_Value
FROM DataCo_Clean
GROUP BY Order_ID
ORDER BY Total_Order_Value ASC;


/*--------------------------------------------------------------
Top 10 Most Profitable Orders
--------------------------------------------------------------*/

SELECT TOP 10
    Order_ID,
    SUM(Order_Profit_Per_Order) AS Total_Order_Profit
FROM DataCo_Clean
GROUP BY Order_ID
ORDER BY Total_Order_Profit DESC;


/*--------------------------------------------------------------
Top 10 Least Profitable Orders
--------------------------------------------------------------*/

SELECT TOP 10
    Order_ID,
    SUM(Order_Profit_Per_Order) AS Total_Order_Profit
FROM DataCo_Clean
GROUP BY Order_ID
ORDER BY Total_Order_Profit ASC;


/*--------------------------------------------------------------
Sales Distribution
--------------------------------------------------------------*/

SELECT
    Order_ID,
    SUM(Sales) AS Total_Order_Sales
FROM DataCo_Clean
GROUP BY Order_ID;


/*--------------------------------------------------------------
Profit Distribution
--------------------------------------------------------------*/

SELECT
    Order_ID,
    SUM(Order_Profit_Per_Order) AS Total_Order_Profit
FROM DataCo_Clean
GROUP BY Order_ID;


/*--------------------------------------------------------------
Percentage of Loss-Making Orders

A loss-making order is an order whose total profit is below zero.
--------------------------------------------------------------*/

WITH CTE_Loss_Orders AS
(
    SELECT
        Order_ID,
        SUM(Order_Profit_Per_Order) AS Total_Order_Profit
    FROM DataCo_Clean
    GROUP BY Order_ID
    HAVING SUM(Order_Profit_Per_Order) < 0
)

SELECT
    CAST(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(DISTINCT Order_ID)
            FROM DataCo_Clean
        )
        AS DECIMAL(10,2)
    ) AS Loss_Making_Order_Percentage
FROM CTE_Loss_Orders;

/*==============================================================
3. PRODUCT PERFORMANCE

Business Question:
Which products, categories, and departments contribute the most
to sales, profit, and customer demand?

Products
- Top Products by Sales
- Top Products by Profit
- Top Products by Quantity Sold

Categories
- Top Categories by Sales
- Top Categories by Profit
- Top Categories by Quantity Sold

Departments
- Top Departments by Sales
- Top Departments by Profit
- Top Departments by Quantity Sold
==============================================================*/


/*--------------------------------------------------------------
Products
--------------------------------------------------------------*/

SELECT TOP 10
    Product_Card_ID,
    Product_Name,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Product_Card_ID,
    Product_Name
ORDER BY Total_Sales DESC;


SELECT TOP 10
    Product_Card_ID,
    Product_Name,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Product_Card_ID,
    Product_Name
ORDER BY Total_Profit DESC;


SELECT TOP 10
    Product_Card_ID,
    Product_Name,
    SUM(Order_Item_Quantity) AS Total_Quantity_Sold,
    CAST(
        SUM(Order_Item_Quantity) * 100.0 /
        (SELECT SUM(Order_Item_Quantity) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Quantity_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Product_Card_ID,
    Product_Name
ORDER BY Total_Quantity_Sold DESC;


/*--------------------------------------------------------------
Categories
--------------------------------------------------------------*/

SELECT TOP 10
    Category_ID,
    Category_Name,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Category_ID,
    Category_Name
ORDER BY Total_Sales DESC;


SELECT TOP 10
    Category_ID,
    Category_Name,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Category_ID,
    Category_Name
ORDER BY Total_Profit DESC;


SELECT TOP 10
    Category_ID,
    Category_Name,
    SUM(Order_Item_Quantity) AS Total_Quantity_Sold,
    CAST(
        SUM(Order_Item_Quantity) * 100.0 /
        (SELECT SUM(Order_Item_Quantity) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Quantity_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Category_ID,
    Category_Name
ORDER BY Total_Quantity_Sold DESC;


/*--------------------------------------------------------------
Departments
--------------------------------------------------------------*/

SELECT TOP 10
    Department_ID,
    Department_Name,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Department_ID,
    Department_Name
ORDER BY Total_Sales DESC;


SELECT TOP 10
    Department_ID,
    Department_Name,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Department_ID,
    Department_Name
ORDER BY Total_Profit DESC;


SELECT TOP 10
    Department_ID,
    Department_Name,
    SUM(Order_Item_Quantity) AS Total_Quantity_Sold,
    CAST(
        SUM(Order_Item_Quantity) * 100.0 /
        (SELECT SUM(Order_Item_Quantity) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Quantity_Contribution_Percentage
FROM DataCo_Clean
GROUP BY
    Department_ID,
    Department_Name
ORDER BY Total_Quantity_Sold DESC;



/*==============================================================
4. CUSTOMER PERFORMANCE

Business Question:
Which customer segments and individual customers contribute
most to DataCo's sales, profit, and order volume?

Customer Segments
- Orders by Segment
- Sales by Segment
- Profit by Segment

Customers
- Top Customers by Sales
- Top Customers by Profit
- Top Customers by Number of Orders
==============================================================*/


/*--------------------------------------------------------------
Customer Segments
--------------------------------------------------------------*/

SELECT
    Customer_Segment,
    COUNT(DISTINCT Order_ID) AS Orders_By_Segment,
    CAST(
        COUNT(DISTINCT Order_ID) * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Orders_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Customer_Segment
ORDER BY Orders_By_Segment DESC;


SELECT
    Customer_Segment,
    SUM(Sales) AS Sales_By_Segment,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Customer_Segment
ORDER BY Sales_By_Segment DESC;


SELECT
    Customer_Segment,
    SUM(Order_Profit_Per_Order) AS Profit_By_Segment,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Customer_Segment
ORDER BY Profit_By_Segment DESC;


/*--------------------------------------------------------------
Customers
--------------------------------------------------------------*/

SELECT TOP 10
    Customer_ID,
    Customer_FName,
    Customer_LName,
    SUM(Sales) AS Total_Customer_Sales
FROM DataCo_Clean
GROUP BY
    Customer_ID,
    Customer_FName,
    Customer_LName
ORDER BY Total_Customer_Sales DESC;


SELECT TOP 10
    Customer_ID,
    Customer_FName,
    Customer_LName,
    SUM(Order_Profit_Per_Order) AS Total_Customer_Profit
FROM DataCo_Clean
GROUP BY
    Customer_ID,
    Customer_FName,
    Customer_LName
ORDER BY Total_Customer_Profit DESC;


SELECT TOP 10
    Customer_ID,
    Customer_FName,
    Customer_LName,
    COUNT(DISTINCT Order_ID) AS Total_Customer_Orders
FROM DataCo_Clean
GROUP BY
    Customer_ID,
    Customer_FName,
    Customer_LName
ORDER BY Total_Customer_Orders DESC;

/*==============================================================
5. GEOGRAPHIC PERFORMANCE

Business Question:
Which markets and geographic locations contribute most to
DataCo's sales and profit?

Markets
- Sales by Market
- Profit by Market

Countries
- Sales by Country
- Profit by Country

Regions
- Sales by Region
- Profit by Region

Cities
- Sales by City
- Profit by City
==============================================================*/


/*--------------------------------------------------------------
Markets
--------------------------------------------------------------*/

SELECT
    Market,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Market
ORDER BY Total_Sales DESC;


SELECT
    Market,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Market
ORDER BY Total_Profit DESC;


/*--------------------------------------------------------------
Countries
--------------------------------------------------------------*/

SELECT
    Order_Country,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Order_Country
ORDER BY Total_Sales DESC;


SELECT
    Order_Country,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Order_Country
ORDER BY Total_Profit DESC;


/*--------------------------------------------------------------
Regions
--------------------------------------------------------------*/

SELECT
    Order_Region,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Order_Region
ORDER BY Total_Sales DESC;


SELECT
    Order_Region,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Order_Region
ORDER BY Total_Profit DESC;


/*--------------------------------------------------------------
Cities
--------------------------------------------------------------*/

SELECT
    Order_City,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Order_City
ORDER BY Total_Sales DESC;


SELECT
    Order_City,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Contribution_Percentage
FROM DataCo_Clean
GROUP BY Order_City
ORDER BY Total_Profit DESC;



/*==============================================================
6. LOGISTICS PERFORMANCE

Business Question:
How efficiently does DataCo fulfill customer deliveries?

Shipping Operations
- Orders by Shipping Mode
- Average Scheduled Shipping Days
- Average Actual Shipping Days

Delivery Performance
- Late Delivery Rate
- On-Time Delivery Rate

Delivery Performance by Shipping Mode
- Delivery Status by Shipping Mode
==============================================================*/


/*--------------------------------------------------------------
Shipping Operations
--------------------------------------------------------------*/

SELECT
    Shipping_Mode,
    COUNT(DISTINCT Order_ID) AS Orders_By_Shipping_Mode,
    CAST(
        COUNT(DISTINCT Order_ID) * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Orders_Contribution_Percentage,
    AVG(Days_Shipment_Scheduled) AS Average_Scheduled_Shipping_Days,
    AVG(Days_Shipping_Real) AS Average_Actual_Shipping_Days
FROM DataCo_Clean
GROUP BY Shipping_Mode;


/*--------------------------------------------------------------
Delivery Performance
--------------------------------------------------------------*/

WITH CTE_Delivery AS
(
    SELECT
        Delivery_Status,
        COUNT(DISTINCT Order_ID) AS Orders
    FROM DataCo_Clean
    WHERE Delivery_Status IN ('Late delivery', 'Shipping on time')
    GROUP BY Delivery_Status
)

SELECT
    Delivery_Status,
    Orders,
    CAST(
        Orders * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Delivery_Distribution_Percentage
FROM CTE_Delivery
ORDER BY Delivery_Distribution_Percentage DESC;


/*--------------------------------------------------------------
Delivery Performance by Shipping Mode
--------------------------------------------------------------*/

WITH CTE_Delivery AS
(
    SELECT
        Shipping_Mode,
        Delivery_Status,
        COUNT(DISTINCT Order_ID) AS Orders
    FROM DataCo_Clean
    WHERE Delivery_Status IN ('Late delivery', 'Shipping on time')
    GROUP BY
        Shipping_Mode,
        Delivery_Status
)

SELECT
    Shipping_Mode,
    Delivery_Status,
    Orders,
    CAST(
        Orders * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Delivery_Distribution_Percentage
FROM CTE_Delivery
ORDER BY
    Shipping_Mode,
    Delivery_Status;

/*==============================================================
7. ORDER OPERATIONS

Business Question:
How are customer orders progressing through the order
fulfillment process?

Order Status
- Order Status Distribution
- Order Completion Rate
- Order Cancellation Rate
- Pending Order Rate

Order Types
- Order Type Distribution
==============================================================*/


/*--------------------------------------------------------------
Order Status
--------------------------------------------------------------*/

WITH CTE_OrderStatus AS
(
    SELECT
        Order_Status,
        COUNT(DISTINCT Order_ID) AS Total_Orders
    FROM DataCo_Clean
    GROUP BY Order_Status
)

SELECT
    Order_Status,
    Total_Orders,
    CAST(
        Total_Orders * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Order_Status_Percentage
FROM CTE_OrderStatus
ORDER BY Total_Orders DESC;


/*--------------------------------------------------------------
Order Types
--------------------------------------------------------------*/

WITH CTE_OrderType AS
(
    SELECT
        Order_Type,
        COUNT(DISTINCT Order_ID) AS Total_Orders
    FROM DataCo_Clean
    GROUP BY Order_Type
)

SELECT
    Order_Type,
    Total_Orders,
    CAST(
        Total_Orders * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Order_Type_Percentage
FROM CTE_OrderType
ORDER BY Total_Orders DESC;



/*==============================================================
8. BUSINESS TRENDS

Business Question:
How have sales, profit, and order volume evolved over time?

Sales Trends
- Monthly Sales
- Yearly Sales

Profit Trends
- Monthly Profit
- Yearly Profit

Order Trends
- Monthly Orders
- Yearly Orders
==============================================================*/


/*--------------------------------------------------------------
Sales Trends
--------------------------------------------------------------*/

-- Monthly Sales

SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month_Number,
    DATENAME(MONTH, Order_Date) AS Month_Name,
    SUM(Sales) AS Total_Sales
FROM DataCo_Clean
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date)
ORDER BY
    Year,
    Month_Number;


-- Yearly Sales

SELECT
    YEAR(Order_Date) AS Year,
    SUM(Sales) AS Total_Sales
FROM DataCo_Clean
GROUP BY YEAR(Order_Date)
ORDER BY Year;


/*--------------------------------------------------------------
Profit Trends
--------------------------------------------------------------*/

-- Monthly Profit

SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month_Number,
    DATENAME(MONTH, Order_Date) AS Month_Name,
    SUM(Order_Profit_Per_Order) AS Total_Profit
FROM DataCo_Clean
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date)
ORDER BY
    Year,
    Month_Number;


-- Yearly Profit

SELECT
    YEAR(Order_Date) AS Year,
    SUM(Order_Profit_Per_Order) AS Total_Profit
FROM DataCo_Clean
GROUP BY YEAR(Order_Date)
ORDER BY Year;


/*--------------------------------------------------------------
Order Trends
--------------------------------------------------------------*/

-- Monthly Orders

SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month_Number,
    DATENAME(MONTH, Order_Date) AS Month_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM DataCo_Clean
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATENAME(MONTH, Order_Date)
ORDER BY
    Year,
    Month_Number;


-- Yearly Orders

SELECT
    YEAR(Order_Date) AS Year,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM DataCo_Clean
GROUP BY YEAR(Order_Date)
ORDER BY Year;

/*==============================================================
9. PRICING STRATEGY

Business Question:
How do DataCo's pricing and discount strategies influence
sales and profit?

Discount Levels
- Discount Level Distribution
- Sales by Discount Level
- Profit by Discount Level

Discount Analysis
- Average Discount by Category
- Average Discount by Market
==============================================================*/


/*--------------------------------------------------------------
Discount Levels
--------------------------------------------------------------*/

-- Order Distribution by Discount Level
WITH CTE_Discount AS
(
    SELECT
        CASE
            WHEN Order_Item_Discount_Rate = 0 THEN 'No Discount'
            WHEN Order_Item_Discount_Rate <= 0.10 THEN 'Low Discount (1-10%)'
            WHEN Order_Item_Discount_Rate <= 0.20 THEN 'Medium Discount (11-20%)'
            ELSE 'High Discount (>20%)'
        END AS Discount_Level,
        Sales,
        Order_Profit_Per_Order,
        Order_ID
    FROM DataCo_Clean
)

SELECT
    Discount_Level,
    COUNT(DISTINCT Order_ID) AS Orders,
    CAST(
        COUNT(DISTINCT Order_ID) * 100.0 /
        (SELECT COUNT(DISTINCT Order_ID) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Order_Percentage
FROM CTE_Discount
GROUP BY Discount_Level
ORDER BY Orders DESC;


-- Sales by Discount Level
WITH CTE_Discount AS
(
    SELECT
        CASE
            WHEN Order_Item_Discount_Rate = 0 THEN 'No Discount'
            WHEN Order_Item_Discount_Rate <= 0.10 THEN 'Low Discount (1-10%)'
            WHEN Order_Item_Discount_Rate <= 0.20 THEN 'Medium Discount (11-20%)'
            ELSE 'High Discount (>20%)'
        END AS Discount_Level,
        Sales,
        Order_Profit_Per_Order,
        Order_ID
    FROM DataCo_Clean
)

SELECT
    Discount_Level,
    SUM(Sales) AS Total_Sales,
    CAST(
        SUM(Sales) * 100.0 /
        (SELECT SUM(Sales) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Sales_Percentage
FROM CTE_Discount
GROUP BY Discount_Level
ORDER BY Total_Sales DESC;


-- Profit by Discount Level
WITH CTE_Discount AS
(
    SELECT
        CASE
            WHEN Order_Item_Discount_Rate = 0 THEN 'No Discount'
            WHEN Order_Item_Discount_Rate <= 0.10 THEN 'Low Discount (1-10%)'
            WHEN Order_Item_Discount_Rate <= 0.20 THEN 'Medium Discount (11-20%)'
            ELSE 'High Discount (>20%)'
        END AS Discount_Level,
        Sales,
        Order_Profit_Per_Order,
        Order_ID
    FROM DataCo_Clean
)

SELECT
    Discount_Level,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        (SELECT SUM(Order_Profit_Per_Order) FROM DataCo_Clean)
        AS DECIMAL(10,2)
    ) AS Profit_Percentage
FROM CTE_Discount
GROUP BY Discount_Level
ORDER BY Total_Profit DESC;


/*--------------------------------------------------------------
Discount Analysis
--------------------------------------------------------------*/

SELECT
    Category_ID,
    Category_Name,
    ROUND(
        AVG(Order_Item_Discount_Rate) * 100,
        2
    ) AS Average_Discount_Rate
FROM DataCo_Clean
GROUP BY
    Category_ID,
    Category_Name
ORDER BY Average_Discount_Rate DESC;


SELECT
    Market,
    ROUND(
        AVG(Order_Item_Discount_Rate) * 100,
        2
    ) AS Average_Discount_Rate
FROM DataCo_Clean
GROUP BY Market
ORDER BY Average_Discount_Rate DESC;



/*==============================================================
10. CUSTOMER PURCHASING BEHAVIOR

Business Question:
How do purchasing behaviors differ across customer segments?

Basket Behavior
- Average Basket Size
- Average Product Lines per Order

Customer Value
- Average Order Value
- Average Orders per Customer
- Average Customer Spending
==============================================================*/


/*--------------------------------------------------------------
Basket Behavior
--------------------------------------------------------------*/

WITH Basket AS
(
    SELECT
        Order_ID,
        Customer_Segment,
        SUM(Order_Item_Quantity) AS Basket_Size
    FROM DataCo_Clean
    GROUP BY
        Order_ID,
        Customer_Segment
)

SELECT
    Customer_Segment,
    CAST(AVG(Basket_Size) AS DECIMAL(10,2)) AS Average_Basket_Size
FROM Basket
GROUP BY Customer_Segment
ORDER BY Average_Basket_Size DESC;


WITH Order_Items AS
(
    SELECT
        Order_ID,
        Customer_Segment,
        COUNT(*) AS Product_Lines
    FROM DataCo_Clean
    GROUP BY
        Order_ID,
        Customer_Segment
)

SELECT
    Customer_Segment,
    CAST(
        AVG(Product_Lines) AS DECIMAL(10,2)
    ) AS Average_Product_Lines_Per_Order
FROM Order_Items
GROUP BY Customer_Segment
ORDER BY Average_Product_Lines_Per_Order DESC;


/*--------------------------------------------------------------
Customer Value
--------------------------------------------------------------*/

WITH Orders AS
(
    SELECT
        Order_ID,
        Customer_Segment,
        SUM(Sales) AS Order_Value
    FROM DataCo_Clean
    GROUP BY
        Order_ID,
        Customer_Segment
)

SELECT
    Customer_Segment,
    CAST(
        AVG(Order_Value) AS DECIMAL(10,2)
    ) AS Average_Order_Value
FROM Orders
GROUP BY Customer_Segment
ORDER BY Average_Order_Value DESC;


WITH Customer_Orders AS
(
    SELECT
        Customer_ID,
        Customer_Segment,
        COUNT(DISTINCT Order_ID) AS Orders_Per_Customer
    FROM DataCo_Clean
    GROUP BY
        Customer_ID,
        Customer_Segment
)

SELECT
    Customer_Segment,
    CAST(
        AVG(Orders_Per_Customer) AS DECIMAL(10,2)
    ) AS Average_Orders_Per_Customer
FROM Customer_Orders
GROUP BY Customer_Segment
ORDER BY Average_Orders_Per_Customer DESC;


WITH Customer_Spending AS
(
    SELECT
        Customer_ID,
        Customer_Segment,
        SUM(Sales) AS Customer_Spending
    FROM DataCo_Clean
    GROUP BY
        Customer_ID,
        Customer_Segment
)

SELECT
    Customer_Segment,
    CAST(
        AVG(Customer_Spending) AS DECIMAL(10,2)
    ) AS Average_Customer_Spending
FROM Customer_Spending
GROUP BY Customer_Segment
ORDER BY Average_Customer_Spending DESC;

/*==============================================================
11. BUSINESS PERFORMANCE INTERACTIONS

Business Question:
Which combinations of markets, product categories,
customer segments, and shipping modes contribute most
to business performance?

Top Product Category by Sales within Each Market

Top Product Category by Profit within Each Market

Top Customer Segment by Sales within Each Market

Most Used Shipping Mode within Each Market

Top Performing Markets
- Total Sales
- Total Profit
- Profit Margin
==============================================================*/


/*--------------------------------------------------------------
Top Product Category by Sales within Each Market
--------------------------------------------------------------*/

WITH CTE_CategorySales AS
(
    SELECT
        Market,
        Category_Name,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER
        (
            PARTITION BY Market
            ORDER BY SUM(Sales) DESC
        ) AS Row_Num
    FROM DataCo_Clean
    GROUP BY
        Market,
        Category_Name
)

SELECT
    Market,
    Category_Name,
    Total_Sales
FROM CTE_CategorySales
WHERE Row_Num = 1
ORDER BY Total_Sales DESC;


/*--------------------------------------------------------------
Top Product Category by Profit within Each Market
--------------------------------------------------------------*/

WITH CTE_CategoryProfit AS
(
    SELECT
        Market,
        Category_Name,
        SUM(Order_Profit_Per_Order) AS Total_Profit,
        ROW_NUMBER() OVER
        (
            PARTITION BY Market
            ORDER BY SUM(Order_Profit_Per_Order) DESC
        ) AS Row_Num
    FROM DataCo_Clean
    GROUP BY
        Market,
        Category_Name
)

SELECT
    Market,
    Category_Name,
    Total_Profit
FROM CTE_CategoryProfit
WHERE Row_Num = 1
ORDER BY Total_Profit DESC;


/*--------------------------------------------------------------
Top Customer Segment by Sales within Each Market
--------------------------------------------------------------*/

WITH CTE_SegmentSales AS
(
    SELECT
        Market,
        Customer_Segment,
        SUM(Sales) AS Total_Sales,
        ROW_NUMBER() OVER
        (
            PARTITION BY Market
            ORDER BY SUM(Sales) DESC
        ) AS Row_Num
    FROM DataCo_Clean
    GROUP BY
        Market,
        Customer_Segment
)

SELECT
    Market,
    Customer_Segment,
    Total_Sales
FROM CTE_SegmentSales
WHERE Row_Num = 1
ORDER BY Total_Sales DESC;


/*--------------------------------------------------------------
Most Used Shipping Mode within Each Market
--------------------------------------------------------------*/

WITH CTE_ShippingMode AS
(
    SELECT
        Market,
        Shipping_Mode,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        ROW_NUMBER() OVER
        (
            PARTITION BY Market
            ORDER BY COUNT(DISTINCT Order_ID) DESC
        ) AS Row_Num
    FROM DataCo_Clean
    GROUP BY
        Market,
        Shipping_Mode
)

SELECT
    Market,
    Shipping_Mode,
    Total_Orders
FROM CTE_ShippingMode
WHERE Row_Num = 1
ORDER BY Total_Orders DESC;


/*--------------------------------------------------------------
Top Performing Markets
--------------------------------------------------------------*/

SELECT
    Market,
    SUM(Sales) AS Total_Sales,
    SUM(Order_Profit_Per_Order) AS Total_Profit,
    CAST(
        SUM(Order_Profit_Per_Order) * 100.0 /
        SUM(Sales)
        AS DECIMAL(10,2)
    ) AS Profit_Margin_Percentage
FROM DataCo_Clean
GROUP BY Market
ORDER BY Total_Profit DESC;