CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2),
    status VARCHAR(20)
);

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT
);
