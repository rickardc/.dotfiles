# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Tab Completion
if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Aliases
alias gs="git status"
alias ls="ls --color=auto"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/chris/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/chris/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/chris/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/chris/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

fastfetch

# Prompt
PS1=""
# Add conda environment to prompt
if [ ! -z "$CONDA_DEFAULT_ENV" ]
then
    PS1+="($CONDA_DEFAULT_ENV) "
fi
PS1+="\[\033[0;32m\]\u@\h\033[0m\]:\033[0;34m\]\w\[\033[0m\]$ "