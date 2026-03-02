CREATE TABLE IF NOT EXISTS public.warehouse_retail_sales (
    year smallint NOT NULL,
    month smallint NOT NULL,
    supplier text NOT NULL,
    item_code text NOT NULL,
    item_description text,
    item_type text NOT NULL,
    retail_sales numeric(12,2) NOT NULL,
    retail_transfers numeric(12,2) NOT NULL,
    warehouse_sales numeric(12,2) NOT NULL,
    CONSTRAINT chk_month_valid 
        CHECK (month >= 1 AND month <= 12),
    CONSTRAINT chk_sales_non_negative 
        CHECK (
            retail_sales >= 0 AND 
            retail_transfers >= 0 AND 
            warehouse_sales >= 0
        ),
    CONSTRAINT pk_warehouse_retail_sales 
        PRIMARY KEY (year, month, supplier, item_code)
);
