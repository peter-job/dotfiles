#!/bin/bash

echo "Installing atuin"

curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

echo "Done installing atuin"
