# Data types

-vertical
## Overview

* Logical types (`BOOLEAN`)
* Numeric types (`INTEGER`, `BIGINT`, `DOUBLE`)
* String types (`VARCHAR`, `CHAR`, `JSON`)
* Date and time types (`DATE`, `TIME`, `TIMESTAMP`)
* Structural types (`ARRAY`, `MAP`, `ROW`)
* Others (`IPADDRESS`, `UUID`, `HyperLogLog`)

<!--
* Different data type in different data sources
* Mapping for working with existing columns
* Mapping for creating new columns
* Varies per connector
* Some configuration
-->

-vertical

## `DATE` and `TIME`

```sql
SELECT 
  DATE '2023-03-23' date,
  TIME '14:45:32.383' time_3,
  TIME '14:45:32.383143 -08:00' time_6_with_timezone,
  TIMESTAMP '2023-03-23 14:45:32.383' timestamp_3,
  TIMESTAMP '2023-03-23 14:45:32.383143 -08:00' timestamp_6_with_timezone,
  INTERVAL '5' DAY five_day_interval;
```

-vertical

## NULL

Every SQL data type includes a special value called the `NULL` value.
It is used to indicate the absence of any data value.

-vertical

## NULL

### Comparisons involving `NULL`

Comparisons (<, >, =) to `NULL` are neither `TRUE` nor `FALSE` but `UNKNOWN`.
Nothing equals `NULL`, not even `NULL`.

-vertical

## NULL

### Testing for `NULL`

To test if a value is `NULL` use the `IS NULL` predicate rather than `= NULL`

This also applies to `CASE`, `NOT IN`, and ALL qualfied subqueries with `NULL`

-vertical

## JSON data type

`JSON` is similar to `VARCHAR` containing JSON except the data has already been parsed

```sql
SELECT
  JSON '["this", ["is"], {"valid": "json"}]' should_work,
  json_array(
    'this', 
    json_array('is'), 
    json_object('valid':'json')
  ) should_also_work,
  typeof(JSON '["this", ["is"], {"valid": "json"}]') type;

SELECT
  JSON 'invalid json' should_fail;
```

-vertical

## JSON data type

```sql
SELECT
  JSON 'null' json_null,
  JSON 'true' bool,
  JSON '"hello"' string,
  JSON '123.45' number,
  JSON '[8,6,7,5,3,0,9]' array,
  JSON '["hello", 123, {"abc": false, "xyz":99}]' mixed;
```

-vertical

## JSON `null` vs SQL `NULL`

A JSON `null` represents another valid value for all JSON data types, where SQL `NULL` represents the absence of a value as discussed before. This sounds like a small change in frame of reference but has real implications on behavior.

Any operation on a SQL `NULL` is undefined and therefore returns a `NULL`.

-vertical

## JSON type

### Casting from JSON

```sql
SELECT
  CAST(v AS MAP(VARCHAR, ARRAY(MAP(VARCHAR, VARCHAR))))
FROM (VALUES JSON '
  {
    "languages":
      [
        {"name":"Java"}, 
        {"name":"Python"}
      ]
  }
') AS t (v);
```

-vertical

## JSON type

### Partial casting from JSON

```sql
SELECT
  CAST(v AS MAP(VARCHAR, ARRAY(MAP(VARCHAR, JSON))))
FROM (VALUES JSON '
  {
    "languages":
      [
        {"id": 123, "name":"Java", "data": [88, 99]}, 
        {"id": 456, "name":"Python"} 
      ]
  }
') AS t (v);
```

