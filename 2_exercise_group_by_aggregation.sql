-- Databricks notebook source
-- MAGIC %run ../_init

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Example Data
-- MAGIC table_name: session_2_sql.sales_by_store
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-01|1|small|10000|
-- MAGIC |2025-01-02|1|small|5000|
-- MAGIC |2025-01-01|2|medium|5000|
-- MAGIC |2025-01-02|2|medium|4000|
-- MAGIC |2025-01-01|3|null|6000|
-- MAGIC |2025-01-02|3|null|7000|
-- MAGIC |2025-01-02|4|large|5000|
-- MAGIC |2025-01-02|4|large|6500|
-- MAGIC |2025-01-03|4||6500|
-- MAGIC |2025-01-04|4||10000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Ex.1 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - count how many days that operate in each shop_id

-- COMMAND ----------

select shop_id ,
count(date)
from session_2_sql.sales_by_store
group by shop_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.1
-- MAGIC |shop_id|num_days|
-- MAGIC |---|---|
-- MAGIC |1|2|
-- MAGIC |2|2|
-- MAGIC |3|2|
-- MAGIC |4|4|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Ex.2 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - count how many store_size = large in each shop_id

-- COMMAND ----------

select shop_id ,
count_if(store_size='large') as count_large
from session_2_sql.sales_by_store
group by shop_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.2
-- MAGIC |shop_id|large_store_size|
-- MAGIC |---|---|
-- MAGIC |1|0|
-- MAGIC |2|0|
-- MAGIC |3|0|
-- MAGIC |4|2|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Ex.3 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - count unique store_size in each shop_id

-- COMMAND ----------

select shop_id ,
count(distinct store_size) as count_size
from session_2_sql.sales_by_store
group by shop_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.3
-- MAGIC |shop_id|count_store_size|
-- MAGIC |---|---|
-- MAGIC |1|1|
-- MAGIC |2|1|
-- MAGIC |3|0|
-- MAGIC |4|2|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Ex.4 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - The lowest sales_amount in each day

-- COMMAND ----------

select date , min(sales_amount) as min_sales
from session_2_sql.sales_by_store
group by date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC result Ex.4
-- MAGIC |date|min_sales|
-- MAGIC |---|---|
-- MAGIC |2025-01-01|5000|
-- MAGIC |2025-01-02|4000|
-- MAGIC |2025-01-03|3500|
-- MAGIC |2025-01-04|10000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Ex.5 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - The highest sales_amount in each day

-- COMMAND ----------

select date , max(sales_amount) as max_sales
from session_2_sql.sales_by_store
group by date order by date desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC result Ex5.
-- MAGIC |date|max_sales|
-- MAGIC |---|---|
-- MAGIC |2025-01-04|10000|
-- MAGIC |2025-01-03|6500|
-- MAGIC |2025-01-02|7000|
-- MAGIC |2025-01-01|10000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Ex.6 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - total sales_amount per day

-- COMMAND ----------

select date , sum(sales_amount) as total_sales
from session_2_sql.sales_by_store
group by date

-- COMMAND ----------

-- MAGIC %md result ex6
-- MAGIC |date|total_sales|
-- MAGIC |---|---|
-- MAGIC |2025-01-01|26000|
-- MAGIC |2025-01-02|22500|
-- MAGIC |2025-01-03|6500|
-- MAGIC |2025-01-04|10000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###Ex.7 
-- MAGIC - table_name: dev_catalog.dwh.sales_by_store
-- MAGIC - total avg_sales per day

-- COMMAND ----------

select date , avg(sales_amount) as avg_sales
from session_2_sql.sales_by_store
group by date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC result ex7
-- MAGIC |date|avg_sales|
-- MAGIC |---|---|
-- MAGIC |2025-01-01|6500|
-- MAGIC |2025-01-02|5625|
-- MAGIC |2025-01-03|6500|
-- MAGIC |2025-01-04|10000|