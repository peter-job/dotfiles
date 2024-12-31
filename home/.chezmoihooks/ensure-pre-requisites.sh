#!/bin/bash

# This script must exit as fast as possible when pre-requisites are already
# met, so we only import the scripts-library when we really need it.

set -eu

wanted_packages=(
  git  # used to find the latest revisions of github repositories
  curl # used to find the latest version of github repositories
  zsh
)

missing_packages=()

for package in "${wanted_packages[@]}"; do
  if ! command -v "${package}" >/dev/null; then
    missing_packages+=("${package}")
  fi
done

if [[ ${#missing_packages[@]} -eq 0 ]]; then
  exit 0
fi

if ! command -v apt >/dev/null; then
  echo "This script only supports APT-based systems."
  exit 1
fi

if [[ "$(id -u)" -ne 0 ]]; then
  # Ensure sudo is installed
  if ! command -v sudo >/dev/null; then
    echo "sudo not found. Installing sudo..."
    apt update
    apt install -y sudo
  fi

  echo "Installing missing packages with APT: ${missing_packages[*]}"
  sudo apt update
  sudo DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends "${missing_packages[@]}"
else
  echo "Installing missing packages with APT: ${missing_packages[*]}"
  apt update
  DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends "${missing_packages[@]}"
fi

echo "Packages installed successfully."
