-- 1. sql
-- Your colleague is preparing a map of all public schools in Massachusetts. 
-- In 1.sql, write a SQL query to find the names and cities of all public schools in Massachusetts.
-- Keep in mind that not all schools in the schools table are considered traditional public schools. 
-- Massachusetts also recognizes charter schools, which (according to DESE!) are considered distinct.
SELECT "name", "city" FROM "schools"
WHERE "state" = 'MA' 
AND "type" = 'Public School';

-- 2.sql
-- Your team is working on archiving old data. 
-- In 2.sql, write a SQL query to find the names of districts that are no longer operational.
-- Districts that are no longer operational have “(non-op)” at the end of their name.
SELECT "name" FROM "districts"
WHERE "name" LIKE '%(non-op)';

-- 3.sql
-- The Massachusetts Legislature would like to learn how much money, on average, districts spent per-pupil last year. 
-- In 3.sql, write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”.
-- Note the per_pupil_expenditure column in the expenditures table contains the average amount, per pupil, each district spent last year. 
-- You’ve been asked to find the average of this set of averages, weighting all districts equally regardless of their size.
SELECT AVG("per_pupil_expenditure") 
AS "Average District Per-Pupil Expenditure" 
FROM "expenditures";

-- 4.sql
-- Some cities have more public schools than others. 
-- In 4.sql, write a SQL query to find the 10 cities with the most public schools.
-- Your query should return the names of the cities and the number of public schools within them, ordered 
-- from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("city") FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
ORDER BY COUNT("city") DESC, "city"
LIMIT 10;

-- 5.sql
-- DESE would like you to determine in what cities additional public schools might be needed. 
-- In 5.sql, write a SQL query to find cities with 3 or fewer public schools. 
-- Your query should return the names of the cities and the number of public schools within them, ordered 
-- from greatest number of public schools to least. If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("*") AS "Pulic Schools Count" 
FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
HAVING "Pulic Schools Count" < 4
ORDER BY "Pulic Schools Count" DESC, "city";

-- 6.sql
-- DESE wants to assess which schools achieved a 100% graduation rate. 
-- In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "name" FROM "schools"
WHERE "id" IN (
    SELECT "school_id" FROM "graduation_rates"
    WHERE "graduated" = '100'
);

-- 7.sql
-- DESE is preparing a report on schools in the Cambridge school district. 
-- In 7.sql, write a SQL query to find the names of schools (public or charter!) in the Cambridge school district. 
-- Keep in mind that Cambridge, the city, contains a few school districts, but DESE is interested in the district whose name is “Cambridge.”
SELECT "name" 
FROM "schools"
WHERE "district_id" IN (
    SELECT "id" 
    FROM "districts"
    WHERE "city" = 'Cambridge' AND "name" = "Cambridge"
);

-- 8.sql
-- A parent wants to send their child to a district with many other students. 
-- In 8.sql, write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
SELECT d."name", e."pupils"
FROM "districts" AS d
JOIN "expenditures" AS e
ON d."id" = e."district_id";

-- 9.sql
-- Another parent wants to send their child to a district with few other students. 
-- In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils. 
-- Report only the name(s).
SELECT d."name"
FROM "districts" AS d
JOIN "expenditures" AS e
ON d."id" = e."district_id"
ORDER BY e."pupils"
LIMIT 1;

-- 10.sql
-- In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values.
-- In 10.sql, write a SQL query to find the 10 public school districts with the highest per-pupil expenditures. 
-- Your query should return the names of the districts and the per-pupil expenditure for each.
SELECT d."name", e."per_pupil_expenditure"
FROM "districts" AS d
JOIN "expenditures" AS e
ON d."id" = e."district_id"
WHERE d."type" = 'Public School District'
ORDER BY e."per_pupil_expenditure" DESC
LIMIT 10;

-- 11.sql
-- Is there a relationship between school expenditures and graduation rates? 
-- In 11.sql, write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate. 
-- Sort the schools from greatest per-pupil expenditure to least. 
-- If two schools have the same per-pupil expenditure, sort by school name.
-- You should assume a school spends the same amount per-pupil their district as a whole spends.
SELECT s."name", e."per_pupil_expenditure", g."graduated"
FROM "schools" AS s
JOIN "expenditures"  AS e ON s."district_id" = e."district_id"
JOIN "graduation_rates" AS g ON s."id" = g."school_id"
ORDER BY e."per_pupil_expenditure" DESC, s."name";

-- 12.sql
-- A parent asks you for advice on finding the best public school districts in Massachusetts. 
-- In 12.sql, write a SQL query to find public school districts with above-average per-pupil expenditures
-- and an above-average percentage of teachers rated “exemplary”. Your query should return the districts’ names, 
-- along with their per-pupil expenditures and percentage of teachers rated exemplary. Sort the results first by the 
-- percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
SELECT d."name", e."per_pupil_expenditure", st."exemplary"
FROM "districts" AS d
JOIN "expenditures" AS e ON d."id" = e."district_id"
JOIN "staff_evaluations" AS st ON d."id" = st."district_id"
WHERE d.type = 'Public School District'
AND e."per_pupil_expenditure" > (SELECT AVG("per_pupil_expenditure") FROM "expenditures")
AND st."exemplary" > (SELECT AVG("exemplary") FROM "staff_evaluations")
ORDER BY st."exemplary" DESC, e."per_pupil_expenditure" DESC;
 
-- 13.sql
-- In 13.sql, write a SQL query to answer a question you have about the data! The query should:
-- Involve at least one JOIN or subquery
-- Write a SQL query to find the relation between graduation rates and proficiency of staff
SELECT s."name", st."proficient", g."graduated"
FROM "schools" AS s
JOIN "staff_evaluations" AS st ON s."district_id" = st."district_id"
JOIN "graduation_rates" AS g ON s."id" = g."school_id"
WHERE st."proficient" IS NOT NULL
ORDER BY st."proficient" DESC, g."graduated" DESC;


