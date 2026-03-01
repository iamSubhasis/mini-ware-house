create table if not exists dw.fact_monthly_sales(
date_key integer not null,
supplier_key integer not null,
product_key integer not null,

retail_sales numeric(12,2) not null,
warehouse_sales numeric(12,2) not null,
retail_transfers numeric(12,2) not null,
total_sales numeric(14,2) not null,
    PRIMARY KEY (date_key, supplier_key, product_key),

    FOREIGN KEY (date_key)
        REFERENCES dw.dim_date(date_key),

    FOREIGN KEY (supplier_key)
        REFERENCES dw.dim_supplier(supplier_key),

    FOREIGN KEY (product_key)
        REFERENCES dw.dim_product(product_key)
);
