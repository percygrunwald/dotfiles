#!/usr/bin/env bash

# Load the user's ~/.bashrc if it exists
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/percy/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/percy/.lmstudio/bin"
# End of LM Studio CLI section
