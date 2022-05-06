#!/usr/bin/env bash

function dig_url() {
    if [ -z "$1" ]; then
        exit 1
    fi

    tmux display-popup -x R -y P -w 75 -h 40 "dig \"$1\""

    do_with_url "$1"
}

function ping_url() {
    if [ -z "$1" ]; then
        exit 1
    fi

    tmux display-popup -x R -y P -w 75 -h 40 "ping \"$1\""

    do_with_url "$1"
}

function do_with_url() {
    if [ -z "$1" ]; then
        exit 1
    fi
    tmux display-menu -T "#[align=centre fg=yellow] URL " -x R -y P        \
        ""                                                                       \
        "-#[nodim] $1 "    ""  ""                                                \
        ""                                                                       \
        "dig"              d   "run -b 'source $THIS_PATH && dig_url \"$1\"'"    \
        "ping"             p   "run -b 'source $THIS_PATH && ping_url \"$1\"'"   \
        ""                                                                       \
        "Close"            q   "run -b 'source $THIS_PATH && close_menu'"
}

function show_network_menu() {
    tmux display-menu -T "#[align=centre fg=yellow] Network " -x R -y P                                \
        ""                                                                                             \
        "url"            u "run -b 'source $THIS_PATH && input_popup do_with_url \"TARGET URL\" 35 5'" \
        ""                                                                                             \
        "Close"          q "run -b 'source $THIS_PATH && close_menu'"
}

