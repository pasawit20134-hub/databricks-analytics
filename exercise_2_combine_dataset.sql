-- Databricks notebook source
-- MAGIC %run ./_init

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### **1. Union of IDs**
-- MAGIC * **Task:** 
-- MAGIC   - Combine distinct `txn_id`s from `session_3_sql.shop_1_sales_transaction` and `session_3_sql.shop_2_sales_transaction` into a single list using `UNION`.

-- COMMAND ----------

select * from session_3_sql.shop_1_sales_transaction

-- COMMAND ----------

select * from session_3_sql.dim_shop_name

-- COMMAND ----------

select * from session_3_sql.shop_2_sales_transaction

-- COMMAND ----------


select txn_id from session_3_sql.shop_1_sales_transaction
union
select txn_id from session_3_sql.shop_2_sales_transaction

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | txn_id |
-- MAGIC | :--- |
-- MAGIC | 1 |
-- MAGIC | 2 |
-- MAGIC | 3 |
-- MAGIC | 4 |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### **2. Inner Join**
-- MAGIC * **Task:** 
-- MAGIC   - Find transactions in `session_3_sql.shop_1_sales_transaction` that have a valid matching shop name in `session_3_sql.dim_shop_name`.

-- COMMAND ----------

select a.txn_id , b.shop_name  from session_3_sql.shop_1_sales_transaction a
inner join  session_3_sql.dim_shop_name b on a.shop_id  = b.shop_id
Order by a.txn_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | txn_id | shop_name |
-- MAGIC | :--- | :--- |
-- MAGIC | 1 | @pitishop |
-- MAGIC | 1 | @pitishop |
-- MAGIC | 2 | @pitishop |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### **3. Left Join**
-- MAGIC * **Task:** 
-- MAGIC   - List all transactions from `session_3_sql.shop_2_sales_transaction`. Attach the `session_3_sql.dim_shop_name` if it exists.

-- COMMAND ----------

select a.txn_id , b.shop_name from session_3_sql.shop_2_sales_transaction a
left join session_3_sql.dim_shop_name b on a.shop_id = b.shop_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | txn_id | shop_name |
-- MAGIC | :--- | :--- |
-- MAGIC | 1 | @valentino |
-- MAGIC | 1 | @valentino |
-- MAGIC | 2 | @valentino |
-- MAGIC | 3 | @valentino |
-- MAGIC | 4 | @valentino |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### **4. Anti Join (Missing Sales)**
-- MAGIC * **Task:** 
-- MAGIC   - Find which shops in `session_3_sql.dim_shop_name` have **never** had a transaction in `session_3_sql.shop_1_sales_transaction`.

-- COMMAND ----------

select shop_name from session_3_sql.dim_shop_name a
anti join session_3_sql.shop_1_sales_transaction b on a.shop_id = b.shop_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | shop_name |
-- MAGIC | :--- |
-- MAGIC | @valentino |
-- MAGIC | @datasparkTH |

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### **5. Full Join with Null Check**
-- MAGIC * **Task:** 
-- MAGIC   - Perform a `FULL JOIN` between `shop_1` sales and `session_3_sql.dim_shop_name`. 
-- MAGIC   - Filter to show only rows where the `shop_name` is missing (transactions with unknown shop IDs).

-- COMMAND ----------

select txn_id , a.shop_id , shop_name from session_3_sql.shop_1_sales_transaction a
full join session_3_sql.dim_shop_name b on a.shop_id = b.shop_id
WHERE b.shop_name IS NULL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC | txn_id | shop_id | shop_name |
-- MAGIC | :--- | :--- | :--- |
-- MAGIC | 3 | 10 | null |
-- MAGIC | 4 | 10 | null |