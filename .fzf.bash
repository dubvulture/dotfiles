# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mrota/.fzf-git/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mrota/.fzf-git/bin"
fi

eval "$(fzf --bash)"
