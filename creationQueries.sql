CREATE TABLE person(
	person_id serial PRIMARY KEY, 
	first_name VARCHAR(500) NOT NULL,
	last_name VARCHAR(500) NOT NULL,
	person_number NUMERIC(12) NOT NULL, 
	street VARCHAR(500),
	zip VARCHAR(20),
	city VARCHAR(500)
);

CREATE TABLE phone(
	phone_id serial PRIMARY KEY,
	phone_number VARCHAR(200),
	person_id INT REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE email(
	email_id serial PRIMARY KEY,
	email_address VARCHAR(200),
	person_id INT REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE contact_person( 
	contact_person_id serial PRIMARY KEY,
	first_name VARCHAR(500),
	last_name VARCHAR(500)
);

CREATE TABLE contact_person_phone(
	contact_person_phone_id serial PRIMARY KEY,
	phone_number VARCHAR(20),
	contact_person_id INT REFERENCES contact_person(contact_person_id) ON DELETE CASCADE
);
CREATE TABLE student(
	student_id serial PRIMARY KEY,
	family_id INT NOT NULL,
	person_id INT REFERENCES person(person_id) ON DELETE CASCADE,
	contact_person_id INT REFERENCES contact_person(contact_person_id)
);

CREATE TABLE instructor(
	instructor_id serial PRIMARY KEY,
	is_able_to_teach_ensemble BOOLEAN,
	person_id INT REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE instructor_skill(
	instructor_skill_id serial PRIMARY KEY,
	skill VARCHAR(200),
	instructor_id INT REFERENCES instructor(instructor_id)
);
CREATE TABLE availability(
	availability_id serial PRIMARY KEY,
	start_time TIME,
	end_time TIME,
	availability_date DATE,
	instructor_id INT REFERENCES instructor(instructor_id)
);
CREATE TABLE renting_system(
	rent_id serial PRIMARY KEY,
	renting_date DATE,
	student_id INT REFERENCES student(student_id)
);
CREATE TABLE inventory(
	inventory_id serial PRIMARY KEY,
	instrument_type VARCHAR(500) NOT NULL,
	model VARCHAR(500) ,
	brand VARCHAR(500) ,
	monthly_price MONEY,
	number_of_instrument INT
);
CREATE TABLE instrument(
	instrument_id serial PRIMARY KEY,
	rent_id INT NOT NULL REFERENCES renting_system(rent_id),
	inventory_id INT NOT NULL REFERENCES inventory(inventory_id)
);

CREATE TABLE student_skill(
	student_skill_id serial PRIMARY KEY,
	skill VARCHAR(200),
	student_id INT NOT NULL REFERENCES student(student_id)
);
CREATE TABLE price_management(
	price_id serial PRIMARY KEY, 
	lesson_type VARCHAR(500) NOT NULL,
	skill_level VARCHAR(200) NOT NULL,
	price MONEY,
	start_valid_date DATE,
	end_valid_date DATE
);
CREATE TABLE lesson(
	lesson_id serial PRIMARY KEY,
	instructor_id INT NOT NULL REFERENCES instructor(instructor_id), 
	price_id INT NOT NULL REFERENCES price_manegment(price_id)
);

CREATE TABLE registration(
	registration_id serial PRIMARY KEY,
	registration_date TIME, 
	registration_time TIME,
	student_id INT NOT NULL REFERENCES student(student_id),
	lesson_id INT NOT NULL REFERENCES lesson(lesson_id) 
);

CREATE TABLE group_lesson(
	group_id serial PRIMARY KEY,
	instrument_used VARCHAR(500) NOT NULL, 
	max_number_of_student INT ,
	min_number_of_student INT ,
	lesson_id INT NOT NULL REFERENCES lesson(lesson_id)
);
CREATE TABLE individual_lesson(
	individual_id serial PRIMARY KEY,
	instrument_used VARCHAR(500) NOT NULL,
	skill_level VARCHAR(500),
	lesson_id INT NOT NULL REFERENCES lesson(lesson_id)
);

CREATE TABLE ensemble_lesson(
	ensemble_id serial PRIMARY KEY,
	genre VARCHAR(500) NOT NULL, 
	max_number_of_student INT,
	min_number_of_student INT,
	lesson_id INT NOT NULL REFERENCES lesson(lesson_id)
);

CREATE TABLE timeslot(
	timeslot_id serial PRIMARY KEY,
	start_time TIME, 
	end_time TIME,
	place VARCHAR(50) NOT NULL,
	lesson_id INT NOT NULL REFERENCES lesson(lesson_id), 
	timeslot_date DATE
);

CRATE TABLE policy(
	policy_id serial PRIMARY KEY,
	description VARCHAR(500),
	start_valid_date DATE,
	end_valid_date DATE
);

