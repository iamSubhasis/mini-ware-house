Mini Data Warehouse (PostgreSQL)
Overview

This project implements a mini data warehouse in PostgreSQL using a star schema design.

The warehouse separates:

Raw ingestion layer (public schema)

Analytical warehouse layer (dw schema)

The goal is to support supplier market dominance and revenue trend analysis.

Architecture

Database: etl_lab
Warehouse Schema: dw

Layers

Raw Layer (public schema)

warehouse_retail_sales (source table)

Warehouse Layer (dw schema)

dim_date

dim_supplier

dim_product

fact_monthly_sales

Fact Table
fact_monthly_sales

Grain:
One row per month per supplier per product.

Measures:

retail_sales

warehouse_sales

retail_transfers

total_sales

Foreign keys:

date_key → dim_date

supplier_key → dim_supplier

product_key → dim_product

Dimensions
dim_date

Monthly date dimension.

dim_supplier

Supplier dimension (SCD Type 1).

dim_product

Product dimension (SCD Type 1).

SCD Strategy

All dimensions implemented as Type 1 (overwrite strategy).

Reason:
Dataset is stable and historical attribute tracking is not required for this phase.

Analytical Objective

Analyze:

Monthly revenue trends

Supplier market dominance

Market share over time

Product revenue concentration

Example Queries

Located in:

sql/06_analytical_queries.sql

Includes:

Monthly market revenue

Supplier market share

Year-over-year comparison

Top products

How to Run

Execute SQL files in order:

01_create_schema.sql

02_create_dimensions.sql

03_create_fact.sql

04_load_dimensions.sql

05_load_fact.sql

06_analytical_queries.sql

Dataset Size

~300,000 rows in source table.

Tech Stack

PostgreSQL 14

SQL-first transformations

Ubuntu (WSL2)

Git for version control
