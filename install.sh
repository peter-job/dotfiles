#!/bin/sh
#
# Install dotfiles via chezmoi
# Copied from [felipecrs' dotfiles install script](https://github.com/felipecrs/dotfiles/blob/c3e0e400e544b3918a856cb10b55672c6ab4c827/install.sh)
# See also [twpayne's original install script](https://github.com/twpayne/dotfiles/blob/cb5ba7a0ba192c7c4a99e411980a4da9848558d7/install.sh)

# -e: exit on error
# -u: exit on unset variables
set -eu

# todo: refactor, too many functions
log_color() {
  color_code="$1"
  shift

  printf "\033[${color_code}m%s\033[0m\n" "$*" >&2
}

log_red() {
  log_color "0;31" "$@"
}

log_blue() {
  log_color "0;34" "$@"
}

log_task() {
  log_blue "🔃" "$@"
}

log_error() {
  log_red "❌" "$@"
}

error() {
  log_error "$@"
  exit 1
}

if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  log_task "Installing chezmoi to '${chezmoi}'"
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://get.chezmoi.io)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://get.chezmoi.io)"
  else
    error "To install chezmoi, you must have curl or wget."
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  unset chezmoi_install_script bin_dir
fi

set -- init --verbose=false "$@"

if [ -n "${DOTFILES_USE_LOCAL_SOURCE-}" ]; then
  # POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
  # shellcheck disable=SC2312
  script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
  set -- "$@" --source="${script_dir}"
else
  set -- "$@" "${DOTFILES_GIT_USERNAME:-peter-job}"
fi

if [ -n "${DOTFILES_ONE_SHOT-}" ]; then
  set -- "$@" --one-shot
else
  set -- "$@" --apply
fi

if [ -n "${DOTFILES_DEBUG-}" ]; then
  set -- "$@" --debug
fi

log_task "Running 'chezmoi $*'"
# replace current process with chezmoi
exec "${chezmoi}" "$@"
