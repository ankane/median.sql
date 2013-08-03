# Median.sql

Adds a median function to PostgreSQL.

Found on [postgresonline.com](http://www.postgresonline.com/journal/archives/67-Build-Median-Aggregate-Function-in-SQL.html) in a comment by Mike.

```sql
SELECT median(n) FROM generate_series(1, 5, 1) n;
-- 3

SELECT median(n) FROM generate_series(1, 6, 1) n;
-- 3.5

SELECT median(n) FROM generate_series(1, 0) n;
-- NULL
```

## Installation

```sh
curl https://raw.github.com/ankane/median.sql/master/postgresql.sql | psql db_name
```
