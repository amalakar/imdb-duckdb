CREATE OR REPLACE TABLE name_basics as
SELECT nconst as nid,
       primaryName as primary_name,
       birthYear as birth_year,
       deathYear as death_year,
       regexp_split_to_array(primaryProfession, ',') as primary_profession,
       regexp_split_to_array(knownForTitles, ',') as known_for_titles,
FROM read_csv('https://datasets.imdbws.com/name.basics.tsv.gz', delim = '\t', quote = NULL, nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM name_basics) TO 'name_basics.parquet' (FORMAT 'parquet');

CREATE OR REPLACE TABLE title_akas as
SELECT
       titleId as id,
       * EXCLUDE(titleId, isOriginalTitle),
       CAST(isOriginalTitle as boolean) as is_original_title
FROM read_csv('https://datasets.imdbws.com/title.akas.tsv.gz', delim = '\t', quote = NULL, nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM title_akas) TO 'title_akas.parquet' (FORMAT 'parquet');

CREATE OR REPLACE TABLE title_basics as
SELECT
    tconst as id,
    titleType as type,
    primaryTitle as primary_title,
    originalTitle as original_title,
    CAST(isAdult as boolean) as is_adult,
    CAST(startYear as USMALLINT) as start_year,
    CAST(endYear as USMALLINT) as end_year,
    CAST(runtimeMinutes as USMALLINT) as runtime_minutes,
    regexp_split_to_array(genres, ',') as genres
FROM read_csv('https://datasets.imdbws.com/title.basics.tsv.gz', delim = '\t', quote = NULL, nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM title_basics) TO 'title_basics.parquet' (FORMAT 'parquet');

CREATE OR REPLACE TABLE title_crew as
SELECT tconst as id,
       regexp_split_to_array(directors, ',') as directors,
       regexp_split_to_array(writers, ',') as writers
FROM read_csv('https://datasets.imdbws.com/title.crew.tsv.gz', delim = '\t', quote = NULL, nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM title_crew) TO 'title_crew.parquet' (FORMAT 'parquet');

CREATE OR REPLACE TABLE title_episode as
SELECT tconst as id,
       parentTconst as parent_tconst,
       CAST(seasonNumber as UINTEGER) as season_number,
       CAST(episodeNumber as UINTEGER) as episode_number
FROM read_csv('https://datasets.imdbws.com/title.episode.tsv.gz', delim = '\t', quote = NULL, nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM title_episode) TO 'title_episode.parquet' (FORMAT 'parquet');


CREATE OR REPLACE TABLE title_principals as
SELECT
    tconst as id,
    nconst as nid,
    * EXCLUDE(tconst, nconst, characters),
    list_transform(
        CAST(characters AS TEXT[]),
        c -> regexp_extract(c, '^"(.*)"$', 1)
    ) as characters
FROM read_csv('https://datasets.imdbws.com/title.principals.tsv.gz', delim = '\t', quote = NULL,
              nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM title_principals) TO 'title_principals.parquet' (FORMAT 'parquet');

CREATE OR REPLACE TABLE title_ratings as
SELECT tconst as id,
       averageRating as avgerage_rating,
       numVotes as votes
FROM read_csv('https://datasets.imdbws.com/title.ratings.tsv.gz', delim = '\t', quote = NULL, nullstr = '\N', escape=NULL);

-- COPY( SELECT * FROM title_ratings) TO 'title_ratings.parquet' (FORMAT 'parquet');
