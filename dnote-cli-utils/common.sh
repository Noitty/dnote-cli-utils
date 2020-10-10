#! /bin/bash

function parse {
    source ~/.dnote-cli-utils/.env
}

# add-task
#  $1 -> ID of the note
#  $2 -> Content to be added
function add-task {
    content=$(dnote view $1 | sed -n -e "/^Here/p" -e "/^#/p")
    printf -v content "${content}"'\n'"$2"
    dnote edit $1 -c "${content}" > /dev/null
}

# add-content
#  $1 -> ID of the note
#  $2 -> content to be added
function add-content {
    content=$(echo "$2" | sed -n -e "/^Here/p" -e "/^#/p")
    dnote edit $1 -c "${content}" > /dev/null
}

