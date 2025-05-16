export PATH="$PATH:/usr/local/go/bin:/home/coder/.local/bin:/opt/nvim-linux-x86_64/bin"

if [ -f /usr/local/bin/starship ]; then
  eval "$(starship init bash)"
fi

alias vim=nvim
export EDITOR=nvim
