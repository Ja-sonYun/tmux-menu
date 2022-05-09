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

    tmux display-popup -x R -y P -w 75 -h 20 "ping \"$1\" | sed -u 's/^.*time=//g; s/ ms//g' | ttyplot -t \"ping to '$1'\" -u ms"
    
    do_with_url "$1"
}

function wifi_signal() {
    tmux display-popup -x R -y P -w 75 -h 20 -E \
        "{ while true; do /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport --getinfo | awk '/agrCtlRSSI/ {print -\$2; fflush();}'; sleep 1; done } | ttyplot -t \"wifi signal\" -u \"-dBm\" -s 90"
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
        "sampler"          s   "run -b 'source $THIS_PATH && sampler \"$1\"'"   \
        ""                                                                       \
        "Close"            q   "run -b 'source $THIS_PATH && close_menu'"
}

function show_network_menu() {
    tmux display-menu -T "#[align=centre fg=yellow] Network " -x R -y P                                \
        ""                                                                                             \
        "url"            u "run -b 'source $THIS_PATH && input_popup do_with_url \"TARGET URL\" 35 5'" \
        "wifi signal"    w "run -b 'source $THIS_PATH && wifi_signal'"                                 \
        ""                                                                                             \
        "Close"          q "run -b 'source $THIS_PATH && close_menu'"
}

