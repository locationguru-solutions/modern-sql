-- soldiers

DROP TABLE IF EXISTS soldiers CASCADE;

CREATE TABLE soldiers
(
	id                 BIGINT    NOT NULL PRIMARY KEY,

	name               TEXT      NOT NULL,

	is_avenger         BOOLEAN   NOT NULL DEFAULT FALSE,
	is_active          BOOLEAN   NOT NULL DEFAULT TRUE,

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP(),
	update_timestamp   TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP(),
	deletion_timestamp TIMESTAMP NULL,

	version            INTEGER   NOT NULL DEFAULT 0
);


CREATE VIEW avengers AS
SELECT * FROM soldiers s WHERE s.is_avenger IS TRUE;

DROP VIEW avengers;

CREATE MATERIALIZED VIEW avengers AS
SELECT * FROM soldiers s WHERE s.is_avenger IS TRUE;

SELECT *
FROM avengers;