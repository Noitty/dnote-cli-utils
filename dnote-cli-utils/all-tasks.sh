#! /bin/bash

source /opt/dnote-cli-utils/common.sh

function edit {
    dnote edit $ALL_TASKS
    sync
}

function view {
    dnote view $ALL_TASKS
}

function sync {
    dnote sync $ALL_TASKS
}

function assign {
     if [[ $# -gt 1 ]]
     then
       text=$(view)
       new_text=$text
       for var in "$@"
       do
         line=$(echo "${text}" | sed -n "/#${var} /p")
         if [[ -n "${line}" ]]
         then
           add-task $TODAY_TASKS "${line}"
           line=$(echo "${line}" | sed 's/\//\\\//')
           new_text=$(echo "${new_text}" | sed "s/${line}//" | sed '/^\s*$/d')
         fi
       done
       add-content $ALL_TASKS "${new_text}"
       dnote sync
     else
        echo "[ERROR] Task identifiers (number) must be given as input of assign"
        usage
     fi
}

function usage {
    echo "Description: list of tasks to be performed in the future."
    echo "Usage:" 
    echo " today-tasks [action] [task_id]"
    echo ""
    echo " actions:"
    echo ""
    echo "  v|view              print current task list."
    echo "  e|edit              edit and syncrhonizes the task list."
    echo "  a|assign <task_id>  assign a task or tasks to be performed for current day. The tasks are placed in the 'today-tasks' list. <task_id> can be a task number, or a list of numbers separated by spaces."
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
    a|assign)
    assign $@
    ;;
    *)
    usage
    ;;
esac
else
    parse
    view
fi
