#!/usr/bin/env bash

cmd=$(compgen -c | sort -u | fzf --border --no-preview)

[ -n "$cmd" ] && exec $cmd
