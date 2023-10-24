SELECT try_cast('abc' AS integer);

SELECT coalesce(null, null, 'abc', '123');

SELECT nullif('abc', 'abc'), nullif('abc', '123');

SELECT typeof('123'), typeof(123), typeof(123.0), typeof(now());

SELECT DATE '2020-02-29';

SELECT TIME '09:55:23.234';

SELECT TIMESTAMP '2001-08-22 03:04:05';

SELECT TIMESTAMP '2023-08-22 03:04:05.3456';

SELECT DATE '2012-08-08' + interval '21' year + interval '5' month;

SELECT interval '7' year - interval '15' month;

SELECT date_add('day', 21, now()) as in_three_weeks;

SELECT date_diff('year', TIMESTAMP '1980-07-06', now()) as age;

SELECT parse_duration('3.81 d');

SELECT current_date;

SELECT current_time;

SELECT current_timestamp,  now();

SELECT localtime;

SELECT localtimestamp;

SELECT date_format(now(), 'day %d in %M of the year %Y, %H th hour');

SELECT human_readable_seconds(37462);

SELECT extract(MONTH FROM TIMESTAMP '2023-11-20 18:10:00');

SELECT format('%1$tA, %1$tB %1$te, %1$tY', DATE'2023-09-07');

SELECT month(TIMESTAMP '2023-11-20 18:10:00');

SELECT from_utf8(x'65683F');

SELECT U&'Hello winter \2603 !';

SELECT 'FirstName' || ',' || 'LastName' || concat(',', 'MiddleName');

SELECT concat('FirstName',',','LastName') || concat(',', 'MiddleName');

SELECT concat_ws(',', 'FirstName', 'LastName', 'MiddleName');

SELECT name FROM tpch.tiny.nation
WHERE name LIKE 'A%' 
OR name like '____N';

SELECT parse_data_size('2.3MB'); -- 2411724

SELECT contains('10.0.0.0/8', IPADDRESS '11.255.255.255');

SELECT contains('2001:0db8:0:0:0:ff00:0042:8329/128', IPADDRESS '2001:0db8:0:0:0:ff00:0042:8328'); 

SELECT url_extract_host('https://trino.io/docs/current/index.html'); -- trino.io

SELECT uuid(); -- new random UUID with each call

SELECT json_exists(c, 'lax $.abs()')
  FROM (VALUES '-1', 'ala') t(c);

SELECT id, description,
  json_exists(description,
    'lax $.children[2]' ) AS more_than_two_children,
  json_exists(description,
    'lax $.children[*]?(@ > 12)' ) AS has_teenager
FROM (
  VALUES (101, '{"comment" : "nice", "children" : [10, 13, 16]}' ),
         (102, '{"comment" : null, "children" : [8, 11]}' ),
         (103, '{"comment" : "knows best", "children" : [2]}' )
) as t(id, description);

SELECT json_query(v, 'lax $.languages') AS languages,
	json_query(v, 'lax $.languages[0].name') AS java,
	json_query(v, 'lax $.languages[1].name') AS python
