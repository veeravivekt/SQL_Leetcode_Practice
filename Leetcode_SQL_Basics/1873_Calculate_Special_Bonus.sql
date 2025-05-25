/*
employee_id -> PK
Table: employee ID, employee name, and salary
Bonus is 100% if: ID = odd, name[0] != M
*/
SELECT employee_id, 
CASE
    WHEN employee_id % 2 <> 0
    AND LEFT(name, 1) <> 'M' THEN salary
    ELSE 0
END AS bonus
FROM Employees
ORDER BY employee_id;