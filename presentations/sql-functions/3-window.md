# Window functions

### Analyzing multiple rows of the result, including pattern matching.  <!-- .element style="color:#f88600;" -->

-vertical
##  Window functions overview

Window functions run across rows of the result. Later in the query processing
order:

```java
  1. FROM and JOINs
  2. WHERE
  3. GROUP BY
  4. HAVING
5. Window functions
  6. SELECT
  7. DISTINCT
  8. ORDER BY
  9. LIMIT
```

-vertical
## Row numbering

Assign each region a unique number, in name order:

```sql
SELECT name,
       row_number() OVER (ORDER BY name) AS id
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | id
-------------+----
 AFRICA      |  1
 AMERICA     |  2
 ASIA        |  3 
 EUROPE      |  4 
 MIDDLE EAST |  5 

-vertical
## Row numbering order

Assign each region a unique number, in descending name order:

```sql
SELECT name,
       row_number() OVER (ORDER BY name DESC) AS id
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | id 
-------------+----
 AFRICA      |  5 
 AMERICA     |  4 
 ASIA        |  3 
 EUROPE      |  2 
 MIDDLE EAST |  1 

-vertical
## Row numbering with limit

Assign each region a number, in descending name order, limited to three rows:

```sql
SELECT name,
       row_number() OVER (ORDER BY name DESC) AS row_number
FROM tpch.tiny.region
ORDER BY name
LIMIT 3;
```

-notes

    name     | id 
-------------+----
 AFRICA      |  5 
 AMERICA     |  4 
 ASIA        |  3 

-vertical
## Rank

Assign a rank to each region, in descending name order:

```sql
SELECT name,
       rank() OVER (ORDER BY name DESC) AS rank
FROM tpch.tiny.region
ORDER BY name;
```

-notes
    name     | rank 
-------------+------
 AFRICA      |    5 
 AMERICA     |    4 
 ASIA        |    3 
 EUROPE      |    2 
 MIDDLE EAST |    1 

-vertical
## Rank with ties

Assign a rank to each region, based on first letter of name:

```sql
SELECT name,
       rank() OVER (ORDER BY substr(name, 1, 1)) AS rank
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | rank 
-------------+------
 AFRICA      |    1 
 AMERICA     |    1 
 ASIA        |    1 
 EUROPE      |    4 
 MIDDLE EAST |    5 

-vertical
## Dense rank with ties

Assign a rank to each region, based on first letter of name:

```sql
SELECT name,
       dense_rank() OVER (ORDER BY substr(name, 1, 1)) AS rank
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | rank 
-------------+------
 AFRICA      |    1 
 AMERICA     |    1 
 ASIA        |    1 
 EUROPE      |    2 
 MIDDLE EAST |    3 

-vertical
## Ranking without ordering

Assign a rank to each region:

```sql
SELECT name,
       rank() OVER (ORDER BY null) AS x,
       rank() OVER () AS y
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | x | y 
-------------+---+---
 AFRICA      | 1 | 1 
 AMERICA     | 1 | 1 
 ASIA        | 1 | 1 
 EUROPE      | 1 | 1 
 MIDDLE EAST | 1 | 1 

-vertical
## Row numbering without ordering

Assign a rank to each region:

```sql
SELECT name,
       row_number() OVER (ORDER BY null) AS x,
       row_number() OVER () AS y
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | x | y 
-------------+---+---
 AFRICA      | 1 | 1 
 AMERICA     | 2 | 2 
 ASIA        | 3 | 3 
 EUROPE      | 4 | 4 
 MIDDLE EAST | 5 | 5 

-vertical
## Assigning rows to buckets

Assign rows into three buckets, in name order:

