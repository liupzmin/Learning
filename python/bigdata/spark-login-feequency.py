from os.path import expanduser, join, abspath

from pyspark.sql import SparkSession
from pyspark.sql import Row
from pyspark.sql.types import *
import sys

flag = sys.argv[1]


spark = SparkSession \
    .builder \
    .appName("Python Spark SQL HDFS To MySQL - login frequency") \
    .getOrCreate()

sc = spark.sparkContext

lines = sc.textFile(
    "hdfs:/user/root/login/request/login-receive." + sys.argv[1] + ".txt")

parts = lines.map(lambda l: l.split("|"))


# Each line is converted to a tuple.
login_request = parts.map(lambda p: (
    p[6], p[8]))

schema_string = "login_ip  message_timestamp"

fields = [StructField(field_name, StringType(), True)
          for field_name in schema_string.split()]

schema = StructType(fields)

schema_request = spark.createDataFrame(login_request, schema)


schema_request.createOrReplaceTempView("t_login_request")

openday = "".join(flag.split('-'))

result = spark.sql(
    "select \"" + openday + "\" openday, substr(message_timestamp, 1, 13) hour, count(*) num from t_login_request group by openday, hour")

'''
result.write.mode("append") \
    .format("jdbc") \
    .option("url", "jdbc:mysql://127.0.0.1") \
    .option("dbtable", "bigdata.t_login_type") \
    .option("user", "big") \
    .option("password", "afis2020") \
    .save()
'''

spark.stop()
