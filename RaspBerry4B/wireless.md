## 1. Install ArchLinuxarm

[Raspberry Pi 4](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4)

## 2. update mirrorlist

> Server = https://mirrors.ustc.edu.cn/archlinuxarm/$arch/$repo

## check endian

```c
#include <sys/utsname.h>
#include <unistd.h>
#include <stdio.h>
 
int main()
{
	union
	{
		short	inum;
		char c[sizeof(short)];
	} un;
	struct utsname	uts;
	un.inum=0x0102;
	if(uname(&uts)<0)
	{
		printf("Could not get host information .\n");
		return -1;
	}
	printf("%s -%s-%s:\n",uts.machine, uts.sysname, uts.release);
	if(sizeof(short)!=2)
	{
		printf("sizeof short =%d\n", sizeof(short));
		return 0;
	}
	if(un.c[0]==1 && un.c[1]==2)
		printf("big_endian.\n");
	else if(un.c[0]==2 && un.c[1]==1)
		printf("little_endian.\n");
	else
		printf("unknown .\n");
	return 0;
}

```

## Wireless network configuration

references: [Wireless network configuration](https://wiki.archlinux.org/index.php/Wireless_network_configuration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

1.  使用wifi-menu连接，自动生成netctl conf

2.  systemctl start netctl-auto@wlan0.service

3.  systemctl enable netctl-auto@wlan0.service（重启自动连接）

## 自动发送ip

**server:**

```python

import socket,time

address = ('192.168.1.183', 31500)
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(address)

while True:
    print('waiting for message ...')
    data,addr = s.recvfrom(1024)
    response = '[%s]: %s' % (time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()), data.decode('utf-8'))
    #s.sendto(response.encode('utf-8'),addr)
    print(response)

s.close()
```

**client:**

```python
import time
from socket import *

HOST = '192.168.1.183'
PORT = 31500
BUFSIZ = 1024
ADDR = (HOST,PORT)

udpCliSock = socket(AF_INET,SOCK_DGRAM)

while True:
    
    data = gethostbyname(gethostname())
    udpCliSock.sendto(data.encode('utf-8'),ADDR)
    time.sleep(1)

udpCliSock.close()
```

## set timer

1. check timer

```shell
systemctl list-timers
```

2. create service

```
vim /etc/systemd/system/sendip.service

[Unit]
Description=test job

[Service]
Type=oneshot
ExecStart=/usr/bin/python /root/udpclient.py
```

3. create timer

```
vim /etc/systemd/system/sendip.timer  

[Unit]
Description=sendip

[Timer]
OnUnitActiveSec=10s
OnBootSec=10s

[Install]
WantedBy=timers.target
```
4. systemctl start|enable mytimer.timer

 详见：[Systemd 定时器教程](http://www.ruanyifeng.com/blog/2018/03/systemd-timer.html)