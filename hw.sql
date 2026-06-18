-- Databricks notebook source
CREATE OR REPLACE TABLE session_3_sql.brz_web_orders (
  order_id STRING, 
  user_ref STRING, 
  order_dt STRING, 
  raw_amount STRING, 
  device STRING
);

CREATE OR REPLACE TABLE session_3_sql.dim_user_profiles (
  user_id INT, 
  region STRING
);

INSERT INTO session_3_sql.brz_web_orders VALUES
  ('O1', 'U100', '2026-05-01', '500.50', 'Mobile'),
  ('O2', 'U100', '2026-05-05', '150.00', 'Mobile'),
  ('O3', 'U200', '20260510', '300.00', 'Desktop'),
  ('O4', 'U300', '2026/05/15', 'invalid', 'Desktop'),
  ('O1', 'U100', '2026-05-01', '500.50', 'Mobile');

INSERT INTO session_3_sql.dim_user_profiles VALUES 
  (100, 'North'), 
  (200, 'South'), 
  (400, 'West');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Silver Layer Cleansing & Deduplication**
-- MAGIC * **Task:**
-- MAGIC   1. Write a `SELECT` statement to clean the raw data.
-- MAGIC   2. Use `DISTINCT` to remove exact duplicates.
-- MAGIC   3. Clean the `user_ref` by removing the 'U' prefix using `regexp_replace()` and cast it to `INT` as `user_id`.
-- MAGIC   4. Parse `order_dt` using `COALESCE()` and `TRY_TO_DATE()` covering formats 'yyyy-MM-dd', 'yyyyMMdd', and 'yyyy/MM/dd' aliased as `clean_dt`.
-- MAGIC   5. Use `TRY_CAST()` to safely convert `raw_amount` to `DECIMAL(10,2)` aliased as `amount`.
-- MAGIC * **Expected Result:**
-- MAGIC | order_id | user_id | clean_dt | amount | device |
-- MAGIC |---|---|---|---|---|
-- MAGIC | O1 | 100 | 2026-05-01 | 500.50 | Mobile |
-- MAGIC | O2 | 100 | 2026-05-05 | 150.00 | Mobile |
-- MAGIC | O3 | 200 | 2026-05-10 | 300.00 | Desktop |
-- MAGIC | O4 | 300 | 2026-05-15 | null | Desktop |

-- COMMAND ----------

select distinct
  order_id,
  cast(regexp_replace(user_ref,'U',"") as Int) as user_id,
  coalesce(
    try_to_date(order_dt,'yyyy-MM-dd'),
    try_to_date(order_dt,'yyyyMMdd'),
    try_to_date(order_dt,'yyyy/MM/dd')
  ) as clean_dt,
  try_cast(raw_amount as Decimal(10,2)) as amount,
  device
from session_3_sql.brz_web_orders

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Gap Analysis (Set Operations)**
-- MAGIC * **Task:**
-- MAGIC   1. Identify registered users who have no valid, parsable financial orders in the system.
-- MAGIC   2. Select `user_id` from the user profiles dimension.
-- MAGIC   3. Use `EXCEPT` against the `user_id` from a CTE of the cleansed orders where `amount IS NOT NULL`.
-- MAGIC * **Expected Result:**
-- MAGIC | user_id |
-- MAGIC |---|
-- MAGIC | 300 |
-- MAGIC | 400 |

-- COMMAND ----------

with clean_orders as (
  select distinct
    cast(regexp_replace(user_ref,'U',"") as Int) as user_id,
    try_cast(raw_amount as Decimal(10,2)) as amount
  from session_3_sql.brz_web_orders
  where try_cast(raw_amount as Decimal(10,2)) is not null
)
select user_id from session_3_sql.dim_user_profiles
except
select user_id from clean_orders ;