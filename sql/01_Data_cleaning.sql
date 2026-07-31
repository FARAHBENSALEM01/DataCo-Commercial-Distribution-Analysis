/*=========================================================
 DATASET OVERVIEW
===========================================================

Objective:
Understand the structure and contents of the raw dataset
before performing any data cleaning.

This section examines:
- Dataset preview
- Total number of rows
- Total number of columns
- Column names
- Data types

=========================================================*/
-- Preview the first 10 records

SELECT TOP (10) *
FROM DataCo_raw;

-- Count the total number of records

SELECT
    COUNT(*) AS total_rows
FROM DataCo_raw;

/*
Result

180,519 rows
*/

-- Count the total number of columns

SELECT
    COUNT(COLUMN_NAME) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCo_raw';

/*
Result

53 columns
*/

-- Display all column names

SELECT
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCo_raw'
ORDER BY ORDINAL_POSITION;

-- Display the data type of each column

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCo_raw'
ORDER BY ORDINAL_POSITION;

/*=========================================================
 DATA TYPE VALIDATION
===========================================================

Objective:
Identify numeric columns imported as FLOAT that contain
only whole numbers and can be safely converted to INT in
the cleaned dataset.

Customer Zipcode is assessed separately because ZIP codes
are identifiers and will be stored as NVARCHAR.

=========================================================*/

/*---------------------------------------------------------
 Validate Candidate Integer Columns
---------------------------------------------------------*/

SELECT DISTINCT [Days for shipping (real)]
FROM DataCo_raw
WHERE [Days for shipping (real)] <> CAST([Days for shipping (real)] AS INT);

SELECT DISTINCT [Days for shipment (scheduled)]
FROM DataCo_raw
WHERE [Days for shipment (scheduled)] <> CAST([Days for shipment (scheduled)] AS INT);

SELECT DISTINCT [Late_delivery_risk]
FROM DataCo_raw
WHERE [Late_delivery_risk] <> CAST([Late_delivery_risk] AS INT);

SELECT DISTINCT [Category Id]
FROM DataCo_raw
WHERE [Category Id] <> CAST([Category Id] AS INT);

SELECT DISTINCT [Customer Id]
FROM DataCo_raw
WHERE [Customer Id] <> CAST([Customer Id] AS INT);

SELECT DISTINCT [Department Id]
FROM DataCo_raw
WHERE [Department Id] <> CAST([Department Id] AS INT);

SELECT DISTINCT [Order Customer Id]
FROM DataCo_raw
WHERE [Order Customer Id] <> CAST([Order Customer Id] AS INT);

SELECT DISTINCT [Order Id]
FROM DataCo_raw
WHERE [Order Id] <> CAST([Order Id] AS INT);

SELECT DISTINCT [Order Item Cardprod Id]
FROM DataCo_raw
WHERE [Order Item Cardprod Id] <> CAST([Order Item Cardprod Id] AS INT);

SELECT DISTINCT [Order Item Quantity]
FROM DataCo_raw
WHERE [Order Item Quantity] <> CAST([Order Item Quantity] AS INT);

SELECT DISTINCT [Product Card Id]
FROM DataCo_raw
WHERE [Product Card Id] <> CAST([Product Card Id] AS INT);

SELECT DISTINCT [Product Category Id]
FROM DataCo_raw
WHERE [Product Category Id] <> CAST([Product Category Id] AS INT);

SELECT DISTINCT [Product Status]
FROM DataCo_raw
WHERE [Product Status] <> CAST([Product Status] AS INT);

/*
Findings

Validation confirmed that the following columns contain
only whole numbers and can be safely converted from
FLOAT to INT:

• Days for shipping (real)
• Days for shipment (scheduled)
• Late_delivery_risk
• Category Id
• Customer Id
• Department Id
• Order Customer Id
• Order Id
• Order Item Cardprod Id
• Order Item Quantity
• Product Card Id
• Product Category Id
• Product Status

Customer Zipcode will be converted to NVARCHAR because
ZIP codes are identifiers rather than numeric values.
*/

