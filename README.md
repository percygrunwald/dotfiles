# Percy's dotfiles

## Installation

```
git clone https://github.com/percygrunwald/dotfiles.git ~/.dotfiles
```

Run `script/install.sh` from anywhere to create symlinks from `$HOME` to the files in `files`. Install script is idempotent and will prompt before it attempts to overwrite an existing file.

```
# Install files
script/install.sh

# Show help
script/install.sh -h
```
