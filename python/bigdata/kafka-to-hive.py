from confluent_kafka import Consumer, KafkaError
import logging
import traceback
import time
from pyhive import hive
import threading
from concurrent.futures import ThreadPoolExecutor, wait
import string

handler = logging.FileHandler('/tmp/kafka-to-hive.log', encoding='UTF-8')
logging_format = logging.Formatter(
    '%(asctime)s - %(levelname)s - %(filename)s - %(funcName)s - %(lineno)s - %(message)s')
logger = logging.getLogger(__name__)
handler.setFormatter(logging_format)
logger.setLevel(logging.DEBUG)
logger.addHandler(handler)


def insertIntoHive(conn, sql, msg):
    #print("topic: {}, message:{}".format(msg.topic(), msg.value()))
    args = msg.value().decode().split("|")
    #print("args: {}".format(args))
    try:
        cursor = conn.cursor()
        cursor.execute(sql, args)
    except Exception as e:
        logger.exception(traceback.format_exc())
        print(e)
    finally:
        cursor.close()


def consume(topic):
    #INSERT_T_LOGIN_REQUEST = "insert into exbxg.t_login_request values(%d,%d,%s,%s,%s,%d,%s,%s,%s)"
    #INSERT_T_LOGIN_RESPONSE = "insert into exbxg.t_login_response values(%d,%d,%s,%s,%s,%s,%d,%s,%s,%s,%s,%s,%s,%s)"

    INSERT_T_LOGIN_REQUEST = "insert into exbxg.t_login_request values(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    INSERT_T_LOGIN_RESPONSE = "insert into exbxg.t_login_response values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    try:
        conn = hive.connect(host='10.158.61.170', port=10000)

        c = Consumer({
            'bootstrap.servers': '10.158.61.170:9092,10.158.61.171:9092,10.158.61.90:9092,10.158.61.95:9092',
            'group.id': 'python-to-hive',
            'auto.offset.reset': 'latest'
        })
        c.subscribe([topic])

        while True:
            msg = c.poll(1.0)

            if msg is None:
                continue
            if msg.error():
                logger.info("Consumer error: {}".format(msg.error()))
                continue

            if msg.topic() == "login-receive":
                insertIntoHive(conn, INSERT_T_LOGIN_REQUEST, msg)
                #print("topic login-receive")
            elif msg.topic() == "login-response":
                insertIntoHive(conn, INSERT_T_LOGIN_RESPONSE, msg)
                #print("topic login-response")

                # time.sleep(1)

    except Exception as e:
        logger.exception(traceback.format_exc())
        print(e)
    finally:
        c.close()


executor = ThreadPoolExecutor(4)
fs = []
for i, v in enumerate(['login-receive', 'login-response']):
    fs.append(executor.submit(consume, v))

wait(fs)

executor.shutdown()
