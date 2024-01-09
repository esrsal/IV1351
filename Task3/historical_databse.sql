
CREATE DATABASE historical;


CREATE EXTENSION IF NOT EXISTS postgres_fdw;

-- The names below should be adjusted to your databse name, and the port used
CREATE SERVER histserver
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (dbname 'new_sound', host 'localhost', port '5433');

-- The user and password should be adjusted based on your username and password
CREATE USER MAPPING FOR current_user
SERVER histserver
OPTIONS (user 'postgres', password 'xxx');


CREATE SCHEMA historical_schema;



IMPORT FOREIGN SCHEMA public FROM SERVER histserver INTO historical_schema;



CREATE TABLE historical_schema.recording (
    record_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255),
    student_last_name VARCHAR(255),
    student_email VARCHAR(255),
    lesson_type VARCHAR(255),
    genre VARCHAR(255),
    instrument_used VARCHAR(255),
    price NUMERIC
);


INSERT INTO historical_schema.recording (
    student_name,
    student_last_name,
    student_email,
    lesson_type,
    genre,
    instrument_used,
    price
)
SELECT
    person.first_name AS student_name,
    person.last_name AS student_last_name,
    email.email_address AS student_email,
    lesson_type_ENUM.lesson_type AS lesson_type,
    ensemble_lesson.genre AS genre,
    COALESCE(individual_lesson.instrument_used, group_lesson.instrument_used) AS instrument_used,
    price_management.price AS price
FROM
    historical_schema.student
    LEFT JOIN historical_schema.person ON historical_schema.student.person_id = historical_schema.person.person_id
    JOIN historical_schema.email ON historical_schema.email.person_id = historical_schema.person.person_id
    JOIN historical_schema.registration ON historical_schema.student.student_id = historical_schema.registration.student_id
    JOIN historical_schema.lesson ON historical_schema.lesson.lesson_id = historical_schema.registration.lesson_id
    JOIN historical_schema.price_management ON historical_schema.price_management.price_id = historical_schema.lesson.price_id
    JOIN historical_schema.lesson_type_ENUM ON historical_schema.price_management.lesson_type_id = historical_schema.lesson_type_ENUM.lesson_type_id
    LEFT JOIN historical_schema.ensemble_lesson ON historical_schema.lesson.lesson_id = historical_schema.ensemble_lesson.lesson_id
    LEFT JOIN historical_schema.group_lesson ON historical_schema.lesson.lesson_id = historical_schema.group_lesson.lesson_id
    LEFT JOIN historical_schema.individual_lesson ON historical_schema.lesson.lesson_id = historical_schema.individual_lesson.lesson_id;


SELECT
    recording.student_name,
	recording.student_last_name,
	recording.student_email,
    recording.lesson_type,
	recording.price,
    recording.genre,
    recording.instrument_used
   
FROM
    historical_schema.recording recording;

