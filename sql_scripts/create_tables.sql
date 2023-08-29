-- Create the orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL
);

-- Create the pizza_types table
CREATE TABLE pizza_types (
    pizza_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT
);

-- Create the pizzas table
CREATE TABLE pizzas (
    pizza_id SERIAL PRIMARY KEY,
    pizza_type_id INT NOT NULL REFERENCES pizza_types(pizza_type_id),
    size VARCHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create the order_details table
CREATE TABLE order_details (
    order_details_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    pizza_id INT NOT NULL REFERENCES pizzas(pizza_id),
    quantity INT CHECK (quantity > 0) NOT NULL
);
