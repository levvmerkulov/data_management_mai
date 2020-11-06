-- первый запрос выводит ФИО
SELECT 'ФИО: Меркулов Лев Владимирович';

-- оконные функции
SELECT 
	userid, 
	movieid,
	((rating - MIN(rating) OVER (PARTITION BY userid)) / 
	(MAX(rating) OVER (PARTITION BY userid) - MIN(rating) OVER (PARTITION BY userid))) as normed_rating,
	AVG(rating) OVER (PARTITION BY userid) as avg_rating
FROM 
	movie.ratings
LIMIT 30;
