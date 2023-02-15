Домашнее задание к занятию "2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

```yaml
version: '3.7'
services:
  postgres:
    image: postgres:12
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
    volumes:
      - ./data:/var/lib/postgresql/data
      - ./bak:/bak
    restart: always
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

*Ответ*
- создайте пользователя test-admin-user и БД test_db
```shell
postgres=# CREATE USER "test-admin-user" WITH LOGIN;
CREATE ROLE
postgres=# CREATE DATABASE test_db;
CREATE DATABASE
postgres=# \l+
                                                                   List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |                Description                 
-----------+----------+----------+------------+------------+-----------------------+---------+------------+--------------------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7969 kB | pg_default | default administrative connection database
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | unmodifiable empty database
           |          |          |            |            | postgres=CTc/postgres |         |            | 
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | default template for new databases
           |          |          |            |            | postgres=CTc/postgres |         |            | 
 test_db   | pCRostgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres         +| 7969 kB | pg_default | 
           |          |          |            |            | postgres=CTc/postgres |         |            | 
(4 rows)
```
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
```shell
postgres=# \c test_db 
You are now connected to database "test_db" as user "postgres".
test_db=# CREATE TABLE orders (id serial PRIMARY KEY, "наименование" TEXT, "цена" INT);
CREATE TABLE
test_db=# CREATE TABLE clients (id serial PRIMARY KEY, "фамилия" TEXT, "страна проживания" TEXT, "заказ" INT REFERENCES orders (id));
CREATE TABLE
test_db=# CREATE INDEX clients_country_idx ON clients("страна проживания"); 
CREATE INDEX
```
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```shell
test_db=# grant ALL ON TABLE clients, orders TO "test-admin-user";
GRANT

```
- создайте пользователя test-simple-user
```shell
postgres=# CREATE USER "test-simple-user" WITH LOGIN;
postgres=#\c test_db


```
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```shell
test_db=# grant SELECT,INSERT,UPDATE,DELETE ON TABLE clients,orders TO "test-simple-user";
GRANT
```

Приведите:
- итоговый список БД после выполнения пунктов выше,
```shell
test_db=# \l+
                                                                   List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   |  Size   | Tablespace |                Description                 
-----------+----------+----------+------------+------------+-----------------------+---------+------------+--------------------------------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |                       | 7969 kB | pg_default | default administrative connection database
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | unmodifiable empty database
           |          |          |            |            | postgres=CTc/postgres |         |            | 
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +| 7825 kB | pg_default | default template for new databases
           |          |          |            |            | postgres=CTc/postgres |         |            | 
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres         +| 8121 kB | pg_default | 
           |          |          |            |            | postgres=CTc/postgres |         |            | 
(4 rows)

```
- описание таблиц (describe)
```shell
test_db=# \d+ orders
                                                   Table "public.orders"
    Column    |  Type   | Collation | Nullable |              Default               | Storage  | Stats target | Description 
--------------+---------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
 наименование | text    |           |          |                                    | extended |              | 
 цена         | integer |           |          |                                    | plain    |              | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap
test_db=# \d+ clients
                                                      Table "public.clients"
      Column       |  Type   | Collation | Nullable |               Default               | Storage  | Stats target | Description 
