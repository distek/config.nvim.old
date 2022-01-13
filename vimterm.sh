#!/bin/bash

mkdir /tmp/tmux-vimterm 2>/dev/null

session=0

if tmux -S /tmp/tmux-vimterm/vimterm -L vimterm ls 2>/dev/null; then
    for s in $(tmux -S /tmp/tmux-vimterm/vimterm -L vimterm ls); do
        if echo "$s" | grep -i "vimterm[0-9]" > /dev/null; then
            if tmux -S /tmp/tmux-vimterm/vimterm -f ~/.config/tmux/vimterm.conf -L vimterm ls -F '#{session_name}' | grep "vimterm$session" > /dev/null; then
                session=$((session + 1))
            else
                break
            fi
        fi
    done
fi

tmux -S /tmp/tmux-vimterm/vimterm -f ~/.config/tmux/vimterm.conf -L vimterm new-session -d -s vimterm$session
tmux -S /tmp/tmux-vimterm/vimterm -L vimterm a -t vimterm$session
