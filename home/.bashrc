

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTIGNORE='ls:cd *:exit:clear'
HISTSIZE=2000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias grep='grep --color=auto'
alias gs='git status'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'

if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/nix/store/knkgz12zyg83w9g61xys6qjxwxgmymh5-bash-completion-2.14.0/etc/profile.d/bash_completion.sh"
fi

eval "$(/nix/store/r0db6sb6kfhv038di4plz2cb1bpnrspd-zoxide-0.9.6/bin/zoxide init bash --cmd cd)"

if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
  eval "$(/nix/store/skn3hqs9fzina081hfcvg8jil84az85f-fzf-0.56.2/bin/fzf --bash)"
fi

PS1='\033[0;32m\]\u@\h\033[0m\]:\033[0;34m\]\w\[\033[0m\]$ '