-------------------+---------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
 фамилия           | text    |           |          |                                     | extended |              | 
 страна проживания | text    |           |          |                                     | extended |              | 
 заказ             | integer |           |          |                                     | plain    |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_country_idx" btree ("страна проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```shell
SELECT 
    grantee, table_name, privilege_type 
FROM 
    information_schema.table_privileges 
WHERE 
    grantee in ('test-admin-user','test-simple-user')
    and table_name in ('clients','orders');
     grantee      | table_name | privilege_type 
------------------+------------+----------------
 test-admin-user  | orders     | INSERT
 test-admin-user  | orders     | SELECT
 test-admin-user  | orders     | UPDATE
 test-admin-user  | orders     | DELETE
 test-admin-user  | orders     | TRUNCATE
 test-admin-user  | orders     | REFERENCES
 test-admin-user  | orders     | TRIGGER
 test-simple-user | orders     | INSERT
 test-simple-user | orders     | SELECT
 test-simple-user | orders     | UPDATE
 test-simple-user | orders     | DELETE
 test-admin-user  | clients    | INSERT
 test-admin-user  | clients    | SELECT
 test-admin-user  | clients    | UPDATE
 test-admin-user  | clients    | DELETE
 test-admin-user  | clients    | TRUNCATE
 test-admin-user  | clients    | REFERENCES
 test-admin-user  | clients    | TRIGGER
 test-simple-user | clients    | INSERT
 test-simple-user | clients    | SELECT
 test-simple-user | clients    | UPDATE
 test-simple-user | clients    | DELETE

```
- список пользователей с правами над таблицами test_db
```shell
test_db=# \dp+
                                           Access privileges
 Schema |      Name      |   Type   |         Access privileges          | Column privileges | Policies 
--------+----------------+----------+------------------------------------+-------------------+----------
 public | clients        | table    | postgres=arwdDxt/postgres         +|                   | 
        |                |          | "test-admin-user"=arwdDxt/postgres+|                   | 
        |                |          | "test-simple-user"=arwd/postgres   |                   | 
 public | clients_id_seq | sequence |                                    |                   | 
 public | orders         | table    | postgres=arwdDxt/postgres         +|                   | 
        |                |          | "test-admin-user"=arwdDxt/postgres+|                   | 
        |                |          | "test-simple-user"=arwd/postgres   |                   | 
 public | orders_id_seq  | sequence |                                    |                   | 
(4 rows)

```
## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|
*Ответ*
```shell
test_db=# insert into orders ("наименование", "цена") values ('Шоколад', '10'), ('Принтер', '3000'), ('Книга', '500'), ('Монитор', '7000'), ('Гитара', '4000');
INSERT 0 5
```
Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|
*Ответ*
```shell
test_db=# INSERT INTO clients ("фамилия", "страна проживания") VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');
INSERT 0 5
```
Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.
```shell
test_db=# SELECT 'clients' AS table,  COUNT(*) AS rows  FROM clients
union all
SELECT 'orders' AS table,  COUNT(*) AS rows  FROM orders;
  table  | rows 
---------+------
 clients |    5
 orders  |    5

```

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

*Ответ*
```shell
test_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга') WHERE "фамилия"='Иванов Иван Иванович';
UPDATE 1
test_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор') WHERE "фамилия"='Петров Петр Петрович';
UPDATE 1
test_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара') WHERE "фамилия"='Иоганн Себастьян Бах';
UPDATE 1
test_db=# select * from clients where "заказ" is not null;                                                                         
 id |       фамилия        | страна проживания | заказ 
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)

```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
*Ответ*
```shell
test_db=# explain select * from clients where "заказ" is not null;
                        QUERY PLAN                         
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("заказ" IS NOT NULL)
(2 rows)

```
* Таблица clients прочитана последовательно
* Последовательность сканирования в clients
  * Стоимости(от..до) `0.00..18.10`
  * Кол-во строк (примерное) `806`
  * Средняя длина строки (байты) `72`
