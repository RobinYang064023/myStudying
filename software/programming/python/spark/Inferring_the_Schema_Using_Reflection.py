import common_module  
from pyspark import SparkContext
from pyspark.sql import Row


spark = common_module.createSparkSession()


sc = spark.sparkContext
lines = sc.textFile("sample.txt")
parts = lines.map(lambda l: l.split(","))
print (type(parts))
print ("=====")
print (parts)
print ("=====")
ip_rule = parts.map(lambda p: Row(ip=p[1], rule=p[4]))
schemaIp_Rule = spark.createDataFrame(ip_rule)
schemaIp_Rule.createOrReplaceTempView("ip_and_rule")

schemaIp_Rule.show()