```sql
SELECT name,
       ntile(3) OVER (ORDER BY name) AS bucket
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | bucket 
-------------+--------
 AFRICA      |      1 
 AMERICA     |      1 
 ASIA        |      2 
 EUROPE      |      2 
 MIDDLE EAST |      3 

-vertical
## Percentage ranking

Percentage rank of rows, in name order:

```sql
SELECT name,
       percent_rank() OVER (ORDER BY name) AS percent
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | percent 
-------------+---------
 AFRICA      |     0.0 
 AMERICA     |    0.25 
 ASIA        |     0.5 
 EUROPE      |    0.75 
 MIDDLE EAST |     1.0 

-vertical
## Partitioning

Divide regions by first letter of name, then assign ranks:

```sql
SELECT name,
       rank() OVER (PARTITION BY substr(name, 1, 1) ORDER BY name) AS rank
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | rank 
-------------+------
 AFRICA      |    1 
 AMERICA     |    2 
 ASIA        |    3 
 EUROPE      |    1 
 MIDDLE EAST |    1 

-vertical
## Partitioning on the same value

Assign a rank to each region:

```sql
SELECT name,
       rank() OVER (PARTITION BY null ORDER BY name) AS x,
       rank() OVER (ORDER BY name) AS y
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     | x | y 
-------------+---+---
 AFRICA      | 1 | 1 
 AMERICA     | 2 | 2 
 ASIA        | 3 | 3 
 EUROPE      | 4 | 4 
 MIDDLE EAST | 5 | 5 

-vertical
## Accessing leading and trailing rows

Access a value in the row behind and ahead of the current row:

```sql
SELECT name,
       lag(name) OVER (ORDER BY name) AS lag,
       lead(name) OVER (ORDER BY name) AS lead
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     |   lag   |    lead     
-------------+---------+-------------
 AFRICA      | NULL    | AMERICA     
 AMERICA     | AFRICA  | ASIA        
 ASIA        | AMERICA | EUROPE      
 EUROPE      | ASIA    | MIDDLE EAST 
 MIDDLE EAST | EUROPE  | NULL        

-vertical
## Accessing leading and trailing rows

Access a value in the row behind and ahead of the current row, with default:

```sql
SELECT name,
       lag(name, 1, 'none') OVER (ORDER BY name) AS lag,
       lead(name, 1, 'none') OVER (ORDER BY name) AS lead
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     |   lag   |    lead     
-------------+---------+-------------
 AFRICA      | none    | AMERICA     
 AMERICA     | AFRICA  | ASIA        
 ASIA        | AMERICA | EUROPE      
 EUROPE      | ASIA    | MIDDLE EAST 
 MIDDLE EAST | EUROPE  | none        

-vertical
##  Accessing leading and trailing rows

Access a value two rows back and two rows ahead, with default:

```sql
SELECT name,
       lag(name, 2, 'none') OVER (ORDER BY name) AS lag2,
       lead(name, 2, 'none') OVER (ORDER BY name) AS lead2
FROM tpch.tiny.region
ORDER BY name;
```

-notes

    name     |  lag2   |    lead2    
-------------+---------+-------------
 AFRICA      | none    | ASIA        
 AMERICA     | none    | EUROPE      
 ASIA        | AFRICA  | MIDDLE EAST 
 EUROPE      | AMERICA | none        
 MIDDLE EAST | ASIA    | none        

-vertical
## Accessing leading and trailing rows with nulls

Access a value in the row behind and ahead of the current row, respecting nulls:

```sql
SELECT id, v,
       lag(v) OVER (ORDER BY id) AS lag,
       lead(v) OVER (ORDER BY id) AS lead
FROM (VALUES (1, 'a'), (2, 'b'), (3, null), (4, 'd'), (5, null)) AS t (id, v)
ORDER BY id;
```

-notes

 id |  v   | lag  | lead 
----+------+------+------
  1 | a    | NULL | b    
  2 | b    | a    | NULL 
  3 | NULL | b    | d    
  4 | d    | NULL | NULL 
  5 | NULL | d    | NULL 

-vertical
## Accessing leading and trailing rows without nulls

