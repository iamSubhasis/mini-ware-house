-- Load dim_date
INSERT INTO dw.dim_date (date_key, year, month, month_name)
SELECT DISTINCT
       (year * 100 + month) AS date_key,
       year,
       month,
       TO_CHAR(TO_DATE(month::text, 'MM'), 'Month') AS month_name
FROM public.warehouse_retail_sales
ON CONFLICT (date_key) DO NOTHING;


-- Load dim_supplier (Type 1)
INSERT INTO dw.dim_supplier (supplier_name)
SELECT DISTINCT supplier
FROM public.warehouse_retail_sales
ON CONFLICT (supplier_name) DO NOTHING;


-- Load dim_product (Type 1)
INSERT INTO dw.dim_product (item_code, item_description, item_type)
SELECT
    item_code,
    MAX(item_description) AS item_description,
    MAX(item_type) AS item_type
FROM public.warehouse_retail_sales
GROUP BY item_code
ON CONFLICT (item_code)
DO UPDATE SET
    item_description = EXCLUDED.item_description,
    item_type = EXCLUDED.item_type;
