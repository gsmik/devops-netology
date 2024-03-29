
# Домашнее задание к занятию "2. Применение принципов IaaC в работе с виртуальными машинами"

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

- Опишите своими словами основные преимущества применения на практике IaaC паттернов. \
**CI (continuous integration)** - Ранее обнаружение багов и их исправление\
**CD (continuous delivery )** - Оперативное развертывание, внесение изменений мелкими доработками, быстрый откат изменений\
**CD (continuous deployment)** - Автоматизация развертывания изменений
- Какой из принципов IaaC является основополагающим? \
**Идемпотентность**

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями? \
**Написан на python, не требует установки агентов на обслуживаемые хосты**
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull? \
Вопрос непонятен. Все зависит от поставленной задачи \
**push** - подходит для развертывание идентичных систем \
**pull** - позволяет костомизировать каждый хост


## Задача 3

Установить на личный компьютер:

- VirtualBox
- Vagrant
- Ansible

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*
```bash
 s3a1@s3a1-All-Series  ~/learning/vagrant  vagrant --version
Vagrant 2.2.6
 s3a1@s3a1-All-Series  ~/learning/vagrant  ansible --version
ansible [core 2.12.10]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/s3a1/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/s3a1/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 14 2022, 12:59:47) [GCC 9.4.0]
  jinja version = 2.10.1
  libyaml = True
 s3a1@s3a1-All-Series  ~/learning/vagrant  vboxmanage -v    
6.1.38_Ubuntur153438

```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```
**Ответ**
```bash
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ docker --version
Docker version 20.10.22, build 3a2c30b

```