/*=========================================================
 DUPLICATE RECORD ASSESSMENT
===========================================================

Objective:
Assess the dataset for duplicate records before performing
any data cleaning.

This section aims to:
- Determine the dataset grain.
- Identify the appropriate primary key.
- Verify primary key uniqueness.
- Detect exact duplicate records.

=========================================================*/

/*---------------------------------------------------------
 Determine the Dataset Grain
-----------------------------------------------------------

Objective:
Identify the level of detail represented by each record
and determine the appropriate primary key.

---------------------------------------------------------*/

-- Count the total number of records

SELECT COUNT(*) AS total_rows
FROM DataCo_raw;

-- Count distinct Order Item IDs

SELECT COUNT(DISTINCT [Order Item Id]) AS distinct_order_item_ids
FROM DataCo_raw;

-- Count distinct Order IDs

SELECT COUNT(DISTINCT [Order Id]) AS distinct_order_ids
FROM DataCo_raw;

/*
Findings

Total Rows              : 180,519
Distinct Order Item IDs : 180,519
Distinct Order IDs      : 65,752

Each Order Item Id uniquely identifies one record, while
multiple Order Item IDs can belong to the same Order Id.

Therefore, the dataset is stored at the order-line level,
where each row represents a single product within an order.
*/
/*---------------------------------------------------------
 Validate Primary Key Uniqueness
-----------------------------------------------------------

Objective:
Verify that Order Item Id uniquely identifies every record.

---------------------------------------------------------*/

SELECT
    [Order Item Id],
    COUNT(*) AS duplicate_count
FROM DataCo_raw
GROUP BY [Order Item Id]
HAVING COUNT(*) > 1;

/*
Findings

No duplicate Order Item IDs were found.

Order Item Id is confirmed as the primary key for this
dataset.
*/

/*---------------------------------------------------------
 Check for Exact Duplicate Records
-----------------------------------------------------------

Objective:
Identify duplicate business records by comparing all
descriptive attributes except the primary key.

---------------------------------------------------------*/
WITH CTE_Duplicates AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY
                    Type,
                    [Days for shipping (real)],
                    [Days for shipment (scheduled)],
                    [Benefit per order],
                    [Sales per customer],
                    [Delivery Status],
                    [Late_delivery_risk],
                    [Category Id],
                    [Category Name],
                    [Customer City],
                    [Customer Country],
                    [Customer Email],
                    [Customer Fname],
                    [Customer Id],
                    [Customer Lname],
                    [Customer Password],
                    [Customer Segment],
                    [Customer State],
                    [Customer Street],
                    [Customer Zipcode],
                    [Department Id],
                    [Department Name],
                    Latitude,
                    Longitude,
                    Market,
                    [Order City],
                    [Order Country],
                    [Order Customer Id],
                    [order date (DateOrders)],
                    [Order Id],
                    [Order Item Cardprod Id],
                    [Order Item Discount],
                    [Order Item Discount Rate],
                    [Order Item Product Price],
                    [Order Item Profit Ratio],
                    [Order Item Quantity],
                    Sales,
                    [Order Item Total],
                    [Order Profit Per Order],
                    [Order Region],
                    [Order State],
                    [Order Status],
                    [Order Zipcode],
                    [Product Card Id],
                    [Product Category Id],
                    [Product Description],
                    [Product Image],
                    [Product Name],
                    [Product Price],
                    [Product Status],
                    [shipping date (DateOrders)],
                    [Shipping Mode]
               ORDER BY [Order Item Id]
           ) AS row_num
    FROM DataCo_raw
)

SELECT *
FROM CTE_Duplicates
WHERE row_num > 1;


/*
Findings

No exact duplicate business records were identified.

No duplicate rows need to be removed during the data
cleaning process.
*/