* Примененный фильтр `("заказ" IS NOT NULL)`
## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 
```shell
vagrant@server1:/usr/stck$ sudo docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED       STATUS          PORTS                                       NAMES
6b40deff4381   postgres:12   "docker-entrypoint.s…"   4 hours ago   Up 11 minutes   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   stck_postgres_1
vagrant@server1:/usr/stck$ docker exec -it stck_postgres_1 bash
root@6b40deff4381:/# pg_dump -U postgres -F t test_db > /bak/test_db.tar
root@6b40deff4381:/# ls /bak
test_db.tar
vagrant@server1:/usr/stck$ docker stop stck_postgres_1
stck_postgres_1
vagrant@server1:/usr/stck$ docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED       STATUS                     PORTS     NAMES
6b40deff4381   postgres:12   "docker-entrypoint.s…"   4 hours ago   Exited (0) 6 seconds ago             stck_postgres_1
vagrant@server1:/usr/stck$ cp docker-compose.yaml docker-compose-2.yaml
vagrant@server1:/usr/stck$ nano docker-compose-2.yaml
 version: '3.7'
 services:
   postgresql:
     image: postgres:12
     ports:
       - "5432:5432"
     environment:
       - POSTGRES_PASSWORD=postgres
       - POSTGRES_USER=postgres
     volumes:
       - ./data2:/var/lib/postgresql/data
       - ./bak:/bak
     restart: always
Ctrl+x >> y >> Enter
vagrant@server1:/usr/stck$ docker-compose -f docker-compose-2.yaml up -d
vagrant@server1:/usr/stck$ docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                     PORTS                                       NAMES
adec286fe6a8   postgres:12   "docker-entrypoint.s…"   13 seconds ago   Up 11 seconds              0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   stck_postgresql_1
6b40deff4381   postgres:12   "docker-entrypoint.s…"   4 hours ago      Exited (0) 4 minutes ago                                               stck_postgres_1
docker exec -it stck_postgresql_1 bash
root@adec286fe6a8:/# ls /bak/
test_db.tar
root@adec286fe6a8:/# psql -U postgres
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \q
root@adec286fe6a8:/# pg_restore -U postgres --verbose -Ft -C -d postgres /bak/test_db.tar 
pg_restore: connecting to database for restore
pg_restore: creating DATABASE "test_db"
pg_restore: connecting to new database "test_db"
pg_restore: creating TABLE "public.clients"
pg_restore: creating SEQUENCE "public.clients_id_seq"
pg_restore: creating SEQUENCE OWNED BY "public.clients_id_seq"
pg_restore: creating TABLE "public.orders"
pg_restore: creating SEQUENCE "public.orders_id_seq"
pg_restore: creating SEQUENCE OWNED BY "public.orders_id_seq"
pg_restore: creating DEFAULT "public.clients id"
pg_restore: creating DEFAULT "public.orders id"
pg_restore: processing data for table "public.clients"
pg_restore: processing data for table "public.orders"
pg_restore: executing SEQUENCE SET clients_id_seq
pg_restore: executing SEQUENCE SET orders_id_seq
pg_restore: creating CONSTRAINT "public.clients clients_pkey"
pg_restore: creating CONSTRAINT "public.orders orders_pkey"
pg_restore: creating INDEX "public.clients_country_idx"
pg_restore: creating FK CONSTRAINT "public.clients clients_заказ_fkey"
pg_restore: creating ACL "public.TABLE clients"
pg_restore: while PROCESSING TOC:
pg_restore: from TOC entry 2979; 0 0 ACL TABLE clients postgres
pg_restore: error: could not execute query: ERROR:  role "test-admin-user" does not exist
Command was: GRANT ALL ON TABLE public.clients TO "test-admin-user";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.clients TO "test-simple-user";


pg_restore: creating ACL "public.TABLE orders"
pg_restore: from TOC entry 2981; 0 0 ACL TABLE orders postgres
pg_restore: error: could not execute query: ERROR:  role "test-admin-user" does not exist
Command was: GRANT ALL ON TABLE public.orders TO "test-admin-user";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO "test-simple-user";


pg_restore: warning: errors ignored on restore: 2
root@adec286fe6a8:/# psql -U postgres
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

postgres=# /l+
postgres-# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)
postgres=# CREATE USER "test-simple-user" WITH LOGIN;
postgres=# CREATE USER "test-admin-user" WITH LOGIN;
postgres=# \c test_db
test_db=# grant SELECT,INSERT,UPDATE,DELETE ON TABLE clients,orders TO "test-simple-user";
GRANT
test_db=# grant ALL ON TABLE clients, orders TO "test-admin-user";
GRANT
test_db-# \du
                                       List of roles
    Role name     |                         Attributes                         | Member of 
------------------+------------------------------------------------------------+-----------
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  |                                                            | {}
 test-simple-user |                                                            | {}



```
---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---