-- Ingredients
CREATE TABLE IF NOT EXISTS ingredients (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "ingredient" TEXT NOT NULL UNIQUE,
    "price_per_unit" INTEGER NOT NULL,
    "unit" TEXT
);

-- Donuts
CREATE TABLE IF NOT EXISTS donuts (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "is_gluten_free" INTEGER NOT NULL,
    "price" INTEGER NOT NULl
);

-- Donuts Ingredients
CREATE TABLE IF NOT EXISTS donutingredients (
    "donut_id" INTEGER NOT NULL,
    "ingredient_id" INTEGER NOT NULL,
    "quanity" INTEGER NOT NULL,
    "unit" TEXT,
    PRIMARY KEY ("donut_id", "ingredient_id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id"),
    FOREIGN KEY ("ingredient_id") REFERENCES "ingredients"("id")
);

-- Customers
CREATE TABLE IF NOT EXISTS customers (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL
);

-- Orders
CREATE TABLE IF NOT EXISTS orders (
    "order_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "customer_id" INTEGER NOT NULL,
    "order_datetime" DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id")
);

-- Order contents
CREATE TABLE IF NOT EXISTS ordercontents (
    "order_id" INTEGER NOT NULL,
    "donut_id" INTEGER NOT NULL,
    "quanity" INTEGER NOT NULL DEFAULT 1,
    PRIMARY KEY ("order_id", "donut_id"),
    FOREIGN KEY ("order_id") REFERENCES "orders"("order_id"),
    FOREIGN KEY ("donut_id") REFERENCES "donuts"("id") 
);