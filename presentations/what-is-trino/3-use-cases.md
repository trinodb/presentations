# Use Cases

-vertical

## Case 1: SQL on anything 

<div style="float: left; width: 60%; text-align: left; font-size:24px;">
  <ul>
    <li>Trino speaks the language of many data sources</li>
    <li>This is thanks to the Server Provider Interface (SPI)</li>
    <li>Data sources include databases, REST services, CSV files, or any data that can be represented in a tabular format</li>
  </ul>
</div>


<div style="float: left; width: 40%; ">
  <lottie-player src="../../assets/animations/sql-on-anything.json" background="transparent"  speed="1"  style="width: 25vw; display: block; margin-left: auto; margin-right: auto;" loop controls autoplay></lottie-player>
</div>

-vertical

## Case 2: Query Federation

<div style="float: left; width: 60%; text-align: left; font-size:24px;">
  <ul>
    <li>All data is accessible from one terminal as opposed to moving data into one location before you can query it</li>
    <li>Unlike other data virtualization that relies solely on pushdown, Trino streams data aross the network to process data on its own infrastructure</li>
  </ul>
</div>



<lottie-player src="../../assets/animations/distributed-federated.json" background="transparent"  speed="1"  style="width: 20vw; display: block; margin-left: auto; margin-right: auto;" loop controls autoplay></lottie-player>

<!-- .element style="float: left; width: 40%;" -->

-vertical

## Case 3: Fast Object Storage Analytics

* Object storage is cheap, distributed, and commonly used to store open filetypes such as ORC, Parquet, JSON, and CSV files
* Data lake is the common term for storing data in an unstructured formats
* Earlier data lakes were slow due to runtime, inneffecient data representation, and lack of accessibility
* New technologies improved upon the speed and discoverability of data such as Iceberg, Amundsen, and Trino
* Trino enabled adhoc queries over large data lakes with petabytes of data
* Data Lakehouse is a Data Lake including scheduled performance maintenance, data governance, and improved data cataloging

-vertical

## Case 4: Batch ETL/ELT

* Trino was built for speed and initially that was enough for most workflows
* Trino's speed was a result of many factors, including that Trino avoided saving intermediate state of the queries during execution meaning an entire query would fail if one task failed.
* For adhoc queries that completed from seconds to minutes, it wasn't very expensive to restart Trino
* As queries times approached hours, few knew how to tune the system to limit query failures
* Trino recently introduced fault-tolerant execution to address larger batch and generally resource-intensive jobs.

-vertical

## Case 5: Data Ingestion/Migration

* Of the most common types of resource intensive jobs are transformation jobs during ingestion or migrating data
* The common name of this workload is ETL where you extract (read) data from a source, transform the incoming data to another form, and load (write) it to a destination
* Trino can easily do this with the SQL `CREATE TABLE destination_table AS SELECT * FROM source_table` syntax
* All transformations are modeled with SQL and Trino
* With Trino's query federation capabilities, you aren't limited to just pulling data from a single source at a time
* Many data orchestration frameworks like Airflow, Dagster, DolphinScheduler, and Prefect are able to integrate with Trino to make scheduling Trino queries

-vertical

## Case 6: Centralized data governance

* Since Trino becomes a common acces point to multiple systems on your platform, it's important to get security and access control right 
* This is actually a large stength of Trino, because as opposed to having to get security right for multple people on multiple systems, Trino is now an access control and security broker and limits the number of locations where you need to impose access control on a data platform
* Along with security, Trino is also able to become a central point of data quality checks via SQL
* Trino has also been used to be a centralized conduit for data lifecycle management and data cataloging
