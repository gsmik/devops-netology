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