# Домашнее задание по лекции "Введение в DevOps"
## Задание 1.
a) [Файл .jsonnet](https://drive.google.com/file/d/1g7y0j5MGTeKLc-6ls27fkUclkabF9JK4/view?usp=sharing)

b) [Файл .md](https://drive.google.com/file/d/1VZKnrNu-AZ4Q39Qb3tqrNpmf7XPwzhUQ/view?usp=sharing)

c) [Файл .sh](https://drive.google.com/file/d/11VYU-Du4YVYHDZr4KOX3G1GqUJ_e2ot7/view?usp=sharing)

d) [Файл .tf](https://drive.google.com/file/d/1_5xct9mfcwNU3Yt-RuH_dDMGnq6BucL9/view?usp=sharing)

e) [Файл .yaml](https://drive.google.com/file/d/16ttq-5vzwbKSI3_Tls48uq9wdyFzmK3B/view?usp=sharing)


## Задание 2.

a) Менеджер получает сообщения о необходимости внежрения нового функционала

b) Менеджер собирает необходимую информацию, проводит анализ требований и разрабатывает ТЗ

c) Собираются отделы (разработчики, тестировщики, devops-инжинеры, менеджеры продуктов/проектов, системные администраторы)

d) Создается план разработки и внедрения, определяются програмно-аппаратные комплексы и системы необходимы для внедрения конечного продукта.

У разработчиков должны быть одинаковые среды разработки, настроены репозитории Git (или другой системы контроля версий)
У тестировщиков должны быть единые инструменты тестирования

f) Должны быть настроены системы мониторинга и логирования результатов прохождения тестов кода

g) Администраторы инфраструктуры выделяют необходимые ресурсы для развертывания инфраструктуры

h) DevOps пишет код для автоматизации развертывания тестовой инфраструктуры для тестирования и проверки нового функционала

i) Разработчики пишут код и выкладывают его в dev репазиторий системы контроля версий

j) DevOps настраивает автоматическую доставку кода из dev репозитория на тестирование и после успешных тестов, доставку кода на тестовую платформу

k) Тестировщики проверяют функционал на тестовой платформе и сообщают результат тестирования менеджеру

l) Менеджер, в случае, найденых проблем отдает код на доработку, если проблем не выявлено, принимет решение и назначает дату релиза

m) DevOps пишет код для автоматизации развертывания тестовой инфраструктуры для prodaction платформы

n) Разработчики отправляют проверенный и одобренный код в ветку prod в репозитории

o) Devops настраивает автоматическую доставку кода из репозитория prod в prodaction платформу, настраивает мониторинг, логирование и резервное копирование prod. платформы

p) В случае проблем с интернет магазином после внесенных изменений есть возможность откатиться на предыдущий релиз

q) DevOps контактирует со всеми отделами На протяжении всего цикла разработки, 