# Path to Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme to load
ZSH_THEME="intheloop" # set by `omz`

# Hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Auto-update behavior
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# String date format.
HIST_STAMPS="dd.mm.yyyy"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred terminal text editor
export EDITOR=hx
export VISUAL=hx

# Golang environment variables
export PATH="$PATH:$HOME/go/bin/"
export PATH="$PATH:/usr/local/go/bin"

# Other env vars
export LIBVA_DRIVER_NAME=iHD vainfo

# Aliases commands
alias vi='hx'
alias c='clear'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias pkgs='xbps-query -l | wc -l'
alias stop-mysql='sudo rm /var/service/mysqld'
alias change-theme='$HOME/.scripts/theme-changer.sh'
alias start-mysql='sudo ln -s /etc/sv/mysqld /var/service/'
alias dotfiles='/usr/bin/git --git-dir=$HOME/Dotfiles --work-tree=$HOME'
alias kinfo='c=$(uname -r); echo "kernel-$c (current)";
            ls /boot/vmlinuz-* | sed "s#.*/vmlinuz-##" | grep -v "$c" | sort -V | sed "s/^/kernel-/"'
