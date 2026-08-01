# Commercial Distribution Performance Analysis

An end-to-end SQL and Power BI project analyzing DataCo's global commercial distribution operations to evaluate sales performance, profitability, customer purchasing behavior, product performance, logistics efficiency, pricing strategy, and geographic markets.

The project transforms raw transactional data into business insights through data cleaning, exploratory analysis, and interactive visualization, supporting data-driven commercial and operational decision-making.

---

# Dashboard

<p align="center">
  <img src="PowerBi/Executive%20overview.png" width="48%">
  <img src="PowerBi/Sales%20and%20product%20Performance.png" width="48%">
</p>

<p align="center">
  <img src="PowerBi/Customer%20and%20market%20insights.png" width="48%">
  <img src="PowerBi/Shipping%20Performance.png" width="48%">
</p>

---

# Interactive Dashboard

🌐 **Power BI Service**

[Open Interactive Dashboard](https://app.powerbi.com/groups/me/reports/56cd5b8a-adf0-4034-b5db-f989c991de1e/03cdbdb9b6e6300d6a93?language=fr-FR&experience=power-bi)

---

# 📥 Power BI File

[Commercial Distribution Performance dashboard.pbix](PowerBi/Commercial%20Distribution%20Performance%20dashboard.pbix)

---

# Power BI Service Visualization Note

> **Note:** Some Microsoft organizational (work or school) Power BI tenants restrict Bing/Azure Maps services. If the map visual does not render in the published report, dashboard screenshots are included in this repository to provide a complete view of the analysis. The `.pbix` file can also be opened locally using Power BI Desktop to access all visuals and interactions.

---

# Business Problem

DataCo operates a global commercial distribution network across multiple products, customer segments, and geographic markets.

Without a clear understanding of the factors influencing sales performance, profitability, logistics operations, and customer purchasing behavior, commercial resources may not be allocated efficiently and operational issues may remain unnoticed.

The company needs to understand:

- Which products, categories, and departments generate the highest business value.
- Which markets contribute most to sales and profit.
- Which customer segments drive business performance.
- Whether logistics operations affect customer experience.
- How pricing strategies influence sales and profitability.

---

# Business Objective

Evaluate DataCo's commercial distribution performance by analyzing sales, profitability, customer purchasing behavior, product contribution, logistics operations, pricing strategy, and geographic markets.

The objective is to identify the factors that influence business performance, highlight operational inefficiencies, and provide recommendations that support commercial and operational decision-making.

---

# Business Questions

This project addresses the following business questions:

- Which markets contribute the most to sales and profit?
- Which products, categories, and departments generate the highest business value?
- Which customer segments contribute most to revenue and profitability?
- How efficiently are orders delivered across shipping methods and markets?
- How do discount levels affect sales and profit?
- Which operational issues have the greatest impact on overall business performance?
- How have sales and profitability evolved between 2015 and 2018?
---

# Project Scope

This project covers the complete analytics workflow, from raw data preparation to business reporting.

The analysis includes:

- Cleaning and preparing the DataCo dataset using SQL Server.
- Performing exploratory data analysis to evaluate business performance.
- Analyzing sales, profit, products, customers, markets, logistics, and pricing.
- Building a dimensional data model in Power BI.
- Developing an interactive dashboard to communicate business performance.
- Providing business recommendations based on analytical findings.

---

# Dataset

| Attribute | Value |
|-----------|-------|
| Dataset | DataCo Smart Supply Chain for Big Data Analysis |
| Source | Mendeley Data |
| Records | 180,519 order-line records |
| Data Grain | Order Item Level |
| Orders | 65,752 |
| Customers | 20,652 |
| Products | 118 |
| Categories | 51 |
| Departments | 11 |
| Countries | 164 |
| Markets | 5 |
| Time Period | January 2015 – January 2018 |

Due to GitHub file size limitations, the dataset is not included in this repository.

**Dataset Source**

https://data.mendeley.com/datasets/8gx2fvg2k6/5

---

# Tools & Technologies

| Category | Technology |
|-----------|------------|
| Database | SQL Server |
| Query Language | SQL (T-SQL) |
| Data Cleaning | SQL |
| Exploratory Data Analysis | SQL |
| Data Modeling | Power BI |
| Data Visualization | Power BI |
| Version Control | Git & GitHub |
| Documentation | Markdown & Microsoft Word |

---

# Project Workflow

```text
                 Raw Dataset
                      │
                      ▼
            Data Cleaning (SQL)
                      │
                      ▼
     Exploratory Data Analysis (SQL)
                      │
                      ▼
        Power BI Data Modeling
                      │
                      ▼
      Dashboard Development (Power BI)
                      │
                      ▼
             Business Insights
                      │
                      ▼
        Business Recommendations
```

---

# Dashboard Structure

The dashboard is organized into four business-focused pages.

| Dashboard Page | Business Focus |
|----------------|----------------|
| Executive Overview | High-level business performance and key performance indicators |
| Sales & Product Performance | Product, category, department, and financial performance |
| Customer & Market Insights | Customer behavior and geographic performance |
| Shipping Performance | Logistics efficiency, delivery performance, and operational analysis |
---

# SQL Analysis

SQL Server was used throughout the project to prepare the data, validate data quality, and perform exploratory analysis before building the Power BI dashboard.

The SQL workflow consisted of two main stages:

1. Data Cleaning and Validation
2. Exploratory Data Analysis (EDA)

All SQL scripts are available in the **sql** folder.

---

# Data Cleaning & Validation

The raw dataset was validated and transformed into an analysis-ready dataset suitable for business analysis and Power BI modeling.

The cleaning process included:

- Standardizing data types.
- Renaming columns using SQL-friendly naming conventions.
- Validating the dataset grain at the **Order Item** level.
- Assessing missing values and redundant attributes.
- Removing non-analytical columns and duplicate information.
- Verifying record uniqueness.
- Creating the final cleaned analytical dataset.

### Data Quality Checks

The cleaning process also included several validation steps to ensure data consistency before analysis:

- Verified duplicate records.
- Checked missing values across all variables.
- Validated key identifiers.
- Assessed unnecessary and low-value attributes.
- Confirmed date consistency.
- Verified numerical fields before analysis.

### Output

The result of the cleaning process was a structured analytical dataset used throughout the SQL analysis and Power BI dashboard.

📄 **SQL Script**

[01_Data_cleaning.sql](sql/01_Data_cleaning.sql)

---

# Exploratory Data Analysis

After data preparation, exploratory analysis was performed using SQL to evaluate commercial performance across financial, operational, customer, product, and logistics dimensions.

The objective of the analysis was to identify business patterns, performance drivers, and operational issues that could support commercial decision-making.

📄 **SQL Script**

[02_Exploratory_Data_analysis.sql](sql/02_Exploratory_Data_analysis.sql)

---

## Analysis Areas

| Analysis Area | Business Focus |
|---------------|----------------|
| Business Overview | Business size, orders, customers, products, countries, and markets |
| Financial Performance | Sales, profit, profit margin, and loss-making transactions |
| Product Performance | Product, category, and department contribution |
| Customer Performance | Customer segments, purchasing behavior, and customer value |
| Geographic Performance | Market, country, region, and city performance |
| Logistics Performance | Shipping efficiency and delivery performance |
| Order Operations | Order status and fulfillment performance |
| Business Trends | Sales, profit, and order evolution over time |
| Pricing Strategy | Relationship between discounts and profitability |
| Customer Purchasing Behavior | Basket size, purchase frequency, and average customer value |
| Cross-Dimensional Analysis | Relationships between products, customers, markets, and logistics |
---

# Key Findings

The analysis revealed several important patterns across DataCo's commercial distribution operations.

| Business Area | Finding | Business Implication |
|---------------|----------|----------------------|
| Overall Performance | DataCo generated **$36.78M** in sales and **$3.97M** in profit between 2015 and 2018. | The business maintained stable commercial activity throughout the analysis period. |
| Profitability | Overall profit margin reached **10.78%**, while **21.15%** of orders generated losses. | A considerable share of transactions reduced profitability despite positive overall financial performance. |
| Product Performance | The **Fishing** category contributed approximately **19%** of total sales and profit. | Revenue is concentrated in a limited number of product categories. |
| Department Performance | The **Fan Shop** department generated nearly **47%** of company sales and profit. | Business performance depends heavily on a single department. |
| Customer Performance | The **Consumer** segment accounted for approximately **52%** of orders, sales, and profit. | Consumer customers represent the company's primary source of revenue. |
| Geographic Performance | **Europe** generated the highest sales and profit among all markets. | Europe represents the company's strongest commercial market. |
| Logistics Performance | **54.8%** of all orders were delivered late. | Delivery delays represent the most significant operational issue identified in the analysis. |
| Shipping Operations | **Standard Class** accounted for approximately **60%** of all shipments. | Most logistics activity relies on a single shipping method. |
| Order Fulfillment | A relatively small proportion of orders reached the **Complete** status. | The fulfillment process presents opportunities for operational improvement. |
| Pricing Strategy | Low and medium discount levels generated approximately **83%** of sales and **84%** of profit. | Moderate discounting supported sales while preserving profitability. |
| Business Trends | Sales and profit remained relatively stable throughout the three-year period. | No major long-term growth or decline was observed during the analysis period. |

---

# Business Recommendations

Based on the analytical findings, the following actions could improve commercial and operational performance.

### 1. Improve Delivery Performance

More than half of all orders were delivered late. Reviewing warehouse coordination, inventory planning, and carrier performance may reduce delivery delays and improve customer satisfaction.

---

### 2. Diversify Product Revenue

Sales and profit are highly concentrated in the **Fishing** category and the **Fan Shop** department. Expanding the contribution of other high-potential product categories would reduce commercial dependence on a limited product portfolio.

---

### 3. Investigate Loss-Making Transactions

Approximately one-fifth of all orders generated negative profit. Analyzing shipping costs, discount levels, destinations, and product mix would help identify the factors contributing to these losses.

---

### 4. Strengthen High-Performing Markets

Europe consistently generated the strongest commercial performance, while LATAM and Pacific Asia also delivered significant revenue. Maintaining investment in these markets while improving lower-performing regions could support balanced business growth.

---

### 5. Maintain Disciplined Discount Policies

Most revenue and profit were generated under low-to-moderate discount levels. Maintaining controlled discount strategies may protect profit margins while sustaining sales performance.

---

### 6. Improve Order Fulfillment Efficiency

Reducing the number of pending and processing orders could shorten fulfillment times, improve customer experience, and accelerate revenue realization.
---

# Repository Structure

```text
Commercial-Distribution-Performance-Analysis/
│
├── sql/
│   ├── 01_Data_cleaning.sql
│   └── 02_Exploratory_Data_analysis.sql
│
├── PowerBi/
│   ├── Commercial Distribution Performance dashboard.pbix
│   ├── Executive overview.png
│   ├── Sales and product Performance.png
│   ├── Customer and market insights.png
│   └── Shipping Performance.png
│
├── Reports/
│   └── Executive Summary.pdf
│
└── README.md
```

---

# Executive Summary

A detailed report summarizing the project methodology, analytical approach, key findings, and business recommendations is available below.

📄 **Executive Summary**

[Executive Summary.pdf](Reports/Executive%20Summary.pdf)

---

# Future Improvements

This project can be extended in several ways to support more advanced business analytics.

Possible improvements include:

- Forecast future sales and profit using time-series models.
- Develop customer segmentation using clustering techniques.
- Build predictive models to identify orders at risk of delivery delays.
- Automate the SQL–Power BI reporting workflow using Python.
- Integrate near real-time operational monitoring dashboards.

---

# Key Skills Demonstrated

This project demonstrates practical experience in:

- SQL data cleaning and validation
- Exploratory data analysis (EDA)
- Business performance analysis
- Star schema data modeling
- DAX measure development
- Interactive dashboard design
- Business storytelling
- Executive reporting
- Git and GitHub project documentation

---

# Author

**Farah Bensalem**

**GitHub**  
https://github.com/FARAHBENSALEM01

**LinkedIn**  
https://www.linkedin.com/in/farah-bensalem/
