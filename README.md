## About

IMDb makes some of their dataset available for non-commercial / personal use at: https://datasets.imdbws.com/
This project allows you to easily import that set into duckdb, and creates a normalized table `movies`
from all the denormalized tsv files they make available.

## How to run

1. Install [duckdb](https://duckdb.org/docs/installation/)
```bash
brew install duckdb
```

2. Run duckdb
```
duckdb imdb.duckdb
```

3. Run the sql files within duckdb
```sql
.read duckdb.import.sql

.read denormalize.sql

select count(*) cnt from movies;
```

### name_basics

|  nconst   | primary_name  | birth_year | death_year |           primary_profession           |               known_for_titles               |
|-----------|---------------|-----------:|-----------:|----------------------------------------|----------------------------------------------|
| nm0000001 | Fred Astaire  | 1899       | 1987       | [actor, miscellaneous, producer]       | [tt0072308, tt0050419, tt0053137, tt0027125] |
| nm0000002 | Lauren Bacall | 1924       | 2014       | [actress, soundtrack, archive_footage] | [tt0037382, tt0075213, tt0117057, tt0038355] |

### title_akas

|  titleId  | ordering |   title    | region | language |  types   |  attributes   | is_original_title |
|-----------|---------:|------------|--------|----------|----------|---------------|------------------:|
| tt0000001 | 1        | Carmencita |        |          | original |               | true              |
| tt0000001 | 2        | Carmencita | DE     |          |          | literal title | false             |


### title_basics
|  tconst   | title_type |     primary_title      |     original_title     | is_adult | start_year | end_year | runtime_minutes |        genres        |
|-----------|------------|------------------------|------------------------|---------:|------------|----------|-----------------|----------------------|
| tt0000001 | short      | Carmencita             | Carmencita             | false    | 1894       |          | 1               | [Documentary, Short] |
| tt0000002 | short      | Le clown et ses chiens | Le clown et ses chiens | false    | 1892       |          | 5               | [Animation, Short]   |


### title_crew

|  tconst   |  directors  | writers |
|-----------|-------------|---------|
| tt0000001 | [nm0005690] |         |
| tt0000002 | [nm0721526] |         |

### title_episode

|  tconst   | parent_tconst | season_number | episode_number |
|-----------|---------------|---------------|----------------|
| tt0041951 | tt0041038     | 1             | 9              |
| tt0042816 | tt0989125     | 1             | 17             |

### title_principals

|  tconst   | ordering |  nconst   | category | job | characters |
|-----------|---------:|-----------|----------|-----|------------|
| tt0000001 | 1        | nm1588970 | self     |     | [Self]     |
| tt0000001 | 2        | nm0005690 | director |     |            |

### title_ratings

|  tconst   | average_rating | num_votes |
|-----------|---------------:|----------:|
| tt0000001 | 5.7            | 2062      |
| tt0000002 | 5.6            | 279       |