FROM (VALUES VARCHAR '
    {"languages": [{"name": "Java"}, {"name": "Python"}]}
') AS t (v);

SELECT
  json_value(v, 'lax $.languages') AS languages,
  json_value(v, 'lax $.languages[0].name') AS java,
	json_value(v, 'lax $.languages[1].name') AS python
FROM (
  VALUES VARCHAR
  '{"languages": [{"name": "Java"}, {"name": "Python"}]}'
  ) AS t (v);

SELECT json_array('Java', 'Python', 'Go');

SELECT json_array('Java', 'Python', null, 'Go');                 
                 
SELECT json_array('Java', 'Python', null, 'Go' NULL ON NULL);

SELECT json_array('Java', 'Python', null, 'Go'
  RETURNING VARCHAR(500));

SELECT json_object('name' VALUE 'Java');

SELECT json_object('languages'
         VALUE json_array('Java', 'Python')
	    );

SELECT
  json_object('languages'
    VALUE json_array(
		  json_object('name' VALUE 'Java'),
	    json_object('name' VALUE 'Python')
	  )
	);

SELECT json_parse('[1, 3, 5, 9]'),
  typeof(json_parse('[1, 3, 5, 9]'));

SELECT json_format(JSON '[1, 2, 3]'),
  typeof(json_format(JSON '[1, 2, 3]'));
 
SELECT
  ARRAY[1, 2, 3],
  ARRAY['foo', 'bar', 'bazz'],
  MAP(ARRAY['foo', 'bar'], ARRAY[1, 2]),
  ROW(1, 2.0);
 
SELECT array_agg(name ORDER BY name DESC) names
FROM tpch.tiny.region;

SELECT a[2] AS second1,
       element_at(a, 2) AS second2,
       element_at(a, -2) AS second_from_last,
       element_at(a, 99) AS bad
FROM (VALUES ARRAY[4, 5, 6, 7, 8]) AS t (a);

SELECT array_sort(ARRAY['a', 'xyz', 'bb', 'abc', 'z', 'b']);

SELECT a,
       any_match(a, e -> e = 8) AS any,
       all_match(a, e -> e = 8) AS all,
       none_match(a, e -> e = 8) AS none
FROM (VALUES ARRAY[4, 5, 6, 7, 8]) AS t (a);

SELECT a,
       filter(a, x -> x > 0) AS positive,
       filter(a, x -> x IS NOT NULL) AS non_null
FROM (VALUES ARRAY[5, -6, NULL, 7]) AS t (a);

SELECT a,
       transform(a, x -> abs(x)) AS positive,
       transform(a, x -> x * x) AS squared
FROM (VALUES ARRAY[5, -6, NULL, 7]) AS t (a);

SELECT array_join(sequence(3, 7), '/') AS joined;

SELECT a,
       array_join(transform(a, e -> format('%,d', e)), ' / ') AS value
FROM (VALUES ARRAY[12345678, 987654321]) AS t (a);

SELECT a,
       reduce(a, 1,
              (a, b) -> a * b,
              x -> x) AS product
FROM (VALUES ARRAY[1, 2, 3, 4, 5]) AS t (a);

SELECT name
FROM (
    VALUES ARRAY['cat', 'dog', 'mouse']
) AS t (a)
CROSS JOIN UNNEST(a) AS x (name);

SELECT id, name
FROM (
    VALUES ARRAY['cat', 'dog', 'mouse']
) AS t (a)
CROSS JOIN UNNEST(a) WITH ORDINALITY AS x (name, id);

SELECT map(ARRAY['x', 'y'], ARRAY[123, 456]);

SELECT map_from_entries(ARRAY[('x', 123), ('y', 456)]);

SELECT m,
       m['xyz'] AS xyz,
       element_at(m, 'abc') AS abc,
       element_at(m, 'bad') AS missing
FROM (VALUES map_from_entries(ARRAY[('abc', 123), ('xyz', 456)])) AS t (m);

SELECT key, value
FROM (
    VALUES map_from_entries(ARRAY[('abc', 123), ('xyz', 456)])
) AS t (m)
CROSS JOIN UNNEST(m) AS x (key, value);

SELECT r.name AS region, n.name AS nation
FROM tpch.tiny.nation AS n
JOIN tpch.tiny.region AS r
ON n.regionkey = r.regionkey
WHERE r.regionkey = 2
ORDER by region, nation;

SELECT name
FROM tpch.tiny.nation
WHERE regionkey=1;

SELECT name
FROM tpch.tiny.nation
WHERE regionkey=1
AND name<>'UNITED STATES';

SELECT name
FROM tpch.tiny.nation
WHERE 
regionkey=1 OR regionkey=2
AND name<>'UNITED STATES'; -- error?!

SELECT name, regionkey 
FROM tpch.tiny.nation
WHERE (regionkey=1 AND NOT name='UNITED STATES')
OR regionkey=2;

SELECT name, regionkey 
FROM tpch.tiny.nation
WHERE regionkey=1 AND NOT name='UNITED STATES'
OR regionkey=2;

SELECT name, regionkey 
FROM tpch.tiny.nation
WHERE regionkey=1 OR regionkey=2 
AND NOT name = 'UNITED STATES'; --error?!

SELECT name, regionkey 
FROM tpch.tiny.nation
WHERE regionkey=2 OR regionkey=1 
AND NOT name = 'UNITED STATES';

SELECT name, regionkey 
FROM tpch.tiny.nation
WHERE (regionkey=2 OR regionkey=1)
AND NOT name = 'UNITED STATES';

SELECT totalprice, custkey 
FROM tpch.tiny.orders 
WHERE totalprice > 400000;

SELECT totalprice, custkey
FROM tpch.tiny.orders
WHERE totalprice BETWEEN 420000 AND 450000;

SELECT name FROM tpch.tiny.region 
WHERE name NOT IN ('ASIA', 'MIDDLE EAST');

SELECT name
FROM tpch.tiny.nation
ORDER BY name DESC
LIMIT 3;

SELECT count(DISTINCT custkey) AS customers
FROM tpch.tiny.orders;

SELECT approx_distinct(custkey) AS customers
FROM tpch.tiny.orders;

SELECT round(avg(price)) AS avg,
       approx_percentile(price, 0.5) AS pct
FROM (
  SELECT cast(round(totalprice) AS bigint) AS price
  FROM tpch.tiny.orders
);

SELECT approx_percentile(price, array[0.1, 0.2, 0.5, 0.9, 0.99]) AS pct
FROM (
  SELECT cast(round(totalprice) AS bigint) AS price
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


