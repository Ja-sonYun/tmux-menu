#!/usr/bin/env bash

project_list_path="/Users/jasonyun/.temporary_files/project_list"

function delete_project() {
    if [ -z "$1" ]; then
        exit 1
    fi

    temp=""

    while read -r line; do
        [[ ! $line =~ "$1" ]] && temp="$temp\n$line"
    done < $project_list_path

    echo "$temp" > $project_list_path

    show_project_menu
}

function edit_project_list() {
    tmux display-popup -x R -y P -w 55 -h 20 -E "nvim $project_list_path"
    
    show_project_menu
}

function add_project() {
    if [ -z "$1" ]; then
        exit 1
    fi
    
    if [ ! -f "$project_list_path" ]; then
        touch "$project_list_path"
    fi

    echo "$1" >> "$project_list_path"

    show_project_menu
}

function show_project_menu() {
    # temp_args=""
    # if [ -f "$project_list_path" ]; then
    #     while read p; do
    #         temp_args="$temp_args $p \"a\" 'run -b \\\'source $THIS_PATH\\\''"
    #     done < "$project_list_path"
    # fi

    tmux display-menu -T "#[align=centre fg=yellow] Project " -x R -y P                                          \
        ""                                                                                                       \
        "Add"             a "run -b 'source $THIS_PATH && input_popup add_project \"NEW PROJECT PATH\" 35 5'"    \
        "Edit"            e "run -b 'source $THIS_PATH && edit_project_list'"                                    \
        ""                                                                                                       \
        `while read p; do
            echo " $p \"a\" \"run -b 'source $THIS_PATH'\" "
        done < "$project_list_path"`                                                                             \
        ""                                                                                                       \
        "Close"           q "run -b 'source $THIS_PATH && close_menu'"
}
