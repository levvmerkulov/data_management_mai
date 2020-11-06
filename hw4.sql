-- Первый запрос выводит ФИО
SELECT 'ФИО: Меркулов Лев Владимирович';

-- Создание таблицы для импорта csv-файла
CREATE TABLE movie.content_genres (
    movieid numeric,
    genre text );

-- Extract. Импорт файла в Postgres
\copy movie.content_genres FROM 'src/genres.csv' DELIMITER ',' CSV HEADER;

SELECT COUNT(*) FROM movie.content_genres;

-- Transform. Обогащение выборки контента и сохранение в новую таблицу
WITH top_rated AS (
	SELECT movieid, AVG(rating) OVER (PARTITION BY movieid) as avg_rating
	FROM movie.ratings
	GROUP BY movieid, rating
	HAVING COUNT(userid) > 50
	ORDER BY avg_rating DESC, movieid ASC
	LIMIT 150 )
SELECT 
	top_rated.movieid, top_rated.avg_rating, kw.keywords
INTO
	movie.top_films_with_tags
FROM top_rated
INNER JOIN ( 
	SELECT movieid, array_agg(genre) as keywords
	FROM movie.content_genres
	GROUP BY movieid) kw
ON 
	top_rated.movieid = kw.movieid;

-- Load. Экспорт таблицы Postgres в файл с разделителем в виде табуляции
\copy movie.top_films_with_tags TO '/usr/share/data_store/raw_data/top_films_with_tags.csv' DELIMITER E'\t' CSV HEADER;