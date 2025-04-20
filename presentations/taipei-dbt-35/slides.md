# What is Trino?

Fast,
<span class="orange">open source</span>,
<span class="pink">SQL query engine</span>
that can query <span class="yellow">different data sources</span>.

---
# Apache Iceberg

<img src="../../assets/logos/trino-iceberg.png" alt="Iceberg" style="max-height: 450px">

---
# Why Iceberg?

* Performance and scalability
* Hidden partitioning
* Safe schema evolution
* Time travel and rollback
* ACID transactions

---
## Performance and scalability

* Fast scan planning
* Advanced filtering using metadata
* No file listing
* Supports huge tables

---
## Hive partitioning

* Partitions are <span class="orange">explict columns</span> in the table
* Must use <span class="pink">value-based</span> partitioning
* Queries must <span class="yellow">explicitly filter</span> on partition columns
* Partitioning **cannot be changed** without significant work

---
## Hidden partitioning

* Partitions are <span class="orange">implicit</span>: no partition columns in the table
* Example: partition by <span class="pink">day</span> or <span class="pink">hour</span> on a <span class="pink">timestamp</span> column
* Queries filter on the <span class="yellow">original columns</span>
* Partition layouts can **evolve** over time

---
## Safe schema evolution

* Add, drop, or rename columns
* Reorder columns in a nested struct
* Widen column types
  * Convert from `int` to `bigint`

---
## Time travel and rollback

* View historical versions of a table
* Rollback to a previous version

---
## ACID transactions

* Data files are tracked in the table metadata
* Readers always see a <span class="orange">consistent view</span> of the data
* Concurrent writes are <span class="pink">safe</span> from conflicts

---
# What's new in Trino?

---
## AI functions

* ai_analyze_sentiment
* ai_classify
* ai_extract
* ai_fix_grammar
* ai_gen
* ai_mask
* ai_translate

---
## Python user-defined functions

```sql
WITH FUNCTION double_it(x int)
  RETURNS int
  LANGUAGE PYTHON
  WITH (handler = 'twice')
  AS $$
  def twice(a):
      return a * 2
  $$
SELECT double_it(21); -- returns 42
```

```sql
CREATE FUNCTION double_it(x int)
RETURNS int
LANGUAGE PYTHON
...
```

---
## Spooling client protocol

* Much higher throughput for data transfer
* Faster query completion
* Reduces CPU usage on coordinator
* Direct download of data from spooling storage

---
## Other improvements

* Access control with <span class="orange">Open Policy Agent</span> or <span class="orange">Apache Ranger</span>
* Lineage tracking with <span class="pink">OpenLineage</span>
* Observability with <span class="yellow">OpenTelemetry</span> and <span class="yellow">OpenMetrics</span>

---
# SQL features in Trino

---
## Simple case expressions

```sql
SELECT n,
       CASE n
           WHEN 1 THEN 'one'
           WHEN 2 THEN 'two'
           ELSE 'many'
       END AS name
FROM (VALUES 1, 2, 3, 4) AS t (n);
```

```text
 n | name
---+------
 1 | one  
 2 | two  
 3 | many
 4 | many
```

---
## Searched case expressions

```sql
SELECT n,
       CASE
           WHEN n = 1 THEN 'aaa'
           WHEN n IN (2, 3) THEN 'bbb'
           ELSE 'ccc'
       END AS name
FROM (VALUES 1, 2, 3, 4) AS t (n);
```

```text
 n | name
---+------
 1 | aaa  
 2 | bbb  
 3 | bbb  
 4 | ccc
```

---
## IF expression

```sql
SELECT format('I have %s cat%s.', n,
              IF(n = 1, '', 's')) AS text
FROM (VALUES 0, 1, 2, 3) AS t (n);
```

```text
text
----------------
I have 0 cats.
I have 1 cat.  
I have 2 cats.
I have 3 cats.
```

---
## TRY expression

```sql
SELECT try(8 / 0) div_zero,
       try(cast('abc' AS integer)) not_integer,
       try(2000000000 + 2000000000) overflow;
```

