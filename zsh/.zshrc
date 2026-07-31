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

# What's your editor?
EDITOR=vim

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

# LKE
export KUBECONFIG=$HOME/.kube/automation-bros.kubeconfig.yaml

# User npm-global
export PATH=~/.npm-global/bin:$PATH
export N_PREFIX=$HOME/n
export PATH="$N_PREFIX/bin:$PATH"

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

# OS-specific config
if [[ "$OSTYPE" == darwin* ]]; then
  source ~/.zshrc.darwin
elif [[ "$OSTYPE" == linux* ]]; then
  source ~/.zshrc.linux
fi
