-- Simple common table expression
WITH voters AS (SELECT * FROM users u WHERE u.birth_date > '2001-08-07')
SELECT *
FROM voters;

-- Multiple common table expressions

WITH voters AS (SELECT * FROM users u WHERE u.birth_date > '2001-08-07'),
	 male_voters AS (SELECT * FROM users u WHERE u.birth_date > '2001-08-07' AND u.gender = 'male'),
	 female_voters AS (SELECT * FROM users u WHERE u.birth_date > '2001-08-07' AND u.gender = 'female')
SELECT count(mv.id) male_voter_count, count(fv.id) female_voter_count, count(v.id) total_voter_count
FROM male_voters mv, female_voters fv, voters v;

WITH voters AS (SELECT * FROM users u WHERE u.birth_date > '2001-08-07'),
	 male_voters AS (SELECT * FROM voters v WHERE v.gender = 'male'),
	 female_voters AS (SELECT * FROM voters v WHERE v.gender = 'female')
SELECT count(mv.id) male_voter_count, count(fv.id) female_voter_count, count(v.id) total_voter_count
FROM male_voters mv, female_voters fv, voters v;

-- Recursive common table expression

WITH RECURSIVE task_heirarchy AS (
    SELECT * FROM tasks t WHERE t.id = 1
    UNION ALL
    SELECT t.* FROM tasks t JOIN task_heirarchy th ON t.parent_id = th.id)
SELECT *
FROM task_heirarchy;

WITH RECURSIVE task_heirarchy AS (
    SELECT * FROM tasks t WHERE t.id = 17
    UNION ALL
    SELECT t.* FROM tasks t JOIN task_heirarchy th ON t.id = th.parent_id)
SELECT *
FROM task_heirarchy;