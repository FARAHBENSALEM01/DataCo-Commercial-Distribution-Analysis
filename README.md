# Diagnosing Revenue Concentration and Delivery Failures in a Global Distribution Network

DataCo operates a global distribution business across **five markets, more than 20,000 customers, and 180,519 order-line records**. Despite generating positive overall profitability, the company faces operational inefficiencies and hidden commercial risks: more than half of orders arrive late, and approximately one in five transactions generates a loss.

This project investigates where underperformance is concentrated — across products, departments, markets, pricing decisions, and shipping operations — and identifies the areas leadership should prioritize first.

Using **SQL Server**, I cleaned and analyzed the dataset, validated business performance indicators, built a **star-schema data model**, and developed a **four-page Power BI dashboard** to support commercial and operational decision-making.

---

# Business Problem

DataCo operates a complex distribution network across multiple products, customer segments, geographic markets, and shipping methods. However, overall business performance can hide important operational and commercial risks.

The company needs better visibility into:

- Revenue concentration and dependency on specific products, departments, and markets.
- The causes behind loss-making transactions despite positive overall profitability.
- Whether delivery performance is affecting customer experience.
- Whether discount practices are supporting growth or reducing margins.
- Whether business performance has improved or stagnated over time.

Without this understanding, commercial and operational resources may not be allocated effectively.

---

# Business Objective

This project identifies the markets, products, and operational processes that are driving — and limiting — DataCo's performance.

The analysis translates these findings into prioritized recommendations focused on:

- Improving delivery performance.
- Protecting profitability.
- Reducing commercial concentration risk.
- Supporting better operational decision-making.

---

# Business Questions

The analysis was designed to answer five key questions:

- Which products, departments, and markets contribute most to revenue and profit?
- What factors are associated with loss-making orders?
- Which shipping methods and markets experience the highest delivery delays?
- How do discount levels influence sales and profitability?
- How have sales and profitability evolved between 2015 and 2018?

---

# Dashboard

The Power BI dashboard is organized into four business-focused pages:

| Dashboard Page | Business Question Answered |
|---|---|
| Executive Overview | How is the business performing overall? |
| Sales & Product Performance | Where is revenue concentrated and what drives performance? |
| Customer & Market Insights | Which customers and markets contribute most? |
| Shipping Performance | Is logistics affecting customer experience? |

## Dashboard Preview

