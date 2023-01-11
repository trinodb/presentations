## Trino icons

Trino also has a useful icon library so you don't need to use boxes for your diagram anymore:

![](../../assets/icons/3-pink/trino-icons-dd00a1_authenticated-non-object.svg)  <!-- .element width="70vw" style="float: none;" title="Authenticated non-object storage" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_authenticated-object-storage.svg)  <!-- .element width="70vw" style="float: none;" title="Authenticated object storage" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_authenticated-session.svg)  <!-- .element width="70vw" style="float: none;" title="Authenticated session" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_authorized-client.svg)  <!-- .element width="70vw" style="float: none;" title="Authorized client" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_browser-chart.svg)  <!-- .element width="70vw" style="float: none;" title="Browser chart" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_catalog.svg)  <!-- .element width="70vw" style="float: none;" title="Catalog" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_cli.svg)  <!-- .element width="70vw" style="float: none;" title="CLI" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_cloud-provider.svg)  <!-- .element width="70vw" style="float: none;" title="Cloud Provider" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_cluster.svg)  <!-- .element width="70vw" style="float: none;" title="Cluster" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_connector.svg)  <!-- .element width="70vw" style="float: none;" title="Connector" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_coordinator.svg)  <!-- .element width="70vw" style="float: none;" title="Coordinator" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_cpu.svg)  <!-- .element width="70vw" style="float: none;" title="CPU" -->

![](../../assets/icons/3-pink/trino-icons-dd00a1_data-entity.svg)  <!-- .element width="70vw" style="float: none;" title="Data entity" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_data-lake.svg)  <!-- .element width="70vw" style="float: none;" title="Data lake" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_data-lakehouse.svg)  <!-- .element width="70vw" style="float: none;" title="Data lakehouse" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_data-warehouse.svg)  <!-- .element width="70vw" style="float: none;" title="Data warehouse" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_desktop-chart.svg)  <!-- .element width="70vw" style="float: none;" title="Desktop chart" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_generic-service.svg)  <!-- .element width="70vw" style="float: none;" title="Generic service" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_group.svg)  <!-- .element width="70vw" style="float: none;" title="Group" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_memory.svg)  <!-- .element width="70vw" style="float: none;" title="Memory" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_non-object.svg)  <!-- .element width="70vw" style="float: none;" title="Non-object storage" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_object-storage.svg)  <!-- .element width="70vw" style="float: none;" title="Object storage" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_private-cloud.svg)  <!-- .element width="70vw" style="float: none;" title="Private cloud" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_privilege.svg)  <!-- .element width="70vw" style="float: none;" title="Privilege" -->

![](../../assets/icons/3-pink/trino-icons-dd00a1_rbac-provider.svg)  <!-- .element width="70vw" style="float: none;" title="RBAC Provider" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_role.svg)  <!-- .element width="70vw" style="float: none;" title="Role" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_shared-secret.svg)  <!-- .element width="70vw" style="float: none;" title="Shared secret" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_user.svg)  <!-- .element width="70vw" style="float: none;" title="User" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_worker.svg)  <!-- .element width="70vw" style="float: none;" title="Worker" -->

-vertical

## Cluster component icons

![](../../assets/icons/3-pink/trino-icons-dd00a1_cluster.svg)  <!-- .element width="70vw" style="float: none;" title="Cluster" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_coordinator.svg)  <!-- .element width="70vw" style="float: none;" title="Coordinator" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_worker.svg)  <!-- .element width="70vw" style="float: none;" title="Worker" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_connector.svg)  <!-- .element width="70vw" style="float: none;" title="Connector" -->

Cluster - very high level; use to describe "where Trino fits in", coordinator, worker, connector

Cluster compnents except catalogs must always be in pink (in default icon set), unless you are also depicting a remote cluster, which should be in teal (found in the secondary icon set) . The black cluster icon in the default icon set is for non-Trino-based clusters in the unlikely event that you should need that.

Source-to-connector lines

Especially when dealing with object storage and their metadata sources, connections between connectors and data sources can get very complicated very fast. Data source lines should be
color matched. You can leave meta data connections black, or color match them to the metadata source. 

-vertical

## Catalog icon

![](../../assets/icons/3-pink/trino-icons-dd00a1_catalog.svg)  <!-- .element width="100vw" style="float: none;" title="Catalog" -->
![](../../assets/icons/4-orange/trino-icons-f88600_catalog.svg)  <!-- .element width="100vw" style="float: none;" title="Catalog" -->
![](../../assets/icons/5-yellow/trino-icons-f8b600_catalog.svg)  <!-- .element width="100vw" style="float: none;" title="Catalog" -->

Catalog - use this for high-level  illustrations to show that catalogs are part of the architecture. If you are using multiple sources, their catalogs should be color-coded to the source

