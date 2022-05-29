#!/usr/bin/env bash

function show_gh_status() {
    tmux display-popup -x R -y P -w 125 -h 25 "gh status"
}

function show_gh_dash() {
    tmux display-popup -x R -y P -w 150 -h 45 -E "gh dash" || true
}

function show_git_tig() {
    tmux display-popup -x R -y P -w 75% -h 70% -E "tig -C '$1'" || true
}

function show_git_ui() {
    tmux display-popup -x R -y P -w 75% -h 70% -E "gitui -d $1" || true
}

function edit_gh_dash() {
    tmux display-popup -x R -y P -w 70 -h 30 -E "nvim $MYDOTFILES/gh-dash/config.yml"
}

function show_git_menu() {
    current_dir="$1"
    current_project="$(basename $current_dir)"

    tmux display-menu -T "#[align=centre fg=yellow] GitHub " -x R -y P                                  \
        ""                                                                                              \
        "-#[nodim] Folder: $current_project "              ""  ""                                       \
        ""                                                                                              \
        "tig"             g "run -b 'source $THIS_PATH && show_git_tig $current_dir'"                  \
        "gitui"             u "run -b 'source $THIS_PATH && show_git_ui $current_dir'"                 \
        "status"            n "run -b 'source $THIS_PATH && show_gh_status'"                            \
        "dash"              d "run -b 'source $THIS_PATH && show_gh_dash'"                              \
        ""                                                                                              \
        "edit dash"         e "run -b 'source $THIS_PATH && edit_gh_dash'"                              \
        "Close"             q "run -b 'source $THIS_PATH && close_menu'"
}
