CREATE TABLE products (
 id SERIAL PRIMARY KEY,
 name TEXT,
 price NUMERIC,
 quantity INTEGER
);

CREATE TABLE stores (
 id SERIAL PRIMARY KEY,
 name TEXT,
 location TEXT
);

CREATE TABLE sales (
 id SERIAL PRIMARY KEY,
 product_id INTEGER REFERENCES products(id),
 store_id INTEGER REFERENCES stores(id),
 quantity INTEGER,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);