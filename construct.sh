#! /bin/bash

env_path=~/.dnote-cli-utils

# create books/notes and configure .env file
mkdir -p $env_path
touch $env_path/.env
#dnote add all-tasks
noteid=$(dnote view all-tasks | awk -F ")" '{print $1}' | awk -F "(" '{print $2}' | sed '/^\s*$/d')
echo "export ALL_TASKS=${noteid}" >> $env_path/.env
#dnote add done-tasks
noteid=$(dnote view done-tasks | awk -F ")" '{print $1}' | awk -F "(" '{print $2}' | sed '/^\s*$/d')
echo "export DONE_TASKS=${noteid}" >> $env_path/.env
#dnote add today-tasks
noteid=$(dnote view today-tasks | awk -F ")" '{print $1}' | awk -F "(" '{print $2}' | sed '/^\s*$/d')
echo "export TODAY_TASKS=${noteid}" >> $env_path/.env
#dnote add weekly-progress
noteid=$(dnote view weekly-progress | awk -F ")" '{print $1}' | awk -F "(" '{print $2}' | sed '/^\s*$/d')
echo "export WEEKLY_PROGRESS=${noteid}" >> $env_path/.env
source $env_path/.env

# Write the first text in the notes
#dnote edit $TODAY_TASKS -c "Here you can see your diary tasks:"
#dnote edit $DONE_TASKS -c "Here you have all the tasks that you have already accomplish:"
#dnote edit $ALL_TASKS -c "Here you have all the tasks that you must accomplish:"
#dnote edit $WEEKLY_PROGRESS -c "Here you will find all the tasks performed in the last week:"

# Final comments
echo "dnote-cli-utils correctly configured! Remember that in ~/.dnote/dnoterc you can modify the default editor and the remote server url, and in ~/.dnote-cli-utils/.env the note ids."