/*=========================================================
 MISSING VALUE ASSESSMENT
===========================================================

Objective:
Assess the dataset for missing values and determine whether
they require data cleaning or have a valid business
explanation.

This section includes:
- Identification of NULL values
- Investigation of missing ZIP codes
- Inspection of categorical variables

=========================================================*/


/*---------------------------------------------------------
 Identify NULL Values
-----------------------------------------------------------

Objective:
Count the number of NULL values in each column to identify
missing information requiring further investigation.

---------------------------------------------------------*/

SELECT
    SUM(CASE WHEN [Type] IS NULL THEN 1 ELSE 0 END) AS type_nulls,
    SUM(CASE WHEN [Days for shipping (real)] IS NULL THEN 1 ELSE 0 END) AS days_shipping_real_nulls,
    SUM(CASE WHEN [Days for shipment (scheduled)] IS NULL THEN 1 ELSE 0 END) AS days_shipment_scheduled_nulls,
    SUM(CASE WHEN [Benefit per order] IS NULL THEN 1 ELSE 0 END) AS benefit_per_order_nulls,
    SUM(CASE WHEN [Sales per customer] IS NULL THEN 1 ELSE 0 END) AS sales_per_customer_nulls,
    SUM(CASE WHEN [Delivery Status] IS NULL THEN 1 ELSE 0 END) AS delivery_status_nulls,
    SUM(CASE WHEN [Late_delivery_risk] IS NULL THEN 1 ELSE 0 END) AS late_delivery_risk_nulls,
    SUM(CASE WHEN [Category Id] IS NULL THEN 1 ELSE 0 END) AS category_id_nulls,
    SUM(CASE WHEN [Category Name] IS NULL THEN 1 ELSE 0 END) AS category_name_nulls,
    SUM(CASE WHEN [Customer City] IS NULL THEN 1 ELSE 0 END) AS customer_city_nulls,
    SUM(CASE WHEN [Customer Country] IS NULL THEN 1 ELSE 0 END) AS customer_country_nulls,
    SUM(CASE WHEN [Customer Email] IS NULL THEN 1 ELSE 0 END) AS customer_email_nulls,
    SUM(CASE WHEN [Customer Fname] IS NULL THEN 1 ELSE 0 END) AS customer_fname_nulls,
    SUM(CASE WHEN [Customer Id] IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN [Customer Lname] IS NULL THEN 1 ELSE 0 END) AS customer_lname_nulls,
    SUM(CASE WHEN [Customer Password] IS NULL THEN 1 ELSE 0 END) AS customer_password_nulls,
    SUM(CASE WHEN [Customer Segment] IS NULL THEN 1 ELSE 0 END) AS customer_segment_nulls,
    SUM(CASE WHEN [Customer State] IS NULL THEN 1 ELSE 0 END) AS customer_state_nulls,
    SUM(CASE WHEN [Customer Street] IS NULL THEN 1 ELSE 0 END) AS customer_street_nulls,
    SUM(CASE WHEN [Customer Zipcode] IS NULL THEN 1 ELSE 0 END) AS customer_zipcode_nulls,
    SUM(CASE WHEN [Department Id] IS NULL THEN 1 ELSE 0 END) AS department_id_nulls,
    SUM(CASE WHEN [Department Name] IS NULL THEN 1 ELSE 0 END) AS department_name_nulls,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS latitude_nulls,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS longitude_nulls,
    SUM(CASE WHEN Market IS NULL THEN 1 ELSE 0 END) AS market_nulls,
    SUM(CASE WHEN [Order City] IS NULL THEN 1 ELSE 0 END) AS order_city_nulls,
    SUM(CASE WHEN [Order Country] IS NULL THEN 1 ELSE 0 END) AS order_country_nulls,
    SUM(CASE WHEN [Order Customer Id] IS NULL THEN 1 ELSE 0 END) AS order_customer_id_nulls,
    SUM(CASE WHEN [order date (DateOrders)] IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN [Order Id] IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN [Order Item Cardprod Id] IS NULL THEN 1 ELSE 0 END) AS order_item_cardprod_id_nulls,
    SUM(CASE WHEN [Order Item Discount] IS NULL THEN 1 ELSE 0 END) AS order_item_discount_nulls,
    SUM(CASE WHEN [Order Item Discount Rate] IS NULL THEN 1 ELSE 0 END) AS order_item_discount_rate_nulls,
    SUM(CASE WHEN [Order Item Id] IS NULL THEN 1 ELSE 0 END) AS order_item_id_nulls,
    SUM(CASE WHEN [Order Item Product Price] IS NULL THEN 1 ELSE 0 END) AS order_item_product_price_nulls,
    SUM(CASE WHEN [Order Item Profit Ratio] IS NULL THEN 1 ELSE 0 END) AS order_item_profit_ratio_nulls,
    SUM(CASE WHEN [Order Item Quantity] IS NULL THEN 1 ELSE 0 END) AS order_item_quantity_nulls,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN [Order Item Total] IS NULL THEN 1 ELSE 0 END) AS order_item_total_nulls,
    SUM(CASE WHEN [Order Profit Per Order] IS NULL THEN 1 ELSE 0 END) AS order_profit_per_order_nulls,
    SUM(CASE WHEN [Order Region] IS NULL THEN 1 ELSE 0 END) AS order_region_nulls,
    SUM(CASE WHEN [Order State] IS NULL THEN 1 ELSE 0 END) AS order_state_nulls,
    SUM(CASE WHEN [Order Status] IS NULL THEN 1 ELSE 0 END) AS order_status_nulls,
    SUM(CASE WHEN [Order Zipcode] IS NULL THEN 1 ELSE 0 END) AS order_zipcode_nulls,
    SUM(CASE WHEN [Product Card Id] IS NULL THEN 1 ELSE 0 END) AS product_card_id_nulls,
    SUM(CASE WHEN [Product Category Id] IS NULL THEN 1 ELSE 0 END) AS product_category_id_nulls,
    SUM(CASE WHEN [Product Description] IS NULL THEN 1 ELSE 0 END) AS product_description_nulls,
    SUM(CASE WHEN [Product Image] IS NULL THEN 1 ELSE 0 END) AS product_image_nulls,
    SUM(CASE WHEN [Product Name] IS NULL THEN 1 ELSE 0 END) AS product_name_nulls,
    SUM(CASE WHEN [Product Price] IS NULL THEN 1 ELSE 0 END) AS product_price_nulls,
    SUM(CASE WHEN [Product Status] IS NULL THEN 1 ELSE 0 END) AS product_status_nulls,
    SUM(CASE WHEN [shipping date (DateOrders)] IS NULL THEN 1 ELSE 0 END) AS shipping_date_nulls,
    SUM(CASE WHEN [Shipping Mode] IS NULL THEN 1 ELSE 0 END) AS shipping_mode_nulls
