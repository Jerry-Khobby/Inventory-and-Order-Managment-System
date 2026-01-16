# Inventory & Order Management System

## Overview

The **Inventory & Order Management System** is a SQL-based database project designed to manage customers, products, inventory levels, and orders efficiently.
The project demonstrates practical database design, normalization, constraints, indexing, stored procedures, triggers, and analytical queries (KPIs).

It is suitable for learning and showcasing skills in:

* Relational database design
* SQL (DDL, DML, constraints, indexes)
* Business analytics using SQL
* Stored procedures and triggers
* Database testing and logging

---

## Features

* Well-structured relational schema
* Enforced data integrity using constraints
* Optimized queries with indexes
* Automated logic using triggers
* Business KPIs for reporting and analysis
* ER diagram for visual understanding
* Test scripts for stored procedures

---

## ER Diagram

The ER diagram illustrates the relationships between customers, products, orders, inventory, and order items.

![ER Diagram](./erd/er-inventory-and-order-management.drawio.png)

---

## Folder Structure

```
inventory-and-order-management-system/
│
├── ddl/
│   ├── schema.sql
│   ├── constraints.sql
│   ├── indexes.sql
│   └── insert_items.sql
│
├── dml/
│   └── kpis.sql
│
├── erd/
│   └── er-inventory-and-order-management.drawio.png
│
├── logs/
│   ├── error_log.err
│   ├── general_log.log
│   └── triggers.sql
│
├── test/
│   └── procedure.sql
│
├── .gitignore
└── README.md
```

---

## Project Structure Explained

### 1. DDL (`ddl/`)

Contains all database definition and setup scripts.

* **schema.sql**
  Defines database tables such as:

  * Customers
  * Products
  * Inventory
  * Orders
  * Order_Items

* **constraints.sql**
  Adds:

  * Primary keys
  * Foreign keys
  * Check constraints
  * Data integrity rules

* **indexes.sql**
  Improves query performance using indexes on frequently accessed columns.

* **insert_items.sql**
  Inserts sample data for testing and demonstration purposes.

---

### 2. DML (`dml/`)

Contains analytical and reporting queries.

* **kpis.sql**
  Includes business intelligence queries such as:

  * Total revenue
  * Top customers
  * Best-selling products
  * Monthly sales trends
  * Sales ranking by category
  * Summary views for reporting

---

### 3. ERD (`erd/`)

* **er-inventory-and-order-management.drawio.png**
  Visual representation of the database schema and relationships.

---

### 4. Logs (`logs/`)

Stores database logs and automation logic.

* **error_log.err** – Captures database errors
* **general_log.log** – Tracks general database operations
* **triggers.sql** – Database triggers for automation, validation, and consistency

---

### 5. Tests (`test/`)

Contains scripts for validating database logic.

* **procedure.sql**
  Tests stored procedures such as order processing and inventory updates.

---

## Execution Order (Recommended)

1. Run `ddl/schema.sql`
2. Run `ddl/constraints.sql`
3. Run `ddl/indexes.sql`
4. Run `ddl/insert_items.sql`
5. Run `logs/triggers.sql`
6. Execute `dml/kpis.sql`
7. Test procedures using `test/procedure.sql`

---

## Use Cases

* Academic database projects
* SQL portfolio projects
* Learning relational database concepts
* Demonstrating analytical SQL skills

---


