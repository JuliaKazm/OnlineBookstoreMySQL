


-- ALTER Statements

ALTER TABLE Order_Items
RENAME TO OrderItems;

ALTER TABLE Employees
ADD COLUMN first_name VARCHAR (25) AFTER name;

ALTER TABLE Employees
ADD COLUMN last_name VARCHAR (25) AFTER first_name;

ALTER TABLE Employees
DROP COLUMN name;

ALTER TABLE Employees
MODIFY COLUMN last_name VARCHAR(30);

ALTER TABLE Books
DROP COLUMN publication_details;

-- INSERT Statements

INSERT INTO Authors (author_id, last_name, contact_details)
VALUES (8, 'Robins', '747-444-8374');

INSERT INTO Customers (customer_id, first_name, last_name, address, contact_details)
VALUES (11, 'Alisa', 'Williams', '9887 Fork St, Chicago, IL 33788', 'home phone 498-999-4647');

INSERT INTO Customers (customer_id, first_name, last_name, address, contact_details)
VALUES (12, 'Mary', 'Olban', '934 Spoon St, San Jose, CA 33788', 'cell phone 567-087-4697');

INSERT INTO Customers (customer_id, first_name, last_name, address, contact_details)
VALUES (13, 'Stephan', 'Bing', '43 1st ave, Campbell, CA 54632', 'cell phone 109-987-4622');

INSERT INTO Orders (orders_id, customer_id, order_date, order_status)
VALUES (11, 13, '2023-05-17', 'shipped');

INSERT INTO Orders (orders_id, customer_id, order_date, order_status)
VALUES (12, 11, '2023-05-17', 'canceled');

INSERT INTO Orders (orders_id, customer_id, order_date, order_status)
VALUES (13, 12, '2023-05-17', 'shipped');

INSERT INTO Payments (payment_id, customer_id, order_id, payment_amount, payment_date)
VALUES (9, 3, 2, 29.99, '2023-05-12');

INSERT INTO Payments (payment_id, customer_id, order_id, payment_amount, payment_date)
VALUES (10, 4, 7, 19.99, '2023-05-14');

INSERT INTO Payments (payment_id, customer_id, order_id, payment_amount, payment_date)
VALUES (11, 12, 11, 39.99, '2023-05-17');

INSERT INTO Payments (payment_id, customer_id, order_id, payment_amount, payment_date)
VALUES (12, 13, 12, 129.99, '2023-05-12');

-- UPDATE Statements

UPDATE Customers  SET first_name = 'Anna ', last_name = 'Taylor'  WHERE (customer_id = 1);
UPDATE Customers  SET first_name = 'Bob ', last_name = 'Smith'  WHERE (customer_id = 2);
UPDATE Customers  SET first_name = 'Leo ', last_name = 'Og'  WHERE (customer_id = 3);
UPDATE Customers  SET first_name = 'Tom ', last_name = 'Ford'  WHERE (customer_id = 4);
UPDATE Customers  SET first_name = 'Ian ', last_name = 'Orel'  WHERE (customer_id = 5);

UPDATE Payments  SET payment_amount = '17.85' WHERE (customer_id = 1);
UPDATE Payments  SET payment_amount = '217.45' WHERE (customer_id = 2);
UPDATE Payments  SET payment_amount = '23.90' WHERE (customer_id = 3);
UPDATE Payments  SET payment_amount = '7.85' WHERE (customer_id = 4);
UPDATE Payments  SET payment_amount = '120.15' WHERE (customer_id = 5);

-- DELETE Statements

DELETE FROM Orders WHERE orders_id = 13;
DELETE FROM Payments 
WHERE payment_id = (SELECT customer_id FROM Customers WHERE last_name = 'Bing');

DELETE FROM Orders WHERE orders_id = 6;
DELETE FROM Payments 
WHERE payment_id = (SELECT customer_id FROM Customers WHERE last_name = 'Smith');

DELETE FROM Orders WHERE orders_id = 2;
DELETE FROM Payments 
WHERE payment_id = (SELECT customer_id FROM Customers WHERE last_name = 'Orel');

-- Join all tables in my database

SELECT * FROM Orders
LEFT JOIN Customers USING (customer_id)
LEFT JOIN Employees ON employee_id = Departments_department_id
LEFT JOIN Departments ON department_id = BookStock_book_stock_id
LEFT JOIN BookStock ON book_stock_id = department_id
LEFT JOIN Publishers ON (publisher_id)
LEFT JOIN Authors USING (author_id)
LEFT JOIN Books USING (book_id)
LEFT JOIN OrderItems ON Orders.orders_id = OrderItems.orders_id
LEFT JOIN Payments ON Orders.orders_id = Payments.payment_id
LEFT JOIN Discounts ON Orders.orders_id = Discounts.discount_id
LEFT JOIN Reviews USING (review_id);

-- Aggregate functions GROUP BY HAVING

SELECT payment_id, SUM(payment_amount) AS total
FROM Payments
GROUP BY payment_id;

SELECT book_id, COUNT(book_id) AS total
FROM Books
GROUP BY book_id;

SELECT customer_id, first_name, last_name, AVG(payment_amount) AS average_payment_amount
FROM Customers
LEFT JOIN Orders ON orders_id = customer_id
GROUP BY orders_id
HAVING average_payment_amount >= 20;

-- JOIN Statements

SELECT customer_id, first_name, last_name
FROM Customers
RIGHT JOIN Orders
USING (customer_id)
WHERE order_status = "shipped";

SELECT customer_id, first_name, last_name
FROM Customers
LEFT JOIN Orders
USING (customer_id)
WHERE order_status = "closed";

SELECT customer_id, first_name, last_name
FROM Customers
LEFT JOIN Orders
USING (customer_id)
WHERE order_status = "in process";


