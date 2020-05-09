from os.path import expanduser, join, abspath

from pyspark.sql import SparkSession
from pyspark.sql import Row
from pyspark.sql.types import *
import sys

flag = sys.argv[1]


spark = SparkSession \
    .builder \
    .appName("Python Spark SQL HDFS To MySQL - login type") \
    .getOrCreate()

sc = spark.sparkContext

lines = sc.textFile(
    "hdfs:/user/root/login/request/login-receive." + sys.argv[1] + ".txt")

parts = lines.map(lambda l: l.split("|"))


# Each line is converted to a tuple.
login_request = parts.map(lambda p: (
    p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]))

schema_string = "sequence message_type login_name password client_version login_type login_ip  message_from message_timestamp"

fields = [StructField(field_name, StringType(), True)
          for field_name in schema_string.split()]

schema = StructType(fields)

schema_request = spark.createDataFrame(login_request, schema)


schema_request.createOrReplaceTempView("t_login_request")

openday = "".join(flag.split('-'))

result = spark.sql(
    "select \"" + openday + "\" openday, login_type, count(*) num from t_login_request group by login_type")


result.write.mode("append") \
    .format("jdbc") \
    .option("url", "jdbc:mysql://127.0.0.1") \
    .option("dbtable", "bigdata.t_login_type") \
    .option("user", "big") \
    .option("password", "afis2020") \
    .save()

spark.stop()