FROM DataCo_raw;


/*
Findings

• Customer Zipcode contains 3 missing values.
• Order Zipcode contains 155,679 missing values.
• Product Description contains only NULL values.
• No other columns contain missing values.

Further investigation is required to determine whether
the missing ZIP codes represent data quality issues or
expected business behavior.
*/

/*---------------------------------------------------------
 Investigate Missing Order ZIP Codes
-----------------------------------------------------------

Objective:
Determine whether missing Order Zipcode values represent
data quality issues or are expected based on the order's
destination country.

---------------------------------------------------------*/

SELECT
    [Order Country],
    COUNT(*) AS total_orders,
    COUNT([Order Zipcode]) AS zipcode_available
FROM DataCo_raw
GROUP BY [Order Country]
ORDER BY total_orders DESC;

/*
Findings

Order ZIP codes are available only for orders shipped
within the United States.

For all other countries, missing ZIP codes are expected
and do not represent a data quality issue.

No imputation or row removal is required.
*/

/*---------------------------------------------------------
 Inspect Categorical Variables
-----------------------------------------------------------

Objective:
Review low-cardinality categorical variables to identify:

- Blank values
- Placeholder values (e.g. Unknown, N/A)
- Inconsistent category names

---------------------------------------------------------*/

SELECT Distinct [Category Name]
FROM DataCo_raw
ORDER BY [Category Name];

