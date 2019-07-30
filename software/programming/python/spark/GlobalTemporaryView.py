import common_module


spark = common_module.createSparkSession()
df = spark.read.load("test.csv", format = "csv")


df.createGlobalTempView("test2")
spark.sql("SELECT * FROM global_temp.test2").show()
spark.newSession().sql("SELECT * FROM global_temp.test2").show()
