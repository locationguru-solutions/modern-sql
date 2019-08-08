-- Inner join

SELECT u.*, v.*
FROM users u
	 INNER JOIN vehicles v ON u.id = v.users_id;

-- Left join

SELECT u.*, v.*
FROM users u
	 LEFT JOIN vehicles v ON u.id = v.users_id;

-- Right join

SELECT u.*, v.*
FROM users u
	 RIGHT JOIN vehicles v ON u.id = v.users_id;

-- Full join

SELECT u.*, v.*
FROM users u
	 FULL JOIN vehicles v ON u.id = v.users_id;

-- Self join

SELECT u1.*, u2.*
FROM users u1
	 JOIN users u2 ON u1.birth_date = u2.birth_date;

-- Cartesian join

SELECT u.*, v.*
FROM users u, vehicles v;

-- Natural join

SELECT *
FROM books b
	 NATURAL JOIN magazines;