# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export BASH_SILENCE_DEPRECATION_WARNING=1

# dotfiles-related tasks
# Find the real path of the dotfiles directory
export DOTFILES_DIR=$(dirname $(dirname $(realpath ${BASH_SOURCE[0]})))

# Update dotfiles every time the shell starts
${DOTFILES_DIR}/script/update.sh

export ERL_AFLAGS="-kernel shell_history enabled"

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export ASDF_DATA_DIR=${ASDF_DIR}

# pip
export PATH=~/.local/bin:$PATH

# Homebrew gnu-sed
# export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Add $HOME/bin to $PATH to allow for user binaries with max priority
export PATH=$HOME/bin:$PATH

# Source aliases
source .bashrc_aliases

# Source functions
source .bashrc_functions

# PS1/prompt
# Built at https://bashrcgenerator.com/
# export PS1="\[$(tput bold)\]\[\033[38;5;10m\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"
