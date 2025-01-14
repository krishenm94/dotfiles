set -o vi

source ~/.aliasrc

eval "$(/opt/homebrew/bin/brew shellenv)"

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi
