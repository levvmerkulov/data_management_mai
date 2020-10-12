-- первый запрос выводит ФИО
SELECT 'ФИО: Меркулов Лев Владимирович';

-- 1.Простые выборки
SELECT * FROM movie.ratings LIMIT 10;

SELECT * FROM movie.links WHERE imdbid like '%42' AND movieid > 100 AND movieid < 1000 LIMIT 10;

-- 2.Сложные выборки. JOIN
SELECT DISTINCT(imdbid)
FROM movie.links
INNER JOIN movie.ratings
	ON links.movieid=ratings.movieid
WHERE ratings.rating = 5 
LIMIT 10;

-- 3.Аггрегация данных: базовые статистики
SELECT COUNT(DISTINCT(links.movieid)) AS unvalued_movies 
FROM movie.links
LEFT JOIN movie.ratings
	ON links.movieid=ratings.movieid
WHERE ratings.rating is NULL;

SELECT userid, AVG(rating) as avg_rating
FROM movie.ratings
GROUP BY userid
HAVING AVG(rating) > 3.5
ORDER BY avg_rating DESC
LIMIT 10;

-- 4.Иерархические запросы
-- 4.1. Подзапросы
SELECT DISTINCT imdbid 
FROM movie.links 
WHERE links.movieid IN (
	SELECT movieid 
	FROM movie.ratings 
	GROUP BY movieid 
	HAVING AVG(rating) > 3.5
) 
LIMIT 10;

-- 4.2. Common Table Expressions
WITH tmp_table AS ( 
	SELECT userid, AVG(rating) as avg_user_rating
	FROM movie.ratings
	GROUP BY userid
	HAVING count(rating) > 10 
)
SELECT AVG(avg_user_rating) FROM tmp_table;

