<h3>
  Trino is a ludicrously fast,
    <span class="animate__flipInX" data-delay="500" style="color:#f88600">open source,</span>
    <span class="animate__flipInX" data-delay="500" style="color:#dd00a1">SQL</span>
    <span class="animate__flipInX" data-delay="500" style="color:#f8b600">query engine.
    </span>
</h3>

-vertical

## Open source

* Created and maintained by a community of contributors
* Licensed under the [Apache license, version 2.0](https://wikipedia.org/wiki/Apache_License)
* Free to run, view the source, redistribute, and modify in any way you see fit.
* Friendly to commercial adoption and usage
* Not a project of the [Apache Software Foundation](https://apache.org/)

-vertical

## Structured Query Language (SQL)

* Declarative language - specify what, not how
* Using SQL enables you focus on the business case
* Trino optimizes query processing for you

```sql
SELECT nationkey, count(*) AS count
FROM tpch.tiny.customer
WHERE mktsegment='AUTOMOBILE'
GROUP BY nationkey;
```

-vertical

## Query engine

<div style="float: left; width: 60%; text-align: left; font-size:24px;" class="r-fit-text">
  <ul>
    <li>Trino is not a database</li>
    <li>Databases include query engines</li>
    <li>Databases also support all the components around storage, transactions, and other features</li>
  </ul>
  <blockquote><p>What's the point of just a query engine?</p></blockquote>
</div>

<div class="r-stack">
  <img class="fragment fade-out" data-fragment-index="0" src="images/relational-database.svg" width="500vw">
  <img class="fragment" data-fragment-index="0" src="images/trino-query-engine.svg" width="200vw">
</div>

-vertical

<h3>
  Trino is a ludicrously fast, open source, SQL query engine
  <span class="animate__flipInX">
    designed to query <span style="color:#dd00a1">disparate data sources</span>.
  </span>
</h3>

-vertical

## Disparate data sources

**Connector-based architecture** \
\
A connector provides Trino an interface that acts as a translation layer from
Trino SQL operations to the domain-specific language of various heterogeneous
data sources.

<!-- .element style="float: left; width: 60%; text-align: center; font-size: 32px" -->

![](images/data-sources.svg) <!-- .element width="150vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

-vertical

<h3>
  Trino is a ludicrously fast,
  <span  class="animate__flipInX" data-delay="500">open source, </span>
  <span class="animate__flipInX" data-delay="500" style="color:#f88600">distributed, </span>
  <span class="animate__flipInX" data-delay="500" style="color:#dd00a1">massively parallel processing, </span>
  <span class="animate__flipInX" data-delay="500">SQL query engine </span>
  <span class="animate__flipInX" data-delay="500">designed to query</span>
  <span class="animate__flipInX" data-delay="500" style="color:#f8b600">large data sets </span>
  <span class="animate__flipInX" data-delay="500">from one or more disparate data sources. </span>
</h3>

-vertical

## What is a large data set?

<div style="float: left; width: 60%; text-align: left; font-size:36px;" >
  <ul>
    <li>Beyond the scale after the Big Data trend</li>
    <li>Onwards from gigabytes to terabytes and petabytes of data</li>
    <li>A variety of data formats</li>
    <li>Capable to process data in minutes to nanoseconds</li>
  </ul>
</div>

![](images/large-data.svg) <!-- .element width="350vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

Trino enables interactive queries with large scale data.

<!-- .element class="r-fit-text" -->

-vertical

## Distributed systems

<div style="float: left; width: 60%; text-align: left; font-size:36px;" >
  <ul>
    <li>Processes big data in a scalable and cost-efficient manner</li>
    <li>Trades off complexity for resiliency and scalability</li>
    <li>Parallel processing in a cluster of nodes<li>
    <li>Coordinator node is responsible for planning and scheduling all the queries</li>
    <li>Query execution is distributed across multiple Trino worker nodes</li>
  </ul>
</div>

![](images/trino-distributed.svg) <!-- .element width="350vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

-vertical

## Massively parallel processing (MPP)


<div style="float: left; width: 60%; text-align: left; font-size:36px;" >
  <ul>
    <li>Splits work up across worker nodes in a cluster of servers</li>
    <li>Uses long-lived Java Virtual Machine (JVM) process on each node</li>
    <li>Lots of parallel threads on each worker JVM</li>
    <li>Reduces response time, but requires integrated scheduling, resource management, and isolation</li>
  </ul>
</div>

![](images/trino-mpp.svg) <!-- .element width="250vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

-vertical

<h3>
  Trino is a ludicrously fast,
  <span style="color:#f88600" class="animate__flipInX" data-delay="500">open source,</span>
  <span style="color:#dd00a1" class="animate__flipInX" data-delay="500">distributed,</span>
  <span style="color:#f8b600" class="animate__flipInX" data-delay="500">massively parallel processing,</span>
  <span style="color:#f88600" class="animate__flipInX" data-delay="500">SQL</span>
  <span style="color:#dd00a1" class="animate__flipInX" data-delay="500">query engine</span>
  <span class="animate__flipInX" data-delay="500">designed to query</span>
  <span style="color:#f8b600" class="animate__flipInX" data-delay="500">large data sets</span>
  <span class="animate__flipInX" data-delay="500">from one or more</span>
  <span style="color:#f88600" class="animate__flipInX" data-delay="500" >disparate data sources.</span>
</h3>
