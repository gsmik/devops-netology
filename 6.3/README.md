# Домашнее задание к занятию "3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

*Ответ*
* Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.\
[docker-compose.yaml](src/ansible/stck/docker-compose.yaml)
```shell
vagrant@server1:~$ docker ps -a
CONTAINER ID   IMAGE     COMMAND                  CREATED       STATUS       PORTS                                                  NAMES
7c95b42356fe   mysql:8   "docker-entrypoint.s…"   2 hours ago   Up 2 hours   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   stck_mysql_1
```
* Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.\
*Создадим БД test_db и восстановим ее*
```shell
vagrant@server1:~$ docker exec -it stck_mysql_1 bash
bash-4.4#
bash-4.4# mysql -p                 
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.32 MySQL Community Server - GPL

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database test_db;
mysql> show databases
    -> ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test_db            |
+--------------------+
5 rows in set (0.08 sec)
mysql> use test_db;
Database changed
mysql> source /bak/test_dump.sql
Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.08 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 0 rows affected (0.03 sec)

Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

Query OK, 0 rows affected (0.02 sec)

Query OK, 0 rows affected (0.01 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> 
```
* Перейдите в управляющую консоль mysql внутри контейнера.\
Используя команду \h получите список управляющих команд.
```shell
bash-4.4# mysql -p                 
Enter password: 
mysql> \h

For information about MySQL products and services, visit:
   http://www.mysql.com/
For developer information, including the MySQL Reference Manual, visit:
   http://dev.mysql.com/
To buy MySQL Enterprise support, training, or other products, visit:
   https://shop.mysql.com/

List of all MySQL commands:
Note that all text commands must be first on line and end with ';'
?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
edit      (\e) Edit command with $EDITOR.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
nopager   (\n) Disable pager, print to stdout.
notee     (\t) Don't write into outfile.
pager     (\P) Set PAGER [to_pager]. Print the query results via PAGER.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.
ssl_session_data_print Serializes the current SSL session data to stdout or file

For server side help, type 'help contents'

mysql> 
```
* Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.
```shell
mysql> status
--------------
**mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)**

Connection id:		10
Current database:	test_db
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.32 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			2 hours 14 min 47 sec

Threads: 2  Questions: 47  Slow queries: 0  Opens: 163  Flush tables: 3  Open tables: 81  Queries per second avg: 0.005
--------------
```
* Подключитесь к восстановленной БД и получите список таблиц из этой БД.\
Как видно из предыдущих ответов я уже подключен к текущей базе, но напишу команду как это сделать.
```shell
mysql> use database test_db;
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)
```
**Приведите в ответе** количество записей с price > 300.\
```shell
mysql> select count(*) from orders where price > '300'
    -> ;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.01 sec)

mysql> 

```



## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

*Ответ*
* Создайте пользователя test в БД c паролем test-pass, используя:
  - плагин авторизации mysql_native_password
  - срок истечения пароля - 180 дней 
  - количество попыток авторизации - 3 
  - максимальное количество запросов в час - 100
  - аттрибуты пользователя:
      - Фамилия "Pretty"
      - Имя "James"

```shell
mysql> create user `test` identified by 'test-pass';
Query OK, 0 rows affected (0.03 sec)
mysql> ALTER user 'test' 
    -> with max_queries_per_hour 100
    -> password expire interval 180 day
    -> failed_login_attempts 3 password_lock_time 2;
Query OK, 0 rows affected (0.02 sec)
mysql> alter user 'test' attribute '{"f-name":"James", "l-name":"Pretty"}';
Query OK, 0 rows affected (0.01 sec)

```
* Предоставьте привелегии пользователю test на операции SELECT базы test_db.
```shell
mysql> grant select on test_db.* to 'test';
Query OK, 0 rows affected (0.01 sec)
```
* Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.
```shell
mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTES;
+------------------+-----------+-----------------------------------------+
| USER             | HOST      | ATTRIBUTE                               |
+------------------+-----------+-----------------------------------------+
| root             | %         | NULL                                    |
| test             | %         | {"f-name": "James", "l-name": "Pretty"} |
| mysql.infoschema | localhost | NULL                                    |
| mysql.session    | localhost | NULL                                    |
| mysql.sys        | localhost | NULL                                    |
| root             | localhost | NULL                                    |
+------------------+-----------+-----------------------------------------+
6 rows in set (0.00 sec)

```
## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`
* Установите профилирование `SET profiling = 1`.
```shell
mysql> set profiling=1;
Query OK, 0 rows affected, 1 warning (0.00 sec)
```
* Изучите вывод профилирования команд `SHOW PROFILES;`.
```shell
mysql> show profiles;
+----------+------------+----------------+
| Query_ID | Duration   | Query          |
+----------+------------+----------------+
|        1 | 0.00004975 | show profiling |
+----------+------------+----------------+
1 row in set, 1 warning (0.00 sec)

```
* Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
```shell
mysql> SHOW TABLE STATUS;
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| Name   | Engine | Version | Row_format | Rows | Avg_row_length | Data_length | Max_data_length | Index_length | Data_free | Auto_increment | Create_time         | Update_time         | Check_time | Collation          | Checksum | Create_options | Comment |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
| orders | InnoDB |      10 | Dynamic    |    5 |           3276 |       16384 |               0 |            0 |         0 |              6 | 2023-02-22 10:35:54 | 2023-02-22 10:35:54 | NULL       | utf8mb4_0900_ai_ci |     NULL |                |         |
+--------+--------+---------+------------+------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+---------------------+------------+--------------------+----------+----------------+---------+
1 row in set (0.01 sec)

```
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`
````shell
mysql> alter table orders engine=MyISAM;
Query OK, 5 rows affected (0.08 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> alter table orders engine=InnoDB;
Query OK, 5 rows affected (0.08 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW profiles;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        4 | 0.00075325 | show status                        |
|        5 | 0.00008800 | SHOW TABLE STATUS                  |
|        6 | 0.00976800 | show status                        |
|        7 | 0.00004875 | SHOW TABLE STATUS                  |
|        8 | 0.00004650 | SHOW TABLE STATUS                  |
|        9 | 0.00005000 | SHOW TABLE STATUS                  |
|       10 | 0.00018600 | SELECT DATABASE()                  |
|       11 | 0.00135850 | show databases                     |
|       12 | 0.00107950 | show tables                        |
|       13 | 0.01886550 | SHOW TABLE STATUS                  |
|       14 | 0.00014275 | alter tables order engine = MyISAM |
|       15 | 0.00004900 | alter table order engine = MyISAM  |
|       16 | 0.00011375 | SELECT DATABASE()                  |
|       17 | 0.08821425 | alter table orders engine=MyISAM   |
|       18 | 0.09088050 | alter table orders engine=InnoDB   |
+----------+------------+------------------------------------+
15 rows in set, 1 warning (0.00 sec)
````
## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.
*Ответ*
```shell
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql
#Скорость IO важнее сохранности данных
innodb_flush_log_at_trx_commit = 1
#Нужна компрессия таблиц для экономии места на диске
innodb_file_per_table=1
#Размер буффера с незакомиченными транзакциями 1 Мб
innodb_log_buffer_size = 1M
#Буффер кеширования 30% от ОЗУ
innodb_buffer_pool_size = 307M
#Размер файла логов операций 100 Мб
innodb_log_file_size = 100M


```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
