source ~/.zsh/git-prompt.zsh/git-prompt.zsh

# Nice prompt
PROMPT='%F{blue}%1~ %F{magenta}> %f $(gitprompt)'

# What's your editor?
EDITOR=vim

# ls with colors
alias ls='ls --color=always'

# Path
PATH=$PATH:$HOME/bin:$HOME/.local/bin

# Completion
autoload -U compinit && compinit

# History Configuration
HISTSIZE=5000
HISTFILE=~/.zsh_history     
SAVEHIST=5000              
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

# History using substring
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Android development
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
