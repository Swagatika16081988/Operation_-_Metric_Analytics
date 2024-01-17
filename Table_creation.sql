create database project3;
show databases;
use project3;


CREATE TABLE job_data(
	ds DATE,
    job_id INT NOT NULL,
    actor_id INT NOT NULL,
	event VARCHAR(50) NOT NULL,
    language VARCHAR(50) NOT NULL,
    time_spent INT NOT NULL,
	org VARCHAR(5) NOT NULL
);

INSERT INTO job_data (ds, job_id, actor_id, event, language, time_spent, org)
VALUES ('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
       ('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
       ('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
       ('2020-11-28', 23, 1005,'transfer', 'Persian', 22, 'D'),
       ('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
       ('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
       ('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
       ('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');
       
SELECT * FROM job_data;
       
       
CREATE TABLE users(
	user_id INT UNIQUE PRIMARY KEY,
    created_at VARCHAR(50),
    company_id INT NOT NULL,
    language VARCHAR(50),
	activated_at VARCHAR(50),
	state VARCHAR(20)
);

SELECT * FROM users;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Case Study 2/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

ALTER TABLE users ADD COLUMN t_c_at DATETIME;
UPDATE users SET t_c_at = STR_TO_DATE(created_at, "%d-%m-%Y %H:%i");
ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users CHANGE COLUMN t_c_at created_at DATETIME;

ALTER TABLE users ADD COLUMN a_c_at DATETIME;
UPDATE users SET a_c_at = STR_TO_DATE(activated_at, "%d-%m-%Y %H:%i");
ALTER TABLE users DROP COLUMN activated_at;
ALTER TABLE users CHANGE COLUMN a_c_at activated_at DATETIME;

SELECT * FROM users;

CREATE TABLE events(
	user_id INT NOT NULL,
    occured_at VARCHAR(50),
    event_type VARCHAR(50),
    event_name VARCHAR(50),
	location VARCHAR(50),
	device VARCHAR(100),
    user_type INT NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Case Study 2/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM events;

ALTER TABLE events ADD COLUMN o_at DATETIME;
UPDATE events SET o_at = STR_TO_DATE(occured_at, "%d-%m-%Y %H:%i");
ALTER TABLE events DROP COLUMN occured_at;
ALTER TABLE events CHANGE COLUMN o_at occured_at DATETIME;

SELECT * FROM events;


CREATE TABLE email_events(
	user_id INT NOT NULL,
    occured_at VARCHAR(50),
	action VARCHAR(100),
    user_type INT NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Case Study 2/email_events.csv'
INTO TABLE email_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM email_events;

ALTER TABLE email_events ADD COLUMN o_at DATETIME;
UPDATE email_events SET o_at = STR_TO_DATE(occured_at, "%d-%m-%Y %H:%i");
ALTER TABLE email_events DROP COLUMN occured_at;
ALTER TABLE email_events CHANGE COLUMN o_at occured_at DATETIME;

SELECT * FROM email_events;


 