--The view: 
CREATE VIEW my_ensemble_count_view AS
SELECT
    ensemble_lesson.max_number_of_student AS max,
    ensemble_lesson.min_number_of_student AS min,
    ensemble_lesson.genre AS genre,
    TO_CHAR(timeslot.timeslot_date, 'Dy') AS day_of_week,
    COUNT(*) AS number_of_students
FROM
    lesson AS L
JOIN
    ensemble_lesson ON L.lesson_id = ensemble_lesson.lesson_id
JOIN
    registration AS R ON R.lesson_id = L.lesson_id
JOIN
    timeslot ON timeslot.lesson_id = R.lesson_id
WHERE 
    timeslot.timeslot_date >= CURRENT_DATE
    AND timeslot.timeslot_date < CURRENT_DATE + INTERVAL '1 week'
GROUP BY
    L.lesson_id, day_of_week, max, min, genre; 
--the query to use to get the analytical table:
SELECT 
    day_of_week,
    genre,
    CASE 
        WHEN number_of_students > max THEN 'No Seat' 
        WHEN number_of_students < max 
            AND number_of_students > max-2 THEN '1 or 2 seats'
        ELSE 'many seats'
    END AS number_of_free_seats,
    number_of_students 
FROM my_ensemble_count_view;