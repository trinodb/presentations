<h3>
  Trino is a ludicrously fast,
  <span class="fragment">
    <span class="animate__flipInX animate__slower">
      <span style="color:#f88600">open source</span>,
    </span> 
    <span class="animate__flipInX animate__slower" data-delay="1000" style="color:#dd00a1">SQL</span>
    <span class="animate__flipInX animate__slower" data-delay="1000">
      <span style="color:#f8b600">query engine</span>.
    </span>
  </span> 
</h3>

-vertical

## Open source

<div style="float: left; width: 60%; text-align: left; font-size:24px;">
  <ul>
    <li>Trino is an <b>open source</b> project licensed under the Apache License, version 2.0</li>
    <li><b>Note:</b> This does not make Trino an Apache project</li>
    <li>Trino is free to run, view the source, redistribute, and modify in any way you see fit</li>
  </ul>
</div>

![](images/open-source.png) <!-- .element height="220" style="background-color:#ffffff75" -->

<!-- .element style="float: left; width: 40%;" -->

-vertical

## Structured Query Language (SQL)

<div style="float: left; width: 60%; text-align: left; font-size:24px;" class="r-fit-text">
  <ul>
    <li>Declarative language - specify what, not how</li>
    <li>Using SQL enables Trino to do the heavy lift of optimizing the code so you don't have to</li>
  </ul>
</div>

![](images/SQL.svg) <!-- .element height="220" style="background-color:#ffffff75" -->

<!-- .element style="float: left; width: 40%;" -->

-vertical

## Query Engine

<div style="float: left; width: 60%; text-align: left; font-size:24px;" class="r-fit-text">
  <ul>
    <li>Trino is not a database</li>
    <li>Databases include query engines, but also support all the components around storage, transactions, and other features</li>
  </ul>
</div>

<div class="r-stack">
  <img class="fragment fade-out" data-fragment-index="0" src="images/relational-database.svg" width="200vw">
  <img class="fragment" data-fragment-index="0" src="images/trino-query-engine.svg" width="200vw">
</div>

<!-- .element style="float: left;  width: 40%;" -->

What&#39;s the point of just a query engine? 

-vertical
 
<h3>
  Trino is a ludicrously fast, open source, SQL query engine...
  <span class="fragment">
    <span class="animate__flipInX animate__slower">
      designed to query <span style="color:#dd00a1">disparate data sources</span>.
    </span>
  </span>
</h3>

-vertical

## Disparate data sources


**SPI (Service Provider Interface)** \
\
A translation layer from the SQL operations to the domain-specific language of various heterogeneous data sources.

<!-- .element style="float: left; width: 60%; text-align: center; font-size: 32px" -->

![](images/data-sources.svg) <!-- .element width="150vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

-vertical

<h3>
  Trino is a ludicrously fast, open source, 
  <span class="fragment">
    <span class="animate__flipInX animate__slower">
      <span style="color:#f88600">distributed</span>,
    </span>
    <span class="animate__flipInX animate__slower">
      <span style="color:#dd00a1">massively parallel processing</span>,
    </span>
  </span>
  SQL query engine designed to query 
  <span class="fragment">
    <span class="animate__flipInX animate__slower">
      <span style="color:#f8b600">large data sets</span> from one or more
    </span>
  </span>
  disparate data sources.
</h3>

-vertical

## What is a large data set?

<div style="float: left; width: 60%; text-align: left; font-size:36px;" >
  <ul>
    <li>Relative to the scale after the initial boom of Big Data</li>
    <li>Gigabytes to petabytes of data</li>
    <li>A variety of data formats</li>
    <li>Able to be processed in minutes to nanoseconds</li>
  </ul>
</div>

![](images/large-data.svg) <!-- .element width="350vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

Trino keeps up with all these requirements on top of the interactive speeds.

<!-- .element class="r-fit-text" -->

-vertical

## Distributed systems


<div style="float: left; width: 60%; text-align: left; font-size:36px;" >
  <ul>
    <li>Processes big data in a scalable and cost-efficient manner</li>
    <li>Trades off complexity for resiliency and scalability</li>
    <li>The coordinator node is responsible for planning and scheduling all the queries</li>
    <li>Query execution is distributed across multiple Trino worker nodes</li>
  </ul>
</div>

![](images/trino-distributed.svg) <!-- .element width="350vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

-vertical

## Massively parallel processing (MPP) architecture


<div style="float: left; width: 60%; text-align: left; font-size:36px;" >
  <ul>
    <li>Splits work up across nodes and threads</li>
    <li>Shares a single long-lived Java Virtual Machine (JVM) process on worker nodes</li>
    <li>Reduces response time, but requires integrated scheduling, resource management, and isolation</li>
  </ul>
</div>

![](images/trino-mpp.svg) <!-- .element width="250vw" style="background-color:#ffffff00" -->

<!-- .element style="float: left;  width: 40%;" -->

-vertical

<h3>
  Trino is a ludicrously fast, 
      <span style="color:#f88600">open source</span>,
      <span style="color:#dd00a1">distributed</span>,
      <span style="color:#f8b600">massively parallel processing</span>,
      <span style="color:#f88600">SQL</span>
      <span style="color:#dd00a1">query engine</span>.
  designed to query 
      <span style="color:#f8b600">large data sets</span> from one or more
  <span style="color:#f88600">disparate data sources</span>.
</h3>
