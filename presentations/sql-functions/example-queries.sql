-- Aggregation module

-- Count how many rows there are in the table
SELECT
  count(*) AS customers
FROM tpch.tiny.customer;

-- Count how many rows with a custkey value there (not null)
SELECT
  count(custkey) AS customers
FROM tpch.tiny.customer;
--1500

-- Use distinct and an identifier if you are not sure about data quality
-- Count how many unique custkey values there are
SELECT
  count(DISTINCT custkey) AS customers
FROM tpch.tiny.customer;
--1500

-- Understand the contex of your query -

-- Not all customers placed orders, look at orders table
SELECT
  count(DISTINCT custkey) AS customers
FROM tpch.tiny.orders;
-- 1000

-- Not all orders where fulfilled
SELECT
  count(DISTINCT custkey) AS customers
FROM tpch.tiny.orders
WHERE orderstatus = 'F';
-- 996

SELECT
  count(DISTINCT custkey) AS customers
FROM tpch.tiny.orders;

SELECT
  approx_distinct(custkey) AS customers
FROM tpch.tiny.orders;

SELECT
  round(avg(price)) AS avg,
  approx_percentile(price, 0.5) AS pct
FROM (
  SELECT
    cast(round(totalprice) AS bigint) AS price
  FROM tpch.tiny.orders
);

SELECT
  approx_percentile(price, array[0.1, 0.2, 0.5, 0.9, 0.99]) AS pct
FROM (
  SELECT
    cast(round(totalprice) AS bigint) AS price
  FROM tpch.tiny.orders
);

SELECT r.name as region, n.name AS nation
FROM tpch.tiny.nation AS n
JOIN tpch.tiny.region AS r
ON n.regionkey = r.regionkey;

SELECT r.name as region, count(n.name)
FROM tpch.tiny.nation AS n
JOIN tpch.tiny.region AS r
ON n.regionkey = r.regionkey
group by r.name;;

SELECT r.name as region, n.name AS nation
FROM tpch.tiny.nation AS n
JOIN tpch.tiny.region AS r
ON n.regionkey = r.regionkey
where n.name like 'A%' or n.name like 'U%'
order by region, nation;

SELECT r.name AS region, count(n.name)
FROM tpch.tiny.nation AS n
JOIN tpch.tiny.region AS r
ON n.regionkey = r.regionkey
where n.name like 'A%' or n.name like 'U%'
group by r.name;

-- Or earlier example

-- Use GROUP BY to segment
SELECT
	count(DISTINCT custkey) AS customers,
	mktsegment
FROM tpch.tiny.customer
GROUP by mktsegment ;

-- Segment again with two related tables
SELECT
	count(DISTINCT o.custkey) AS customers,
	c.mktsegment
FROM tpch.tiny.orders AS o JOIN tpch.tiny.customer AS c
ON o.custkey = c.custkey
GROUP by c.mktsegment;

SELECT max_by(clerk, totalprice) clerk,
       max(totalprice) price
FROM tpch.tiny.orders;

SELECT max(cast(row(totalprice, clerk) AS
           row(price double, clerk varchar))).*
FROM tpch.tiny.orders;

SELECT max_by(clerk, totalprice, 3) clerks
FROM tpch.tiny.orders;

SELECT
  count_if(orderpriority = '1-URGENT') AS urgent,
  count_if(orderpriority = '2-HIGH') AS high,
  count_if(orderpriority = '3-MEDIUM') AS medium,
  count_if(orderpriority = '4-NOT SPECIFIED') AS not_specified,
  count_if(orderpriority = '5-LOW') AS low
FROM tpch.tiny.orders;

SELECT
  count(*) FILTER (WHERE orderpriority = '1-URGENT') AS urgent,
  count(*) FILTER (WHERE orderpriority = '2-HIGH') AS high,
  count(*) FILTER (WHERE orderpriority = '3-MEDIUM') AS medium,
  count(*) FILTER (WHERE orderpriority = '4-NOT SPECIFIED') AS not_specified,
  count(*) FILTER (WHERE orderpriority = '5-LOW') AS low
FROM tpch.tiny.orders;

SELECT
  avg(totalprice) FILTER (WHERE orderpriority = '1-URGENT') AS urgent,
  avg(totalprice) FILTER (WHERE orderpriority = '2-HIGH') AS high,
  avg(totalprice) FILTER (WHERE orderpriority = '3-MEDIUM') AS medium,
  avg(totalprice) FILTER (WHERE orderpriority = '4-NOT SPECIFIED') AS not_specified,
  avg(totalprice) FILTER (WHERE orderpriority = '5-LOW') AS low
FROM tpch.tiny.orders;

SELECT avg(totalprice *
           CASE
             WHEN orderpriority = '1-URGENT' THEN 1.10
             WHEN orderpriority = '2-HIGH' THEN 1.05
             ELSE 1.0
           END) / avg(totalprice) AS premium
FROM tpch.tiny.orders;

SELECT orderpriority,
       count(*) AS orders
FROM tpch.tiny.orders
GROUP BY ROLLUP(orderpriority)
ORDER BY orderpriority;

SELECT linestatus, returnflag,
       count(*) AS items
FROM tpch.tiny.lineitem
GROUP BY ROLLUP(linestatus, returnflag)
ORDER BY linestatus, returnflag;

SELECT linestatus, returnflag,
       count(*) AS items
FROM tpch.tiny.lineitem
GROUP BY CUBE(linestatus, returnflag)
ORDER BY linestatus, returnflag;

SELECT linestatus, returnflag,
       count(*) AS items
FROM tpch.tiny.lineitem
GROUP BY GROUPING SETS (
    (linestatus),
    (returnflag),
    (linestatus, returnflag),
    ())
