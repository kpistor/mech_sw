// Databricks notebook source exported at Tue, 21 Jul 2015 17:35:35 UTC
// MAGIC %md
// MAGIC # Run Selected Statements on Every Machine

// COMMAND ----------

def runEverywhere(command : String, ctx: SparkContext) = {
  val parts = ctx.defaultParallelism/2
  ctx.parallelize(1 to parts, parts).mapPartitions { iter =>

  import sys.process._

  val out = new StringBuilder
  val err = new StringBuilder

  val logger = ProcessLogger(
      (o: String) => out.append(o).append("\n"),
      (e: String) => err.append(e).append("\n"))

  val ret = command ! logger
  Seq((ret, out, err)).iterator
  
}.collect()
}

// COMMAND ----------

runEverywhere("/home/ubuntu/databricks/python/bin/pip install nltk",sc)

// COMMAND ----------

runEverywhere("/home/ubuntu/databricks/python/bin/python -m nltk.downloader all", sc)

// COMMAND ----------

