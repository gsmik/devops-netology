*Задание №1 – Ветвление, merge и rebase.*
1. Создайте в своем репозитории каталог branching и в нем два файла merge.sh и rebase.sh с содержимым:
```  
  mkdir branching
  touch branching/merge.sh
  vim branching/merge.sh
  cp branching/merge.sh branching/rebase.sh
  git commit -a -m 'prepare for merge and rebase'
```
***Подготовка файла merge.sh.***
```commandline
  git checkout -b git-merge
  vim branching/merge.sh
  git add branching/merge.sh
  git commit branching/merge.sh -m 'merge: @ instead *'
  vim branching/merge.sh
  git add branching/merge.sh
  git commit branching/merge.sh -m 'merge: use shift'
```
***Изменим main.***
```commandline
 git checkout main
 vim branching/rebase.sh
 git add branching/rebase.sh
 git commit branching/rebase.sh -m 'add new line'
```
**Промежуточный результат**
![](c:\users\s.gnetov\documents\net\devops-netology\1.3\img\1.png)

***Подготовка файла rebase.sh.***
```commandline
git log --oneline
git checkout 116e0d9
git checkout -b git-rebase
git log --oneline
vim branching/rebase.sh
git add branching/rebase.sh
git commit branching/rebase.sh -m 'git-rebase 1'
vim branching/rebase.sh
git add branching/rebase.sh
git commit branching/rebase.sh -m 'git-rebase 2'
```
***Merge***
```commandline
git push origin git-rebase
git push origin git-merge
git push origin main
git checkout main
git merge git-merge
git push origin
```
![](c:\users\s.gnetov\documents\net\devops-netology\1.3\img\2.png)

***Rebase***
```commandline
git checkout git-rebase
git rebase -i main
cat branching/rebase.sh
vim branching/rebase.sh
git add branching/rebase.sh
git rebase --continue
git push
git push -u origin git-rebase
git push -u origin git-rebase -f
git checkout main
git merge git-rebase
git push
```
![](c:\users\s.gnetov\documents\net\devops-netology\1.3\img\3.png)