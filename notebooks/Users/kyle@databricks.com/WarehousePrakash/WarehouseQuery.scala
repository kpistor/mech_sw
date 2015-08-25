// Databricks notebook source exported at Tue, 25 Aug 2015 23:44:56 UTC
// MAGIC %sql select count(*) from warehouse_lot_of_partitions

// COMMAND ----------

// MAGIC %sql select count(*) from warehouse_lot_of_partitions where year=2014 and month=1 and day=1

// COMMAND ----------

// MAGIC %md After consolidating partitions

// COMMAND ----------

// MAGIC %sql select count(*) from parquet_warehouse

// COMMAND ----------

// MAGIC %sql select count(*) from parquet_warehouse where year=2014 and month=1 and day=1

// COMMAND ----------

