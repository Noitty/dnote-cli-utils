#! /bin/bash

current_folder=$(pwd)
dst_path=/opt/
inst_path=$dst_path/dnote-cli-utils

# Check if dnote is installed
dnote_path=$(whereis dnote)
dnote_path=$(echo $dnote_path | sed 's/dnote: //')
if [[ -z "${dnote_path}" ]]
then
   echo "dnote-cli not installed. You must install it before using the dnote-cli-utils. Review documentation (https://github.com/dnote/dnote)"
   exit 1
else
   echo "Found dnote-cli. Installing dnote-cli-utils ..."
fi

# Move the files into the current folder
cp -r $current_folder/dnote-cli-utils /opt/

# Make them executables
chmod +x $inst_path/all-tasks.sh
chmod +x $inst_path/done-tasks.sh
chmod +x $inst_path/today-tasks.sh
chmod +x $inst_path/weekly-progress.sh
chmod +x $inst_path/common.sh

# Link executables
ln -s $inst_path/all-tasks.sh /usr/bin/all-tasks
ln -s $inst_path/done-tasks.sh /usr/bin/done-tasks
ln -s $inst_path/today-tasks.sh /usr/bin/today-tasks
ln -s $inst_path/weekly-progress.sh /usr/bin/weekly-progress

# Final comments
echo "dnote-cli-utils correctly installed! Remember to execute ./construct.sh to create the different notes and the configuration params."
