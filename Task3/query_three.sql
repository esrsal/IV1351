WITH lesson_count AS (
    SELECT
        I.instructor_id,
        COUNT(*) AS given_lesson_count
    FROM
        timeslot AS TS
    JOIN
        lesson ON TS.lesson_id = lesson.lesson_id
    JOIN
        instructor AS I ON lesson.instructor_id = I.instructor_id
    WHERE
        TS.timeslot_date >= DATE_TRUNC('MONTH', 
            CURRENT_DATE - INTERVAL '1 month')
        AND TS.timeslot_date < DATE_TRUNC('MONTH', CURRENT_DATE)
    GROUP BY
        I.instructor_id
)

SELECT
    I.instructor_id,
    P.first_name,
    P.last_name,
    LC.given_lesson_count
FROM
    instructor AS I
JOIN
    person AS P ON I.person_id = P.person_id
JOIN
    lesson_count AS LC ON I.instructor_id = LC.instructor_id;