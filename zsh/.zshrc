# fuzzy
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Completion
autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

# Plugins
# source /usr/share/zsh/plugins/zsh-completions/zsh-completions.zsh
source ~/.zsh/git-prompt.zsh/git-prompt.zsh
source ~/.zsh/vi-mode.zsh/vi-mode.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Nice prompt
PROMPT='%F{blue}%1~ $(gitprompt)$(vi_mode_status)'

# Check the hostname and prepend if it's not "thinkpadx1"
if [[ $(< /etc/hostname) != "thinkpadx1" ]]; then
  PROMPT="(%F{yellow}$(< /etc/hostname)%f) $PROMPT"
fi

# What's your editor?
EDITOR=vim

# ls with colors
alias ls='ls --color=always'
alias x=exit
alias vim=nvim
alias node=$HOME/n/bin/node
alias ssh='TERM=xterm ssh'

# Path
PATH=$PATH:$HOME/bin:$HOME/.local/bin


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

export AWS_MFA_DEVICE_ARN=arn:aws:iam::042502209102:mfa/elaich

notify-deploy-completed() {
  osascript -e 'display notification "Done deploying or something went wrong 😀"'
}
deploy() {
  branchToDeploy="$(git rev-parse --abbrev-ref HEAD)"
  remoteToDeployTo="$1"
  shift
  echo "Deploying branch '$branchToDeploy' to remote '$remoteToDeployTo'"...
  sleep 5 # Give time to control-c
  time git push "$@" "$remoteToDeployTo" "${branchToDeploy}:master" || echo "Deployment failed"
}
deploy-develop() {
  deploy heroku-develop --force
}
export PATH="/home/marouane/.ebcli-virtual-env/executables:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/marouane/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/home/marouane/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/marouane/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/marouane/tmp/google-cloud-sdk/completion.zsh.inc'; fi

# Deno
export DENO_INSTALL="/home/marouane/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DVM_DIR="/home/marouane/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

# LKE
export KUBECONFIG=$HOME/.kube/automation-bros.kubeconfig.yaml

# User npm-global
export PATH=~/.npm-global/bin:$PATH
export N_PREFIX=$HOME/n

# TeX Live paths
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

source <(kubectl completion zsh)
compdef _kubectl kubectl
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

alias ssm_staging="aws ssm start-session --target i-0983fd91609ddec61 --region us-east-1" 
alias ssm_sn51_server="aws ssm start-session --target i-0e28f335a9f6f9829 --region us-east-1"
alias ssm_sn51_validator="aws ssm start-session --target i-0ded363a0d221b7bd --region us-east-1"
alias ssm_sn51_paytao="aws ssm start-session --target i-0784dd56a6643d15d --region us-east-1"
