-- Monthly Total Market Revenue
SELECT
    d.year,
    d.month,
    SUM(f.total_sales) AS total_market_sales
FROM dw.fact_monthly_sales f
JOIN dw.dim_date d
    ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;


-- Supplier Market Share Per Month
SELECT
    d.year,
    d.month,
    s.supplier_name,
    SUM(f.total_sales) AS supplier_sales,
    ROUND(
        SUM(f.total_sales) * 100.0 /
        SUM(SUM(f.total_sales)) OVER (PARTITION BY d.year, d.month),
        2
    ) AS market_share_percent
FROM dw.fact_monthly_sales f
JOIN dw.dim_date d
    ON f.date_key = d.date_key
JOIN dw.dim_supplier s
    ON f.supplier_key = s.supplier_key
GROUP BY d.year, d.month, s.supplier_name
ORDER BY d.year, d.month, supplier_sales DESC;


-- Top 5 Products Overall
SELECT
    p.item_code,
    SUM(f.total_sales) AS total_sales
FROM dw.fact_monthly_sales f
JOIN dw.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.item_code
ORDER BY total_sales DESC
LIMIT 5;
