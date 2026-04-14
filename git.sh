#!/bin/bash

username=$1

if [ -z "$username" ]; then
  echo "ERROR: username is required"
  exit 1
fi

email=""
token=""

# -----------------------
# Detect email vs token
# -----------------------
if [[ "$2" == *"@"* ]]; then
  email="$2"
  token="$3"
else
  token="$2"
fi

# -----------------------
# Identity (only if email exists)
# -----------------------
if [ -n "$email" ]; then
  git config --global user.name "$username"
  git config --global user.email "$email"
fi

# -----------------------
# Credentials (if token exists)
# -----------------------
if [ -n "$token" ]; then
  git config --global credential.helper store
  echo "https://$username:$token@github.com" > "$HOME/.git-credentials"
fi
