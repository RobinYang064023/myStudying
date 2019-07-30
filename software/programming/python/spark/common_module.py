from pyspark.sql import SparkSession  

def createSparkSession():
    spark = SparkSession \
            .builder \
            .appName("Python Spark SQL basic example.") \
            .config("spark.some.config.option", "some-value") \
            .getOrCreate()
    return spark
