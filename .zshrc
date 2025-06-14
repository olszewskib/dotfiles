# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin::$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

export ZSH_CUSTOM="$ZSH/custom"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting kubectl fzf-zsh-plugin)

source $ZSH/oh-my-zsh.sh

#####################
# User configuration#
#####################

export SUPPRESS_LABEL_WARNING=True

# ssh-agent
. ~/.gnome-keyring-ssh.sh

# zsh autosuggest-accept custom bind
bindkey '^y' autosuggest-accept

# Envs
if [ -f ~/.zshrc_envs ]; then
    source ~/.zshrc_envs
fi

# Navigation
cdpath=(~/Documents)
setopt auto_pushd

# Aliases
alias k="kubectl"
alias ks="kubens"
alias kx="kubectx"
alias d="docker"
alias cdd="cd ~/Documents"
alias py="python3"
alias c="clear"
alias vim="nvim"
alias tg="terragrunt"
alias lg="lazygit"
alias db="cd ~/Documents/database_backup"
alias tf="cd ~/Documents/terraform"

# Functions

pf() {
    source ~/.profile
}

zshrc() {
    nvim ~/.zshrc
    source ~/.zshrc
}

tfoci() {
    source ~/.oci/"$1.sh"
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