Access a value in the row behind and ahead of the current row, ignoring nulls:

```sql
SELECT id, x,
       lag(x) IGNORE NULLS OVER (ORDER BY id) AS lag,
       lead(x) IGNORE NULLS OVER (ORDER BY id) AS lead
FROM (VALUES (1, 'a'), (2, 'b'), (3, null), (4, 'd'), (5, null)) AS t (id, x)
ORDER BY id;
```

-notes

 id |  x   | lag  | lead 
----+------+------+------
  1 | a    | NULL | b    
  2 | b    | a    | d    
  3 | NULL | b    | d    
  4 | d    | b    | NULL 
  5 | NULL | d    | NULL 

-vertical
## Window frames

Each row in a partition has a frame:

* ROWS: physical frame based on an exact number of rows
* RANGE: logical frame that includes all rows that are peers within the ordering

Examples:

* `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`
* `RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING`
* `ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING`
* `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`
* `ROWS BETWEEN UNBOUNDED PRECEDING AND 5 FOLLOWING`
* `ROWS BETWEEN 3 PRECEDING AND UNBOUNDED FOLLOWING`

[Source](https://www.sqlitetutorial.net/sqlite-window-functions/sqlite-window-frame/)

-vertical
## Accessing the first value

```sql
SELECT name,
       first_value(name) OVER (
           ORDER BY name
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS value
FROM tpch.tiny.region;
```

-notes

    name     | value  
-------------+--------
 AFRICA      | AFRICA 
 AMERICA     | AFRICA 
 ASIA        | AFRICA 
 EUROPE      | AFRICA 
 MIDDLE EAST | AFRICA 

-vertical
## Accessing the last value

```sql
SELECT name,
       last_value(name) OVER (
           ORDER BY name
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS value
FROM tpch.tiny.region;
```

-notes

    name     |    value    
-------------+-------------
 AFRICA      | MIDDLE EAST 
 AMERICA     | MIDDLE EAST 
 ASIA        | MIDDLE EAST 
 EUROPE      | MIDDLE EAST 
 MIDDLE EAST | MIDDLE EAST 

-vertical
## Accessing the Nth value

```sql
SELECT name,
       nth_value(name, 2) OVER (
           ORDER BY name
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS value
FROM tpch.tiny.region;
```

-notes

    name     |  value  
-------------+---------
 AFRICA      | AMERICA 
 AMERICA     | AMERICA 
 ASIA        | AMERICA 
 EUROPE      | AMERICA 
 MIDDLE EAST | AMERICA 

-vertical
## Window frame ROWS vs RANGE

```sql
SELECT id, v,
       array_agg(v) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows,
       array_agg(v) OVER (ORDER BY id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range,
       array_agg(v) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rows_tie,
       array_agg(v) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS range_tie
FROM (VALUES (1, 'a'), (2, 'b'), (3, 'c'), (3, 'd'), (5, 'e')) AS t (id, v);
```

-notes

 id | v |      rows       |      range      |    rows_tie     |    range_tie    
----+---+-----------------+-----------------+-----------------+-----------------
  1 | a | [a]             | [a]             | [a]             | [a, b, c, d, e] 
  2 | b | [a, b]          | [a, b]          | [a, b]          | [a, b, c, d, e] 
  3 | c | [a, b, c]       | [a, b, c, d]    | [a, b, c]       | [a, b, c, d, e] 
  3 | d | [a, b, c, d]    | [a, b, c, d]    | [a, b, c, d]    | [a, b, c, d, e] 
  5 | e | [a, b, c, d, e] | [a, b, c, d, e] | [a, b, c, d, e] | [a, b, c, d, e] 

-vertical
## Rolling and total sum

```sql
SELECT v,
       sum(v) OVER (ORDER BY v ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling,
       sum(v) OVER () total
FROM (VALUES 1, 2, 3, 4, 5) AS t (v);
```

-notes

 v | rolling | total 
---+---------+-------
 1 |       1 |    15 
 2 |       3 |    15 
 3 |       6 |    15 
 4 |      10 |    15 
 5 |      15 |    15 

-vertical
## Partition sum

```sql
SELECT p, v,
       sum(v) OVER (
           PARTITION BY p ORDER BY v
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum
FROM (VALUES ('a', 1), ('a', 2), ('a', 3), ('b', 4), ('b', 5), ('b', 6)) AS t (p, v);
```

-notes

 p | v | sum 
---+---+-----
 a | 1 |   1 
 a | 2 |   3 
 a | 3 |   6 
 b | 4 |   4 
 b | 5 |   9 
 b | 6 |  15 

-vertical
## Pattern matching

![](images/doordash-stock.png) <!-- .element width="550vw" -->

-vertical
## MATCH_RECOGNIZE

```java
1. FROM and JOINs including MATCH_RECOGNIZE
  2. WHERE
  3. GROUP BY
  4. HAVING
  5. Window functions
  6. SELECT
  7. DISTINCT
  8. ORDER BY
  9. LIMIT
```

-vertical
## MATCH_RECOGNIZE

Approach `MATCH_RECOGNIZE` in four steps:

1. Define partitioning and ordering rules <!--helps define the window where the pattern is examined-->
1. Define patterns using regular expressions and variables <!--What pattern am I looking for and how-->
1. Define measure and compute during match <!--What information am I looking to get out of that pattern and what calculations do I do-->
1. Define the shape output <!--How much information do I want back-->

-vertical

## MATCH_RECOGNIZE
1. Define partitions and ordering to identify the window over which your pattern will be evaluated

```sql
PARTITION BY custkey
ORDER BY orderdate
```

-vertical
## MATCH_RECOGNIZE

2. Define the pattern events and the pattern of those events using regular expressions 

```sql
PATTERN (START DOWN+ UP+)
DEFINE
  DOWN AS totalprice < PREV(totalprice),
  UP AS totalprice > PREV(totalprice)
```

This is the classic stock market "V" pattern. 
* `START` matches all columns so we don't skip evaluating the border rows
* `DOWN` matches the pattern where `totalprice` value goes lower from the previous row
* `UP` matches the pattern where `totalprice` value goes higher from the previous row

-vertical
## MATCH_RECOGNIZE

3. Define measures: source data points, pattern data points, and aggregates related to a pattern
```sql
MEASURES
  START.totalprice AS start_price,
  LAST(DOWN.totalprice) AS bottom_price,
  LAST(UP.totalprice) AS final_price,
  START.orderdate AS start_date,
  LAST(UP.orderdate) AS final_date
```

-vertical
## MATCH_RECOGNIZE

4. Define output style and specify where the row pattern matching resumes

```sql
ONE ROW PER MATCH
AFTER MATCH SKIP PAST LAST ROW
```
* `ONE ROW PER MATCH` indicates to summarize the results rather than `ALL ROWS PER MATCH`
* `SKIP PAST LAST ROW` indicates where to start checking for matching patterns
  * only used for overlapping patterns

-vertical
## MATCH_RECOGNIZE

### All together now

```sql
SELECT
  custkey,
  start_price,
  bottom_price,
  final_price,
  start_date,
  bottom_date,
  final_date
FROM orders
  MATCH_RECOGNIZE (
    PARTITION BY custkey
    ORDER BY orderdate
    MEASURES
      START.totalprice AS start_price,
      LAST(DOWN.totalprice) AS bottom_price,
      LAST(UP.totalprice) AS final_price,
      START.orderdate AS start_date,
      LAST(DOWN.orderdate) AS bottom_date,
      LAST(UP.orderdate) AS final_date
    ONE ROW PER MATCH
    PATTERN (START DOWN+ UP+)
    DEFINE
      DOWN AS totalprice < PREV(totalprice),
      UP AS totalprice > PREV(totalprice)
  );
```
