from os.path import expanduser, join, abspath

from pyspark.sql import SparkSession
from pyspark.sql import Row
from pyspark.sql.types import *
import sys


flag = sys.argv[1]

if not flag:
    print("no enough args!")
    sys.exit()

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL HDFS To MySQL") \
    .getOrCreate()


sc = spark.sparkContext

lines = sc.textFile(
    "hdfs:/user/root/login/response/login-response." + sys.argv[1] + ".txt")

print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$login_lines: {}".format(lines.count()))

lines.collect()


parts = lines.map(lambda l: l.split("|"))


# Each line is converted to a tuple.
login_response = parts.map(lambda p: (
    p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12], p[13]))


schemaString = "sequence message_type member_id operator_id receive_time response_time response_code message_operator_id gateway_ip gateway_port open_day last_open_day message_from message_timestamp"

fields = [StructField(field_name, StringType(), True)
          for field_name in schemaString.split()]

schema = StructType(fields)

schemaResponse = spark.createDataFrame(login_response, schema)


schemaResponse.createOrReplaceTempView("t_login_response")


result = spark.sql("select count(*) num,max(open_day) openday,avg(response_time - receive_time) avg_interval,min(response_time - receive_time) min_interval, max(response_time - receive_time) max_interval, min(message_timestamp) early_login, max(message_timestamp) last_login from t_login_response").rdd.collect()

for row in result:
    openday = row.openday
    login_times = row.num
    login_avg_latency = round(row.avg_interval, 2)
    login_min_latency = round(row.min_interval, 2)
    login_max_latency = round(row.max_interval, 2)
    earliest_login = row.early_login
    last_login = row.last_login

login_number = spark.sql(
    "select distinct member_id from t_login_response").rdd.count()

login_success_times = spark.sql(
    "select sequence from t_login_response where response_code = 0").rdd.count()

login_fail_times = spark.sql(
    "select sequence from t_login_response where response_code != 0").rdd.count()


verfiy_lines = sc.textFile(
    "hdfs:/user/root/verify/response/verify-response." + sys.argv[1] + ".txt")

print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$verfiy_lines: {}".format(verfiy_lines.count()))

verify_parts = verfiy_lines.map(lambda l: l.split("|"))

verify_response = verify_parts.map(lambda p: (
    p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11]))

verify_schema_string = "sequence message_type operator_id receive_time response_time response_code message_operator_id member_id member_name order_type message_from message_timestamp"

verify_fields = [StructField(field_name, StringType(), True)
                 for field_name in verify_schema_string.split()]

verify_schema = StructType(verify_fields)

verify_schema_response = spark.createDataFrame(verify_response, verify_schema)

verify_schema_response.createOrReplaceTempView("t_verify_response")

result = spark.sql("select avg(response_time - receive_time) avg_interval,min(response_time - receive_time) min_interval, max(response_time - receive_time) max_interval from t_verify_response").rdd.collect()

for row in result:
    verify_avg_latency = round(row.avg_interval, 2)
    verify_min_latency = round(row.min_interval, 2)
    verify_max_latency = round(row.max_interval, 2)

verify_number = spark.sql(
    "select distinct member_id from t_verify_response where response_code = 0").rdd.count()
verify_sucess_times = spark.sql(
    "select sequence from t_verify_response where response_code = 0").rdd.count()
verify_fail_times = spark.sql(
    "select sequence from t_verify_response where response_code != 0").rdd.count()


data = [(openday, login_times, login_number, login_avg_latency, login_min_latency, login_max_latency, login_success_times, login_fail_times,
         earliest_login, last_login, verify_number, verify_avg_latency, verify_min_latency, verify_max_latency, verify_sucess_times, verify_fail_times)]

df = spark.createDataFrame(data, schema=['openday', 'login_times', 'login_number', 'login_avg_latency', 'login_min_latency', 'login_max_latency', 'login_success_times',
                                         'login_fail_times', 'earliest_login', 'last_login', 'verify_number', 'verify_avg_latency', 'verify_min_latency', 'verify_max_latency', 'verify_sucess_times', 'verify_fail_times'])


df.write.mode("append") \
    .format("jdbc") \
    .option("url", "jdbc:mysql://127.0.0.1") \
    .option("dbtable", "bigdata.t_login_base_info") \
    .option("user", "big") \
    .option("password", "afis2020") \
    .save()

#print("args: {} {} {} {} {} {} {} {} {} {} {} {} {} {} {} {}".format(openday, login_times, login_number, login_avg_latency, login_min_latency, login_max_latency, login_success_times, login_fail_times, earliest_login, last_login, verify_number, verify_avg_latency, verify_min_latency, verify_max_latency, verify_sucess_times, verify_fail_times))

spark.stop()
