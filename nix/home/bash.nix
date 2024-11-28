{pkgs, ...}: {
  enable = true;

  enableCompletion = true;

  historySize = 2000;

  historyIgnore = [
    "ls"
    "cd *"
    "exit"
    "clear"
  ];

  shellAliases = {
    # Example aliases
    ll = "ls -alF";
    la = "ls -A";
    l = "ls -CF";
    gs = "git status";
    ls = "ls --color=auto";
    grep = "grep --color=auto";
  };

  initExtra = ''
    PS1='\033[0;32m\]\u@\h\033[0m\]:\033[0;34m\]\w\[\033[0m\]$ '
  '';
}
