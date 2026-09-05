-- ICS 499 - SQL Data Anonymization Assignment
-- Synthetic Test Data
-- IMPORTANT: All names, addresses, emails, and phone numbers in this file are fictional.
-- The file is intentionally designed to test:
--   1. Anonymization of names, addresses, emails, and phone numbers
--   2. Consistency when the same value appears multiple times
--   3. Consistency across multiple tables
--   4. Preservation of non-sensitive values and SQL structure
--   5. Handling of apostrophes and different INSERT statement styles

DROP TABLE IF EXISTS shipping;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200),
    email VARCHAR(100),
    phone VARCHAR(30),
    loyalty_level VARCHAR(20),
    active BOOLEAN
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    order_date DATE,
    product_name VARCHAR(100),
    quantity INT,
    amount DECIMAL(10,2)
);

CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(30),
    contact_type VARCHAR(30),
    notes VARCHAR(255)
);

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    recipient_name VARCHAR(100),
    shipping_address VARCHAR(200),
    phone VARCHAR(30),
    carrier VARCHAR(50),
    tracking_status VARCHAR(50)
);

-- -------------------------------------------------------------------
-- CUSTOMERS
-- -------------------------------------------------------------------

INSERT INTO customers
(customer_id, name, address, email, phone, loyalty_level, active)
VALUES
(101, 'Wendy Jones', '2449 Gamble Lake Suite 991, Lake Kimberly, CA 79132', 'rramos@example.org', '634-520-7615', 'Gold', TRUE),
(102, 'John Anderson', '21653 Courtney Drives, West Rachel, WA 90587', 'fryebarbara@example.net', '839-714-5357', 'Silver', TRUE),
(103, 'Tara Mejia', '8432 Murray Lock, New Douglasport, IN 08940', 'kimberly30@example.com', '061-077-4782', 'Bronze', TRUE),
(104, 'Maureen Perez', '426 Dunn Cove Apt. 133, East David, PW 59804', 'kmacdonald@example.org', '452-182-1626', 'Gold', TRUE),
(105, 'Heather Perkins', '91310 Greg Port, Port Elizabethfurt, PR 32721', 'egonzalez@example.org', '921-169-8431', 'Silver', FALSE),
(106, 'Timothy Rivera', '51458 Mcknight Village, North Joseph, OK 00627', 'ndecker@example.com', '392-374-9133', 'Gold', TRUE),
(107, 'Jason Martinez', '2366 Wright Keys, New Angelaville, WA 36659', 'rachel11@example.org', '204-001-5539', 'Bronze', TRUE),
(108, 'Tyler Clark Jr.', '972 Wilcox Points, Bethanyberg, WI 21218', 'andrewalvarado@example.net', '680-500-3226', 'Silver', TRUE),
(109, 'Christopher Mills', '8403 Harris Pike, Joshuamouth, OH 31722', 'brianwebb@example.org', '666-817-7084', 'Gold', FALSE),
(110, 'Bryan Robinson', 'USNS Stevens, FPO AA 22683', 'laurencox@example.com', '936-439-1478', 'Bronze', TRUE);

-- A second INSERT statement to ensure programs do not assume one INSERT per table.

INSERT INTO customers VALUES
(111, 'Courtney Jimenez', '2593 Calhoun Common, Angelaville, OR 02855', 'erinmurphy@example.com', '230-200-0693', 'Gold', TRUE),
(112, 'Brandy Shaw', '5373 John Motorway, New Douglas, DC 44723', 'vmorales@example.com', '068-366-2176', 'Silver', TRUE),
(113, 'Brenda Burton', '6253 Lewis Freeway Suite 297, Deborahchester, AK 71965', 'sean51@example.org', '384-286-0934', 'Bronze', TRUE),
(114, 'Amy Adams', '461 Kelly Roads, Port Caleb, NH 40698', 'stephanie85@example.org', '060-038-6440', 'Gold', TRUE),
(115, 'Nicholas Taylor Jr.', '22876 Eric Glens Apt. 015, West Toddfort, PR 36839', 'emiller@example.org', '486-071-2414', 'Silver', TRUE);

-- -------------------------------------------------------------------
-- ORDERS
-- Repeated customer names and emails must map consistently.
-- -------------------------------------------------------------------

