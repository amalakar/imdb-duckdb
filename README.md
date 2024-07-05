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
.read raw_import.sql

.read movies.sql

select count(*) cnt from movies;
```

## Data Model / Sample
### Denormalized Tables
#### movies

|     id     |                  url                  | title_type | primary_title  | original_title | is_adult | start_year | end_year | runtime_minutes |           genres           | average_rating | num_votes |                                                                          actors                                                                          |     directors      |                           producers                           | writers |
|------------|---------------------------------------|------------|----------------|----------------|---------:|------------|----------|-----------------|----------------------------|---------------:|----------:|----------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------|---------------------------------------------------------------|---------|
| tt15239678 | https://www.imdb.com/title/tt15239678 | movie      | Dune: Part Two | Dune: Part Two | false    | 2024       |          | 166             | [Action, Adventure, Drama] | 8.6            | 464587    | [Timothée Chalamet, Zendaya, Rebecca Ferguson, Josh Brolin, Austin Butler, Dave Bautista, Christopher Walken, Léa Seydoux, Javier Bardem, Florence Pugh] | [Denis Villeneuve] | [Patrick McCormick, Mary Parent, Cale Boyter, Tanya Lapointe] |         |

### Raw IMDB tables
#### name_basics

| nid       |   primary_name   | birth_year | death_year |      primary_profession      |               known_for_titles               |
|-----------|------------------|-----------:|------------|------------------------------|----------------------------------------------|
| nm0898288 | Denis Villeneuve | 1967       |            | [director, writer, producer] | [tt1160419, tt1856101, tt1255953, tt2543164] |

#### title_akas

|  id  | ordering |     title      | region | language |    types    | attributes | is_original_title |
|------|---------:|----------------|--------|----------|-------------|------------|------------------:|
| tt15239678 | 1        | Dune: Part Two |        |          | original    |            | true              |
| tt15239678 | 10       | Dune: Part Two | SE     |          | imdbDisplay |            | false             |

#### title_basics
|     id     | type  | primary_title  | original_title | is_adult | start_year | end_year | runtime_minutes |           genres           |
|------------|-------|----------------|----------------|---------:|------------|----------|-----------------|----------------------------|
| tt15239678 | movie | Dune: Part Two | Dune: Part Two | false    | 2024       |          | 166             | [Action, Adventure, Drama] |

#### title_crew

|     id     |  directors  |              writers              |
|------------|-------------|-----------------------------------|
| tt15239678 | [nm0898288] | [nm0898288, nm3123612, nm0378541] |

#### title_episode

|    id     | parent_tconst | season_number | episode_number |
|-----------|---------------|---------------|----------------|
| tt0041951 | tt0041038     | 1             | 9              |
| tt0042816 | tt0989125     | 1             | 17             |

### title_principals

|     id     |    nid    | ordering |      category       |           job           |      characters       |
|------------|-----------|---------:|---------------------|-------------------------|-----------------------|
| tt15239678 | nm3154303 | 1        | actor               |                         | [Paul Atreides]       |
| tt15239678 | nm3918035 | 2        | actress             |                         | [Chani]               |
| tt15239678 | nm0272581 | 3        | actress             |                         | [Jessica]             |

### title_ratings

|     id     | avgerage_rating | votes  |
|------------|----------------:|-------:|
| tt15239678 | 8.6             | 464587 |