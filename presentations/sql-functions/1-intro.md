# More functions

* Functions and operators are everywhere.
* Your saw a lot already in prior classes.
* Most of them were  operators and scalar functions.
* The output is a single value (scalar).

-vertical
## Next up

Let's look at more complex functions:

* **Aggregate functions** - combine values from multiple rows
* **Window functions** and pattern matching - analyze multiple rows
* **Table functions** - return a table of results
* **Routines** - define your own functions

-vertical
## NULL for warm up

Before we begin, let's talk about nothing:

* `NULL` values in a column can affect casting, conditions, joins
* [Logical comparisons](https://trino.io/docs/current/functions/logical.html#effect-of-null-on-logical-operators)
  need to take `NULL` into account
* Check if a value is null has to use `IS NULL` and `IS NOT NULL`
* Effect on SQL function and routine invocations
