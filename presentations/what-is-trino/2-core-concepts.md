# Core concepts

-vertical

## Data source

* Any system Trino can query to retrieve data
* Data must be representable in tabular format
* Databases, files in object storage or any filesystems, document store, REST APIs, and more

-vertical

## Catalogs

* Configuration to connect to a data source in Trino
* Allows querying data source
* Access in Trino by the name of the catalog
* Catalogs contain one or more schemas
* Configures a specific connector

-vertical

## Connector

* Included in Trino as plugin
* Translation layer between Trino and data source
* Provides a table-based abstraction of the underlying data source

 