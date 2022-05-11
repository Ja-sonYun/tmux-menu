#!/usr/bin/env bash

function show_gh_status() {
    tmux display-popup -x R -y P -w 125 -h 25 "gh status"
}

function show_gh_dash() {
    tmux display-popup -x R -y P -w 125 -h 45 "gh dash" || true
}

function show_git_ui() {
    tmux display-popup -x R -y P -w 75% -h 70% "gitui -d $1" || true
}

function show_git_menu() {
    current_dir="$1"
    current_project="$(basename $current_dir)"

    tmux display-menu -T "#[align=centre fg=yellow] GitHub " -x R -y P                                  \
        ""                                                                                              \
        "-#[nodim] Folder: $current_project "              ""  ""                                       \
        ""                                                                                              \
        "gitui"             g "run -b 'source $THIS_PATH && show_git_ui $current_dir'"                  \
        "status"            n "run -b 'source $THIS_PATH && show_gh_status'"                            \
        "dash"              d "run -b 'source $THIS_PATH && show_gh_dash'"                              \
        ""                                                                                              \
        "Close"             q "run -b 'source $THIS_PATH && close_menu'"
}
