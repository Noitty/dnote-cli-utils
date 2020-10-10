#! /bin/bash

source /opt/dnote-cli-utils/common.sh

function edit {
    dnote edit $WEEKLY_PROGRESS
    sync
}

function view {
    dnote view $WEEKLY_PROGRESS
}

function sync {
    dnote sync $WEEKLY_PROGRESS
}

function clean {
    text=$(view)
    text=$(echo "${text}" | sed -n "/^Here/p")
    dnote edit $WEEKLY_PROGRESS  -c "${text}" > /dev/null
    sync
}

function usage {
    echo "Description: list of tasks associated to the current weekly progress."
    echo "Usage:" 
    echo " weekly-progress [action]"
    echo ""
    echo " actions:"
    echo ""
    echo "  v|view	print current task list."
    echo "  e|edit	edit and syncrhonizes the task list."
    echo "  c|clean	empty the task list"
    echo "  s|sync	syncrhonize with remote dnote server."
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
    c|clean)
    clean
    ;;
    *)
    usage
    ;;
esac
else
    parse
    view
fi
