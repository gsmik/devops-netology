#!/usr/bin/env python3

from datetime import datetime
import socket
import time
hosts = {
    'drive.yandex.ru': '0',
    'mail.yandex.ru': '0',
    'yandex.ru': '0'}
for host in hosts:
    init_ip = socket.gethostbyname(host)
    hosts[host] = init_ip
while True:
    date = datetime.now()
    print(date)
    for host in hosts:
        oip = hosts[host]
        nip = socket.gethostbyname(host)
        if nip != oip:
            hosts[host] = nip
            print(date,
                  host + " " + "IP changed: old IP" + " " +oip , "new IP"+ " " +nip)
        print(host + " " +hosts[host])
    time.sleep(15)


