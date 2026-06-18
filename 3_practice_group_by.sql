-- Databricks notebook source
-- MAGIC %run ./_init_database

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### task_1 group by with different aggregation style
-- MAGIC   - 1.0 group by and count
-- MAGIC   - 1.1 group by and select min values
-- MAGIC   - 1.2 group by and select max valuse

-- COMMAND ----------

select * from session_2_sql.sample_dataset

-- COMMAND ----------

-- DBTITLE 1,group by
select id , count(comment) as count_comment ,max(amount) as max_amount , min(amount) as min_amount
from session_2_sql.sample_dataset 
where comment = 'good' 
group by id

-- COMMAND ----------

alter table session_2_sql.sample_dataset  add column amount int after id_2

-- COMMAND ----------

truncate table session_2_sql.sample_dataset

-- COMMAND ----------

-- DBTITLE 1,Fix syntax error in insert statement
insert into table session_2_sql.sample_dataset values
(1, 1, 300, 'good', 'better', '2026-03-24', true),
(2, 1, 800, 'bad', null, '2026-03-24', true),
(3, 1, 5000, 'good', null, '2026-03-24', null),
(4, 1, 3200, '', null, '2026-03-24', false)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### task_2 use having after group by to filter unncessery records
-- MAGIC   - 1.0 having if count > 1

-- COMMAND ----------

-- DBTITLE 1,group by with having
select id , count(comment) as count_comment ,max(amount) as max_amount , min(amount) as min_amount
from session_2_sql.sample_dataset 
where comment = 'good' 
group by id having count(comment) > 1