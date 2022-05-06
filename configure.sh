#!/usr/bin/env bash

function nvim_configure() {
    tmux display-popup -x R -y P -w 75 -h 60 -E "nvim $MYDOTFILES/nvim/init.vim"
}

function tmux_configure() {
    tmux display-popup -x R -y P -w 75 -h 60 -E "nvim $MYDOTFILES/tmux/tmux.conf"
}

function show_configure_menu() {
    tmux display-menu -T "#[align=centre fg=yellow] Configure " -x R -y P                               \
        ""                                                                                              \
        "nvim"            n "run -b 'source $THIS_PATH && nvim_configure'"                              \
        "tmux"            t "run -b 'source $THIS_PATH && tmux_configure'"                              \
        ""                                                                                              \
        "Close"           q "run -b 'source $THIS_PATH && close_menu'"
}
