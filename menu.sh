#!/usr/bin/env bash

THIS_PATH=`realpath ${BASH_SOURCE[0]}`

# cbfl library must be sourced on bashrc.
source ~/.bashrc

source $(dirname $THIS_PATH)/network.sh
source $(dirname $THIS_PATH)/configure.sh
source $(dirname $THIS_PATH)/project_manager.sh
source $(dirname $THIS_PATH)/git.sh
source $(dirname $THIS_PATH)/process.sh
source $(dirname $THIS_PATH)/manage.sh

function input_popup() {
    # args:
    #   $1: func   
    #   $2: message
    #   $3: width
    #   $4: height
    envar_key="__input"
    tmux display-popup -x R -y P -w $3 -h $4 -E "bash -c ' \
        printf \"\e[1;33m%-6s\e[m\n\" \" $2\"             ;\
        printf \"%0.s═\" {1..$(( $3 - 2 ))}               ;\
        read -p \" > \" input                             ;\
        tmux setenv $envar_key \"\$input\"                ;\
    '"
    env_input=$(tmux showenv $envar_key)
    input="${env_input#*=}"
    tmux setenv -u $envar_key

    if [ ! -z "$input" ]; then
        $1 $input
    fi
}

function show_main_menu() {
    current_dir="$1"
    current_dir_shorted=$(shorten_pwd $1)

    tmux display-menu -T "#[align=centre fg=yellow] Menu " -x R -y P                         \
        ""                                                                                   \
        "-#[nodim] $current_dir_shorted "      ""  ""                                        \
        "-#[nodim] $(date +%F) $(date +%T)"    ""  ""                                        \
        ""                                                                                   \
        "GitHub"                    g   "run -b 'source $THIS_PATH && show_git_menu $current_dir'"        \
        "Project"                   w   "run -b 'source $THIS_PATH && show_project_menu'"    \
        "Manage"                    s   "run -b 'source $THIS_PATH && show_manage_menu'"     \
        "Network"                   n   "run -b 'source $THIS_PATH && show_network_menu'"    \
        "Process"                   p   "run -b 'source $THIS_PATH && show_process_menu'"    \
        "Configure"                 c   "run -b 'source $THIS_PATH && show_configure_menu'"  \
        "Test"                      t   "run -b 'source $THIS_PATH && do_test'"              \
        ""                                                                                   \
        "Close"                     q   "run -b 'source $THIS_PATH && close_menu'"
}

function close_menu() {
    :
}

function do_test() {
    tmux display-popup -x R -y P -w 80 -h 30 -E "zsh -c 'cd ~/project/menu && cargo run'"
}
