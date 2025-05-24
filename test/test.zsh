#!/usr/bin/env zsh

eval "$(dircolors -b)"
ls_colors_array=(${(s.:.)LS_COLORS})
zstyle ':completion:*' list-colors $ls_colors_array
