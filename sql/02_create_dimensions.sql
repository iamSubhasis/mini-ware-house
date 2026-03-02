create table if not exists dw.dim_date(
date_key integer primary key,
year smallint not null,
month smallint not null,
month_name text not null,
unique(year,month)
);

create table if not exists dw.dim_supplier(
supplier_key serial primary key,
supplier_name text not null unique
);

create table if not exists dw.dim_product(
product_key serial primary key,
item_code text not null unique,
item_description text,
item_type text not null
);


