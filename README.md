# DataCo Commercial Distribution Analysis

A SQL and Power BI project analyzing DataCo's global commercial distribution operations to evaluate sales performance, profitability, customer behavior, product performance, logistics efficiency, pricing strategy, and geographic markets.

The project aims to identify the main drivers of business performance, uncover operational challenges, and provide data-driven recommendations to support better commercial decision-making.

---

# Dashboard

<p align="center">
  <img src="PowerBi/Executive%20overview.png" width="48%">
  <img src="PowerBi/Sales%20and%20product%20Performance.png" width="48%">
</p>

<p align="center">
  <img src="PowerBi/Shipping%20Performance.png" width="48%">
  <img src="PowerBi/Customer%20and%20market%20insights.png" width="48%">
</p>


## Interactive Dashboard

🌐 **Power BI Service**

[Open Interactive Dashboard](https://app.powerbi.com/groups/me/reports/56cd5b8a-adf0-4034-b5db-f989c991de1e/03cdbdb9b6e6300d6a93?language=fr-FR&experience=power-bi)


## 📥 Power BI File

[Commercial Distribution Performance dashboard.pbix](PowerBi/Commercial%20Distribution%20Performance%20dashboard.pbix)


### Power BI Service Visualization Note

Some visuals may not appear correctly in Power BI Service due to platform limitations:

- The **map visual** may require geographic permissions and may not render depending on Power BI Service settings.
- The **scatter chart visual** may not display correctly online due to visualization compatibility limitations.

For complete access to all visuals and interactions, download and open the `.pbix` file using Power BI Desktop.

---

# Business Problem

DataCo operates a global commercial distribution business across multiple markets, products, and customer segments.

Without a detailed understanding of the factors influencing sales, profitability, operational efficiency, and customer behavior, business resources may not be allocated effectively.

The company needs to identify:

- Which products and categories generate the highest value.
- Which markets contribute most to revenue and profit.
- Which customer segments drive business performance.
- Whether logistics operations affect customer experience.
- How pricing strategies influence sales and profitability.

---

# Business Objective

Evaluate DataCo's commercial performance by analyzing sales, profit, customers, products, operations, logistics, pricing, and geographic markets.

The objective is to identify key business drivers, uncover operational challenges, and translate analytical findings into actionable recommendations for improving commercial performance.

---

# Business Question

How can DataCo improve its commercial performance by understanding the factors that drive sales, profit, customer purchasing behavior, product performance, logistics efficiency, and geographic performance?

---

# Project Scope

This project focuses on:

- Cleaning and preparing the DataCo dataset using SQL.
- Performing exploratory data analysis to evaluate business performance.
- Identifying patterns in sales, profit, products, customers, markets, logistics, and pricing.
- Developing an interactive Power BI dashboard to communicate insights.
- Providing business recommendations based on analytical findings.

---

# Dataset

| Attribute | Value |
|---|---|
| Source | DataCo Smart Supply Chain for Big Data Analysis |
| Records | 180,519 order-line records |
| Grain | Order Item Level |
| Orders | 65,752 |
| Customers | 20,652 |
| Products | 118 |
| Countries | 164 |
| Markets | 5 |
| Time Period | January 2015 - January 2018 |

Due to GitHub file size limitations, the dataset is not uploaded directly in this repository.

Dataset Source:

[DataCo Smart Supply Chain Dataset](https://data.mendeley.com/datasets/8gx2fvg2k6/5)

---

# Tools & Technologies

| Category | Tool |
|---|---|
| Database | SQL Server |
| Query Language | SQL (T-SQL) |
| Data Cleaning | SQL |
| Exploratory Data Analysis | SQL |
| Data Visualization | Power BI |
| Version Control | Git & GitHub |
| Documentation | Microsoft Word |

---

# Project Workflow

```
Raw Dataset
      │
      ▼
Data Cleaning (SQL)
      │
      ▼
Exploratory Data Analysis (SQL)
      │
      ▼
Business Insights
      │
      ▼
Power BI Dashboard
      │
      ▼
Business Recommendations
      │
      ▼
Executive Summary
```

---

# SQL Analysis

All SQL scripts are available in the `sql` folder.

## Data Cleaning

The raw dataset was transformed into an analysis-ready dataset.

The cleaning process included:

- Data type conversion.
- SQL-friendly column renaming.
- Column redundancy assessment.
- Removal of unnecessary attributes.
- Exclusion of duplicate information.
- Creation of the cleaned analytical dataset.

📄 SQL Script:

[01_Data_cleaning.sql](sql/01_Data_cleaning.sql)

---

## Exploratory Data Analysis

The exploratory analysis was performed using SQL to answer business questions across multiple areas.

📄 SQL Script:

[02_Exploratory_Data_analysis.sql](sql/02_Exploratory_Data_analysis.sql)


Analysis areas:

| Analysis Area | Description |
|---|---|
| Business Overview | Overall business size, customers, orders, products, and markets |
| Financial Performance | Sales, profit, margins, and loss-making transactions |
| Product Performance | Product, category, and department contribution |
| Customer Performance | Customer segments and high-value customers |
| Geographic Performance | Market, country, region, and city performance |
| Logistics Performance | Shipping efficiency and delivery performance |
| Order Operations | Order status and fulfillment process |
| Business Trends | Sales, profit, and order evolution over time |
| Pricing Strategy | Discount impact on sales and profitability |
| Customer Purchasing Behavior | Basket size, frequency, and customer value |
| Business Performance Interactions | Relationships between markets, products, customers, and logistics |

---

# Key Findings

| Analysis Area | Key Finding |
|---|---|
| Overall Performance | DataCo generated $36.78M in sales and $3.97M in profit between 2015 and 2018 |
| Profitability | Overall profit margin reached 10.78%, but 21.15% of orders generated losses |
| Product Performance | Fishing category generated approximately 19% of total sales and profit |
| Department Performance | Fan Shop accounted for nearly 47% of company sales and profit |
| Customer Performance | Consumer segment contributed around 52% of orders, sales, and profit |
| Geographic Performance | Europe was the strongest market, contributing around 29.6% of sales |
| Logistics | 54.8% of orders were delivered late, representing the main operational challenge |
| Shipping | Standard Class represented approximately 60% of shipments |
| Order Operations | Only around one-third of orders reached Complete status |
| Pricing Strategy | Low and medium discounts generated approximately 83% of sales and 84% of profit |
| Business Trends | Sales and profit remained relatively stable throughout the analyzed period |

---

# Business Recommendations

### 1. Improve Delivery Performance

More than half of orders were delivered late. DataCo should improve warehouse coordination, inventory planning, and carrier performance monitoring.

### 2. Reduce Dependence on Limited Product Categories

The business relies heavily on Fishing products and the Fan Shop department. Expanding other product categories would reduce commercial risk.

### 3. Investigate Loss-Making Orders

Approximately 21% of orders generated losses. These transactions should be analyzed based on discounts, shipping costs, products, and destinations.

### 4. Focus on High-Performing Markets

Europe, LATAM, and Pacific Asia represent the strongest markets and should remain priorities for commercial investment.

### 5. Maintain Controlled Discounting

Moderate discounts generate most sales and profit. Increasing discounts may reduce profitability without guaranteeing additional value.

### 6. Improve Order Processing Efficiency

Reducing pending and processing orders can improve customer satisfaction and accelerate revenue realization.

---

# Repository Structure

```
DataCo-Commercial-Distribution-Analysis/

│
├── sql/
│   ├── 01_Data_cleaning.sql
│   └── 02_Exploratory_Data_analysis.sql
│
├── PowerBi/
│   ├── Commercial Distribution Performance dashboard.pbix
│   ├── Executive overview.png
│   ├── Sales and product Performance.png
│   ├── Shipping Performance.png
│   └── Customer and market insights.png
│
├── Reports/
│   └── Executive Summary.pdf
│
└── README.md
```

---

# Executive Summary

A detailed business report summarizing the methodology, analytical approach, key findings, and recommendations is available below.

📄 [Executive Summary.pdf](Reports/%20Executive%20Summary.pdf)

---

# Future Improvements

Future work could extend this project by:

- Building predictive models to forecast sales and profitability.
- Developing customer segmentation models.
- Applying machine learning techniques to predict purchasing behavior.
- Creating automated reporting pipelines using Python and Power BI.
- Integrating real-time supply chain monitoring dashboards.

---

# Author

**Farah Bensalem**

GitHub:  
https://github.com/FARAHBENSALEM01

LinkedIn:  
https://www.linkedin.com/in/farah-bensalem/
