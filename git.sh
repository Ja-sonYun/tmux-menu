#!/usr/bin/env bash

function show_gh_status() {
    tmux display-popup -x R -y P -w 125 -h 25 "gh status"
}

function show_git_menu() {
    tmux display-menu -T "#[align=centre fg=yellow] GitHub " -x R -y P                                  \
        ""                                                                                              \
        "status"            n "run -b 'source $THIS_PATH && show_gh_status'"                            \
        ""                                                                                              \
        "Close"           q "run -b 'source $THIS_PATH && close_menu'"
}