INSERT INTO orders
(order_id, customer_id, customer_name, customer_email, order_date, product_name, quantity, amount)
VALUES
(5001, 101, 'Wendy Jones', 'rramos@example.org', '2026-01-12', 'Wireless Keyboard', 1, 49.99),
(5002, 102, 'John Anderson', 'fryebarbara@example.net', '2026-01-15', 'USB-C Hub', 2, 79.98),
(5003, 101, 'Wendy Jones', 'rramos@example.org', '2026-02-03', 'Laptop Stand', 1, 34.95),
(5004, 107, 'Jason Martinez', 'rachel11@example.org', '2026-02-14', 'Webcam', 1, 89.00),
(5005, 104, 'Maureen Perez', 'kmacdonald@example.org', '2026-03-01', 'Noise-Canceling Headphones', 1, 159.99),
(5006, 108, 'Tyler Clark Jr.', 'andrewalvarado@example.net', '2026-03-06', 'External SSD', 1, 119.50),
(5007, 102, 'John Anderson', 'fryebarbara@example.net', '2026-03-20', 'Mechanical Keyboard', 1, 99.99),
(5008, 111, 'Courtney Jimenez', 'erinmurphy@example.com', '2026-04-02', 'Monitor Arm', 2, 129.98),
(5009, 113, 'Brenda Burton', 'sean51@example.org', '2026-04-18', 'Portable Monitor', 1, 219.00),
(5010, 115, 'Nicholas Taylor Jr.', 'emiller@example.org', '2026-05-10', 'Bluetooth Speaker', 1, 69.95),
(5011, 106, 'Timothy Rivera', 'ndecker@example.com', '2026-05-22', 'Tablet Case', 2, 58.00),
(5012, 104, 'Maureen Perez', 'kmacdonald@example.org', '2026-06-11', 'Wireless Mouse', 1, 39.99),
(5013, 114, 'Amy Adams', 'stephanie85@example.org', '2026-06-25', 'Desk Lamp', 1, 45.50),
(5014, 108, 'Tyler Clark Jr.', 'andrewalvarado@example.net', '2026-07-08', 'USB Microphone', 1, 109.99),
(5015, 107, 'Jason Martinez', 'rachel11@example.org', '2026-07-19', 'HDMI Cable', 3, 29.97);

-- -------------------------------------------------------------------
-- CONTACTS
-- Names, emails, and phone numbers repeat from customers.
-- Notes and contact_type are non-sensitive test values and should remain.
-- -------------------------------------------------------------------

INSERT INTO contacts VALUES
(9001, 101, 'Wendy Jones', 'rramos@example.org', '634-520-7615', 'Primary', 'Prefers email contact'),
(9002, 102, 'John Anderson', 'fryebarbara@example.net', '839-714-5357', 'Primary', 'Call after 5 PM'),
(9003, 104, 'Maureen Perez', 'kmacdonald@example.org', '452-182-1626', 'Primary', 'No special instructions'),
(9004, 107, 'Jason Martinez', 'rachel11@example.org', '204-001-5539', 'Primary', 'Customer since 2024'),
(9005, 108, 'Tyler Clark Jr.', 'andrewalvarado@example.net', '680-500-3226', 'Primary', 'Prefers text messages'),
(9006, 111, 'Courtney Jimenez', 'erinmurphy@example.com', '230-200-0693', 'Primary', 'VIP customer'),
(9007, 113, 'Brenda Burton', 'sean51@example.org', '384-286-0934', 'Primary', 'No special instructions'),
(9008, 115, 'Nicholas Taylor Jr.', 'emiller@example.org', '486-071-2414', 'Primary', 'Prefers email contact');

-- -------------------------------------------------------------------
-- SHIPPING
-- Names, addresses, and phones repeat from customers.
-- -------------------------------------------------------------------

INSERT INTO shipping
(shipping_id, order_id, recipient_name, shipping_address, phone, carrier, tracking_status)
VALUES
(7001, 5001, 'Wendy Jones', '2449 Gamble Lake Suite 991, Lake Kimberly, CA 79132', '634-520-7615', 'UPS', 'Delivered'),
(7002, 5002, 'John Anderson', '21653 Courtney Drives, West Rachel, WA 90587', '839-714-5357', 'FedEx', 'Delivered'),
(7003, 5003, 'Wendy Jones', '2449 Gamble Lake Suite 991, Lake Kimberly, CA 79132', '634-520-7615', 'USPS', 'Delivered'),
(7004, 5004, 'Jason Martinez', '2366 Wright Keys, New Angelaville, WA 36659', '204-001-5539', 'UPS', 'Delivered'),
(7005, 5005, 'Maureen Perez', '426 Dunn Cove Apt. 133, East David, PW 59804', '452-182-1626', 'FedEx', 'Delivered'),
(7006, 5006, 'Tyler Clark Jr.', '972 Wilcox Points, Bethanyberg, WI 21218', '680-500-3226', 'UPS', 'In Transit'),
(7007, 5008, 'Courtney Jimenez', '2593 Calhoun Common, Angelaville, OR 02855', '230-200-0693', 'FedEx', 'Delivered'),
(7008, 5009, 'Brenda Burton', '6253 Lewis Freeway Suite 297, Deborahchester, AK 71965', '384-286-0934', 'USPS', 'In Transit'),
(7009, 5010, 'Nicholas Taylor Jr.', '22876 Eric Glens Apt. 015, West Toddfort, PR 36839', '486-071-2414', 'UPS', 'Delivered'),
(7010, 5013, 'Amy Adams', '461 Kelly Roads, Port Caleb, NH 40698', '060-038-6440', 'FedEx', 'Processing');

-- -------------------------------------------------------------------
-- Additional statements that should remain unchanged.
-- -------------------------------------------------------------------

UPDATE customers
SET loyalty_level = 'Platinum'
WHERE customer_id = 101;

-- This query contains no PII values and should not be modified.
DELETE FROM orders
WHERE order_id = 9999;

-- End of synthetic test file.