SELECT Distinct [Customer City]
FROM DataCo_raw
ORDER BY [Customer City];


SELECT Distinct [Customer Country]
FROM DataCo_raw
ORDER BY [Customer Country];

SELECT Distinct [Customer Fname]
FROM DataCo_raw
ORDER by [Customer Fname];

SELECT Distinct [Customer Lname]
FROM DataCo_raw;

SELECT Distinct [Customer Segment]
FROM DataCo_raw;

SELECT Distinct [Customer State]
FROM DataCo_raw;

SELECT Distinct [Customer Street]
FROM DataCo_raw;

SELECT Distinct [Department Name]
FROM DataCo_raw;

SELECT Distinct Market
FROM DataCo_raw;

SELECT Distinct [Order City]
FROM DataCo_raw
ORDER BY [Order City]

SELECT Distinct [Order Country]
FROM DataCo_raw;

SELECT Distinct [Order Region]
FROM DataCo_raw;

SELECT Distinct [Order State]
FROM DataCo_raw;

SELECT Distinct [Order Status]
FROM DataCo_raw;

SELECT Distinct [Order Zipcode]
FROM DataCo_raw;

SELECT Distinct [Product Description]
FROM DataCo_raw;
-- all null

SELECT Distinct [Product Name]
FROM DataCo_raw;

SELECT Distinct [Shipping Mode]
FROM DataCo_raw;

/*
Findings

No blank values, placeholder values, or inconsistent
category labels were identified within the inspected
categorical variables.

No cleaning actions are required.
*/

/*=========================================================
 TEXT QUALITY ASSESSMENT
===========================================================

Objective:
Assess the quality of categorical text fields by checking
for leading or trailing whitespace that could create
duplicate categories or inaccurate aggregations during
analysis.
=========================================================*/


/*---------------------------------------------------------
 Check for Leading and Trailing Whitespace
-----------------------------------------------------------

Objective:
Identify text values containing unnecessary leading or
trailing spaces.

These spaces may cause identical categories to be treated
as different values during reporting and visualization.

---------------------------------------------------------*/
SELECT *
FROM DataCo_raw
WHERE [Category Name] <> LTRIM(RTRIM([Category Name]));


SELECT *
FROM DataCo_raw
WHERE [Customer Country] <> LTRIM(RTRIM([Customer Country]));


SELECT *
FROM DataCo_raw
WHERE [Customer Segment] <> LTRIM(RTRIM([Customer Segment]));

SELECT *
FROM DataCo_raw
WHERE [Department Name] <> LTRIM(RTRIM([Department Name]));

SELECT *
FROM DataCo_raw
WHERE Market <> LTRIM(RTRIM(Market));

SELECT *
FROM DataCo_raw
WHERE [Order Country] <> LTRIM(RTRIM([Order Country]));

SELECT *
FROM DataCo_raw
WHERE [Order Region] <> LTRIM(RTRIM([Order Region]));

SELECT *
FROM DataCo_raw
WHERE [Order Status] <> LTRIM(RTRIM([Order Status]));


SELECT *
FROM DataCo_raw
WHERE [Shipping Mode] <> LTRIM(RTRIM([Shipping Mode]));


SELECT *
FROM DataCo_raw
WHERE [Delivery Status] <> LTRIM(RTRIM([Delivery Status]));
/*
Findings

No leading or trailing whitespace was detected in the
assessed categorical variables.

No trimming is required.
*/

