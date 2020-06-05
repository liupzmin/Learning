import websocket
import requests
import json
import db
import time
from pprint import pprint
try:
    import thread
except ImportError:
    import _thread as thread
import time

dbconfig = {"host": "127.0.0.1", "port": 3306,
            "user": "big", "password": "afis2020", "database": "bigdata"}

mysql_pool = db.MySQLPool(**dbconfig)

sqlstr = "insert into  t_market_maker_check (open_day, contract_id, sell_price, sell_qtt, buy_price, buy_qtt, qtime, min_diff_price, is_fit) values (%s, %s, %s, %s, %s, %s, %s, %s, %s)"


def get_min_diff_price():
    req = requests.get('http://127.0.0.1:8088/contracts')

    if req.status_code != 200:
        print("call contracts api failed, error code {} ".format(req.status_code))
        return None

    ct = req.json()

    if ct['code'] != 0:
        print('request contracts error: {} \n'.format(ct['code']))
        return None

    return {c['contractId']: c['minDiffPrice'] for c in ct['data']}


min_diff_price = get_min_diff_price()


def is_fit(contractId, buyOne, sellOne):

    diff = sellOne['price'] - buyOne['price']

    if buyOne['qtt'] > 10 and sellOne['qtt'] > 10 and diff < 2 * min_diff_price[contractId]:
        return 1
    else:
        return 0


def on_message(ws, message):
    openday = time.strftime("%Y%m%d", time.localtime())
    message = json.loads(message)
    if 'data' not in message:
        return None
    for q in message['data']:
        sorted_buy = sorted(
            q['buyTicks'], key=lambda i: i['price'], reverse=True)
        sorted_sell = sorted(
            q['sellTicks'], key=lambda i: i['price'], reverse=False)

        result = is_fit(q['contractId'], sorted_buy[0], sorted_sell[0])

        data = (openday, q['contractId'], sorted_sell[0]['price'],
                sorted_sell[0]['qtt'], sorted_buy[0]['price'], sorted_buy[0]['qtt'], q['time'], min_diff_price[q['contractId']], result)

        print("quotation data: {} \n".format(data))

        re = mysql_pool.execute(sqlstr, data, True)

        if re['status'] != 1:
            print("insert failed : {}\n".format(data))


def on_error(ws, error):
    print(error)


def on_close(ws):
    print("### closed ###")


def on_open(ws):
    ws.send('{cmd: "sub", args: ["quotation.*"]}')


if __name__ == "__main__":
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("ws://127.0.0.1:8098/ws/quotation",
                                on_message=on_message,
                                on_error=on_error,
                                on_close=on_close)
    ws.on_open = on_open
    ws.run_forever()
