-- users

DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE users
(
	id                 BIGINT    NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,

	first_name         TEXT      NOT NULL,
	last_name          TEXT      NOT NULL,
	birth_date         DATE      NOT NULL,
	joining_date       DATE      NOT NULL,

	gender             TEXT      NOT NULL,

	is_active          BOOLEAN   NOT NULL DEFAULT TRUE,

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP(),
	update_timestamp   TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP(),
	deletion_timestamp TIMESTAMP NULL,

	version            INTEGER   NOT NULL DEFAULT 0
);

INSERT INTO users (first_name, last_name, birth_date, joining_date, gender)
VALUES ('Thomas', 'Anderson', '1971-09-13', '1999-03-31', 'male'),
	   ('Steve', 'Rogers', '1915-01-01', '1940-03-15', 'male'),
	   ('Bruce', 'Banner', '1982-02-01', '2012-05-04', 'male'),
	   ('Samuel ', 'Jackson', '1962-12-31', '1980-05-04', 'male'),
	   ('Carol', 'Danvers', '1960-02-29', '1985-09-09', 'female'),
	   ('Natasha', 'Romanoff', '1987-09-30', '2012-05-04', 'female'),
	   ('Maria', 'Hill', '1971-09-13', '2011-05-04', 'female');

-- tasks

DROP TABLE IF EXISTS tasks CASCADE;

CREATE TABLE tasks
(
	id                 BIGINT    NOT NULL PRIMARY KEY,

	parent_id          BIGINT    NULL REFERENCES tasks (id) ON UPDATE CASCADE ON DELETE CASCADE,

	title              TEXT      NOT NULL,
	description        TEXT      NOT NULL DEFAULT '',

	is_active          BOOLEAN   NOT NULL DEFAULT TRUE,

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP(),
	update_timestamp   TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP(),
	deletion_timestamp TIMESTAMP NULL,

	version            INTEGER   NOT NULL DEFAULT 0
);


INSERT INTO tasks (id, title)
VALUES (1, 'Parent 1'), (2, 'Parent 2'), (3, 'Parent 3');

INSERT INTO tasks (id, parent_id, title)
VALUES (4, 1, 'Child 1.1'),
	   (5, 1, 'Child 1.2'),
	   (6, 1, 'Child 1.3'), --
	   (7, 2, 'Child 2.1'),
	   (8, 2, 'Child 2.2'),
	   (9, 2, 'Child 2.3'), --
	   (10, 3, 'Child 3.1'),
	   (11, 3, 'Child 3.2'),
	   (12, 3, 'Child 3.3'),
	   (13, 3, 'Child 3.4');

INSERT INTO tasks (id, parent_id, title)
VALUES (14, 4, 'Child 1.1.1'), (15, 5, 'Child 1.2.1'), (16, 6, 'Child 1.3.1'), (17, 6, 'Child 1.3.2');


SELECT *
FROM tasks;