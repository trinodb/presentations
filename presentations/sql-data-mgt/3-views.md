# Back to analytics

... and understanding views.

-vertical
## What is a view?

* A SQL `SELECT`` query
* With a name
* Exposes result columns from query like a table
* Encapsulates complexities of queries
* Makes it easier for users
* Runs the query each time the view is accessed

-vertical
## Types of views

* Trino views
* RDBMS views, like a PostgreSQL view
* Hive views

All use the SQL from the respective systems.

-vertical
## Trino views

* Written in Trino SQL
* Stored in the metastore of a catalog
* Hive, Iceberg, and Delta Lake connectors
* Any valid Trino query, can also access other catalogs

-vertical
## RDBMS view

* Defined with SQL from RDBMS
* Stored in `information_schema` of database
* Have to be processed by RBDMS, Trino doesn't know SQL of data source
* Show up as tables in Trino

-vertical
## Hive view

* Defined in Hive QL
* Stored in metastore
* Trino can access and process as legacy migration approach
* Conversion from Hive QL to Trino is not perfect

-vertical
## Trino view details

```text
CREATE [ OR REPLACE ] VIEW view_name
[ COMMENT view_comment ]
[ SECURITY { DEFINER | INVOKER } ]
AS query
```

-vertical
## Definer or invoker

* Invoker - query is simply a stored query
* Definer - access from view creator exposes more access
* Default is definer!

-vertical
## Trino view example

```sql
CREATE VIEW vw_supplier_per_nation AS
  SELECT
    nationkey,
    count(*) AS supplier_count
  FROM tpch.sf100.supplier
  GROUP BY nationkey;

DROP VIEW vw_supplier_per_nation;
```

-vertical
## View access

Like a table

```sql
SELECT * FROM vw_supplier_per_nation;

SELECT
  nation.name,
  vw_supplier_per_nation.supplier_count
FROM vw_supplier_per_nation
  JOIN nation
  ON vw_supplier_per_nation.nationkey = nation.nationkey;
```

-vertical
## Materialized view

* A view with storage
* Puts results of query into hidden table
* Subsequent access uses table transparently
* Refresh mechanism required
* Fall through to view for stale data

-vertical
## Trino materialized view

Limited to Iceberg connector

```sql
CREATE MATERIALIZED VIEW mv_supplier_per_nation AS
  SELECT
    nationkey,
    count(*) AS supplier_count
  FROM tpch.sf100.supplier
  GROUP BY nationkey;
```

CTAS, merge, and scheduled updates can be a hacky alternative.

-vertical
## Materialized view access

Like a table

```sql
SELECT * FROM mv_supplier_per_nation;

SELECT
  nation.name,
  mv_supplier_per_nation.supplier_count
FROM mv_supplier_per_nation
  JOIN nation
  ON mv_supplier_per_nation.nationkey = nation.nationkey;
```
