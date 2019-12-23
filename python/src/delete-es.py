import requests
import json
import datetime
import time
import sys

url = 'https://search-ccts-es-pdhw3ifgz4lr2rxbfgals7vkmm.cn-northwest-1.es.amazonaws.com.cn/*'
response = requests.get(url)
index_json = response.json()

# 检查日期是否符合删除标准
def checktime(timestr):
        split_time = datetime.datetime.strptime(timestr,'%Y.%m.%d')
        today = datetime.datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
        if split_time < today - datetime.timedelta(days=10):
                return 1
        else:
                return 0 

# 检查日期是否合法
def isVaildDate(date):
        try:
            if ":" in date:
                time.strptime(date, "%Y.%m.%d %H:%M:%S")
            else:
                time.strptime(date, "%Y.%m.%d")
            return True
        except:
            return False


"""

遍历json, 适用于python 2，python 3 需要index_json.items()

"""
for i,j in index_json.iteritems():
        #print(j['settings']['index']['creation_date'])
        today = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # 如果不是 xxx-xxx 形式则过滤
        if (i.find('-') == -1):
                print(today + ' Unknown index: ' + i + ', do nothing!')
                continue

        # 从json数据中获取索引的创建日期，并转化为字符串
        timeStamp = j['settings']['index']['creation_date']
        d = datetime.datetime.fromtimestamp(int(timeStamp) / 1000, None)
        timeStr = d.strftime("%Y.%m.%d")
        
        #print(timeStr)
        
        if not isVaildDate(timeStr):
                print(today + ' Unknown index: ' + i + ', invalid date and do nothing!')
                continue

        # 如果服务删除规则则删除索引
        if checktime(timeStr):
                print(today + ' begin to delete index: ' + i)
                deleteurl = 'https://search-ccts-es-pdhw3ifgz4lr2rxbfgals7vkmm.cn-northwest-1.es.amazonaws.com.cn/'+i
                print(deleteurl)
                dresponse = requests.delete(deleteurl)
                print(dresponse.text)