`TRY` avoids these failures:

* `Division by zero`
* `Cannot cast 'abc' to INT`
* `integer addition overflow: 2000000000 + 2000000000`

---
## Conditional and conversion

```sql
SELECT try_cast('abc' AS integer); -- null

SELECT coalesce(null, null, 'abc', '123'); -- 'abc'

SELECT nullif('abc', 'abc'); -- null
SELECT nullif('abc', '123'); -- 'abc'

SELECT typeof('123'), typeof(123), typeof(123.0);
```

---
## Format function

```sql
SELECT format('pi = %.5f', pi()); -- 3.14159

SELECT format('agent %03d', 7); -- agent 007

SELECT format('$%,.2f', 1234567.89); -- $1,234,567.89

SELECT format('%-7s,%7s', 'hello', 'world');
-- hello  ,   world

SELECT format('%2$s %3$s %1$s', 'a', 'b', 'c'); -- b c a

SELECT format('%1$tB %1$te, %1$tY', DATE '2001-07-04');
-- July 4, 2001
```

---
## String comparison

`LIKE` operator with `_` and `%` placeholders

```sql
SELECT name FROM tpch.tiny.nation
WHERE name LIKE 'A%'
OR name LIKE '____N';
```

---
## Regular expressions

* `regexp_count`
* `regexp_extract`
* `regexp_like`
* `regexp_position`
* `regexp_replace`

---
## JSON functions

* `json_exists`
* `json_query`
* `json_value`
* `json_array`
* `json_object`

Standard SQL JSON path language

---
## Date and timestamp functions

```sql
SELECT date_format(now(), '%d-%M-%Y %H'); -- MySQL

SELECT format_datetime(now(),'y-M-dd'); -- Java

SELECT human_readable_seconds(37462);

SELECT format('%1$tB %1$te, %1$tY', DATE '2023-09-07');

SELECT extract(MONTH FROM TIMESTAMP '2023-11-20 18:10:00');

SELECT month(TIMESTAMP '2023-11-20 18:10:00');
```

---
## Many other functions

```sql
SELECT parse_data_size('2.3MB');

SELECT contains('10.0.0.0/8', IPADDRESS '11.255.255.255');

SELECT url_extract_host('https://trino.io/docs/');

SELECT uuid(); -- new random UUID with each call
```

---
## Structural data types

Many functions for arrays, maps, and rows

```sql
SELECT
  ARRAY[1, 2, 3],
  ARRAY['foo', 'bar', 'bazz'],
  MAP(ARRAY['foo', 'bar'], ARRAY[1, 2]),
  ROW(1, 2.0);''
```

---
## Associated max value

Find the clerk with the most expensive order:

```sql
SELECT max_by(clerk, totalprice) clerk,
       max(totalprice) price
FROM orders;
```

---
## Pivoting using filtering

Order counts by priority

```sql
SELECT priority, count(*)
FROM orders
GROUP BY priority;
```

With separate columns per priority

```sql
SELECT
  count(*) FILTER (WHERE priority = 'URGENT') AS urgent,
  count(*) FILTER (WHERE priority = 'HIGH') AS high,
  count(*) FILTER (WHERE priority = 'MEDIUM') AS medium,
  count(*) FILTER (WHERE priority = 'LOW') AS low
FROM orders;
```

---
## ROLLUP with single column

```sql
SELECT
  orderpriority,
  count(*) AS orders
FROM orders
GROUP BY ROLLUP (orderpriority)
ORDER BY orderpriority;
```

---
## ROLLUP with multiple columns

```sql
SELECT
  linestatus, returnflag,
  count(*) AS items
FROM lineitem
GROUP BY ROLLUP (linestatus, returnflag)
ORDER BY linestatus, returnflag;
```

---
## CUBE

```sql
SELECT
  linestatus, returnflag,
  count(*) AS items
FROM lineitem
GROUP BY CUBE (linestatus, returnflag)
ORDER BY linestatus, returnflag;
```

---
## GROUPING SETS

