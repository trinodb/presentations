# SQL routines

### User-defined functions for everyone.  <!-- .element style="color:#f88600;" -->

-vertical
## Functions from plugins

* Only option prior to Trino 431
* Custom functions need to be implemented in a plugin
* Written in Java
* Binary bundle must be deployed to all Trino nodes

> Very powerful, but difficult.

-vertical
## Support for SQL routines

* Added for Trino 431 and newer
* Custom functions for all client users
* Written in SQL
* As part of a query as *inline routine*
* Separately defined for reuse as *catalog routine*

> Easy to use and powerful.

-vertical
## Use cases

* Encapsulate common expression and function usage
* Standardize business logic and validation
* Reduce complexity
* Enable reuse and consistency
* Simplify queries using expressions and functions

-vertical
## Inline routines

* Declared as part of a `SELECT` query
* Only valid in scope of processing that query
* Great for developing routines

-vertical
## Inline routine example

```sql
WITH
  FUNCTION doubleup(x integer)
    RETURNS integer
    RETURN x * 2
SELECT doubleup(21), doubleup(12);
```

Multiple functions and multiple usages are supported.

-vertical
## Catalog routine

* Add with `CREATE FUNCTION`
* Remove with `DROP FUNCTION`
* List with `SHOW FUNCTIONS FROM catalog.schema`
* Must use fully qualified routine names `catalog.schema.routine`

-vertical
## Catalog routine storage

* Requires a catalog with a connector that supports routine storage
* Hive or Memory connectors
* Optionally use a dedicated catalog, example name `routines`
* Any schema
* Optionally dedicated schema for all routines or for specific topics like `math`

-vertical
## Default catalog routine storage

* Simple and convenient configuration to
* Allow use of routine name only
* Add catalog with storage support
* Set up default in `config.properties`

```properties
sql.default-function-catalog=brain
sql.default-function-schema=default
sql.path=brain.default
```

-vertical
## Catalog routine example

```sql
CREATE FUNCTION triple(x integer)
  RETURNS integer
  RETURN x * 3;

SELECT triple(7);

DROP FUNCTION triple(integer);
```

No need to use `brain.default.triple` everywhere!

-vertical
## Supported statements

A simple procedural SQL language within
[FUNCTION](https://trino.io/docs/current/routines/function.html)

* [BEGIN](https://trino.io/docs/current//routines/begin)
* [CASE](https://trino.io/docs/current//routines/case)
* [DECLARE](https://trino.io/docs/current//routines/declare)
* [IF](https://trino.io/docs/current//routines/if)
* [ITERATE](https://trino.io/docs/current//routines/iterate)
* [LEAVE](https://trino.io/docs/current//routines/leave)
* [LOOP](https://trino.io/docs/current//routines/loop)
* [REPEAT](https://trino.io/docs/current//routines/repeat)
* [RETURN](https://trino.io/docs/current//routines/return)
* [SET](https://trino.io/docs/current//routines/set)
* [WHILE](https://trino.io/docs/current//routines/while)

-vertical
## Loop example

* [Fibonnacci sequence](https://en.wikipedia.org/wiki/Fibonacci_sequence)
* Start with `0, 1`
* Value is sum of prior two numbers
* `0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, .. `
* Look at the [implementation with `WHILE`](https://trino.io/docs/current/routines/examples.html#fibonacci-example)

-vertical
## Supported?

Yes:

* Call other built-in and custom functions
* Call other routines

No:

* Process SQL queries
* Recursion

-vertical
## Example use case

* Create a `human_readable_days` routine
* Similar to the built-in `human_readable_seconds` function

```sql
SELECT human_readable_seconds(134823);
-- 1 day, 13 hours, 27 minutes, 3 seconds

SELECT hrd(2324);
-- About 6 years and 4 months
```

-vertical
## Example routine

```sql
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
        SET d = d - cast( years AS integer) * 365 ;
        SET months = truncate(d / 30);
        IF months > 0 and years > 0 THEN
            SET answer = answer || ' and ';
       	END IF;
        IF months > 0 THEN
       		set answer = answer || format('%1.0f', months) || ' month';
       	END IF;
        IF months > 1 THEN
            SET answer = answer || 's';
        END IF;
        IF years < 1 and months < 1 THEN
        	SET answer = 'Less than 1 month';
        END IF;
        RETURN answer;
    END;
```

-vertical
## Example testing

```sql
SELECT hrd(10) -- Less than 1 month
SELECT hrd(95) -- About 3 months
SELECT hrd(400) -- About 1 year and 1 month
SELECT hrd(369) -- About 1 year
SELECT hrd(800) -- About 2 years and 2 months
SELECT hrd(1100) -- About 3 years
SELECT hrd(5000) -- About 13 years and 8 months
```

* Next up - customize to exact message
* How long is one month?
* How long is one year?

-vertical
## SQL routine conclusion

* Try it out
* Read the [documentation](https://trino.io/docs/current/routines.html)
