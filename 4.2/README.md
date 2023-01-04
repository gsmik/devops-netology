# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

### Цель задания

В результате выполнения этого задания вы:

1. Познакомитесь с синтаксисом Python.
2. Узнаете, для каких типов задач его можно использовать.
3. Воспользуетесь несколькими модулями для работы с ОС.


### Инструкция к заданию

1. Установите Python 3 любой версии.
2. Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-01-bash/README.md).
3. Заполните недостающие части документа решением задач (заменяйте `???`, остальное в шаблоне не меняйте, чтобы не сломать форматирование текста, подсветку синтаксиса). Вместо логов можно вставить скриншоты по желанию.
4. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
5. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.

------

## Задание 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:

| Вопрос  | Ответ                                                                                                                                |
| ------------- |--------------------------------------------------------------------------------------------------------------------------------------|
| Какое значение будет присвоено переменной `c`?  | Traceback (most recent call last):  File "<stdin>", line 1, in <module>TypeError: unsupported operand type(s) for +: 'int' and 'str' |
| Как получить для переменной `c` значение 12?  | c = str(a) + b                                                                                                                       |
| Как получить для переменной `c` значение 3?  | c = a + int(b)                                                                                                                       |

------

## Задание 2

Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. 

Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3
import os
bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os

targ_folder = "~/learning/devops-netology"
bash_command = ["cd "+targ_folder, "git status"]
print(f'Target folder: {targ_folder}')

result_os = os.popen(' && '.join(bash_command)).read()

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '').replace('#','')
        print('modified'+(os.path.join(targ_folder, prepare_result)))
    elif result.find('new file') != -1:
        prepare_result = result.replace('\tnew file:   ', '').replace('#', '')
        print('new file:'+(os.path.join(targ_folder, prepare_result)))
```

### Вывод скрипта при запуске при тестировании:
```bash
Target folder: ~/learning/devops-netology
Status new file:~/learning/devops-netology/4.2/src/4-2-2.py
Status modified:~/learning/devops-netology/4.2/README.md
Status modified:~/learning/devops-netology/4.2/src/4-2-2.py
```

------

## Задание 3

Доработать скрипт выше так, чтобы он не только мог проверять локальный репозиторий в текущей директории, но и умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os
import sys

targ_folder = "./"
if len(sys.argv) >= 2:
    targ_folder = sys.argv[1]
    print(f"Requested target folder :  {targ_folder}")
    if not os.path.isdir(targ_folder):
        sys.exit("Target folder doesn't exist :" + {targ_folder} )
bash_command = ["cd "+targ_folder, "git status 2>&1"]
result_os = os.popen(' && '.join(bash_command)).read()
if result_os.find ('not a git') != -1:
    sys.exit ("but it's not a git repository: " + {targ_folder})
git_command = ["git rev-parse --show-toplevel"]
git_top_level = (os.popen(' && '.join(git_command)).read()).replace('\n', '/')
print(f"Yours GIT directory is: {git_top_level}" )
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '').replace('#','')
        print('modified'+(os.path.join(targ_folder, prepare_result)))
    elif result.find('new file') != -1:
        prepare_result = result.replace('\tnew file:   ', '').replace('#', '')
        print('new file:'+(os.path.join(targ_folder, prepare_result)))
```

### Вывод скрипта при запуске при тестировании:
```bash
s3a1@s3a1-All-Series  ~/learning/devops-netology   main ±✚  python3 4.2/src/4-2-3.py
Yours GIT directory is: /home/s3a1/learning/devops-netology/
new file:./4.2/src/4-2-2.py
new file:./4.2/src/4-2-3.py
modified./4.2/README.md
modified./4.2/src/4-2-3.py
---------------------------
 s3a1@s3a1-All-Series  ~/learning/devops-netology/4.2/src   main ±✚  python3 4-2-3.py ~/learning/devops-netology/3.1/          
Requested target folder :  /home/s3a1/learning/devops-netology/3.1/
Yours GIT directory is: /home/s3a1/learning/devops-netology/
new file:/home/s3a1/learning/devops-netology/3.1/../4.2/src/4-2-2.py
new file:/home/s3a1/learning/devops-netology/3.1/../4.2/src/4-2-3.py
modified/home/s3a1/learning/devops-netology/3.1/../4.2/README.md
modified/home/s3a1/learning/devops-netology/3.1/../4.2/src/4-2-3.py

```

------

## Задание 4

Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. 

Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. 

Мы хотим написать скрипт, который: 
- опрашивает веб-сервисы, 
- получает их IP, 
- выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. 

Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
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
            print(date, host + " " + "IP changed: old IP" + " " +oip , "new IP"+ " " +nip)
        print(host + " " +hosts[host])
    time.sleep(15)
```
**Заменил сервисы на:**
* 'drive.yandex.ru'
* 'mail.yandex.ru'
* 'yandex.ru

### Вывод скрипта при запуске при тестировании:
```bash
✘ s3a1@s3a1-All-Series  ~/learning/devops-netology/4.2/src   main ±✚  python3 4-2-4.py
2023-01-04 23:29:45.605303
drive.yandex.ru 213.180.204.242
mail.yandex.ru 77.88.21.37
yandex.ru 77.88.55.80
2023-01-04 23:30:00.620912
drive.yandex.ru 213.180.204.242
mail.yandex.ru 77.88.21.37
2023-01-04 23:30:00.620912 yandex.ru IP changed: old IP 77.88.55.80 new IP 5.255.255.5
yandex.ru 5.255.255.5
2023-01-04 23:30:15.635804
drive.yandex.ru 213.180.204.242
mail.yandex.ru 77.88.21.37
2023-01-04 23:30:15.635804 yandex.ru IP changed: old IP 5.255.255.5 new IP 5.255.255.60
yandex.ru 5.255.255.60
2023-01-04 23:30:30.651581
drive.yandex.ru 213.180.204.242
mail.yandex.ru 77.88.21.37
yandex.ru 5.255.255.60

```

------

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз: 
* переносить архив с нашими изменениями с сервера на наш локальный компьютер, 
* формировать новую ветку, 
* коммитить в неё изменения, 
* создавать pull request (PR) 
* и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. 

Мы хотим максимально автоматизировать всю цепочку действий. 
* Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым).
* При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. 
* С директорией локального репозитория можно делать всё, что угодно. 
* Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. 

Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```

----

### Правила приема домашнего задания

В личном кабинете отправлена ссылка на .md файл в вашем репозитории.

-----

### Критерии оценки

Зачет - выполнены все задания, ответы даны в развернутой форме, приложены соответствующие скриншоты и файлы проекта, в выполненных заданиях нет противоречий и нарушения логики.

На доработку - задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки. 

Обязательными к выполнению являются задачи без указания звездочки. Их выполнение необходимо для получения зачета и диплома о профессиональной переподготовке.
Задачи со звездочкой (*) являются дополнительными задачами и/или задачами повышенной сложности. Они не являются обязательными к выполнению, но помогут вам глубже понять тему.
