#!/bin/bash

## install tailscale
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt-get update
sudo apt-get install tailscale -y

echo "starting tailscaled"
nohup sudo tailscaled &> /tmp/nohup.out &
if [ -n "$TAILSCALE_AUTHKEY" ]; then
  sudo tailscale up --authkey="$TAILSCALE_AUTHKEY"
fi

sudo apt-get install -y awscli
