#!/usr/bin/env python3
import os

targ_folder = "~/learning/devops-netology"
bash_command = ["cd "+targ_folder, "git status"]
print(f'Target folder: {targ_folder}')

result_os = os.popen(' && '.join(bash_command)).read()

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '').replace('#','')
        #print(os.path.join(targ_folder, prepare_result))
        print(f'Status modified:' + (os.path.join(targ_folder, prepare_result)))
    elif result.find('new file') != -1:
        prepare_result = result.replace('\tnew file:   ', '').replace('#', '')
        #print(os.path.join(targ_folder, prepare_result))
        print(f'Status new file:' + (os.path.join(targ_folder, prepare_result)))

