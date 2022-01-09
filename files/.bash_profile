# Load the user's ~/.bashrc if it exists
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Add $HOME/bin to the end of $PATH to allow for user binaries
PATH=$PATH:$HOME/bin
export PATH
