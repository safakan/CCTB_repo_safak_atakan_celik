CREATE TABLE customers (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE orders (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    order_total NUMERIC NOT NULL,
	customer_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(id)
);



CREATE TABLE books (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(50),
	genre VARCHAR(20),
    author VARCHAR(25) NOT NULL,
    price_to_customer NUMERIC NOT NULL
);

CREATE TABLE orders_and_books (
    order_id INT NOT NULL,
	book_id INT NOT NULL,
	PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);


