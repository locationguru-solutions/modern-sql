-- Top 3 oldest employees using LIMIT

SELECT *
FROM users u
ORDER BY u.joining_date
LIMIT 3;

-- Top 3 newest employees using LIMIT

SELECT *
FROM users u
ORDER BY u.joining_date DESC
LIMIT 3;

-- Top oldest male and female employees using LIMIT

SELECT *
FROM users u
	 JOIN (SELECT u2.gender, min(u2.joining_date) joining_date FROM users u2 GROUP BY u2.gender) u2
		  ON u.gender = u2.gender AND u.joining_date = u2.joining_date;

-- Top newest male and female employees using LIMIT

SELECT *
FROM users u
	 JOIN (SELECT u2.gender, max(u2.joining_date) joining_date FROM users u2 GROUP BY u2.gender) u2
		  ON u.gender = u2.gender AND u.joining_date = u2.joining_date;

-- Top 3 oldest employees using RANK()

SELECT *
FROM (SELECT RANK() OVER (ORDER BY u.joining_date) rank_number, u.*
	  FROM users u) u
WHERE u.rank_number <= 3;

-- Top 3 newest employees using RANK()

SELECT *
FROM (SELECT RANK() OVER (ORDER BY u.joining_date DESC) rank_number, u.*
	  FROM users u) u
WHERE u.rank_number <= 3;

-- Top 3 oldest employees using DENSE_RANK()

SELECT *
FROM (SELECT DENSE_RANK() OVER (ORDER BY u.joining_date) rank_number, u.*
	  FROM users u) u
WHERE u.rank_number <= 3;

-- Top 3 newest employees using DENSE_RANK()

SELECT *
FROM (SELECT DENSE_RANK() OVER (ORDER BY u.joining_date DESC) rank_number, u.*
	  FROM users u) u
WHERE u.rank_number <= 3;

-- Top oldest male and female employees using LIMIT

SELECT *
FROM (SELECT DENSE_RANK() OVER (PARTITION BY u.gender ORDER BY u.joining_date) rank_number, u.*
	  FROM users u) u
WHERE u.rank_number = 1;

-- Top newest male and female employees using LIMIT

SELECT *
FROM (SELECT DENSE_RANK() OVER (PARTITION BY u.gender ORDER BY u.joining_date DESC) rank_number, u.*
	  FROM users u) u
WHERE u.rank_number = 1;