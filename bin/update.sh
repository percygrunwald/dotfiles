#!/usr/bin/env bash

set -e

function print_usage {
  printf 'Usage: %s [options]\n' ${0##*/}
  cat << 'EOF'

Options:
        -h : Print this help text
EOF
}

function print_help {
  cat << 'EOF'
Pulls from the dotfiles repo and ensures all files are installed, silently.
Assumes this script is being run from within a dotfiles git repo.

EOF
print_usage
}

# Get the absolute path of a file
#
# Args:
#   $1 - The file path
#
# Returns:
#   stdout - The absolute path to the file
#
# Usage:
#   abs_path ./rel/path/to/file
#     => /abs/path/to/file
function abs_path {
  printf '%b' "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

HELP=n
while getopts 'fh' OPTION; do
  case ${OPTION} in
    h ) HELP=y ;;
    * ) print_usage >&2
        exit 2
        ;;
  esac
done
shift $(($OPTIND - 1))

if [ "$HELP" == "y" ]; then
  print_help >&2
  exit 1
fi

ABS_ROOT_DIR=$(dirname $(dirname $(abs_path ${0})))
REPO_PATH="${ABS_ROOT_DIR}/.git"

printf "Checking for updates to dotfiles... "

GIT_PULL_RES=$(git --git-dir ${REPO_PATH} pull)

if [[ "$GIT_PULL_RES" == "Already up to date." ]]; then
  printf "Already up to date!\n"
  exit 0;
fi

printf "dotfiles updated, running install...\n"
${ABS_ROOT_DIR}/bin/install.sh -f
printf "All files linked and updated, please reload the shell to ensure changes were applied.\n"
