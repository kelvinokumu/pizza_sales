-- Create the orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL
);

-- Create the order_details table
CREATE TABLE order_details (
    order_details_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id VARCHAR(30) NOT NULL,
    quantity INT NOT NULL
);

-- Create the pizzas table
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50) NOT NULL,
    size VARCHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);


CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT
);
