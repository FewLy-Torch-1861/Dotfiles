#!/usr/bin/env bash

cmd=$(compgen -c | sort -u | fzf --border)

[ -n "$cmd" ] && exec $cmd
