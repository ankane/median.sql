-- median
-- http://www.postgresonline.com/journal/archives/67-Build-Median-Aggregate-Function-in-SQL.html

CREATE OR REPLACE FUNCTION array_median(numeric[])
  RETURNS numeric AS
$$
    SELECT CASE
    WHEN array_upper($1,1) = 0 THEN null
    WHEN mod(array_upper($1,1),2) = 1 THEN asorted[ceiling(array_upper(asorted,1)/2.0)]
    ELSE ((asorted[ceiling(array_upper(asorted,1)/2.0)] + asorted[ceiling(array_upper(asorted,1)/2.0)+1])/2.0) END
    FROM (SELECT ARRAY(SELECT ($1)[n] FROM
generate_series(1, array_upper($1, 1)) AS n
    WHERE ($1)[n] IS NOT NULL
            ORDER BY ($1)[n]
) As asorted) As foo ;
$$
  LANGUAGE SQL;

DROP AGGREGATE IF EXISTS median(numeric);
CREATE AGGREGATE median(numeric) (
  SFUNC=array_append,
  STYPE=numeric[],
  FINALFUNC=array_median
);
