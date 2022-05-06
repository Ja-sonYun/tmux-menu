#!/usr/bin/env bash

function show_top() {
    tmux display-popup -x R -y P -w 75 -h 40 -E "top"
}

function show_ps() {
    tmux display-popup -x R -y P -w 75 -h 20 "ps -a"
}

function show_process_menu() {
    tmux display-menu -T "#[align=centre fg=yellow] Process " -x R -y P                                \
        ""                                                                                             \
        "top"            t "run -b 'source $THIS_PATH && show_top'"                                    \
        "ps -a"          p "run -b 'source $THIS_PATH && show_ps'"                                     \
        ""                                                                                             \
        "Close"          q "run -b 'source $THIS_PATH && close_menu'"
}
