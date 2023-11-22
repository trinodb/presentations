# Table functions

### Rows of column of data as a result.  <!-- .element style="color:#f88600;" -->

-vertical
## Table functions

* Result set is a table
* One or more columns
* One of more rows
* Relatively new feature with lots of potential
* [Write your own and contribute](https://trino.io/docs/current/develop/table-functions.html)

-vertical
## Categories

* Built-in global table function
* Connector-specific table function

-vertical
## exclude_columns

* Global table function
* Useful for wide tables
* Use with `*` to return all but a few columns

```sql
SELECT * FROM
TABLE(
	exclude_columns(
		input => TABLE(tpch.tiny.customer),
        columns => DESCRIPTOR(comment, acctbal, address)
    )
);
```

-vertical
## sequence

* Generate a sequence of integers
* Configure start, stop, and step
* Optionally combine with CTAS

-vertical
## sequence example

```sql
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
```

-vertical
## Polymorphic table functions PTF

* Returns variable, unknown number columns
* Opens very flexible use cases

-vertical
## Connector table functions

* `table_changes` in Delta Lake connector to access change data feed
* `sheet` in Google Sheets connector to return sheet
* `procedure` in SQL Server connector to execute procedures

-vertical
## Query pass through

* `query` or `raw_query` in numerous connectors
* Provide native query string to data source
* Query engine of data source processes native query
* Data source returns table to Trino

-vertical
## Query pass through example

Native query language can be anything:

* [PostgreSQL dialect](https://trino.io/docs/current/connector/postgresql.html#query-varchar-table)
* [Elasticsearch JSON matcher](https://trino.io/docs/current/connector/elasticsearch.html#raw-query-varchar-table)

-vertical
## Table functions conclusion

* New and very powerful feature.
* Lots of potential for future improvements.