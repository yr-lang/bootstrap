#!/bin/bash
set -e

USER_NAME="yrkit"

if [ "$1" != "--skip-user" ] && [ "$USER" != "$USER_NAME" ]; then
  id "$USER_NAME" >/dev/null 2>&1 || sudo useradd -m -s /bin/bash -G sudo "$USER_NAME"
  exec sudo -u "$USER_NAME" -H bash "$0"
fi

BOOTSTRAP_DIR="$HOME/.yrkit-bootstrap"
mkdir -p "$BOOTSTRAP_DIR"

sudo apt update
sudo apt install -y nodejs npm git jq ack docker.io docker-compose gh curl python-is-python3

sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker $USER

export NVM_DIR="$HOME/.nvm"

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
fi

source "$NVM_DIR/nvm.sh"

nvm install 22
nvm use 22
nvm alias default 22

npm list -g pm2 >/dev/null 2>&1 || npm i -g pm2
npm list -g http-server >/dev/null 2>&1 || npm i -g http-server
npm list -g yr-cli >/dev/null 2>&1 || npm i -g yr-cli

curl -fsSL https://raw.githubusercontent.com/yr-lang/bootstrap/main/docker-compose.yml \
  -o "$BOOTSTRAP_DIR/docker-compose.yml"

newgrp docker <<EOF
docker-compose -f "$BOOTSTRAP_DIR/docker-compose.yml" up -d
EOF

mkdir -p "$HOME/.yrlibs"
DOTFILES_DIR="$HOME/.yrlibs/dotfiles"
DOTFILES_REPO="https://github.com/yr-lang/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  git -C "$DOTFILES_DIR" pull
fi

cd "$DOTFILES_DIR" && ./install.sh && cd -

exec bash
