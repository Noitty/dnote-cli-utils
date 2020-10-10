#! /bin/bash

source /opt/dnote-cli-utils/common.sh

function edit {
    dnote edit $DONE_TASKS
    sync
}

function view {
    dnote view $DONE_TASKS
}

function sync {
    dnote sync $DONE_TASKS
}

function open {
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
       add-content $DONE_TASKS "${new_text}"
       dnote sync
     else
        echo "[ERROR] Task identifiers (number) must be given as input of open"
        usage
     fi
}

function usage {
    echo "Description: list of tasks that have already been done."
    echo "Usage:" 
    echo " done-tasks [action] [task_id]"
    echo ""
    echo " actions:"
    echo ""
    echo "  v|view              print current task list."
    echo "  e|edit              edit and syncrhonizes the task list."
    echo "  o|open <task_id>    open again a task that has been previously closed. The tasks are placed in the 'all-tasks' list. <task_id> can be a task number, or a list of numbers separated by spaces."
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
    o|open)
    open $@
    ;;
    *)
    usage
    ;;
esac
else
   parse
   view
fi