```sql
SELECT
  linestatus, returnflag,
  count(*) AS items
FROM lineitem
GROUP BY GROUPING SETS (
    (linestatus),
    (returnflag),
    (linestatus, returnflag),
    ()
)
ORDER BY linestatus, returnflag;
```

---
## Lambda expressions

Lambda expression with one input:

```sql
x -> x + 8
```

Lambda expression with two inputs:

```sql
(x, y) -> x + y
```

---
## Aggregating into an array

```sql
SELECT array_agg(name ORDER BY name DESC) names
FROM region;
```

Note the `ORDER BY` clause

---
## Accessing array elements

```sql
SELECT a[2] AS second1,
       element_at(a, 2) AS second2,
       element_at(a, -2) AS second_from_last,
       element_at(a, 99) AS bad
FROM (VALUES ARRAY[4, 5, 6, 7, 8]) AS t (a);
```

---
## Sorting arrays

```sql
SELECT array_sort(ARRAY['a', 'xyz', 'bb', 'abc', 'z', 'b']);
```

Optionally supply a comparator function

```sql
SELECT array_sort(ARRAY[3, 2, null, 5, null, 1, 2],
                  -- sort null first with descending order
                  (x, y) -> CASE WHEN x IS NULL THEN -1
                                 WHEN y IS NULL THEN 1
                                 WHEN x < y THEN 1
                                 WHEN x = y THEN 0
                                 ELSE -1 END);
-- [null, null, 5, 3, 2, 2, 1]
```

---
## Matching elements

Do any, all, or none of the elements equal 8?

```sql
SELECT a,
       any_match(a, e -> e = 8) AS any,
       all_match(a, e -> e = 8) AS all,
       none_match(a, e -> e = 8) AS none
FROM (VALUES ARRAY[4, 5, 6, 7, 8]) AS t (a);
```

---
## Filtering elements

Return data if function results in `true`

```sql
SELECT a,
       filter(a, x -> x > 0) AS positive,
       filter(a, x -> x IS NOT NULL) AS non_null
FROM (VALUES ARRAY[5, -6, NULL, 7]) AS t (a);
```

---
## Transforming elements

Convert each element with a function

```sql
SELECT a,
       transform(a, x -> abs(x)) AS positive,
       transform(a, x -> x * x) AS squared
FROM (VALUES ARRAY[5, -6, NULL, 7]) AS t (a);
```

---
## Converting arrays to strings

```sql
SELECT array_join(sequence(1, 5), '/'); -- 1/2/3/4/5
```

---
## Unnest an array

Split it up into multiple rows

```sql
SELECT name
FROM (
    VALUES ARRAY['cat', 'dog', 'mouse']
) AS t (a)
CROSS JOIN UNNEST(a) AS x (name);
```

---
## Unnest an array with ordinality

```sql
SELECT id, name
FROM (
    VALUES ARRAY['cat', 'dog', 'mouse']
) AS t (a)
CROSS JOIN UNNEST(a) WITH ORDINALITY AS x (name, id);
```

---
## Creating maps

From arrays of keys and values

```sql
SELECT map(ARRAY['x', 'y'], ARRAY[123, 456]);
```

From an array of entry rows

```sql
SELECT map_from_entries(ARRAY[('x', 123), ('y', 456)]);
```

---
## Accessing map elements

```sql
SELECT m,
       m['xyz'] AS xyz,
       element_at(m, 'abc') AS abc,
       element_at(m, 'bad') AS missing
FROM (VALUES map_from_entries(
                 ARRAY[('abc', 123), ('xyz', 456)])
) AS t (m);
```

---
## Unnesting a map

Split into multiple rows

```sql
SELECT key, value
FROM (VALUES map_from_entries(
                 ARRAY[('abc', 123), ('xyz', 456)])
) AS t (m)
CROSS JOIN UNNEST(m) AS x (key, value);
```

---
## Thank you! Questions?

More Trino resources:

* Blog: <span class="pink">trino.io/blog</span>
* Documentation: <span class="pink">trino.io/docs</span>
* Community: <span class="pink">trino.io/community</span>
* Join us on Slack: <span class="pink">trino.io/slack</span>
