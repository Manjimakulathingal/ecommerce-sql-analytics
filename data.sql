customers table
customer_id INT
name VARCHAR(50)
city VARCHAR(50)
signup_date DATE

INSERT INTO customers VALUES
(1,'Amit','Mumbai','2023-01-10'),
(2,'Sara','Delhi','2023-03-15'),
(3,'John','Bangalore','2023-05-20'),
(4,'Priya','Mumbai','2023-07-25'),
(5,'Ali','Hyderabad','2023-09-10');

orders table
order_id INT
customer_id INT
order_date DATE
order_amount DECIMAL(10,2)
status VARCHAR(20)

INSERT INTO orders VALUES
(101,1,'2024-01-10',500,'Completed'),
(102,2,'2024-01-15',800,'Completed'),
(103,1,'2024-02-10',300,'Cancelled'),
(104,3,'2024-02-20',1200,'Completed'),
(105,4,'2024-03-05',700,'Completed'),
(106,5,'2024-03-18',400,'Completed'),
(107,2,'2024-04-01',950,'Completed');

products table
product_id INT
product_name VARCHAR(50)
category VARCHAR(50)
price DECIMAL(10,2)

INSERT INTO products VALUES
(1,'Laptop','Electronics',50000),
(2,'Phone','Electronics',20000),
(3,'Shoes','Fashion',3000),
(4,'Watch','Accessories',5000);

orders_items
order_item_id INT
order_id INT
product_id INT
quantity INT

INSERT INTO order_items VALUES
(1,101,2,1),
(2,102,1,1),
(3,104,3,2),
(4,105,4,1),
(5,106,2,2),
(6,107,1,1);
