# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

export ZSH_CUSTOM="$ZSH/custom"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting kubectl fzf-zsh-plugin)

source $ZSH/oh-my-zsh.sh

#####################
# User configuration#
#####################

# zsh autosuggest-accept custom bind
bindkey '^y' autosuggest-accept

# ssh-agent
if [ -f ~/.gnome-keyring-ssh.sh ]; then
    . ~/.gnome-keyring-ssh.sh
fi

# Envs
if [ -f ~/.zshrc_envs ]; then
    source ~/.zshrc_envs
fi

# Aliases

alias k="kubectl"
alias ks="kubens"
alias kx="kubectx"
alias knodes="kubectl get nodes -o custom-columns='NAME:.metadata.name,POOL:.metadata.labels.pool,READY:.status.conditions[?(@.type==\"Ready\")].status'"
alias kpods="kubectl get pods -o custom-columns='NAME:.metadata.name,POOL:.spec.nodeSelector.pool,PHASE:.status.phase'"
alias d="docker"
alias cdd="cd ~/Documents"
alias py="python3"
alias c="clear"
alias vim="nvim"
alias tg="terragrunt"
alias lg="lazygit"
alias tf="cd ~/Documents/terraform"

# Functions

pf() {
    source ~/.profile
}

zshrc() {
    nvim ~/.zshrc
    source ~/.zshrc
}

sshc() {
  ssh `grep "^Host" ~/.ssh/config | awk '{print $2}' | fzf-tmux -p`
}

klogs() {
  kubectl get pods | fzf-tmux -p | awk '{print $1}' | xargs kubectl logs
}

krm() {
  kubectl get "$1" | fzf-tmux -p | awk '{print $1}' | xargs kubectl delete $1
}

ka() {
  ls -1 | fzf-tmux -p | xargs kubectl apply -f
}

gbc() {
  git branch --list | fzf-tmux -p | xargs git checkout
}

drm() {
  docker "$1" ls | awk '{print $1":"$2}'| fzf-tmux -p | xargs docker "$1" rm
}