ORDER BY linestatus, returnflag;

SELECT name,
       reduce_agg(value, 1,
                  (a, b) -> a * b,
                  (a, b) -> a * b) AS product
FROM (VALUES ('x', 1), ('x', 3), ('x', 5),
             ('y', 2), ('y', 4), ('y', 6)) AS t (name, value)
GROUP BY name;

-- Table functions module

SELECT * FROM
TABLE(
	exclude_columns(
		input => TABLE(tpch.tiny.customer),
        columns => DESCRIPTOR(comment, acctbal, address)
    )
);

SELECT * FROM
TABLE(
	sequence(
		start => 0,
        stop => 100,
        step => 10
    )
);

CREATE TABLE brain.default.step_ten AS
SELECT sequential_number as id
FROM
TABLE(
	sequence(
		start => 0,
        stop => 10000,
        step => 10
    )
);

SELECT * FROM brain.default.step_ten;

DROP TABLE brain.default.step_ten;

-- SQL routine module

SHOW CATALOGS;

WITH
  FUNCTION doubleup(x integer)
    RETURNS integer
    RETURN x * 2
SELECT doubleup(21), doubleup(12);

SHOW SCHEMAS FROM brain;

CREATE FUNCTION brain.default.doubleup(x integer)
  RETURNS integer
  RETURN x * 2;

SELECT brain.default.doubleup(21);

CREATE FUNCTION triple(x integer)
  RETURNS integer
  RETURN x * 3;

SELECT triple(7);

SHOW FUNCTIONS FROM brain.default;

DROP FUNCTION doubleup(integer);

DROP FUNCTION triple(integer);

-- From docs
CREATE FUNCTION fib(n bigint)
RETURNS bigint
BEGIN
  DECLARE a, b bigint DEFAULT 1;
  DECLARE c bigint;
  IF n <= 2 THEN
    RETURN 1;
  END IF;
  WHILE n > 2 DO
    SET n = n - 1;
    SET c = a + b;
    SET a = b;
    SET b = c;
  END WHILE;
  RETURN c;
END;

SELECT fib(-1); -- 1
SELECT fib(0); -- 1
SELECT fib(1); -- 1
SELECT fib(2); -- 1
SELECT fib(3); -- 2
SELECT fib(4); -- 3
SELECT fib(5); -- 5
SELECT fib(6); -- 8
SELECT fib(7); -- 13
SELECT fib(8); -- 21

SELECT fib(-1), fib(0), fib(1), fib(2), fib(3), fib(4), fib(5), fib(6), fib(7), fib(8);

DROP FUNCTION fib(bigint);

-- Improved
CREATE FUNCTION fib(n bigint)
RETURNS bigint
BEGIN
  DECLARE a, b bigint DEFAULT 1;
  DECLARE c bigint;
  IF n < 1 THEN
  	RETURN 0;
  ELSEIF n <= 2 THEN
    RETURN 1;
  END IF;
  WHILE n > 2 DO
    SET n = n - 1;
    SET c = a + b;
    SET a = b;
    SET b = c;
  END WHILE;
  RETURN c;
END;

SELECT fib(-1), fib(0), fib(1), fib(2), fib(3), fib(4), fib(5), fib(6), fib(7), fib(8);

DROP FUNCTION fib(bigint);

-- human_readable_days function, similar to human_readable_seconds.

-- For development as inline routine
WITH
FUNCTION hrd(d integer)
    RETURNS VARCHAR
    BEGIN
        DECLARE answer varchar default 'About ';
        DECLARE years real;
        DECLARE months real;
        SET years = truncate(d/365);
        IF years > 0 then
       		SET answer = answer || format('%1.0f', years) || ' year';
        END IF;
        IF years > 1 THEN
            SET answer = answer || 's';
        END IF;
        SET d = d - cast(years AS integer) * 365 ;
        SET months = truncate(d / 30);
        IF months > 0 AND years > 0 THEN
            SET answer = answer || ' and ';
       	END IF;
        IF months > 0 THEN
       		set answer = answer || format('%1.0f', months) || ' month';
       	END IF;
        IF months > 1 THEN
            SET answer = answer || 's';
        END IF;
        IF years < 1 AND months < 1 THEN
        	SET answer = 'Less than 1 month.';
        END IF;
        RETURN answer;
    END
SELECT hrd(10), hrd(95), hrd(400), hrd(369), hrd(500), hrd(800), hrd(1100), hrd(5000);

-- Catalog routine creation
CREATE FUNCTION hrd(d integer)
    RETURNS VARCHAR
    BEGIN
        DECLARE answer varchar default 'About ';
        DECLARE years real;
        DECLARE months real;
        SET years = truncate(d/365);
        IF years > 0 then
       		SET answer = answer || format('%1.0f', years) || ' year';
        END IF;
        IF years > 1 THEN
            SET answer = answer || 's';
        END IF;
        SET d = d - cast(years AS integer) * 365 ;
        SET months = truncate(d / 30);
        IF months > 0 AND years > 0 THEN
            SET answer = answer || ' and ';
       	END IF;
        IF months > 0 THEN
       		set answer = answer || format('%1.0f', months) || ' month';
       	END IF;
        IF months > 1 THEN
            SET answer = answer || 's';
        END IF;
        IF years < 1 AND months < 1 THEN
        	SET answer = 'Less than 1 month.';
        END IF;
        RETURN answer;
    END;

SELECT hrd(10);
SELECT hrd(95);
SELECT hrd(400);
SELECT hrd(369);
SELECT hrd(800);
SELECT hrd(1100);
SELECT hrd(5000);

DROP FUNCTION hrd(integer);
