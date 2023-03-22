# CRUD Statements

-vertical

## SHOW CREATE TABLE

```sql
SHOW CREATE TABLE tpch.tiny.orders;
```

Output
```
              Create Table
----------------------------------------
 CREATE TABLE tpch.tiny.orders (
    orderkey bigint NOT NULL,
    custkey bigint NOT NULL,
    orderstatus varchar(1) NOT NULL,
    totalprice double NOT NULL,
    orderdate date NOT NULL,
    orderpriority varchar(15) NOT NULL,
    clerk varchar(15) NOT NULL,
    shippriority integer NOT NULL,
    comment varchar(79) NOT NULL
 )
(1 row)
```

-vertical

## CREATE

```sql
CREATE SCHEMA datalake.tiny
WITH (location = 's3a://datalake/');
```

```sql
CREATE TABLE datalake.tiny.orders (
   orderkey BIGINT NOT NULL,
   custkey BIGINT NOT NULL,
   orderstatus VARCHAR(1) NOT NULL,
   totalprice DOUBLE NOT NULL,
   orderdate DATE NOT NULL,
   orderpriority VARCHAR(15) NOT NULL,
   clerk VARCHAR(15) NOT NULL,
   shippriority INTEGER NOT NULL,
   comment VARCHAR(79) NOT NULL
)
WITH(
  format = 'Parquet',
  location = 's3a://datalake/orders'
);
```

-vertical

## INSERT

```sql
INSERT INTO datalake.tiny.orders
  SELECT * FROM tpch.tiny.orders;
```

-vertical

## CREATE TABLE AS SELECT (CTAS)

```sql
CREATE TABLE datalake.tiny.customer
WITH(
  format = 'Parquet',
  location = 's3a://datalake/customer'
)
AS
  SELECT * FROM tpch.tiny.customer;
```

-vertical

## Trino CTAS is special

```
CREATE TABLE datalake.default.pokemon 
WITH (
  format = 'Parquet',
  location = 's3a://datalake/pokemon/parquet'
) AS
  SELECT
    CAST(number AS INTEGER) AS number,
    name,
    CAST(
      json_parse(
        replace(Abilities, '''', '"')
      ) AS ARRAY(VARCHAR)
    ) AS abilities,
    CAST(generation AS DOUBLE) AS generation,
    CAST(
      CAST("Final Evolution" AS DOUBLE
      ) AS BOOLEAN
    ) AS final_evolution,
    ...
FROM datalake.default.pokemon_csv d JOIN
     mongo.public.pokemongo m ON CAST(d.number AS INTEGER) = m.pokenumber ;
```

Same applies to `VIEWS` and `MATERIALIZED VIEWS` aka CVAS and CMVAS!

-vertical

## UPDATE

```sql
UPDATE datalake.tiny.orders 
SET orderstatus = 'F' 
WHERE orderdate > DATE '1997-06-30' 
  AND orderpriority = '4-NOT SPECIFIED';
```

```sql
SELECT *
FROM datalake.tiny.orders 
WHERE orderdate > DATE '1997-06-30';
```

-vertical

## DELETE

```sql
DELETE FROM datalake.tiny.orders
WHERE orderpriority = '4-NOT SPECIFIED';
```

-vertical

## MERGE

```sql
SELECT 
  orderstatus, 
  COUNT(*) AS num_orderstatus 
FROM datalake.tiny.orders 
GROUP BY orderstatus;
```

```sql
MERGE INTO datalake.tiny.orders i
USING tpch.tiny.orders t
ON (i.orderkey = t.orderkey)
  WHEN MATCHED AND t.orderstatus = 'F'
    THEN DELETE
  WHEN MATCHED
    THEN UPDATE
      SET orderstatus = 'O';
```

-vertical

## MERGE

Lets recover those deleted columns and remove by different criteria

```sql
MERGE INTO datalake.tiny.orders i
USING tpch.tiny.orders t
ON (i.orderkey = t.orderkey)
  WHEN MATCHED THEN
    UPDATE
      SET orderstatus = t.orderstatus
  WHEN NOT MATCHED THEN
    INSERT VALUES(
      t.orderkey, 
      t.custkey, 
      t.orderstatus, 
      t.totalprice, 
      t.orderdate, 
      t.orderpriority, 
      t.clerk, 
      t.shippriority, 
      t.comment
    );
```

-vertical

## TRUNCATE

```sql
TRUNCATE TABLE datalake.tiny.orders; 
-- faster but not supported in various connectors 

DELETE FROM datalake.tiny.orders;
```

<lottie-player src="./animations/flips-table.json" background="transparent"  speed="1"  style="width: 15vw; display: block; margin-left: auto; margin-right: auto;" loop controls autoplay></lottie-player>

