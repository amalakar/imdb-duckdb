CREATE
OR REPLACE TABLE movies AS

WITH persons AS (
    select p.nconst,
    tconst,
    n.primary_name,
    category,
    from title_principals p join name_basics n
    on p.nconst = n.nconst
), movie_persons as (
    select t.tconst,
    array_agg(primary_name) FILTER(category = 'actor' OR category = 'actress') as actors,
    array_agg(primary_name) FILTER (category = 'director') as directors,
    array_agg(primary_name) FILTER (category='producer') as producers,
    array_agg(primary_name) FILTER (category='writers') as writers
    from title_basics t join persons p
    on t.tconst = p.tconst
    group by 1
)
SELECT t.tconst                                        as id,
       concat('https://www.imdb.com/title/', t.tconst) as url,
       title_type,
       primary_title,
       original_title,
       is_adult,
       start_year,
       end_year,
       runtime_minutes,
       genres,
       average_rating,
       num_votes,
       actors,
       directors,
       producers,
       writers
from title_basics t
         join title_ratings r on t.tconst = r.tconst
         join movie_persons p on t.tconst = p.tconst;


COPY
(
SELECT *
FROM movies)
    TO 'movies.parquet'
    (FORMAT 'parquet');

