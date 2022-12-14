# Домашнее задание к занятию "3.7. Компьютерные сети.Лекция 2"

### Цель задания

В результате выполнения этого задания вы:

1. Познакомитесь с инструментами настройки сети в Linux, агрегации нескольких сетевых интерфейсов, отладки их работы.
2. Примените знания о сетевых адресах на практике для проектирования сети.


### Инструкция к заданию

1. Создайте .md-файл для ответов на задания в своём репозитории, после выполнения прикрепите ссылку на него в личном кабинете.
2. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.


### Инструменты/ дополнительные материалы, которые пригодятся для выполнения задания

1. [Калькулятор сетей online](https://calculator.net/ip-subnet-calculator.html).
2. Калькулятор сетей программа - ipcalc (`apt install ipcalc`), если есть графический интерфейс, то у программы калькулятора есть инженерный режим, там можно и сети считать.


------

## Задание

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?
 * *Linux* `ip a`, `ip link show`, `ifconfig`
 * *Windows*  
   * `cmd` `ipconfig /all`, 
   * `powershell` , `get-netipaddress`
2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?
* Общее название такого протокола NDP (neighbor discovery protocol). У некоторых вендеров есть свой проприетарный протокол
  * Cisco - CDR
  * Mikrotik  - MNDP
  * LLDP - Linux 
* В Linux используется пакет `lldpd`, команды для управления `lldpctl` или `lldpcli`
   
3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.
* Для разделения L2 коммутатора на несколько виртуальных сетей используется техноглогия `VLAN`(Virtual Local Area Network)
* Пакет для управления `VLAN` в `Linux` 
  * `IPRoute2`
  * `vlan`
  * `NetworkManager`
  * Пример `netplan`
  ```bash
  network:
    version: 2
    renderer: networkd
    ethernets:
        ens3: {}
    vlans: 
        vlan5:
            id: 5
            link: ens3
            dhcp4: no
            addresses: [10.0.0.15/24]
            gateway: 10.0.0.1
  ```
4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
* Bonding\
`vagrant@vagrant:~$ modinfo bonding | grep mode:
parm:           mode:Mode of operation; 0 for balance-rr, 1 for active-backup, 2 for balance-xor, 3 for broadcast, 4 for 802.3ad, 5 for balance-tlb, 6 for balance-alb (charp)`
* Team - крайне мало информации\
Для балансировки можно использовать 
  * mode: 0 for balance-rr
  * mode: 2 for balance-xor
  * mode: 5 for balance-tlb
  * mode: 6 for balance-alb (charp)
* Пример конфига LACP
  * /etc/netplan/50-cloud-init.yaml
  ```bash
  network:
      ethernets:
          enp3s0:
              addresses:
              - 192.168.1.57/24
              gateway4: 192.168.1.1
              nameservers:
                  addresses:
                  - 8.8.8.8
                  - 8.8.4.4
                  search: []
              optional: true
          enp5s0:
              addresses:
              - 192.168.1.58/24
              gateway4: 192.168.1.1
              nameservers:
                  addresses:
                  - 8.8.8.8
                  - 8.8.4.4
                  search: []
              optional: true
      version: 2
  ```
  * nano /etc/netplan/bond0.yaml
  ```bash
  network:
     bonds:
       bond0:
        addresses: [192.168.1.59/24]
        gateway4: 192.168.1.1
        nameservers:
          addresses: [8.8.8.8,8.8.4.4]
        interfaces: [enp3s0, enp5s0]
  ```
5. Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.
*  IP адресов 8 (1 IP-адрес сети, 6 ip адресов для хостов, 1 IP broadcast)
*  32 подсети можно получить из сети с маской /24
*  Примеры подсетей /29 
   - 10.10.10.0/29 (10.10.0.0-10.10.0.7)
     - где 10.10.10.0 - адрес сети, а 10.10.10.7 - broadcast-адрес
   - 10.10.0.8.29 (10.10.10.8-10.10.10.15)
     - где 10.10.10.8 - адрес сети, а 10.10.10.15 - broadcast-адрес\
  и т.д.

6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.
* Т.к. существует всего 4 диапазона, которые определены как диапазоны для использования в локальных сетях и 3 из них заняты, нам остался диапазон 100.64.0.0 — 100.127.255.255 с маской /10
* 10.64.0.0/26 - на 64 адреса
7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP? 
* Windows
  * Показать ARP-таблицу: `arp -a` или `arp -g` или `arp -a -v`
  * Очистить кэш весь: `arp -d *`
  * Удалить только один IP: `arp -d <ip адрес>`
* Linux
  * Показать ARP-таблицу: `ip n`
  * Очистить кэш весь: `ip n flush all`
  * Удалить только один IP:  `ip neigh del dev <интерфейc> <IP адрес>`

*В качестве решения ответьте на вопросы и опишите, каким образом эти ответы были получены*

---

## Задание для самостоятельной отработки* (необязательно к выполнению)

 8. Установите эмулятор EVE-ng.
 
 [Инструкция по установке](https://github.com/svmyasnikov/eve-ng)

 Выполните задания на lldp, vlan, bonding в эмуляторе EVE-ng. 
 
----

### Правила приема домашнего задания

В личном кабинете отправлена ссылка на .md файл в вашем репозитории.


### Критерии оценки

Зачет - выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики.

На доработку - задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки. 
 
Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.
Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.
