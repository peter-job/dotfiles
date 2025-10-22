#!/bin/sh

# Install dotfiles via chezmoi

set -e # -e: exit on error

# Set profile to "work"
export DOTFILES_PROFILE="work"

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

set -- init

if [ -n "${DOTFILES_USE_LOCAL_SOURCE-}" ]; then
  # POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
  # shellcheck disable=SC2312
  script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
  set -- "$@" --source="$script_dir"
else
  # Clone from github by default
  # In dev containers we want this because local source is only a shallow clone
  # Repo name must be "dotfiles".
  # If you use a different repo name, add a forward slash and repo name after the username below.
  set -- "$@" "${DOTFILES_GITHUB_USERNAME:-peter-job}"
fi

set -- "$@" --apply

echo "Executing '$chezmoi $*"

# Replace current process with chezmoi + init args
exec "$chezmoi" "$@"