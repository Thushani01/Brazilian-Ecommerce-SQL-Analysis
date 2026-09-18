-- Brazilian E-Commerce SQL Analysis
-- Database: ecommerce_analysis
-- Tool: MySQL
-- Dataset: Olist Brazilian E-Commerce Public Dataset

USE ecommerce_analysis;

-- =====================================================
-- 1. Order Status Distribution
-- =====================================================

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- =====================================================
-- 2. Total Product Sales
-- =====================================================

SELECT
    ROUND(SUM(price), 2) AS total_sales
FROM order_items;


-- =====================================================
-- 3. Monthly Sales
-- =====================================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS sales_month,
    ROUND(SUM(oi.price), 2) AS monthly_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY sales_month
ORDER BY sales_month;

-- =====================================================
-- 4. Top 10 Product Categories by Sales
-- =====================================================

SELECT
    p.product_category_name AS category,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;

-- =====================================================
-- 5. Average Order Value for Delivered Orders
-- =====================================================

SELECT
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- =====================================================
-- 6. Payment Methods
-- =====================================================

SELECT
    payment_type,
    COUNT(*) AS payment_count,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- =====================================================
-- 7. Repeat Customers
-- =====================================================

SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY order_count DESC
LIMIT 10;


-- =====================================================
-- 8. Repeat Customer Percentage
-- =====================================================

SELECT
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(DISTINCT customer_unique_id) FROM customers),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT
        c.customer_unique_id
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(DISTINCT o.order_id) > 1
) AS repeat_customer_list;

-- =====================================================
-- 9. Average Delivery Time
-- =====================================================

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS average_delivery_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;

-- =====================================================
-- 10. Average Review Score
-- =====================================================

SELECT
    ROUND(AVG(review_score), 2) AS average_review_score
FROM order_reviews;

-- =====================================================
-- 11. Review Score by Delivery Status
-- =====================================================

SELECT
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    COUNT(*) AS review_count,
    ROUND(AVG(r.review_score), 2) AS average_review_score
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;

-- =====================================================
-- 12. Late Delivery Percentage
-- =====================================================

SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- =====================================================
-- 13. Sales by Customer State
-- =====================================================

SELECT
    c.customer_state AS state,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_sales DESC;


-- =====================================================
-- 14. Top 10 Sellers by Sales
-- =====================================================

SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_sales DESC
LIMIT 10;

-- =====================================================
-- 15. Sales by Seller State
-- =====================================================

SELECT
    s.seller_state AS state,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY total_sales DESC;

-- =====================================================
-- 16. Freight as Percentage of Product Sales
-- =====================================================

SELECT
    ROUND(
        100 * SUM(freight_value) / SUM(price),
        2
    ) AS freight_percentage_of_product_sales
FROM order_items;

-- =====================================================
-- 17. Multi-Item Orders
-- =====================================================

SELECT
    COUNT(*) AS multi_item_orders
FROM (
    SELECT
        order_id
    FROM order_items
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS multi_item_order_list;

-- =====================================================
-- 17. Multi-Item Orders
-- =====================================================
