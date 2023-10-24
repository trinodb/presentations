SELECT name
FROM tpch.tiny.nation
ORDER BY name;

SELECT name
FROM tpch.tiny.nation
WHERE name LIKE 'M%';

SHOW CATALOGS;

SHOW SCHEMAS FROM sample;

SHOW SCHEMAS FROM tpch;

SHOW TABLES FROM tpch.tiny;

SHOW COLUMNS FROM tpch.tiny.nation;

SHOW CREATE TABLE tpch.tiny.nation;

SHOW SESSION;

SHOW SESSION LIKE 'dist%';

SET SESSION distributed_sort = false;

SHOW FUNCTIONS;

SHOW FUNCTIONS LIKE 'concat%';

USE tpch.tiny;

SELECT name FROM tpch.tiny.nation;

EXPLAIN SELECT name FROM tpch.tiny.nation;

EXPLAIN ANALYZE SELECT name FROM tpch.tiny.nation;

SELECT name, comment
FROM tpch.tiny.nation
WHERE name LIKE 'M%';

PREPARE test FROM
SELECT nationkey, name, comment FROM tpch.tiny.nation;

DESCRIBE OUTPUT test;

SELECT name
FROM tpch.tiny.nation
WHERE name LIKE 'M%'
LIMIT 1;

SELECT 'Today: ' || CAST(current_date AS VARCHAR);

VALUES 'Today: ' || CAST(current_date AS VARCHAR);

VALUES 'Today: ' || CAST(current_date AS VARCHAR),
       'Tomorrow: ' || date_format(date_add('day', 1, current_timestamp), '%Y-%m-%d');

SELECT * FROM (
  VALUES ('Today', CAST(current_date AS VARCHAR)),
         ('Tomorrow', date_format(date_add('day', 1, current_timestamp), '%Y-%m-%d'))
) as t(description, the_date)
ORDER BY the_date DESC;

VALUES format('pi = %.5f', pi()),
       format('agent %03d', 7),
       format('$%,.2f', 1234567.89),
       format('%-7s,%7s', 'hello', 'world'),
       format('%2$s %3$s %1$s', 'a', 'b', 'c'),
       format('%1$tA, %1$tB %1$te, %1$tY', date '2006-07-04');

VALUES 'Tomorrow: ' || date_format(date_add('day', 1, current_timestamp), '%Y-%m-%d');

SELECT n,
       CASE n
           WHEN 1 THEN 'one'
           WHEN 2 THEN 'two'
           ELSE 'many'
       END AS name
FROM (VALUES 1, 2, 3, 4) AS t (n);

SELECT n,
       CASE
           WHEN n = 1 THEN 'aaa'
           WHEN n IN (2, 3) THEN 'bbb'
           ELSE 'ccc'
       END AS name
FROM (VALUES 1, 2, 3, 4) AS t (n);

SELECT format('I have %s cat%s.', n,
              IF(n = 1, '', 's')) AS text
FROM (VALUES 0, 1, 2, 3) AS t (n);

SELECT try(8 / 0) div_zero,
       try(cast('abc' AS integer)) not_integer,
       try(2000000000 + 2000000000) overflow;

SELECT name, regionkey
FROM tpch.tiny.nation
WHERE name LIKE 'U%'
AND regionkey != 1;

SELECT name
FROM tpch.tiny.nation
ORDER BY name DESC
LIMIT 3;

SELECT 
  r.name AS region, 
  n.name AS nation 
FROM 
  tpch.tiny.nation AS n, 
  tpch.tiny.region AS r
WHERE 
  n.regionkey = r.regionkey
ORDER by region, nation;

SELECT 
  r.name AS region, 
  n.name AS nation 
FROM 
  tpch.tiny.nation AS n
JOIN
  tpch.tiny.region AS r
ON n.regionkey = r.regionkey
ORDER by region, nation;
