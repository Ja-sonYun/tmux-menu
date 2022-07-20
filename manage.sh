#!/usr/bin/env bash

function show_schedule() {
    tmux display-popup -x R -y P -w 125 -h 30 "/Users/jasonyun/project/icalcli/dist/icalcli/icalcli --width 40"
}

function show_tasks() {
    tmux display-popup -x R -y P -w 125 -h 50 -E "taskwarrior-tui"
}

function show_week_timew() {
    tmux display-popup -x R -y P -w 140 -h 18 "timew week"
}

function show_mail() {
    tmux display-popup -x R -y P -w 50% -h 70 -E "neomutt"
}

function show_wiki() {
    tmux display-popup -x R -y P -w 50% -h 70% -E "nvim ~/vimwiki/index.wiki"
}

function show_weather() {
    tmux display-popup -x R -y P -w 127 -h 42 "curl wttr.in"
}

function show_manage_menu() {
    current_dir="$1"
    current_project="$(basename $current_dir)"

    tmux display-menu -T "#[align=centre fg=yellow] Manage " -x R -y P                                  \
        "calendar"          c "run -b 'source $THIS_PATH && show_schedule'"                             \
        "weather"           w "run -b 'source $THIS_PATH && show_weather'"                              \
        ""                                                                                              \
        "Close"             q "run -b 'source $THIS_PATH && close_menu'"
}
        # "wiki"              i "run -b 'source $THIS_PATH && show_wiki'"                                 \
        # "task"              t "run -b 'source $THIS_PATH && show_tasks'"                                \
        # "timew"             m "run -b 'source $THIS_PATH && show_week_timew'"                           \
        # "mail"              e "run -b 'source $THIS_PATH && show_mail || true'"                         \
