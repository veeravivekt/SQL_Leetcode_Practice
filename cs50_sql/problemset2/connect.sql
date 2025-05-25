CREATE TABLE IF NOT EXISTS users (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT UNIQUE NOT NULL,
    "password" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS schools (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "school_name" TEXT NOT NULL,
    "school_type" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "year_founded" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS companies (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "company_name" TEXT NOT NULL,
    "company_industry" TEXT NOT NULL,
    "location" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS connections (
    "user1_id" INTEGER NOT NULL,
    "user2_id" INTEGER NOT NULL,
    PRIMARY KEY ("user1_id", "user2_id"),
    FOREIGN KEY ("user1_id") REFERENCES "users"("id"),
    FOREIGN KEY ("user2_id") REFERENCES "users"("id")
);

CREATE TABLE IF NOT EXISTS user_schools (
    "user_id" INTEGER NOT NULL,
    "school_id" INTEGER NOT NULL,
    "start_date" DATE,
    "end_date" DATE,
    "degree_type" TEXT,
    PRIMARY KEY ("user_id", "school_id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("school_id") REFERENCES "schools"("id")
);

CREATE TABLE IF NOT EXISTS user_compaines (
    "user_id" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "start_date" DATE,
    "end_date" DATE,
    "title" TEXT,
    PRIMARY KEY ("user_id", "company_id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id"),
    FOREIGN KEY ("company_id") REFERENCES "companies"("id")
);
