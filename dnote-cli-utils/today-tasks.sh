#! /bin/bash

source /opt/dnote-cli-utils/common.sh

function edit {
    dnote edit $TODAY_TASKS
    sync
}

function view {
    dnote view $TODAY_TASKS
}

function sync {
    dnote sync $TODAY_TASKS
}

function close {
     if [[ $# -gt 1 ]]
     then
       text=$(view)
       new_text=$text
       for var in "$@"
       do
         line=$(echo "${text}" | sed -n "/#${var} /p")
         if [[ -n "${line}" ]]
         then
           add-task $WEEKLY_PROGRESS "${line}"
           add-task $DONE_TASKS "${line}"
           line=$(echo "${line}" | sed 's/\//\\\//')
           new_text=$(echo "${new_text}" | sed "s/${line}//" | sed '/^\s*$/d')
         fi
       done
       add-content $TODAY_TASKS "${new_text}"
       dnote sync
     else
        echo "[ERROR] A task identifier (number) must be given as input of close"
        usage
     fi
}

function retract {
     if [[ $# -gt 1 ]]
     then
       text=$(view)
       new_text=$text
       for var in "$@"
       do
         line=$(echo "${text}" | sed -n "/#${var} /p")
         if [[ -n "${line}" ]]
         then
           add-task $ALL_TASKS "${line}"
           line=$(echo "${line}" | sed 's/\//\\\//')
           new_text=$(echo "${new_text}" | sed "s/${line}//" | sed '/^\s*$/d')
         fi
       done
       add-content $TODAY_TASKS "${new_text}"
       dnote sync
     else
        echo "[ERROR] Task identifiers (number) must be given as input of deassign"
        usage
     fi
}


function usage {
    echo "Description: list of tasks to be performed for the current day."
    echo "Usage:" 
    echo " today-tasks [action] [task_id]"
    echo ""
    echo " actions:"
    echo ""
    echo "  v|view              print current task list."
    echo "  e|edit              edit and syncrhonizes the task list."
    echo "  c|close <task_id>   close a task or tasks that have been done. The tasks are placed in the 'done-tasks' and 'weekly-progress' lists. <task_id> can be a task number or a list of numbers separated by spaces."
    echo "  r|retract <task_id> undo a close action of a task or tasks. The tasks are placed in the 'all-tasks' list. <task_id> can be a task number or a list of numbers separated by spaces."
    echo "  s|sync              syncrhonize with remote dnote server."
}

if [[ $# -gt 0 ]]
then
key="$1"
parse
case $key in
    e|edit)
    edit
    ;;
    v|view)
    view
    ;;
    s|sync)
    sync
    ;;
    c|close)
    close $@
    ;;
    r|retract)
    retract $@
    ;;
    *)
    usage
    ;;
esac
else
    parse
    view
fi
