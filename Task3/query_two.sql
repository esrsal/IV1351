WITH family_counts AS (
SELECT family_id, COUNT(*) AS sibling_count
FROM student
GROUP BY family_id
HAVING COUNT(*) IN (1, 2, 3)
)

SELECT 
    sibling_count-1 AS no_of_siblings,
    SUM(CASE WHEN sibling_count = 1 THEN 1 ELSE 0 END) +
    SUM(CASE WHEN sibling_count = 2 THEN 1 ELSE 0 END) * 2+
    SUM(CASE WHEN sibling_count = 3 THEN 1 ELSE 0 END) * 3 
        AS number_of_students
FROM family_counts
GROUP BY sibling_count
ORDER BY sibling_count; 