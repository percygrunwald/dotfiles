#!/usr/bin/env bash

function print_usage {
  cat << 'EOF'
Usage:  install.sh [options]

Options:
        -f : Overwrite existing files with symlinks without prompting
        -h : Print this help text
EOF
}

function print_help {
  cat << 'EOF'
This script installs all files in the "./files" directory into \$HOME with a
symlink. Relative paths under "./files" are maintained under \$HOME such that
"./files/path/.dotfile" is symlinked from "\$HOME/path/.dotfile". This script
is idempotent and will prompt if a file already exists, unless run with "-f".
The script will create any missing directories.

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

# Get input from the user to make some choice.
#
# Args:
#   $* - The prompt for the user
#
# Returns:
#   Global variable $CHOICE - The user response. "y", "Y", "1" and "yes" are all
#   standardized to "y". "n", "N", "0" and "no" are all standardized to "n". All
#   other responses are returned as-is.
#
# Usage:
#   choice Do you wish to delete the file?
function choice {
  CHOICE=''
  local prompt=$*
  local answer

  read -p "$prompt " answer
  case "$answer" in
    [yY1] | yes ) CHOICE=y ;;
    [nN0] | no ) CHOICE=n ;;
    *     ) CHOICE="$answer" ;;
  esac
}

# Symlink a file from the files_dir in the local repo into $HOME, preserving
# the relative path under the files dir.
#
# $HOME/path/to/.dotfile -> /path/to/repo/files/.dotfile
#
# Args:
#   $1 - The absolute path of the file
#   Global variable $ABS_FILES_DIR - The absolute path of the files dir
#
# Returns:
#   Nothing
#
# Usage:
#   link_file /path/to/.dotfile
function link_file {
  local file=$1
  local rel_file_path=${file##$ABS_FILES_DIR/}
  local dest="$HOME/$rel_file_path"

  if [ \( ! -e "$dest" \) -o "$FORCE" == y ]; then
    printf '%b\n' "Linking $dest -> $file..."
    ln -f -s "$file" "$dest"
    continue
  fi

  choice "File $dest already exists, overwrite?"

  if [ $CHOICE == "y" ]; then
    printf '%b\n' "Overwriting existing file with link $dest -> $file..."
    ln -f -s "$file" "$dest"
  else
    printf '%b\n' "Not overwriting file $dest, moving on..."
    continue
  fi
}

FORCE=n
HELP=n
while getopts 'fh' OPTION; do
  case ${OPTION} in
    f ) FORCE=y ;;
    h ) HELP=y ;;
    * ) print_usage >&2
        exit 2
        ;;
  esac
done
shift $(($OPTIND - 1))

if [ "$HELP" == y ]; then
  print_help >&2
  exit 1
fi

ABS_SCRIPT_PATH=$(abs_path $0)
ABS_ROOT_DIR=$(dirname $(dirname "$ABS_SCRIPT_PATH"))
REL_FILES_DIR=files
ABS_FILES_DIR="$ABS_ROOT_DIR/$REL_FILES_DIR"
FILES=$(find $ABS_FILES_DIR -type f)

for FILE in $FILES; do
  link_file "$FILE"
done
