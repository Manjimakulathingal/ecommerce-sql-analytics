-- =========================
-- LEVEL 1: BASIC ANALYSIS
-- =========================

-- Total customers
SELECT COUNT(*) FROM customers;

-- Total revenue (completed orders)
SELECT SUM(order_amount) 
FROM orders 
WHERE status = 'Completed';

-- Average order value
SELECT AVG(order_amount) 
FROM orders 
WHERE status = 'Completed';

-- Customers from Mumbai
SELECT customer_id, name 
FROM customers 
WHERE city = 'Mumbai';


-- =========================
-- LEVEL 2: JOINS
-- =========================

-- Total revenue per customer
SELECT 
    c.customer_id,
    c.name,
    SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.name;

-- Top 3 customers
SELECT 
    c.customer_id,
    c.name,
    SUM(o.order_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 3;


-- =========================
-- LEVEL 3: WINDOW FUNCTIONS
-- =========================

-- Rank customers by spending
SELECT 
    customer_id,
    name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank
FROM (
    SELECT 
        c.customer_id,
        c.name,
        SUM(o.order_amount) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.name
) t;

-- Running revenue
SELECT 
    order_date,
    order_amount,
    SUM(order_amount) OVER (ORDER BY order_date) AS running_total
FROM orders;

-- Latest order per customer
SELECT *
FROM (
    SELECT 
        order_id,
        customer_id,
        order_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY order_date DESC
        ) AS rn
    FROM orders
) t
WHERE rn = 1;


-- =========================
-- LEVEL 4: BUSINESS METRICS
-- =========================

-- Repeat customers
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Cancelled percentage
SELECT 
    ROUND(
        COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*), 
    2) AS cancelled_percentage
FROM orders;

-- Revenue contribution %
SELECT 
    customer_id,
    SUM(order_amount) AS total_spent,
    ROUND(
        SUM(order_amount) * 100.0 /
        (SELECT SUM(order_amount) FROM orders WHERE status = 'Completed'),
    2) AS revenue_percentage
FROM orders
WHERE status = 'Completed'
GROUP BY customer_id;

-- Category revenue
SELECT 
    p.category,
    SUM(o.order_amount) AS category_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY category_revenue DESC;
