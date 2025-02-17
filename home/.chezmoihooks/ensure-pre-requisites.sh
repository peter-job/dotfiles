#!/bin/bash

###############################################################################
# MIT License

# Copyright (c) 2020 Felipe Santos

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
###############################################################################

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
