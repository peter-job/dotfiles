# shellcheck shell=bash


# Load dotfiles if they're readable and regular files
load_dotfiles() {
local file
  local dotfiles=(
    ~/.path
    ~/.aliases
    ~/.extra
  )
  for file in $dotfiles; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
  done
}

load_dotfiles
