-- Databricks notebook source
-- MAGIC %run ./_init

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Ex1. Casting Quantities
-- MAGIC * **Task:** 
-- MAGIC   - Select `txn_id` and `quantity` from `session_3_sql.shop_1_sales_transaction`. 
-- MAGIC   - Create a new column casting `quantity` as a `FLOAT` and another casting it as a `STRING`.
-- MAGIC   - Display only 3 records
-- MAGIC

-- COMMAND ----------

select
  txn_id,
  quantity,
  cast(quantity as float) as qty_float,
  cast(quantity as string) as qty_string
from
  session_3_sql.shop_1_sales_transaction
limit 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **expected result**
-- MAGIC | txn_id | quantity | qty_float | qty_string |
-- MAGIC | :--- | :--- | :--- | :--- |
-- MAGIC | 1 | 5 | 5.0 | 5 |
-- MAGIC | 1 | 5 | 5.0 | 5 |
-- MAGIC | 2 | 8 | 8.0 | 8 |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Ex2. Date Manipulation
-- MAGIC   - Task:
-- MAGIC     - Select distinct `txn_date` from `session_3_sql.shop_1_sales_transaction`.
-- MAGIC     - Calculate the date **7 days after** the transaction date.

-- COMMAND ----------

select distinct txn_date , date_add(txn_date,7) as next_week
 from session_3_sql.shop_1_sales_transaction

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **expected result**
-- MAGIC | txn_date | next_week |
-- MAGIC | :--- | :--- |
-- MAGIC | 2026-02-01 | 2026-02-08 |
-- MAGIC | 2026-02-02 | 2026-02-09 |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### EX3. Handling Nulls with Coalesce
-- MAGIC   - **Task:** 
-- MAGIC     - Perform a Left Join between `session_3_sql.shop_1_sales_transaction` and `session_3_sql.dim_shop_name`. 
-- MAGIC     - Use `COALESCE` to replace NULL `shop_name` with the text `'Unknown Shop'`.

-- COMMAND ----------

select * from session_3_sql.shop_1_sales_transaction

-- COMMAND ----------

select
  txn_id,
  coalesce(Sn.shop_name, 'Unknown Shop') as shop_name_fixed
from
  session_3_sql.shop_1_sales_transaction S
    Left join session_3_sql.dim_shop_name Sn
      on S.shop_id = Sn.shop_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | txn_id | shop_name_fixed |
-- MAGIC | :--- | :--- |
-- MAGIC | 1 | @pitishop |
-- MAGIC | 1 | @pitishop |
-- MAGIC | 2 | @pitishop |
-- MAGIC | 3 | Unknown Shop |
-- MAGIC | 4 | Unknown Shop |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### EX4. Safe Conversion (TRY_CAST)
-- MAGIC   - **Task:** 
-- MAGIC     - Select `shop_name` from `session_3_sql.dim_shop_name`. 
-- MAGIC     - Try to cast the `shop_name` (e.g., '@pitishop') into an `INTEGER`. 
-- MAGIC     - Use `TRY_CAST` to ensure it returns `NULL` instead of crashing.

-- COMMAND ----------

select shop_name,
  try_cast(shop_name as integer) as invalid_cast
from session_3_sql.dim_shop_name

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | shop_name | invalid_cast |
-- MAGIC | :--- | :--- |
-- MAGIC | @pitishop | null |
-- MAGIC | @valentino | null |
-- MAGIC | @datasparkTH | null |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Ex5. Month-End Reporting
-- MAGIC   - **Task:** 
-- MAGIC     - For every transaction in `shop_1_sales_transaction`, 
-- MAGIC     - calculate how many days were left in that month from the `txn_date`.

-- COMMAND ----------

select txn_date , datediff(last_day(txn_date),txn_date) as days_left_in_month
from session_3_sql.shop_1_sales_transaction

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | txn_date | days_left_in_month |
-- MAGIC | :--- | :--- |
-- MAGIC | 2026-02-01 | 27 |
-- MAGIC | 2026-02-01 | 27 |
-- MAGIC | 2026-02-01 | 27 |
-- MAGIC | 2026-02-02 | 26 |
-- MAGIC | 2026-02-02 | 26 |