# Aggregation

### Pulling multiple rows together for analysis. <!-- .element style="color:#f88600;" -->

-vertical
## Aggregation how to

A collections of aspects to use:

* `DISTINCT` keyword
* `GROUP BY` clause
* `HAVING` condition on aggregated values
* Lots of [aggregate functions](https://trino.io/docs/current/functions/aggregate.html) like `count`, `sum`, `avg`

-vertical
## Counting distinct items

How many unique customers do we have?

```sql
SELECT
  count(DISTINCT custkey) AS customers
FROM tpch.tiny.customer;
```

Use `DISTINCT` if you are unsure about data quality.

-vertical
## Understand the question asked

How many unique customers who actually placed an order that was
fulfilled do we have?

```sql
SELECT
  count(DISTINCT custkey) AS customers
FROM tpch.tiny.orders
WHERE orderstatus = 'F';
```

This gives an exact answer, but is slow and memory intensive.

-vertical
## Counting distinct items

Approximately how many unique customers do we have?

```sql
SELECT
  approx_distinct(custkey) AS customers
FROM tpch.tiny.orders;
```

This example has an error of 1.66%, but is faster.

-vertical
##  Approximate percentiles

What is the order price at the 50th percentile?

```sql
SELECT
  round(avg(price)) AS avg,
  approx_percentile(price, 0.5) AS pct
FROM (
  SELECT
    cast(round(totalprice) AS bigint) AS price
  FROM tpch.tiny.orders
);
```

-vertical
##  Approximate percentiles

What are the order prices at the 10th, 20th, 50th, 90th, and 99th percentiles?

```sql
SELECT
  approx_percentile(price, array[0.1, 0.2, 0.5, 0.9, 0.99]) AS pct
FROM (
  SELECT
    cast(round(totalprice) AS bigint) AS price
  FROM tpch.tiny.orders
);
```

-vertical
## Analysis with groups

Simple example with `count()` aggregate function

```sql
SELECT r.name AS region, count(n.name)
FROM tpch.tiny.nation AS n
JOIN tpch.tiny.region AS r
ON n.regionkey = r.regionkey
WHERE n.name LIKE 'A%' OR n.name like 'U%'
GROUP BY r.name;
```

-vertical
## Analysis with groups

Improvement from preceding example:

```sql
SELECT
	count(DISTINCT custkey) AS customers,
	mktsegment
FROM tpch.tiny.customer
GROUP by mktsegment;

SELECT
	count(DISTINCT o.custkey) AS customers,
	c.mktsegment
FROM tpch.tiny.orders AS o JOIN tpch.tiny.customer AS c
ON o.custkey = c.custkey
GROUP by c.mktsegment;
```

-vertical
## Associated max value

Find the clerk with the most expensive order:

```sql
SELECT max_by(clerk, totalprice) clerk,
       max(totalprice) price
FROM tpch.tiny.orders;
```

-vertical
## Associated max value using a row type

Find the clerk with the most expensive order:

```sql
SELECT max(cast(row(totalprice, clerk) AS
           row(price double, clerk varchar))).*
FROM tpch.tiny.orders;
```

-vertical
## Associated max values

Find the clerks with the most expensive orders:

 ```sql
 SELECT max_by(clerk, totalprice, 3) clerks
 FROM tpch.tiny.orders;
```

-vertical
## Pivoting with conditional counting

Order counts by order priority, as separate columns:

```sql
SELECT
  count_if(orderpriority = '1-URGENT') AS urgent,
  count_if(orderpriority = '2-HIGH') AS high,
  count_if(orderpriority = '3-MEDIUM') AS medium,
  count_if(orderpriority = '4-NOT SPECIFIED') AS not_specified,
  count_if(orderpriority = '5-LOW') AS low
FROM tpch.tiny.orders;
```

-vertical
## Pivoting with filtering

Order counts by order priority, as separate columns:

```sql
SELECT
  count(*) FILTER (WHERE orderpriority = '1-URGENT') AS urgent,
  count(*) FILTER (WHERE orderpriority = '2-HIGH') AS high,
  count(*) FILTER (WHERE orderpriority = '3-MEDIUM') AS medium,
  count(*) FILTER (WHERE orderpriority = '4-NOT SPECIFIED') AS not_specified,
  count(*) FILTER (WHERE orderpriority = '5-LOW') AS low
FROM tpch.tiny.orders;
```

-vertical
## Pivoting averages

Total order price by order priority, as separate columns:

```sql
SELECT
  avg(totalprice) FILTER (WHERE orderpriority = '1-URGENT') AS urgent,
  avg(totalprice) FILTER (WHERE orderpriority = '2-HIGH') AS high,
  avg(totalprice) FILTER (WHERE orderpriority = '3-MEDIUM') AS medium,
  avg(totalprice) FILTER (WHERE orderpriority = '4-NOT SPECIFIED') AS not_specified,
  avg(totalprice) FILTER (WHERE orderpriority = '5-LOW') AS low
FROM tpch.tiny.orders;
```

-vertical
## Aggregating a complex expression

What if we charge a premium based on order priority?

```sql
SELECT avg(totalprice *
           CASE
             WHEN orderpriority = '1-URGENT' THEN 1.10
             WHEN orderpriority = '2-HIGH' THEN 1.05
             ELSE 1.0
           END) / avg(totalprice) AS premium
FROM tpch.tiny.orders;
```

-vertical
## ROLLUP with single

```sql
SELECT
  orderpriority,
  count(*) AS orders
FROM tpch.tiny.orders
GROUP BY ROLLUP(orderpriority)
ORDER BY orderpriority;
```

-vertical
## ROLLUP with multiple

```sql
SELECT
  linestatus, returnflag,
  count(*) AS items
FROM tpch.tiny.lineitem
GROUP BY ROLLUP(linestatus, returnflag)
ORDER BY linestatus, returnflag;
```

-vertical
## CUBE

```sql
SELECT
  linestatus, returnflag,
  count(*) AS items
FROM tpch.tiny.lineitem
GROUP BY CUBE(linestatus, returnflag)
ORDER BY linestatus, returnflag;
```

-vertical
## GROUPING SETS

```sql
SELECT
  linestatus, returnflag,
  count(*) AS items
FROM tpch.tiny.lineitem
GROUP BY GROUPING SETS (
    (linestatus),
    (returnflag),
    (linestatus, returnflag),
    ())
ORDER BY linestatus, returnflag;
```

-vertical
## Intermission - Lambda expressions

Lambda expression with one input:

```sql
x -> x + 8
```

Lambda expression with two inputs:

```sql
(x, y) -> x + y
```

-vertical
## Aggregating using a lambda

Compute the product of the values in the group:

```sql
SELECT name,
       reduce_agg(value, 1,
                  (a, b) -> a * b,
                  (a, b) -> a * b) AS product
FROM (VALUES ('x', 1), ('x', 3), ('x', 5),
             ('y', 2), ('y', 4), ('y', 6)) AS t (name, value)
GROUP BY name;
```

 -notes

 name | product
------+---------
 x    |      15
 y    |      48

-vertical
## Impact from connectors

* Aggregate function pushdown
* Parallelism with object storage connectors
* Predicate pushdown
* Join pushdown

Significant impact from large data sets

-vertical
## Aggregation conclusion

* Reveals crucial business insights
* Offers many approaches

Practice, apply your knowledge, and learn more