#!/bin/bash
files=('/etc/passwd' '/etc/shadow')
commands=('date' 'uname -a' 'hostname -s')

for file in ${files[@]}; do
ls -l $file >> new.txt
done
for user is $(ls /home)
do
sudo -lU $user
done

for x in {0..2}
do
results=$(${commands[$x]})
echo "Results of \"${commands[$x]}\" command:"
echo results
echo ""

done

~                                                                               
~                                                                               
"~/sys_info2.sh" 21L, 318C                                    1,1           All
