-- Passengers first name, last name, age
CREATE TABLE passengers (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER,
);
-- Check-Ins: date and time, passenger, flight
CREATE TABLE checkins (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "time" DATETIME NOT NULL,
    "passenger_id" INTEGER NOT NULL,
    "flight_id" INTEGER NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(id),
    FOREIGN KEY (flight_id) REFERENCES flights(id)
)
-- Airlines: name of airlines, concourse
CREATE TABLE airlines (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "name" TEXT UNIQUE NOT NULL,
    "concourse" TEXT NOT NULL
)
-- Flights: flight number, airline, airport from, airport to, departure time, arrival time
CREATE TABLE flights (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "flight_number" INTEGER NOT NULL,
    "airline_id" INTEGER NOT NULL,
    "airport_from" TEXT NOT NULL,
    "airport_to" TEXT NOT NULL,
    "departure_time" NUMERIC NOT NULL,
    "arrival_time" NUMERIC NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(id)
)
