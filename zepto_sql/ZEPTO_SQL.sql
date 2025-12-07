create schema zepto_analysis;
USE zepto_analysis;
CREATE TABLE zepto_products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    original_price INT NOT NULL,
    discounted_price INT NOT NULL,
    discount_percent INT NOT NULL,
    premium VARCHAR(20) NOT NULL,
    quantity VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1) NOT NULL,
    review_count INT NOT NULL,
    delivery_time INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    selling_price INT NOT NULL
);

select * from zepto_products; 
desc zepto_products; 
-- 1Q. Show all columns from the zepto_products table.
select * from zepto_analysis.zepto_products;
-- 2Q. List the first 20 products in the dataset.
select * from zepto_analysis.zepto_products limit 20;
-- 3Q. Show all unique product categories.
select distinct category from zepto_analysis.zepto_products;
-- 4Q. Find products with a price greater than 1000
select * from zepto_analysis.zepto_products where selling_price > 1000;
-- 5Q.Count how many products have a rating above 4.5.
select count(*) as rating_count from zepto_analysis.zepto_products where rating > 4.5;
-- 6Q.Count how many premium products are there.
select count(*) as premium_yes from zepto_analysis.zepto_products where premium = 'yes';
-- 7Q. Retrieve products with more than 1,000 reviews.
select * from zepto_analysis.zepto_products where review_count > 1000;
-- 8Q.Display the top 5 most expensive products by original_price.
select * from zepto_analysis.zepto_products order by original_price desc limit 5;
-- 9Q. Find total number of premium and non-premium products.
select premium,count(*) as premium_status from zepto_analysis.zepto_products group by premium ;
-- 10Q. Count total products in each category.
select category,count(*) as product_count from zepto_analysis.zepto_products group by category order by product_count desc ;
-- 11Q. Find the product with the highest price
select * from zepto_analysis.zepto_products order by selling_price desc limit 10;
-- 12Q. Find the product with the lowest rating.
select * from zepto_analysis.zepto_products order by rating asc limit 10;
-- 13Q. Calculate the average rating for each category.
select category,avg(rating) as avg_rating  from zepto_analysis.zepto_products group by category order by avg_rating desc;
-- 14Q. Find the category with the highest average discount_percent.
select category,avg(discount_percent) as avg_discount from zepto_analysis.zepto_products group by category order by avg_discount desc;
-- 15Q.  Show total review_count per category.
select category,count(review_count) as total_reviewcounts from zepto_analysis.zepto_products group by category order by total_reviewcounts desc;
-- 16Q. Find average selling_price for premium vs non-premium products.
select premium,avg(selling_price) as avg_sellingprice from zepto_analysis.zepto_products group by premium;
-- 17Q. Show the difference between original_price and selling_price for every product.
select  product_id,product_name,original_price,selling_price, (original_price-selling_price) as difference from zepto_analysis.zepto_products;
-- 18Q . Count products for each delivery_time option.
select delivery_time,count(*) as products_delivered from zepto_analysis.zepto_products group by delivery_time order by products_delivered desc;
-- 19Q. Find products where discounted_price is more than 50% of original_price.
select * from zepto_analysis.zepto_products where discount_percent > 50;
-- 20Q. List all products delivered within "10 minutes" or less.
SELECT *
FROM zepto_analysis.zepto_products
WHERE CAST(SUBSTRING_INDEX(delivery_time, ' ', 1) AS UNSIGNED) <= 10;
-- 21Q.  Which category has the highest number of highly rated products above 4.0?
select product_id,product_name,rating,
case
when rating > 4.5 then 'high rated'
when rating between 4.0 and 3.5 then ' modrate rated'
else 'low rated'
end as ratings
from zepto_analysis.zepto_products;
-- 22Q. Group products by rating buckets (0–1, 1–2, 2–3, 3–4, 4–5) and count products in each bucket.		
select product_id,product_name,rating,
CASE
    WHEN rating >= 0 AND rating < 1 THEN '0-1'
    WHEN rating >= 1 AND rating < 2 THEN '1-2'
    WHEN rating >= 2 AND rating < 3 THEN '2-3'
    WHEN rating >= 3 AND rating < 4 THEN '3-4'
    WHEN rating >= 4 AND rating <= 5 THEN '4-5'
    ELSE 'Invalid'
