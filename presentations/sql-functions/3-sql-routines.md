# SQL routines

User-defined functions for everyone

-vertical
## TBD

Procedural



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

Using Lambdas is best practice for SQL routines.

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
## Lambda expression in a routine
