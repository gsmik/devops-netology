# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Как сдавать задания

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.

Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.

Домашнее задание выполните в файле readme.md в github репозитории. В личном кабинете отправьте на проверку ссылку на .md-файл в вашем репозитории.

Любые вопросы по решению задач задавайте в чате учебной группы.

---


## Важно!

Перед отправкой работы на проверку удаляйте неиспользуемые ресурсы.
Это важно для того, чтоб предупредить неконтролируемый расход средств, полученных в результате использования промокода.

Подробные рекомендации [здесь](https://github.com/netology-code/virt-homeworks/blob/virt-11/r/README.md)

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo. \
**Ответ**
<details>

``` bash
vagrant@server1:~$ mkdir mydocker
vagrant@server1:~$ cd mydocker/
vagrant@server1:~/mydocker$ vi Dockerfile
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ vi index.html
vagrant@server1:~/mydocker$ vi Dockerfile
vagrant@server1:~/mydocker$ docker build -t gsmik/nginx
"docker build" requires exactly 1 argument.
See 'docker build --help'.

Usage:  docker build [OPTIONS] PATH | URL | -

Build an image from a Dockerfile
vagrant@server1:~/mydocker$ ls
Dockerfile  index.html
vagrant@server1:~/mydocker$ docker build -t gsmik/nginx
"docker build" requires exactly 1 argument.
See 'docker build --help'.

Usage:  docker build [OPTIONS] PATH | URL | -

Build an image from a Dockerfile
vagrant@server1:~/mydocker$ docker build -t gsmik/nginx:v1 .
Sending build context to Docker daemon  3.072kB
Error response from daemon: dockerfile parse error line 2: unknown instruction: MAINTENER
vagrant@server1:~/mydocker$ vi Dockerfile
vagrant@server1:~/mydocker$ docker build -t gsmik/nginx:v1 .
Sending build context to Docker daemon  3.072kB
Step 1/4 : FROM nginx:latest
latest: Pulling from library/nginx
8740c948ffd4: Pull complete 
d2c0556a17c5: Pull complete 
c8b9881f2c6a: Pull complete 
693c3ffa8f43: Pull complete 
8316c5e80e6d: Pull complete 
b2fe3577faa4: Pull complete 
Digest: sha256:b8f2383a95879e1ae064940d9a200f67a6c79e710ed82ac42263397367e7cc4e
Status: Downloaded newer image for nginx:latest
 ---> a99a39d070bf
Step 2/4 : MAINTAINER Sergey Gnetov
 ---> Running in 7c6457a10aa8
Removing intermediate container 7c6457a10aa8
 ---> 3858d471b3fc
Step 3/4 : ENV TZ=Europe/Moscow
 ---> Running in e2460467d1c8
Removing intermediate container e2460467d1c8
 ---> 6046504626f4
Step 4/4 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> 24cd00d65909
Successfully built 24cd00d65909
Successfully tagged gsmik/nginx:v1
vagrant@server1:~/mydocker$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
gsmik/nginx   v1        24cd00d65909   26 seconds ago   142MB
nginx         latest    a99a39d070bf   8 days ago       142MB
vagrant@server1:~/mydocker$ docker run -it -d -p 8080:80 --name nginx gsmik/nginx:latest
Unable to find image 'gsmik/nginx:latest' locally
docker: Error response from daemon: pull access denied for gsmik/nginx, repository does not exist or may require 'docker login': denied: requested access to the resource is denied.
See 'docker run --help'.
vagrant@server1:~/mydocker$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
gsmik/nginx   v1        24cd00d65909   2 minutes ago   142MB
nginx         latest    a99a39d070bf   8 days ago      142MB
vagrant@server1:~/mydocker$ docker run -it -d -p 8080:80 --name nginx gsmik/nginx:v1
dd5b68250c101ae2ad36fefce6fa9a90df080415facf8b7ec09dec8579874b54
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ docker ps
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                                   NAMES
dd5b68250c10   gsmik/nginx:v1   "/docker-entrypoint.…"   23 seconds ago   Up 21 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx
vagrant@server1:~/mydocker$  curl 0.0.0.0:8080
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
vagrant@server1:~/mydocker$ 
vagrant@server1:~/mydocker$ docker login -u gsmik
Password: 
WARNING! Your password will be stored unencrypted in /home/vagrant/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
vagrant@server1:~/mydocker$ docker push gsmij/nginx:v1
The push refers to repository [docker.io/gsmij/nginx]
An image does not exist locally with the tag: gsmij/nginx
vagrant@server1:~/mydocker$ docker push gsmik/nginx:v1
The push refers to repository [docker.io/gsmik/nginx]
fa54b8866871: Pushed 
80115eeb30bc: Mounted from library/nginx 
049fd3bdb25d: Mounted from library/nginx 
ff1154af28db: Mounted from library/nginx 
8477a329ab95: Mounted from library/nginx 
7e7121bf193a: Mounted from library/nginx 
67a4178b7d47: Mounted from library/nginx 
v1: digest: sha256:24e100bcc9702f7479710b94b77ac835330db8bafe54191d85555fa08b5092aa size: 1777
```
</details>

https://hub.docker.com/repository/docker/gsmik/nginx


## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

**Ответ:**
* Высоконагруженное монолитное java веб-приложение - Docker не подходит. Т.к. во-первых - монолит, во-вторых высоконагруженное java-приложение. Для работы потребуется JVM.
* Nodejs веб-приложение - Вполне себе хорошая практика использовать Docker для web-приложений на NodeJS. Docker позволит быстро разворачивать, масштабировать сервис или переносить на другие докер-хосты.
* Мобильное приложение c версиями для Android и iOS - 
* Шина данных на базе Apache Kafka - Подходит, быстрое развертывание и масштабирование
* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - Вполне подходит, да и вендер рекомендует
* Мониторинг-стек на базе Prometheus и Grafana - почему бы и да. Удобно.
* MongoDB, как основное хранилище данных для java-приложения - Вообще очень не хорошо, как по мне, БД в контейнере держать. Но для тестов можно.
* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - можно использовать и контейнеры. Только для чего? Gitlab и Docker Registry нечасто требуют быстрого масштабирования. Да и в DR могут лежать тяжелые файлы, которые надо не забыть  прокинуть через volume.


## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.