END as ratings
from zepto_analysis.zepto_products;
-- 23Q. Use a CTE to find the average price for each category, then list products priced above their category average.
WITH category_avg AS (
    SELECT 
        category,
        AVG(selling_price) AS avg_price
    FROM zepto_analysis.zepto_products
    GROUP BY category
)
SELECT *
FROM category_avg;
-- 24Q. Use a CTE to calculate discounted price for each product and return only products where the discounted price is below 200.
WITH discount_calc AS (
    SELECT 
        product_id,
        product_name,
        original_price,
        discount_percent,
        original_price - (original_price * discount_percent / 100) AS calc_discounted
    FROM zepto_products
)
select * from
discount_calc;
-- 25Q. Use a CTE to find top 5 products by rating and then filter only those with more than 1000 reviews.
WITH top_rated AS (
    SELECT 
        product_id,
        product_name,
        category,
        rating,
        review_count
    FROM zepto_products
    ORDER BY rating DESC
    LIMIT 5
)
select * from top_rated;
-- 26Q. View showing product name, category, price and discounted price
CREATE VIEW vw_product_pricing AS
SELECT 
    product_name,
    category,
    selling_price,
    discounted_price
FROM zepto_products;
select * from vw_product_pricing;
-- 27Q. View showing category-wise average rating and number of products
CREATE VIEW vw_category_rating_summary AS
SELECT 
    category,
    AVG(rating) AS avg_rating,
    COUNT(*) AS product_count
FROM zepto_products
GROUP BY category;
select * from vw_category_rating_summary;
-- 28Q. Assign dense ranks to categories based on their average selling_price.
SELECT
    category,
    AVG(selling_price) AS avg_price,
    DENSE_RANK() OVER (
        ORDER BY AVG(selling_price) DESC
    ) AS price_rank
FROM zepto_products
GROUP BY category;
-- 29Q. Create a window that shows each product’s discount_percent compared with category average.
SELECT
    product_id,
    product_name,
    category,
    discount_percent,
    AVG(discount_percent) OVER (
        PARTITION BY category
    ) AS avg_category_discount,
    discount_percent 
        - AVG(discount_percent) OVER (PARTITION BY category)
        AS discount_difference
FROM zepto_products;
-- 30Q. Rank products by review_count within each category.
SELECT
    product_id,
    product_name,
    category,
    review_count,
    RANK() OVER (
        PARTITION BY category
        ORDER BY review_count DESC
    ) AS category_review_rank
FROM zepto_products;
-- 31Q. Create a stored procedure that returns all products from a given category whose rating is above a rating threshold passed as a parameter.
DELIMITER $$

CREATE PROCEDURE get_products_by_category_rating (
    IN p_category VARCHAR(100),
    IN p_min_rating DECIMAL(3,2)
)
BEGIN
    -- Check if category exists
    IF NOT EXISTS (SELECT 1 FROM zepto_products WHERE category = p_category) THEN
        SELECT 'Category does not exist' AS message;
    ELSE
        SELECT 
            product_id,
            product_name,
            category,
            rating,
            selling_price
        FROM zepto_products
        WHERE category = p_category
          AND rating > p_min_rating
        ORDER BY rating DESC;
    END IF;
END $$

DELIMITER ;
CALL get_products_by_category_rating('Snacks', 4.0);
-- 33Q. Show all products that take more than 10 minutes to deliver.
SELECT product_id, product_name, delivery_time
FROM zepto_products
WHERE delivery_time > 10;
-- 34Q. Find the average delivery_time for each category.
SELECT category, AVG(delivery_time) AS avg_delivery
FROM zepto_products
GROUP BY category;
-- 35Q. Show products whose delivery_time is faster than their category average.
SELECT zp.product_id, zp.product_name, zp.category, zp.delivery_time
FROM zepto_products zp
WHERE delivery_time < (
    SELECT AVG(delivery_time)
    FROM zepto_products
    WHERE category = zp.category
);
-- 36Q. Show each product’s delivery_time compared with category average.
SELECT 
    product_id,
    product_name,
    category,
    delivery_time,
    AVG(delivery_time) OVER (PARTITION BY category) AS category_avg_delivery
FROM zepto_products;





