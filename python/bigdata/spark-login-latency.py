from os.path import expanduser, join, abspath

from pyspark.sql import SparkSession
from pyspark.sql import Row
from pyspark.sql.types import *
import sys

flag = sys.argv[1]


spark = SparkSession \
    .builder \
    .appName("Python Spark SQL HDFS To MySQL - login latency") \
    .getOrCreate()

sc = spark.sparkContext

lines = sc.textFile(
    "hdfs:/user/root/login/request/login-response." + sys.argv[1] + ".txt")

parts = lines.map(lambda l: l.split("|"))


# Each line is converted to a tuple.
login_request = parts.map(lambda p: (
    p[2], p[3], p[4], p[5], p[13]))

schema_string = "member_id operator_id receive_time response_time message_timestamp"

fields = [StructField(field_name, StringType(), True)
          for field_name in schema_string.split()]

schema = StructType(fields)

schema_request = spark.createDataFrame(login_request, schema)


schema_request.createOrReplaceTempView("t_login_reponse")

openday = "".join(flag.split('-'))

result = spark.sql(
    "select \"" + openday + "\" openday, member_id, operator_id, (response_time - receive_time) latency, message_timestamp from t_login_reponse")

'''
result.write.mode("append") \
    .format("jdbc") \
    .option("url", "jdbc:mysql://127.0.0.1") \
    .option("dbtable", "bigdata.t_login_type") \
    .option("user", "big") \
    .option("password", "afis2020") \
    .save()
'''
result.show(1000)
spark.stop()