/*=========================================================
 DATE VALIDATION
===========================================================

Objective:
Validate the completeness and consistency of the date
fields used throughout the dataset.

The following checks are performed:

- Missing dates
- Chronological consistency
- Shipping duration consistency

=========================================================*/
/*---------------------------------------------------------
 Check for Missing Dates
---------------------------------------------------------*/
SELECT *
FROM DataCo_raw
WHERE [order date (DateOrders)] IS NULL
   OR [shipping date (DateOrders)] IS NULL;

/*
Findings

No missing order dates or shipping dates were identified.
*/

/*---------------------------------------------------------
 Validate Date Sequence
-----------------------------------------------------------

Objective:
Ensure that shipping dates do not occur before the
corresponding order dates.

---------------------------------------------------------*/
SELECT *
FROM DataCo_raw
WHERE [shipping date (DateOrders)] <
      [order date (DateOrders)];
/*
Findings

No records were found where the shipping date precedes
the order date.
*/


/*---------------------------------------------------------
 Validate Shipping Duration
-----------------------------------------------------------

Objective:
Verify that the recorded shipping duration matches the
difference between the order date and shipping date.

---------------------------------------------------------*/

SELECT
    [order date (DateOrders)],
    [shipping date (DateOrders)],
    [Days for shipping (real)],
    DATEDIFF(day,
             [order date (DateOrders)],
             [shipping date (DateOrders)]) AS calculated_days
FROM DataCo_raw
WHERE DATEDIFF(day,
             [order date (DateOrders)],
             [shipping date (DateOrders)])
<> [Days for shipping (real)];

/*
Findings

The recorded shipping duration is consistent with the
difference between the order and shipping dates.

No inconsistencies were identified.
*/

/*=========================================================
 BUSINESS RULE VALIDATION
===========================================================

Objective:
Verify that key business variables contain logically valid
values before creating the cleaned dataset.

=========================================================*/
SELECT * 
FROM DataCo_raw
WHERE [Order Item Quantity] <=0;


SELECT * 
FROM DataCo_raw
WHERE [Product Price] = 0;

SELECT * 
FROM DataCo_raw
WHERE Sales <=0;

SELECT * 
FROM DataCo_raw
WHERE [Order Item Discount Rate] between 0 AND 1;

SELECT * 
FROM DataCo_raw
WHERE Late_delivery_risk in (0, 1);


/*
Findings
No invalid business values were found.
/*=========================================================

 4. COLUMN REDUNDANCY ASSESSMENT

===========================================================

Objective:

Identify columns containing duplicate information before

creating the cleaned analytical dataset.

The assessment focuses on:

- Customer identifiers

- Product identifiers

- Financial metrics
=========================================================*/
---------------------------------------------------------
 Customer Identifier Check
---------------------------------------------------------*/
SELECT COUNT(*) AS mismatch_count

FROM DataCo_raw

WHERE [Customer Id] <> [Order Customer Id]

   OR ([Customer Id] IS NULL AND [Order Customer Id] IS NOT NULL)

   OR ([Customer Id] IS NOT NULL AND [Order Customer Id] IS NULL);

/*---------------------------------------------------------

 Product Identifier Check

---------------------------------------------------------*/
SELECT COUNT(*) AS mismatch_count

FROM DataCo_raw

WHERE [Product Card Id] <> [Order Item Cardprod Id]

   OR ([Product Card Id] IS NULL AND [Order Item Cardprod Id] IS NOT NULL)

   OR ([Product Card Id] IS NOT NULL AND [Order Item Cardprod Id] IS NULL);

/*---------------------------------------------------------

 Financial Metric Check
---------------------------------------------------------*/
SELECT COUNT(*) AS mismatch_count

FROM DataCo_raw

WHERE [Benefit per order] <> [Order Profit Per Order]

   OR ([Benefit per order] IS NULL AND [Order Profit Per Order] IS NOT NULL)

   OR ([Benefit per order] IS NOT NULL AND [Order Profit Per Order] IS NULL);
