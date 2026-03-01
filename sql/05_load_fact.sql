INSERT INTO dw.fact_monthly_sales (
    date_key,
    supplier_key,
    product_key,
    retail_sales,
    warehouse_sales,
    retail_transfers,
    total_sales
)
SELECT
    (r.year * 100 + r.month) AS date_key,
    s.supplier_key,
    p.product_key,
    r.retail_sales,
    r.warehouse_sales,
    r.retail_transfers,
    (r.retail_sales + r.warehouse_sales + r.retail_transfers) AS total_sales
FROM public.warehouse_retail_sales r
JOIN dw.dim_supplier s
    ON r.supplier = s.supplier_name
JOIN dw.dim_product p
    ON r.item_code = p.item_code
ON CONFLICT (date_key, supplier_key, product_key)
DO UPDATE SET
    retail_sales     = EXCLUDED.retail_sales,
    warehouse_sales  = EXCLUDED.warehouse_sales,
    retail_transfers = EXCLUDED.retail_transfers,
    total_sales      = EXCLUDED.total_sales;
