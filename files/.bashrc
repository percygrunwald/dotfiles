#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export BASH_SILENCE_DEPRECATION_WARNING=1

# dotfiles-related tasks
# Find the real path of the dotfiles directory
export DOTFILES_DIR=$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")

# Update dotfiles every time the shell starts
if [ -f "${DOTFILES_DIR}"/script/update.sh ]; then
  "${DOTFILES_DIR}"/script/update.sh
fi

# General dev
alias setenv="source ./set_env.sh"

# General shell
alias resource="source ~/.bashrc"
alias now="date +%s"
alias ll="ls -lah"
alias cd..="cd.."
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder; echo 'Flushed!'"
## Prints the last command in history
alias q='$(fc -ln -1)'
function calc {
  awk "BEGIN {print $*}"
}
function s2c {
  tr ' ' ','
}
function s2n {
  tr ' ' '\n'
}
function c2s {
  tr ',' ' '
}
function c2n {
  tr ',' '\n'
}
function n2c {
  tr '\n' ','
}
function n2s {
  tr '\n' ' '
}

# Bundle
alias be="bundle exec"

# Rails
alias rs="bin/rails server"
alias rc="bin/rails console"
alias r="bin/rake"
alias rdm="bin/rake db:migrate"
alias rt="bin/rake test"
alias bs="bin/spring"

# Ansible
alias ap="ansible-playbook"
alias av="ansible-vault"

# Elixir/Phoenix
alias ism="iex -S mix"
alias mt="mix test"
alias mtt="mix test --trace"
alias mps="mix phx.server"
export ERL_AFLAGS="-kernel shell_history enabled"

# pwgen
alias pw="pwgen -s"
alias pws="pwgen -sy"

# Git
alias gc="git commit --all -m"
alias gca="git commit --all --amend"
alias gcapf="git commit --all --amend --no-edit && git push --force"
alias gp="git push"
alias gpf="gp --force"
alias grm='git fetch && git rebase origin/master'
alias grma='git fetch && git rebase origin/main'
alias gc='git checkout'
alias gcmp='gc master && git pull'
alias gcmap='gc main && git pull'
alias gs='git status'
alias gd='git diff'
alias gcane='git commit --all --amend --no-edit'
alias branch='git rev-parse --abbrev-ref HEAD'

# tmux
alias tmc='tmux -CC attach || tmux -CC'

# ASDF
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export ASDF_DATA_DIR=${ASDF_DIR}

# UUIDs
alias uuid="python -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)' | pbcopy && pbpaste && echo"
alias uuidfull="python -c 'import sys,uuid; sys.stdout.write(str(uuid.uuid4()))' | pbcopy && pbpaste && echo"
alias guid="uuid"

# Hugo
alias hugodate="date '+%FT%T+08:00' | pbcopy && pbpaste && echo"

# Python
alias pyserver="python -m SimpleHTTPServer"
alias venv="source .venv/bin/activate"

# Docker
alias de="docker exec"
alias deit="de -i -t"
alias dps="docker ps -a"
alias dil="docker image ls"
alias dr="docker run"
alias drit="docker run --rm -it"
alias drd="dr -d"
alias drdp="drd --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro"
alias drp="dr --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro"
alias drm="docker rm -f"

# Kubernetes
alias k="kubectl"

# Vagrant
alias vu="vagrant up --parallel"
alias vd="vagrant destroy --parallel"
alias vdu="vd && vu"
alias vp="vagrant provision"

# Homebrew
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# VS Code
if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Rancher desktop
if [ -d "$HOME/.rd/bin" ]; then
  export PATH="$HOME/.rd/bin:$PATH"
fi

# Homebrew gnu-sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# PS1/prompt
# Built at https://bashrcgenerator.com/
export PS1="\[$(tput bold)\]\[\033[38;5;10m\]\u@\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

# Meraki
alias s0='svn revert -R . && svn st | cut -d " " -f 8 | xargs rm -rf'
alias s1='svn up && script/svn_avail_fast.rb -U'
alias s2='script/svnmerge merge -b -r'
alias s3='svn commit -F svnmerge-commit-message.txt'
alias sst='sm svn st'
alias sga='sm git apply'
alias sgar='sm git apply --reverse'
alias update_mmap='(cd ~/co/machines-map && gcmp)'
alias cdl='cd ~/co/manage'
alias cdla='cd ~/co/manage/extra/ansible'
alias cdlr='cd ~/co/manage-released'
alias cdmm='cd ~/co/machines-map'
alias ec='jq -r "[.[] | select(.role_info.elasticsearch.cluster != null) | .role_info.elasticsearch.cluster] | unique[]" /var/local/meraki/inventory/machines_map.json'
alias ecnc='(cd ~/co/manage/ && bundle exec script/elasticsearch/cluster_nodes.rb --print-clusters)'
alias asudo='sudo -E env "PATH=$PATH"'
alias m='~/co/manage/script/machines'
function mm {
  if [ "$1" == "" ]; then return; fi
  jq -r ".[] | select(.name == \"$1\") | del(.ssh, .ssh_rsa_pub)" /var/local/meraki/inventory/machines_map.json
}
function mr {
  if [ "$1" == "" ]; then return; fi
  jq -cr ".[] | select(.roles_flat | any(test(\"$1\"))) | {name: .name, roles: .roles_flat}" /var/local/meraki/inventory/machines_map.json
}
function n {
  if [ "$1" == "" ]; then return; fi
  SHARD_ID=$1
  CLUSTER=${2:-meraki.com}
  jq -r ".[] | select((.role_info.dashboard.id == $SHARD_ID or .role_info.master.id == $SHARD_ID) and .cluster == \"$CLUSTER\") | del(.ssh, .ssh_rsa_pub)" /var/local/meraki/inventory/machines_map.json
}
function ecn {
  (cd ~/co/manage/ && bundle exec script/elasticsearch/cluster_nodes.rb --cluster ${1})
}
function inv {
  (cd ~/co/manage/extra/ansible && inventories/${1}.sh | jq . | less)
}
function fp {
  branch=$(branch)
  git format-patch -1 --stdout > ~/patches/${branch}
  echo "${branch}"
}
function p {
  branch=$(branch)
  fp && scp ~/patches/${branch} ${1}:~
}
function pd {
  scp -3 "$1:/home/percy/patches/$2" "$3:/home/percy/$2"
}
function pf {
  scp -3 "sdg0:/home/percy/patches/$1" "chi0:/home/percy/$1"
  ssh -t chi0 "scp /home/percy/$1 $2:/home/percy"
}
function ar {
  (cd extra/ansible && sudo bin/ansible-role ${1} -v -D)
}
function clrq {
  (cd ~/co/manage/ && be script/elasticsearch/cancel_long_running_tasks.rb --action-filter "indices:data/read/search" --target-cluster ${1})
}
function lrq {
  clrq "${1} --list"
}
function fixssh {
  eval "$(tmux show-env -s |grep '^SSH_')"
}
function github_stars {
  curl -s "https://api.github.com/repos/${1}" | jq '.["stargazers_count"]'
}
function artifactory_auth () {
    OP_JSON=$(op item get artifactory.ikarem.io --vault Employee --format json)
    export BUNDLE_ARTIFACTORY__IKAREM__IO="$(echo $OP_JSON | jq '.fields[] | select(.id=="username") | .value' | sed 's/"//g'):$(echo $OP_JSON |jq '.fields[] | select(.id=="password") | .value' | sed 's/"//g')"
}

# Add $HOME/bin to $PATH to allow for user binaries with max priority
export PATH=$HOME/bin:$PATH

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/percy/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
