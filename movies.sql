CREATE
OR REPLACE TABLE movies AS

WITH persons AS (
    select p.nid,
    id,
    n.primary_name,
    category,
    from title_principals p join name_basics n
    on p.nid = n.nid
), movie_persons as (
    select t.id,
    array_agg(primary_name) FILTER(category = 'actor' OR category = 'actress') as actors,
    array_agg(primary_name) FILTER (category = 'director') as directors,
    array_agg(primary_name) FILTER (category='producer') as producers,
    array_agg(primary_name) FILTER (category='writers') as writers
    from title_basics t join persons p
    on t.id = p.id
    group by 1
)
SELECT t.id                                        as id,
       concat('https://www.imdb.com/title/', t.id) as url,
       type,
       primary_title,
       original_title,
       is_adult,
       start_year,
       end_year,
       runtime_minutes,
       genres,
       average_rating as rating,
       votes,
       actors,
       directors,
       producers,
       writers
from title_basics t
         join title_ratings r on t.id = r.id
         join movie_persons p on t.id = p.id;


COPY
(
SELECT *
FROM movies)
    TO 'movies.parquet'
    (FORMAT 'parquet');

