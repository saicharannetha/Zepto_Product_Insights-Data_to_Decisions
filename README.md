
# 🛒 Zepto Product Insights - Data to Decisions

Building a complete analytics workflow for Zepto by scraping product data with Selenium, performing in-depth EDA in Python, modelling insights with SQL, and developing interactive dashboards in Power BI.
![zepto_home](https://github.com/saicharannetha/Zepto_Product_Insights-Data_to_Decisions/blob/main/dashboard/zepto_home.png)
## 📌 Table of Contents
- <a href="#overview">Overview</a>
- <a href="#business-problem">Business Problem</a>
- <a href="#dataset">Dataset</a>
- <a href="#tools--technologies">Tools & Technologies</a>
- <a href="#project-structure">Project Structure</a>
- <a href="#data-cleaning--preparation">Data Cleaning & Preparation</a>
- <a href="#exploratory-data-analysis-eda">Exploratory Data Analysis (EDA)</a>
- <a href="#research-questions--key-findings">Research Questions & Key Findings</a>
- <a href="#dashboard">Dashboard</a>
- <a href="#final-recommendations">Final Recommendations</a>
- <a href="#author--contact">Author & Contact</a>

<h2><a class="anchor" id="overview"></a>Overview</h2>

This project builds a full web scraping and EDA workflow for analysing product data from Zepto. It focuses on pricing patterns, discount behaviour, ratings, categories and delivery performance. Using Python, Selenium, pandas and visualisation tools, the raw website data is transformed into structured insights that support teams working on pricing, marketing, category decisions and operations.
---
<h2><a class="anchor" id="business-problem"></a>Business Problem</h2>
This project addresses several key challenges faced by a quick-commerce platform like Zepto:
- Understanding how product attributes such as ratings, reviews, discounts and premium tags influence customer choices and overall demand.

- Identifying categories and products that show weak engagement or consistently low performance, helping to refine the catalogue and improve assortment quality.
- 
- Analysing pricing and discount patterns to detect items that may be mispriced, under-promoted or over-discounted, which affects both customer perception and profitability.
- 
- Evaluating delivery time variation across categories to highlight operational delays and reliability issues that may impact customer satisfaction.
- 
- Assessing how product performance signals correlate with buying behaviour, allowing the business to target improvements in pricing strategy, product visibility and delivery efficiency.
---
<h2><a class="anchor" id="dataset"></a>Dataset</h2>

The project uses product data scraped from 17 Zepto categories, each stored as a separate CSV file in the `/data/` folder.
---

<h2><a class="anchor" id="tools--technologies"></a>Tools & Technologies</h2>

- SQL (Common Table Expressions,views, Filtering)
- Python (Pandas, Matplotlib, Seaborn)
- Power BI (Interactive Visualizations)
- GitHub
---
<h2><a class="anchor" id="project-structure"></a>Project Structure</h2>

```
zepto-product-insights/
│
├── README.md
│
├── webscraping_zepto.ipynb          # Selenium scraping workflow
│
├── zepto_EDA/                        # Exploratory Data Analysis
│   └── zepto_products.ipynb
│
├── zepto_sql/                        # SQL queries
│   └── zepto_sql.sql
│
├── data/                             # Raw and processed data files
│     └── zepto_products.csv
│
├── dashboard/                        # Power BI dashboards
│   └── zepto_product_insights.pdf
│   └──zepto_product_analysis.pdf
```
---
<h2><a class="anchor" id="data-cleaning--preparation"></a>Data Cleaning & Preparation</h2>

- Collected product data from 17 categories using Selenium web scraping.

- Saved each scraped category as an individual CSV file.

- Combined all category files into a single consolidated dataset named zepto_products.csv.

  Cleaned and prepared the dataset by:

- Removing entries with missing prices, ratings or delivery information

- Fixing data types for numeric fields such as price, rating, and discount

- Handling duplicates created during scraping

- Standardising category names and product attributes
---
<h2><a class="anchor" id="exploratory-data-analysis-eda"></a>Exploratory Data Analysis (EDA)</h2>

**Missing or Incorrect Values Detected:**

- 53 missing values in discount_percent

- 391 missing values in rating

- 1 missing value in quantity

**Outliers Identified:**

- 232 extreme values detected in selling_price using the IQR method

- Heavy right-skew in selling_price before capping (skewness 6.89 → 1.15)

**Correlation Analysis:**

- Very weak correlation between selling_price and discount_percent (0.005)

- Weak negative correlation between selling_price and rating (-0.14)

- Very weak positive correlation between selling_price and review_count (0.088)

- Rating shows no strong relationship with any numeric variable
---
<h2><a class="anchor" id="research-questions--key-findings"></a>Research Questions & Key Findings</h2>
**Brands for Promotions**
- 198 brands with high margins but low sales

- Untapped growth opportunity

- Action: Launch targeted promotions

**Top Vendors Concentration Risk**
- Top 10 vendors = 65.69% of purchases
  
- Supply chain risk → Diversify to 50+ suppliers

- Target: Reduce to 45-50%

 **Bulk Purchasing Impact**
- 72% cost savings per unit on bulk orders

- Example: ₹100 → ₹28 per unit

- Significant margin improvement opportunity

 **Unsold Inventory**
- $2.71M worth of slow-moving stock

- Capital inefficiency + carrying costs

- Action: Implement clearance strategy
  

---
## Dashboard
The [dashboard](https://app.powerbi.com/view?r=eyJrIjoiNDY4YjI5NGItM2MwOC00YjVkLWJhODctOTU4ZWExODNjM2MzIiwidCI6IjM0YzYzYTY3LTQ3MDktNDMxZS1hYTJlLTkwOTY2NjMxNTRhYyJ9) consists of 2 dashoards: 

**home**

**Page 1 – Customer Engagement & Category Analysis**
8 Charts:

- Delivery Time by Rating

- Customers Rating

- Premium Toggle

- Rating and Reviews

- Rating by Reviews by Category

- Total Reviews by Category

- Category Summary Table

**Page 2 – Pricing, Discounts & Category Performance**
6 Charts:

- Price by Delivery Time

- Discounted Price and Original Price by Category

- Selling Price vs Original Price by Category

- Premium Segment Toggle

- Average Selling Price by Category

- Category Metrics Table

![Customer Engagement & Category Analysis](https://github.com/saicharannetha/Zepto_Product_Insights-Data_to_Decisions/blob/main/dashboard/zepto_page1.png)
![Pricing, Discounts & Category Performance](https://github.com/saicharannetha/Zepto_Product_Insights-Data_to_Decisions/blob/main/dashboard/zepto_page2.png)

<h2><a class="anchor" id="final-recommendations"></a>Final Recommendations</h2>


**Optimize Discount Strategy**
- **Insight:** Bread, cool drinks, detergent, ice cream have the highest discounts; books and fragrances have the lowest.  
- **Action:** Apply selective discounting — increase discounts on premium categories (jewellery, toys) to boost volume while protecting margins on essentials.  
- **Reference:** Q1 Answer, Average Selling Price by Category  

**Leverage Product Quality**
- **Insight:** 94.94% of products are highly rated (4.0–5.0), with an average rating of 4.5.  
- **Action:** Highlight and promote highly-rated products in-app; use ratings as a key differentiator.  
- **Reference:** Distribution of Product Ratings, Rating and Reviews  

**Category-Specific Pricing**
- **Insight:** Highest priced categories: Jewellery, fragrances, toys; lowest priced: Vegetables, chips, bread.  
- **Action:** Create tiered pricing and margin strategies by category segment (premium vs essentials).  
- **Reference:** Average Selling Price by Category  

**Delivery Excellence as Competitive Advantage**
- **Insight:** Fastest delivery: Ice cream, chocolate, cookies, detergent (essentials); Slowest: Books, jewellery, fragrances.  
- **Action:** Maintain fast delivery SLAs on quick-consumption categories; optimise logistics for premium categories.  
- **Reference:** Delivery Time Distribution, Average Delivery Time by Category  

**Expand High-Performing Categories**
- **Insight:** Skin care, chocolate, and cool drinks have the highest product counts and reviews.  
- **Action:** Expand assortment in high-engagement categories; rationalise low-count categories (cheese, meats, bread).  
- **Reference:** Category Distribution, Total Reviews by Category
  

## 📊 Implementation Summary

| Priority | Insight | Action |
|----------|---------|--------|
| 🟠 **HIGH** | Selective discount strategy | Increase discounts on premium items; maintain margins on essentials |
| 🟠 **HIGH** | 94.94% highly-rated products | Use quality as a marketing differentiator |
| 🟡 **MEDIUM** | Category price variation | Apply category-specific strategies |
| 🟡 **MEDIUM** | Fast delivery on essentials | Optimise logistics by category |
| 🟡 **MEDIUM** | High engagement categories | Expand skin care, chocolate, and cool drink assortment |

---

✅ **All recommendations are based on Zepto's actual product and sales data analysis.**


---
<h2><a class="anchor" id="author--contact"></a>Author & Contact</h2>

**Sai Charan Konam**  
Aspring Data Analyst  
📧 Email: konamsaicharannetha@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/saicharannetha/)  
