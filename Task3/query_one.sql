SELECT
    TO_CHAR(T.timeslot_date, 'Mon') AS month,
    COUNT(IL.lesson_id) AS individual_lesson,
    COUNT(GL.lesson_id) AS group_lesson,
    COUNT(EL.lesson_id) AS ensemble_lesson,
    COUNT(IL.lesson_id) + COUNT(GL.lesson_id) 
        + COUNT(EL.lesson_id) AS total,
    EXTRACT(YEAR FROM CURRENT_DATE) AS current_year
FROM
    timeslot AS T
JOIN lesson ON 
    T.lesson_id = lesson.lesson_id
LEFT JOIN individual_lesson AS IL ON 
    IL.lesson_id = lesson.lesson_id
LEFT JOIN group_lesson AS GL ON 
    GL.lesson_id = lesson.lesson_id
LEFT JOIN ensemble_lesson AS EL ON 
    EL.lesson_id = lesson.lesson_id
WHERE 
    EXTRACT(YEAR FROM T.timeslot_date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    TO_CHAR(T.timeslot_date, 'Mon')
ORDER BY
    CASE TO_CHAR(T.timeslot_date, 'Mon')
        WHEN 'Jan' THEN 1
        WHEN 'Feb' THEN 2
        WHEN 'Mar' THEN 3
        WHEN 'Apr' THEN 4
        WHEN 'May' THEN 5
        WHEN 'Jun' THEN 6
        WHEN 'Jul' THEN 7
        WHEN 'Aug' THEN 8
        WHEN 'Sep' THEN 9
        WHEN 'Oct' THEN 10
        WHEN 'Nov' THEN 11
        WHEN 'Dec' THEN 12
    END;