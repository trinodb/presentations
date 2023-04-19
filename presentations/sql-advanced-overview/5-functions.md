# Functions and operators

-vertical

## Overview

* Trino comes with about 450 functions and operators out of the box as of version 410
* Everything from common math functions all the way to a recent addition to the
SQL spec, JSON functions.

-vertical

## Math functions

```sql
SELECT
  (2 + 2 - 1 * 6 / 3) % 3 math_operators,
  abs(-5) abs,
  ceil(5.5) ceil,
  log2(256) log2,
  e() eulers_number,
  pi() pi_constant,
  sqrt(4) square_root,
  rand() psuedo_random,
  cos(0) cosine,
  cosine_similarity(MAP(ARRAY['a'], ARRAY[1.0]), MAP(ARRAY['a'], ARRAY[2.0])); 
```

-vertical

## JSON functions

New way
```sql
SELECT
  json_query('["hi", 3, {"abc": 99}]', 'strict $') jq_root,
  json_query('["hi", 3, {"abc": 99}]', 'strict $[2]') jq_object,
  JSON '["hi", 3, {"abc": false, "xyz":99}]' parsed_json, 
  json_value('["hi", 3, {"abc": 99}]', 'strict $[2].abc') jv_scalar,
  json_exists('["hi", 3, {"abc": 99}]', 'strict $') je_root;
```
<!--
json_object and json_arrays functions
zero-based vs SQLs one-based arrays
-->

Old way
```sql
SELECT
  json_extract('["hi", 3, {"abc": 99}]', '$') extract_root,
  json_extract('["hi", 3, {"abc": 99}]', '$[2]') extract_object,
  json_parse('["hi", 3, {"abc": 99}]') parse_json,
  json_extract_scalar('["hi", 3, {"abc": 99}]', '$[2].abc') extract_scalar;
```

-vertical

## String Functions

```sql
SELECT
  format('pi = %.5f', pi()) format,
  'Hello' || 'Bun Bun' concat,
  concat_ws('Hello ', 'Commander', ' ', NULL, 'BUN BUN') concat_ws,
  translate('Commander Bun Bun', 'B', U&'\+01F600') translate,
  substr('believe', 3, 3) substr,
  reverse(replace(replace('team', 't'), 'a')) no_i_in_team,
  reverse('racecar'),
  lower('MiSSiSSiPPi') lower,
  levenshtein_distance('abcdefgh', 'abcdefu') levenshtein,
  starts_with('abcdefgh', 'abcdef') starts_with;

   
```

-vertical

## Lambda expressions

A way to write a function inline and pass it to another function to apply it over your data. 

```sql
-- single input lambda function
x -> x + 8

-- multiple input lambda function
(x, y) -> x + y
```

-vertical

## Lambda expressions

```sql
SELECT
  xvals,
  a,
  b,
  transform(
    xvals, 
    x -> a * x + b
  ) AS linear_function_values
FROM (
  VALUES
    (ARRAY[1, 2], 10, 5),
    (ARRAY[3, 4], 4, 2)
) AS t(xvals, a, b);
```

-vertical

## Table Functions

A table function is a function returning a table. It can be invoked inside the `FROM` clause of a query. 

```sql
SELECT *
FROM
  TABLE(
    example.system.sheet(
      id => 'googleSheetIdHere',
      range => 'TabName!A1:B4'
    )
  );
```

-vertical

## Polymorphic Table Functions

The row type of the returned table can depend on the arguments passed with invocation of the function. If different row types can be returned, the function is a *polymorphic table function*.


```sql
SELECT *
FROM TABLE(
  snowflake.system.query(
    query => '
      SELECT * 
      FROM table SAMPLE BERNOULLI(20.3) 
    '
  )
);
```

-vertical

## DIY PTFs!

```java
public class MyFunction
        extends AbstractConnectorTableFunction
{
    public MyFunction()
    {
        super(
                "system",
                "my_function",
                List.of(
                        ScalarArgumentSpecification.builder()
                                .name("COLUMN_COUNT")
                                .type(INTEGER)
                                .defaultValue(2)
                                .build(),
                        ScalarArgumentSpecification.builder()
                                .name("ROW_COUNT")
                                .type(INTEGER)
                                .build()),
                GENERIC_TABLE);
    }
}
```

-vertical

## DIY PTFs

```java
@Override
public TableFunctionAnalysis analyze(ConnectorSession session, ConnectorTransactionHandle transaction, Map<String, Argument> arguments)
{
    long columnCount = (long) ((ScalarArgument) arguments.get("COLUMN_COUNT")).getValue();
    long rowCount = (long) ((ScalarArgument) arguments.get("ROW_COUNT")).getValue();

    // custom validation of arguments
    if (columnCount < 1 || columnCount > 3) {
         throw new TrinoException(INVALID_FUNCTION_ARGUMENT, "column_count must be in range [1, 3]");
    }

    if (rowCount < 1) {
        throw new TrinoException(INVALID_FUNCTION_ARGUMENT, "row_count must be positive");
    }

    // determine the returned row type
    List<Descriptor.Field> fields = List.of("col_a", "col_b", "col_c").subList(0, (int) columnCount).stream()
            .map(name -> new Descriptor.Field(name, Optional.of(BIGINT)))
            .collect(toList());

    Descriptor returnedType = new Descriptor(fields);

    return TableFunctionAnalysis.builder()
            .returnedType(returnedType)
            .build();
}
```

-vertical

## User-Defined Functions

```java
public class ExampleFunctionsPlugin
        implements Plugin
{
    @Override
    public Set<Class<?>> getFunctions()
    {
        return ImmutableSet.<Class<?>>builder()
                .add(IsNullFunction.class)
                .build();
    }
}
```

-vertical

## User-Defined Functions

```java
@ScalarFunction(name = "is_null")
@Description("Returns TRUE if the argument is NULL")
public final class IsNullFunction
{
    @TypeParameter("T")
    @SqlType(StandardTypes.BOOLEAN)
    public static boolean isNullSlice(
      @SqlNullable @SqlType("T") Slice value
    ){
        return (value == null);
    }

    @TypeParameter("T")
    @SqlType(StandardTypes.BOOLEAN)
    public static boolean isNullLong(
      @SqlNullable @SqlType("T") Long value
    ){
        return (value == null);
    }

    // ...and so on for each native container type
}
```
