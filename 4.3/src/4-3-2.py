#!/usr/bin/env python3
import json
import yaml
import socket
import time
import datetime

hosts = {
    'drive.yandex.ru': '0',
    'mail.yandex.ru': '0',
    'yandex.ru': '0'}
for host in hosts:
    init_ip = socket.gethostbyname(host)
    hosts[host] = init_ip

def json_yaml_w(y):
    with open('hosts.json', 'w') as jtmp:
        jtmp.write(str(json.dumps(y)))
    with open('hosts.yaml', 'w') as ytmp:
        ytmp.write(yaml.dump(y))
    return

while True:
    date = datetime.datetime.now()
    df = date.strftime('%Y%M%d_%H:%M:%S')
    print ("-")
    #print(df)
    for host in hosts:
        oip = hosts[host]
        nip = socket.gethostbyname(host)
        if nip != oip:
            hosts[host] = nip
            print(df + " - " + host + " " + "IP changed: old IP" + " " +oip , "new IP"+ " " +nip)
        print(df + " - "+host + " " +hosts[host])
        json_yaml_w(hosts)
    time.sleep(15)


