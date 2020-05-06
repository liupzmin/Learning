from confluent_kafka import Consumer, KafkaError
import logging
import traceback
import time
from pyhive import hive
import threading
from concurrent.futures import ThreadPoolExecutor, wait
import string

logdir = "/tmp"
filedir = "/home/liupeng/logindata"

handler = logging.FileHandler(logdir + '/kafka-to-file.log', encoding='UTF-8')
logging_format = logging.Formatter(
    '%(asctime)s - %(levelname)s - %(filename)s - %(funcName)s - %(lineno)s - %(message)s')
logger = logging.getLogger(__name__)
handler.setFormatter(logging_format)
logger.setLevel(logging.DEBUG)
logger.addHandler(handler)


def writeToFile(topic, msg):
    # print("topic: {}, message:{}".format(msg.topic(), msg.value()))
    cols = msg.value().decode().split("|")
    filedate = cols[-1].split()[0]
    # print("mesage date: {}".format(filedate))
    sequence = (topic, filedate, "txt")
    filename = ".".join(sequence)
    try:
        with open(filedir + '/' + filename, "a") as myfile:
            myfile.write(msg.value().decode())
            myfile.write("\n")
    except Exception as e:
        logger.exception(traceback.format_exc())
        print(e)


def consume(topic):

    try:

        c = Consumer({
            'bootstrap.servers': '10.158.61.170:9092,10.158.61.171:9092,10.158.61.90:9092,10.158.61.95:9092',
            'group.id': 'python-to-file',
            'auto.offset.reset': 'earliest'
        })
        c.subscribe([topic])

        while True:
            msg = c.poll(1.0)

            if msg is None:
                continue
            if msg.error():
                logger.info("Consumer error: {}".format(msg.error()))
                continue

            writeToFile(topic, msg)

    except Exception as e:
        logger.exception(traceback.format_exc())
        print(e)
    finally:
        c.close()


executor = ThreadPoolExecutor(4)
fs = []
for i, v in enumerate(['login-receive', 'login-response', 'verify-receive', 'verify-response']):
    fs.append(executor.submit(consume, v))

wait(fs)

executor.shutdown()