/*
The redundancy assessment identified identical values across:
• Customer Id and Order Customer Id

• Product Card Id and Order Item Cardprod Id

• Benefit per order and Order Profit Per Order

Decisions:
• Keep Customer Id as the customer identifier and exclude Order Customer Id from DataCo_Clean.

• Keep Product Card Id as the product identifier and exclude Order Item Cardprod Id from DataCo_Clean.

• Keep Order Profit Per Order as the profit metric because it provides a clearer business interpretation and exclude Benefit per order.




*/
/*=========================================================

5. CREATE CLEAN TABLE

===========================================================

Objective:

Create a cleaned version of the dataset by:

- Converting data types

- Renaming columns using SQL-friendly names

- Excluding unnecessary and redundant columns

The raw table remains unchanged.

=========================================================*/

SELECT

    /*-----------------------------------------------------
      Order Information
    -----------------------------------------------------*/

    CAST([Order Id] AS INT) AS order_id,
    [order date (DateOrders)] AS order_date,
    [shipping date (DateOrders)] AS shipping_date,
    [Type] AS order_type,
    [Order Status] AS order_status,
    [Order Region] AS order_region,
    [Order Country] AS order_country,
    [Order State] AS order_state,
    [Order City] AS order_city,
    [Order Zipcode] AS order_zipcode,

    /*-----------------------------------------------------
      Order Item Information
    -----------------------------------------------------*/

    CAST([Order Item Id] AS INT) AS order_item_id,
    CAST([Order Item Quantity] AS INT) AS order_item_quantity,
    [Order Item Product Price] AS order_item_product_price,
    [Order Item Discount] AS order_item_discount,
    [Order Item Discount Rate] AS order_item_discount_rate,
    [Order Item Total] AS order_item_total,
    [Order Item Profit Ratio] AS order_item_profit_ratio,

    /*-----------------------------------------------------
      Product Information
    -----------------------------------------------------*/

    CAST([Product Card Id] AS INT) AS product_card_id,
    CAST([Product Category Id] AS INT) AS product_category_id,
    [Product Name] AS product_name,
    [Product Price] AS product_price,

    /*-----------------------------------------------------
      Customer Information
    -----------------------------------------------------*/

    CAST([Customer Id] AS INT) AS customer_id,
    [Customer Fname] AS customer_fname,
    [Customer Lname] AS customer_lname,
    [Customer Segment] AS customer_segment,
    [Customer Country] AS customer_country,
    [Customer State] AS customer_state,
    [Customer City] AS customer_city,
    CAST([Customer Zipcode] AS NVARCHAR(255)) AS customer_zipcode,

    /*-----------------------------------------------------
      Category & Department
    -----------------------------------------------------*/

    CAST([Category Id] AS INT) AS category_id,
    [Category Name] AS category_name,
    CAST([Department Id] AS INT) AS department_id,
    [Department Name] AS department_name,

    /*-----------------------------------------------------
      Shipping Information
    -----------------------------------------------------*/

    CAST([Days for shipping (real)] AS INT) AS days_shipping_real,
    CAST([Days for shipment (scheduled)] AS INT) AS days_shipment_scheduled,
    CAST([Late_delivery_risk] AS INT) AS late_delivery_risk,
    [Delivery Status] AS delivery_status,
    [Shipping Mode] AS shipping_mode,

    /*-----------------------------------------------------
      Financial Information
    -----------------------------------------------------*/

    [Sales per customer] AS sales_per_customer,
    Sales AS sales,
    [Order Profit Per Order] AS order_profit_per_order,

    /*-----------------------------------------------------
      Geographic Information
    -----------------------------------------------------*/

    Market AS market,
    Latitude AS latitude,
    Longitude AS longitude

INTO DataCo_Clean

FROM DataCo_raw;
/*=========================================================
 Validation
=========================================================*/

-- Verify row count
SELECT COUNT(*) AS total_rows
FROM DataCo_Clean;

-- Verify column count
SELECT COUNT(COLUMN_NAME) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DataCo_Clean';

-- Preview cleaned dataset
SELECT TOP (10) *
FROM DataCo_Clean;
