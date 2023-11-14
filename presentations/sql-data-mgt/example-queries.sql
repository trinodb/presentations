SHOW CATALOGS;

CREATE CATALOG brain USING memory;

CREATE CATALOG tpch USING tpch;

SHOW CATALOGS;

DROP CATALOG brain;

DROP CATALOG tpch;

SHOW CATALOGS;

CREATE SCHEMA brain.demo;

SHOW SCHEMAS FROM brain;

-- Important for the following statements
-- Change to whatever catalog and schema you use for learning
USE brain.demo;

CREATE TABLE person (
  firstname varchar(50),
  lastname varchar(50),
  dob date
);

INSERT INTO person (firstname, lastname, dob)
VALUES
('Manfred', 'Moser', DATE '1999-01-01'),
('David', 'Phillips', DATE '2000-02-02');

SELECT * FROM  person;

SHOW CATALOGS;

SHOW SCHEMAS FROM brain;

SHOW TABLES FROM brain.demo;

SHOW CREATE TABLE brain.demo.person;

DESCRIBE brain.demo.person;

SELECT * FROM system.metadata.catalogs;

SELECT * FROM brain.information_schema.columns
  WHERE table_schema = 'demo'
  AND table_name = 'person';


-- Module 2

DROP TABLE person;

CREATE TABLE person (
  uuid uuid,
  firstname varchar(50),
  lastname varchar(50),
  dob date,
  create_ts timestamp
);

DESCRIBE person;

INSERT INTO person (uuid, firstname, lastname, dob, create_ts)
VALUES
(uuid(), 'Manfred', 'Moser', DATE '1999-01-01', now()),
(uuid(), 'David', 'Phillips', DATE '2000-02-02', now());

SELECT * FROM person;

SELECT
  firstname || ' ' || lastname AS Name,
  date_diff('year', dob, current_date) AS Age
FROM person;

CREATE TABLE region AS
  SELECT * FROM tpch.tiny.region;

SELECT * FROM region;

CREATE TABLE nation AS
  SELECT * FROM tpch.tiny.nation;

SELECT * FROM nation;

CREATE TABLE supplier_us
AS
  SELECT * FROM tpch.tiny.supplier
  WHERE nationkey = 24;

SELECT * FROM supplier_us;

SELECT
  nationkey,
  count(*) AS supplier_count
 FROM tpch.sf100.supplier
 GROUP BY nationkey;

CREATE TABLE supplier_per_nation AS
  SELECT
    nationkey,
    count(*) AS supplier_count
  FROM tpch.sf100.supplier
  GROUP BY nationkey;

SELECT * FROM supplier_per_nation;

SELECT nation.name, supplier_per_nation.supplier_count
FROM supplier_per_nation
JOIN nation
ON supplier_per_nation.nationkey = nation.nationkey;

DROP TABLE supplier_per_nation;

-- Run again
INSERT INTO person (uuid, firstname, lastname, dob, create_ts)
VALUES
(uuid(), 'Manfred', 'Moser', DATE '1999-01-01', now()),
(uuid(), 'David', 'Phillips', DATE '2000-02-02', now());

SELECT * FROM person;

--oops .. need to update
-- might not work depending on connector support for UPDATE
UPDATE person
SET
  firstname='Martin',
  lastname='Traverso',
  dob = DATE '2000-03-03'
WHERE uuid = UUID '042cbe59-4b63-48d0-b6a7-f8a535e16784'; -- update to UUID value

UPDATE person
SET
  firstname='Dain',
  lastname='Sundstrom',
  dob = DATE '2000-04-04'
WHERE uuid = UUID 'ec625e61-b4a2-4ce3-a597-a1897ef8e525'; -- update to UUID value

UPDATE person
SET create_ts = now();

SELECT * FROM person;

DELETE FROM person
WHERE uuid = UUID '8e11175e-fe32-41d9-8de3-57d903b39de5' OR
 uuid = UUID '648c440f-4c3b-48a2-8a0b-f3f55d7c425d'; -- update to UUID values

SELECT * FROM person;

DELETE FROM person
WHERE firstname='Manfred';

ALTER TABLE person
ADD COLUMN update_ts timestamp; -- fails!

ALTER TABLE person
ADD COLUMN update_ts timestamp(6);

ALTER TABLE person
ADD COLUMN role varchar(50);

ALTER TABLE person
ALTER COLUMN lastname SET DATA TYPE varchar(100);

DESCRIBE person;

CREATE TABLE person2 AS SELECT * FROM person;

-- Run again
INSERT INTO person2 (uuid, firstname, lastname, dob, create_ts, update_ts, role)
VALUES
(uuid(), 'Manfred', 'Moser', DATE '1999-01-01', now(), now(), 'Maintainer');

SELECT * FROM person;

SELECT * FROM person2;

MERGE INTO person USING person2 AS p2
ON (person.uuid = p2.uuid)
  WHEN MATCHED
    THEN UPDATE SET role = 'Co-creator', update_ts = now()
   WHEN NOT MATCHED
        THEN INSERT (uuid, firstname, lastname, dob, create_ts, update_ts, role)
              VALUES(p2.uuid, p2.firstname, p2.lastname, p2.dob, p2.create_ts, p2.update_ts, p2.role);

DELETE FROM person WHERE firstname = 'Manfred';

UPDATE person SET role = null;

UPDATE person SET role = 'Co-creator';

SELECT * FROM person;


-- Module 3 - Views and materialized views

CREATE VIEW vw_supplier_us
AS
  SELECT * FROM tpch.tiny.supplier
  WHERE nationkey = 24;

SELECT * FROM vw_supplier_us;

DROP VIEW vw_supplier_us;

CREATE VIEW vw_supplier_per_nation AS
  SELECT
    nationkey,
    count(*) AS supplier_count
  FROM tpch.sf100.supplier
  GROUP BY nationkey;

SELECT * FROM vw_supplier_per_nation;

DROP VIEW vw_supplier_per_nation;

SELECT nation.name, vw_supplier_per_nation.supplier_count
FROM vw_supplier_per_nation
JOIN nation
ON vw_supplier_per_nation.nationkey = nation.nationkey;

CREATE MATERIALIZED VIEW mv_supplier_us
AS
  SELECT * FROM tpch.tiny.supplier
  WHERE nationkey = 24;

SELECT * FROM mv_supplier_us;

DROP MATERIALIZED VIEW mv_supplier_us;

CREATE MATERIALIZED VIEW mv_supplier_per_nation AS
  SELECT
    nationkey,
    count(*) AS supplier_count
  FROM tpch.sf100.supplier
  GROUP BY nationkey;

SELECT * FROM mv_supplier_per_nation;

SELECT
    nation.name,
    mv_supplier_per_nation.supplier_count
FROM mv_supplier_per_nation
JOIN nation
ON mv_supplier_per_nation.nationkey = nation.nationkey;

DROP MATERIALIZED VIEW mv_supplier_per_nation;
