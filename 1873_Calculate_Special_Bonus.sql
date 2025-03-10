/*
employee_id -> PK
Table: employee ID, employee name, and salary
Bonus is 100% if: ID = odd, name[0] != M
*/
SELECT 
    employee_id,
    IF(employee_id % 2 = 1 AND SUBSTRING(name, 1, 1) != 'M', salary, 0) AS bonus
FROM 
    Employees
ORDER BY
    employee_id