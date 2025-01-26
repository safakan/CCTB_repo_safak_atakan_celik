CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    phone TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    id  INT NOT NULL PRIMARY KEY, -- same as user id: 1:1 relationship users-customers
    name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS orders (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL,
    order_total NUMERIC NOT NULL,
	customer_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(id) -- 1:many relationship customers-orders
);

CREATE TABLE IF NOT EXISTS books (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT,
    price_to_customer NUMERIC NOT NULL,
    detail TEXT -- JSON
);

CREATE TABLE IF NOT EXISTS authors (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    detail TEXT --JSON
);

CREATE TABLE IF NOT EXISTS genres (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS books_and_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS books_and_genres (
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books (id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres (id) ON DELETE CASCADE

);



CREATE TABLE IF NOT EXISTS suppliers (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    contact_information TEXT NOT NULL,
    detail TEXT NOT NULL
);

-- many to many between orders and books through a junction table
CREATE TABLE IF NOT EXISTS orders_and_books (
    order_id INT NOT NULL,
	book_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
	PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

CREATE TABLE IF NOT EXISTS supplier_book_contracts (
    id  INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
	start_date DATE NOT NULL,
    end_date DATE,
    price_from_supplier NUMERIC NOT NULL,
    details TEXT, -- JSON
    book_id INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);



CREATE TABLE IF NOT EXISTS invoices (
    id INT NOT NULL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status TEXT NOT NULL,
    payment_method TEXT,
    transaction_id TEXT,
    paid_at TIMESTAMP,
    details TEXT, -- JSON
    FOREIGN KEY (id) REFERENCES orders(id) ON DELETE CASCADE -- zero or one orders-invoices ?
);


CREATE TABLE IF NOT EXISTS addresses (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    address1 TEXT NOT NULL,
    address2 TEXT,
    city TEXT NOT NULL,
    state TEXT,
    zip TEXT NOT NULL,
    country TEXT NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS deliveries (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    address_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL,
    carrier_name TEXT NOT NULL,
    tracking_number TEXT NOT NULL,
    delivery_cost NUMERIC NOT NULL,
    details TEXT, -- JSON
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE CASCADE
);

