# Use Cases

-vertical

## Case 1: Query Federation

* Access all data accessible from one terminal as opposed to having to 
* As oppossed to prior data virtualization technologies that relied solely on pushdown, Trino moves both table data across the network to perform joins and other operations on its own infrastructure.
* 
<!-- .element class="r-fit-text" -->

![](images/data-sources.svg) <!-- .element width="150vw" style="background-color:#ffffff00" -->

```SQL
SELECT *
FROM postgres.sales.customer c JOIN mongo.sales.orders o ON c.id = o.customerId
WHERE c.mktsegment = 'AUTOMOBILE';
```

-vertical

## Case 2: Fast Object Storage Analytics

-vertical

## Case 3: Batch ETL/ELT

-vertical

## Case 4: Translation of SQL on any data model

-vertical

## Case 5: Data Ingestion/Migration

-vertical

## Case 6: Centralized data governance

Trino as an anlytics/security/ data quality / governance broker
