#!/usr/bin/env bash

cliphist list | tofi --prompt "📋 " --padding-left 5% --font-size 16 --num-results 16 | cliphist decode | wl-copy 
