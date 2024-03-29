-- employees

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees
(
	id                 BIGINT    NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,

	customer_id        BIGINT    NOT NULL DEFAULT (cast((random() * 100 + 1) AS BIGINT)),

	name               TEXT      NOT NULL,

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP()

);

-- devices

DROP TABLE IF EXISTS devices CASCADE;

CREATE TABLE devices
(
	id                 BIGINT    NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,

	customer_id        BIGINT    NOT NULL DEFAULT (cast((random() * 100 + 1) AS BIGINT)),

	serial_number      TEXT      NOT NULL,

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP()

);

-- employee_device_mapping

DROP TABLE IF EXISTS employee_device_mapping CASCADE;

CREATE TABLE employee_device_mapping
(
	id                 BIGINT    NOT NULL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,

	customer_id        BIGINT    NOT NULL,
	employee_id        BIGINT    NOT NULL REFERENCES employees (id),
	device_id          BIGINT    NOT NULL REFERENCES devices (id),

	creation_timestamp TIMESTAMP NOT NULL DEFAULT CLOCK_TIMESTAMP()
);

INSERT INTO employees(name
)
SELECT ('E-' || split_part(uuid_generate_v4()::TEXT, '-', 5))
FROM generate_series(1, 10000);

INSERT INTO devices(serial_number
)
SELECT ('S-' || split_part(uuid_generate_v4()::TEXT, '-', 5))
FROM generate_series(1, 1000);

INSERT INTO employee_device_mapping(customer_id, employee_id, device_id)
	(SELECT e.customer_id, e.id, d.id
	 FROM employees e
		  JOIN devices d ON d.customer_id = e.customer_id);

SELECT *
FROM employee_device_mapping
LIMIT 100;

SELECT DISTINCT customer_id, count(customer_id)
FROM employee_device_mapping
GROUP BY customer_id
ORDER BY customer_id
LIMIT 100
;

EXPLAIN ANALYZE
SELECT e.*
FROM employees e
	 JOIN employee_device_mapping edm ON e.customer_id = 1 AND edm.customer_id = 1 AND e.id = edm.employee_id
	 JOIN devices d ON d.customer_id = 1 AND edm.device_id = d.id
WHERE e.customer_id = 1;

EXPLAIN ANALYZE
	SELECT e.*
	FROM employees e
		 JOIN employee_device_mapping edm ON e.id = edm.employee_id
		 JOIN devices d ON edm.device_id = d.id
	WHERE e.customer_id = 1;


SELECT *
FROM users
WHERE creation_timestamp >= '2019-08-08'
      and creation_timestamp < '2019-08-09';