Technically these are a part of the Trino architecture. If you are only including one catalog, it should be pink like the other 
cluster components. If you are depicting multiple data sources and their catalogs then you can differentiate them by matching 
their color to their data source.

-vertical

## Data sources 

![](../../assets/icons/1-dark-blue/trino-icons-000033_catalog.svg)  <!-- .element width="100vw" style="float: none;" title="Catalog" -->
![](../../assets/icons/1-dark-blue/trino-icons-000033_non-object.svg)  <!-- .element width="70vw" style="float: none;" title="Non-object storage" -->
![](../../assets/icons/2-cobalt-blue/trino-icons-001c93_catalog.svg)  <!-- .element width="100vw" style="float: none;" title="Catalog" -->
![](../../assets/icons/2-cobalt-blue/trino-icons-001c93_object-storage.svg)  <!-- .element width="70vw" style="float: none;" title="Object storage" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_catalog.svg)  <!-- .element width="100vw" style="float: none;" title="Catalog" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_data-lake.svg)  <!-- .element width="70vw" style="float: none;" title="Data lake" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_data-lakehouse.svg)  <!-- .element width="70vw" style="float: none;" title="Data lakehouse" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_data-warehouse.svg)  <!-- .element width="70vw" style="float: none;" title="Data warehouse" -->

<!-- .element style="background-color: #ffffff88;" -->

Shown above are the default colors for each category of data source: object storage, non-object storage, and data lake/lakehouse, respectively. 
Use the secondary colors only if you are showing multiples of the same category. Similarly, only use the last resort icon set colors if you 
are using more than two of the same category.

-vertical

## Security icons

![](../../assets/icons/4-orange/trino-icons-f88600_authenticated-session.svg)  <!-- .element width="70vw" style="float: none;" title="Authenticated session" -->
![](../../assets/icons/4-orange/trino-icons-f88600_shared-secret.svg)  <!-- .element width="70vw" style="float: none;" title="Shared secret" -->
![](../../assets/icons/4-orange/trino-icons-f88600_rbac-provider.svg)  <!-- .element width="70vw" style="float: none;" title="RBAC provider" -->
![](../../assets/icons/4-orange/trino-icons-f88600_authenticated-non-object.svg)  <!-- .element width="70vw" style="float: none;" title="Authenticated non-object storage" -->
![](../../assets/icons/4-orange/trino-icons-f88600_authenticated-object-storage.svg)  <!-- .element width="70vw" style="float: none;" title="Authenticated object storage" -->

Trino-based cluster security "components" are always shown in orange, including all 
[authentication types](https://trino.io/docs/current/security/authentication-types.html) and 
[access control types](https://trino.io/docs/current/security.html#access-control).

-vertical

## Auth icons

![](../../assets/icons/0-black/trino-icons-212121_user.svg)  <!-- .element width="70vw" style="float: none;" title="User" -->
![](../../assets/icons/0-black/trino-icons-212121_authorized-client.svg)  <!-- .element width="70vw" style="float: none;" title="Authorized client" -->
![](../../assets/icons/0-black/trino-icons-212121_role.svg)  <!-- .element width="70vw" style="float: none;" title="Role" -->
![](../../assets/icons/0-black/trino-icons-212121_privilege.svg)  <!-- .element width="70vw" style="float: none;" title="Privilege" -->

<!-- .element style="background-color: #ffffff88;" -->

The default color for authorization entities is black. Use the secondary colors only if you are showing multiples of the same category. Similarly, only use the last resort icon set colors if you are using more than two.

-vertical

## User icon

![](../../assets/icons/0-black/trino-icons-212121_user.svg)  <!-- .element width="200vw" title="User" -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_user.svg)  <!-- .element width="200vw" title="User" -->

<!-- .element style="background-color: #ffffff88;" -->

Users in context of security, along with roles, privs, groups, and security entities default to black. Use colors if depicting 
multiple policy items (groups, privs, roles) etc., or data sources.

-vertical

## Misc icons

![](../../assets/icons/3-pink/trino-icons-dd00a1_cloud-provider.svg)  <!-- .element width="70vw" style="float: none;" title="Cloud Provider"  -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_private-cloud.svg)  <!-- .element width="70vw" style="float: none;" title="Private cloud"  -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_cpu.svg)  <!-- .element width="70vw" style="float: none;" title="CPU"  -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_memory.svg)  <!-- .element width="70vw" style="float: none;" title="Memory"  -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_generic-service.svg)  <!-- .element width="70vw" style="float: none;" title="Generic service"  -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_desktop-chart.svg)  <!-- .element width="70vw" style="float: none;" title="Desktop chart"  -->
![](../../assets/icons/3-pink/trino-icons-dd00a1_cli.svg)  <!-- .element width="70vw" style="float: none;" title="CLI"  -->

We have some icons to depict cloud providers and private clouds, CPU and memory, generic services, and client icons.
