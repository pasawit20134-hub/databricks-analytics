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
-- MAGIC
-- MAGIC ###
-- MAGIC table_name : session_2_sql.shop_name
-- MAGIC |shop_id|shop_name|
-- MAGIC |---|---|
-- MAGIC |1|pharam2|
-- MAGIC |3|satupardit|
-- MAGIC |4|samyan|
-- MAGIC |5|bangyai|
-- MAGIC |6|ramintra|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### ex.1
-- MAGIC - table_name session_2_sql.sales_by_store
-- MAGIC - get only shop_id is not equal to 1

-- COMMAND ----------

SELECT * 
FROM session_2_sql.sales_by_store WHERE shop_id != 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex1:
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
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
-- MAGIC ### ex.2:
-- MAGIC - table_name : session_2_sql.sales_by_store
-- MAGIC - get only store_size that start with sm

-- COMMAND ----------

select * from session_2_sql.sales_by_store
where store_size like "sm%"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex2:
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-01|1|small|10000|
-- MAGIC |2025-01-02|1|small|5000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### ex.3: 
-- MAGIC - table_name : session_2_sql.shop_name
-- MAGIC - get only shop_name that start with sa and has only 6 digits from session_2_sql.shop_name

-- COMMAND ----------

select * from session_2_sql.shop_name
where shop_name like "sa____"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.3
-- MAGIC |shop_id|shop_name|
-- MAGIC |---|---|
-- MAGIC |4|samyan|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### ex.4: 
-- MAGIC - table_name : session_2_sql.sales_by_store
-- MAGIC - get only sales_amount is more than 5,000 and less than 10,000

-- COMMAND ----------

select * from session_2_sql.sales_by_store
where sales_amount > 5000 and sales_amount < 10000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.4
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-01|3|null|6000|
-- MAGIC |2025-01-02|3|null|7000|
-- MAGIC |2025-01-02|4|large|6500|
-- MAGIC |2025-01-03|4||6500|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### ex.5: 
-- MAGIC - table_name : session_2_sql.sales_by_store
-- MAGIC - get only sales_amount between 5000 - 10000

-- COMMAND ----------

select * from session_2_sql.sales_by_store
where sales_amount between 5000 and 10000

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.5
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-01|1|small|10000|
-- MAGIC |2025-01-02|1|small|5000|
-- MAGIC |2025-01-01|2|medium|5000|
-- MAGIC |2025-01-01|3|null|6000|
-- MAGIC |2025-01-02|3|null|7000|
-- MAGIC |2025-01-02|4|large|5000|
-- MAGIC |2025-01-02|4|large|6500|
-- MAGIC |2025-01-03|4||6500|
-- MAGIC |2025-01-04|4||10000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### ex.6: 
-- MAGIC - table_name : session_2_sql.sales_by_store
-- MAGIC - get only shop_id are not equal to 1, 4

-- COMMAND ----------

select * from session_2_sql.sales_by_store 
where shop_id not in (1,4)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.6
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-01|2|medium|5000|
-- MAGIC |2025-01-02|2|medium|4000|
-- MAGIC |2025-01-01|3|null|6000|
-- MAGIC |2025-01-02|3|null|7000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###ex.7: 
-- MAGIC - table_name : session_2_sql.sales_by_store
-- MAGIC - get only store_size is null

-- COMMAND ----------

select * from session_2_sql.sales_by_store
where store_size is null

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.7
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-01|3|null|6000|
-- MAGIC |2025-01-02|3|null|7000|

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ###ex.8:
-- MAGIC - table_name : session_2_sql.sales_by_store
-- MAGIC - get only store_size is blank ("")

-- COMMAND ----------

select * from session_2_sql.sales_by_store
where store_size = ""

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Result Ex.8
-- MAGIC |date|shop_id|store_size|sales_amount|
-- MAGIC |---|---|---|---|
-- MAGIC |2025-01-03|4||3500|
-- MAGIC |2025-01-04|4||10000|