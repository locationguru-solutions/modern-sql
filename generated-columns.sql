-- users

DROP TABLE IF EXISTS humans CASCADE;

CREATE TABLE humans
(
	id                 BIGINT    NOT NULL PRIMARY KEY,

	first_name         TEXT      NOT NULL,
	last_name          TEXT      NOT NULL,
	display_name       TEXT      NOT NULL GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED,

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP()
);

INSERT INTO humans (id, first_name, last_name)
VALUES (1, 'Donald', 'Duck');

SELECT * FROM humans;