![Executive Overview](https://github.com/FARAHBENSALEM01/Commercial-Distribution-Performance-Analysis/raw/main/PowerBI/Executive%20overview.png)

![Sales and Product Performance](https://github.com/FARAHBENSALEM01/Commercial-Distribution-Performance-Analysis/raw/main/PowerBI/Sales%20and%20product%20Performance.png)

![Customer and Market Insights](https://github.com/FARAHBENSALEM01/Commercial-Distribution-Performance-Analysis/raw/main/PowerBI/Customer%20and%20market%20insights.png)

![Shipping Performance](https://github.com/FARAHBENSALEM01/Commercial-Distribution-Performance-Analysis/raw/main/PowerBI/Shipping%20Performance.png)

---

🌐 **Interactive Dashboard (Power BI Service):**  
[Open Interactive Dashboard](#)

📥 **Power BI File:**  
[Commercial Distribution Performance Dashboard.pbix](#)

> Note: Some Microsoft organizational Power BI environments restrict Bing/Azure Maps services. If map visuals do not render in the published dashboard, screenshots are included in this repository and the `.pbix` file can be opened locally in Power BI Desktop.

---

# Methodology

```text
Business Understanding
        ↓
Data Audit
        ↓
Data Preparation
        ↓
Data Modeling (Star Schema)
        ↓
Exploratory Analysis
        ↓
Insight Generation
        ↓
Business Recommendations
        ↓
Dashboard for Decision Support
```

The analysis started from business questions rather than the dataset itself. SQL and Power BI were used to investigate business performance, identify root causes, and support decision-making.

---

# Key Findings & Business Implications

## Delivery performance is the largest operational challenge

**54.8% of orders were delivered late**, making delivery performance the most significant operational issue identified.

Because Standard Class represents approximately 60% of shipments, the next operational step should be to analyze whether this shipping method disproportionately contributes to delays before redesigning broader fulfillment processes.

---

## Loss-making transactions are hidden behind positive overall performance

Approximately **21.15% of orders generated losses**, despite an overall profit margin of **10.78%**.

This indicates that aggregate profitability is masking a meaningful group of underperforming transactions. Further investigation should focus on:

- Shipping costs
- Discount levels
- Product mix
- Geographic destinations

---

## Revenue concentration creates commercial risk

The **Fan Shop department generates approximately 47% of company sales and profit**, making it DataCo's strongest contributor but also its largest concentration risk.

The **Fishing category contributes approximately 19% of total sales and profit**, reinforcing the need to monitor dependency on a limited number of revenue sources.

---

## Europe is the strongest commercial market

Europe generates the highest sales and profit among the five analyzed markets.

However, before increasing investment specifically in Europe, its performance advantage should be quantified against LATAM and Pacific Asia to determine the scale of the difference.

---

## Moderate discounts appear sustainable

Low and medium discount levels generated approximately:

- **83% of sales**
- **84% of profit**

This suggests current discount practices are generally supporting performance. Additional analysis of high-discount transactions is required before changing pricing strategy.

---

## Sales and profitability remained relatively flat

Between **2015 and 2018**, sales and profit remained largely stable.

For a distribution business, limited growth over several years should be treated as a signal for further investigation, particularly alongside concentration and operational risks.

---

# Business Recommendations

## Priority 1 — Improve delivery performance

With more than half of orders arriving late, logistics improvement represents the most immediate opportunity.

Recommended actions:

- Analyze late deliveries by shipping method and market.
- Review warehouse coordination and inventory planning.
- Investigate whether Standard Class is driving a disproportionate share of delays.

---

## Priority 2 — Investigate loss-making transactions

The loss-making segment should be analyzed separately to identify the main drivers of negative margins.

Focus areas:

- Shipping costs
- Discounts
- Product categories
- Destination markets

---

## Priority 3 — Reduce revenue concentration risk

DataCo should continue developing high-potential departments and categories outside Fan Shop and Fishing to reduce dependency on a limited number of revenue sources.

---

## Priority 4 — Maintain disciplined discount policies

Current discount levels appear sustainable, but high-discount transactions require additional analysis before introducing pricing changes.

---

## Priority 5 — Monitor market concentration

Europe currently leads performance, but investment decisions should be based on quantified differences between markets.

---

# Business Impact

This analysis identifies two structural challenges affecting DataCo:

1. **Operational inefficiency:** More than half of shipments experience delays.
2. **Commercial concentration risk:** A significant share of performance depends on a limited number of departments and categories.

Addressing these issues provides a data-driven foundation for improving customer experience, protecting profitability, and reducing business risk.

---

# Dataset

| Attribute | Value |
|---|---|
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

Dataset source:  
https://data.mendeley.com/datasets/8gx2fvg2k6/5

---

# Tools & Technologies

| Category | Technology |
|---|---|
| Database | SQL Server |
| Query Language | SQL (T-SQL) |
| Data Cleaning | SQL |
| Exploratory Analysis | SQL |
| Data Modeling | Power BI Star Schema |
| Visualization | Power BI |
| Calculations | DAX |
| Version Control | Git & GitHub |
| Documentation | Markdown & Microsoft Word |

---

# SQL Analysis

SQL Server was used to prepare the data, validate data quality, and perform exploratory analysis.

## Data Cleaning

📄 [01_Data_cleaning.sql](sql/01_Data_cleaning.sql)

Performed:

- Data type standardization
- Column cleaning
- Missing value assessment
- Duplicate validation
- Data grain verification

## Exploratory Analysis

📄 [02_Exploratory_Data_analysis.sql](sql/02_Exploratory_Data_analysis.sql)

Analysis areas:

- Business overview
- Financial performance
- Product performance
- Customer analysis
- Geographic analysis
- Logistics performance
- Business trends
- Pricing strategy
- Cross-dimensional analysis

---

# Executive Summary

A one-page executive summary presenting the key findings, recommendations, and business impact is available here:

📄 [Executive Summary.pdf](Reports/Executive%20Summary.pdf)

---

# Repository Structure

```text
Commercial-Distribution-Performance-Analysis/

│
├── sql/
│   ├── 01_Data_cleaning.sql
│   └── 02_Exploratory_Data_analysis.sql
│
├── PowerBI/
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

# Future Improvements

- Analyze late deliveries by shipping method and market.
- Quantify performance differences between Europe, LATAM, and Pacific Asia.
- Analyze high-discount transactions to identify pricing thresholds.
- Measure fulfillment cycle time and delayed order stages.
- Forecast future sales and profitability using time-series models.
- Develop predictive models for delivery delay risk.
- Automate SQL-to-Power BI reporting workflows using Python.

---

# Key Skills Demonstrated

- SQL data cleaning and validation
- Exploratory data analysis (EDA)
- Star-schema data modeling
- DAX measure development
- Commercial performance analysis
- Root-cause investigation
- Business intelligence dashboard development
- Executive reporting and storytelling
- GitHub documentation

---

# Author

**Farah Bensalem**  
PhD in Econometrics | Data Analyst | Business Intelligence

GitHub: https://github.com/FARAHBENSALEM01

LinkedIn: https://www.linkedin.com/in/farah-bensalem/
