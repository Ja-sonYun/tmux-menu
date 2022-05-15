#!/usr/bin/env bash

function show_schedule() {
    tmux display-popup -x R -y P -w 125 -h 22 "/Users/jasonyun/project/icalcli/dist/icalcli/icalcli"
}


function show_manage_menu() {
    current_dir="$1"
    current_project="$(basename $current_dir)"

    tmux display-menu -T "#[align=centre fg=yellow] Manage " -x R -y P                                  \
        "calendar"          c "run -b 'source $THIS_PATH && show_schedule'"                             \
        ""                                                                                              \
        "Close"             q "run -b 'source $THIS_PATH && close_menu'"
}
