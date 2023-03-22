# Window functions

-vertical

## Window functions

1. `FROM` and `JOIN`
1. `WHERE`
1. `GROUP BY`
1. `HAVING`
1. `SELECT` <--- (Window Functions)
1. `DISTINCT`
1. `ORDER BY`
1. `LIMIT`

-vertical

For these examples, let's use the `tpch.tiny` catalog and schema

```sql
USE tpch.tiny;
```

-vertical


## Window functions

### Row numbering

Assign a unique number in name order

```sql
SELECT 
  name,
  row_number() OVER (ORDER BY name) AS id
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Row numbering in descending order

Notice there are two `ORDER BY` statements

```sql
SELECT 
  name,
  row_number() OVER (ORDER BY name DESC) AS id
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Row numbering order with `LIMIT` 

Pay attention to the order `LIMIT` is applied

```sql
SELECT 
  name,
  row_number() OVER (ORDER BY name DESC) AS id
FROM region
ORDER BY name
LIMIT 3;
```

-vertical

## Window functions

### Rank

Rank is similar to row number but addresses ties unless there are none

```sql
SELECT 
  name,
  rank() OVER (ORDER BY name DESC) AS rank
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Rank with ties

```sql
SELECT 
  name,
  rank() OVER (ORDER BY substr(name, 1, 1)) AS rank
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Dense rank with ties

```sql
SELECT 
  name,
  dense_rank() OVER (ORDER BY substr(name, 1, 1)) AS rank
FROM region
ORDER BY name;
```

-vertical

## Window functions 

### Ranking without ordering

```sql
SELECT 
  name,
  rank() OVER (ORDER BY NULL) AS rank1,
  rank() OVER () AS rank2
FROM region
ORDER BY name;
```

-vertical

## Window functions 

### Row number without ordering

```sql
SELECT 
  name,
  row_number() OVER (ORDER BY NULL) AS id1,
  row_number() OVER () AS id2
FROM region
ORDER BY name;
```
-vertical

## Window functions

### Assigning rows to buckets

```sql
SELECT 
  name,
  ntile(3) OVER (ORDER BY name) AS bucket
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Percentage ranking 

Percentage rank of rows in name order

```sql
SELECT 
  name,
  format(
    '%.1f%%', 
    percent_rank() OVER (ORDER BY name) * 100
  ) AS percent
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Partitioning

Divide regions by first letter of name, then assigns rank

```sql
SELECT 
  name,
  rank() OVER (PARTITION BY substr(name, 1, 1) ORDER BY name) AS rank
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Partitioning on the same value

```sql
SELECT 
  name,
  rank() OVER (PARTITION BY NULL ORDER BY name) AS rank1,
  rank() OVER (ORDER BY name) AS rank2
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Accessing leading and trailing rows

Access a value in the row behind and ahead of the current row

```sql
SELECT 
  name,
  lag(name) OVER (ORDER BY name) AS lag,
  lead(name) OVER (ORDER BY name) AS lead
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Accessing leading and trailing rows

Access a value in the row behind and ahead of the current row with default

```sql
SELECT 
  name,
  lag(name, 1, 'none') OVER (ORDER BY name) AS lag,
  lead(name, 1, 'none') OVER (ORDER BY name) AS lead
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Accessing leading and trailing rows

Access a value two rows behind and two rows ahead of the current row with default

```sql
SELECT 
  name,
  lag(name, 2, 'none') OVER (ORDER BY name) AS lag,
  lead(name, 2, 'none') OVER (ORDER BY name) AS lead
FROM region
ORDER BY name;
```

-vertical

## Window functions

### Accessing leading and trailing rows respecting NULLs

```sql
SELECT 
  id,
  v,
  lag(v) OVER (ORDER BY id) AS lag,
  lead(v) OVER (ORDER BY id) AS lead
FROM (
  VALUES 
    (1, 'a'),
    (2, 'b'), 
    (3, NULL), 
    (4, 'd'), 
    (5, NULL)
  ) AS t (id, v)
ORDER BY id;
```

-vertical

## Window functions

### Accessing leading and trailing rows ignoring NULLs

```sql
SELECT 
  id,
  v,
  lag(v) IGNORE NULLS OVER (ORDER BY id) AS lag,
  lead(v) IGNORE NULLS OVER (ORDER BY id) AS lead
FROM (
  VALUES 
    (1, 'a'),
    (2, 'b'), 
    (3, NULL), 
    (4, 'd'), 
    (5, NULL)
  ) AS t (id, v)
ORDER BY id;
```

-vertical

## Window functions

### Window frames
<div style="float: left; width: 60%; text-align: left; font-size:24px;" >
  Each row in a partition has a frame:
  <ul style="font-size:24px;">
    <li>ROWS: physical frame based on the exact number of rows</li>
    <li>RANGE: logical frame that includes all rows that are <i>peers</i> within the ordering</li>
  </ul>
  Examples:
  <ul style="font-size:24px;">
    <li>ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING</pre></li>
    <li>ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW</li>
    <li>ROWS BETWEEN UNBOUNDED PRECEDING AND 5 FOLLOWING</li>
    <li>ROWS BETWEEN 3 PRECEDING AND UNBOUNDED FOLLOWING</li>
  </ul>

</div>

![](images/sql-window-function-frame.png) <!-- .element width="375vw" -->

-vertical

## Window functions

### Window frames

Accessing the first value

```sql
SELECT
  name,
  first_value(name) OVER (
    ORDER BY name
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS value
FROM region;
```

-vertical

## Window functions

### Window frames

Accessing the last value

```sql
SELECT
  name,
  last_value(name) OVER (
    ORDER BY name
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS value
FROM region;
```

-vertical

## Window functions

### Window frames

Accessing the nth value

```sql
SELECT
  name,
  nth_value(name, 2) OVER (
    ORDER BY name
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS value
FROM region;
```

-vertical

## Window functions

### Window frame ROWS vs RANGE

```sql
SELECT 
  id,
  v,
  array_agg(v) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows,
  array_agg(v) OVER (ORDER BY id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range,
  array_agg(v) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_tie
FROM (
  VALUES 
    (1, 'a'),
    (2, 'b'), 
    (3, 'c'), 
    (3, 'd'), 
    (5,  'e')
  ) AS t (id, v)
ORDER BY id;
```

-vertical

## Window functions

### Rolling and total sum

```sql
SELECT 
  v,
  sum(v) OVER (ORDER BY v ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling,
  sum(v) OVER () AS total
FROM (
  VALUES 1, 2, 3, 4, 5
) AS t (v);
```

-vertical

## Window functions

### Partition sum

```sql
SELECT 
  p,
  v,
  sum(v) OVER (
    PARTITION BY p
    ORDER BY v
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS sum
FROM (
  VALUES 
    ('a', 1),
    ('a', 2), 
    ('a', 3), 
    ('b', 4), 
    ('b', 5), 
    ('b', 6)
  ) AS t (p, v);
```
