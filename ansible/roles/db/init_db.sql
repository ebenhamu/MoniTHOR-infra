-- Create tables
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    address TEXT,
    phone_number VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10, 2),
    is_kosher BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert mock users
INSERT INTO users (first_name, last_name, email, address, phone_number) VALUES
('David', 'Goldman', 'david@example.com', '123 Jerusalem St.', '123-456-7890'),
('Sarah', 'Levy', 'sarah@example.com', '456 Tel Aviv Blvd.', '987-654-3210'),
('Michael', 'Cohen', 'michael@example.com', '789 Haifa Ave.', '555-444-3333'),
('Rachel', 'Friedman', 'rachel@example.com', '101 Beersheba Rd.', '222-333-4444'),
('Yossi', 'Ben-David', 'yossi@example.com', '321 Eilat Way.', '666-777-8888');

-- Insert mock kosher products
INSERT INTO products (name, price, is_kosher) VALUES
('Kosher Bread', 5.50, TRUE),
('Kosher Cheese', 8.00, TRUE),
('Kosher Chicken', 15.99, TRUE),
('Kosher Wine', 25.00, TRUE),
('Kosher Milk', 4.20, TRUE),
('Kosher Beef', 20.50, TRUE),
('Kosher Yogurt', 3.75, TRUE),
('Kosher Eggs', 2.50, TRUE),
('Kosher Chocolate', 6.80, TRUE),
('Kosher Honey', 9.30, TRUE);