#!/bin/bash

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Install apt software
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common apt-transport-https ca-certificates curl lsb-release

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# Install Terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

# Install AZ CLI
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: $(lsb_release -cs)
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources

sudo apt-get update
sudo apt-get install azure-cli

# Install SOPS
curl -LO https://github.com/getsops/sops/releases/download/v3.10.2/sops-v3.10.2.linux.amd64
sudo mv sops-v3.10.2.linux.amd64 /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops

# Install golang
curl -LO https://go.dev/dl/go1.24.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz
rm go1.24.3.linux-amd64.tar.gz

# Install Commitizen
sudo apt update
pipx ensurepath
pipx install commitizen

# Starship
curl -sS https://starship.rs/install.sh -o starship.sh
chmod u+x starship.sh
./starship.sh --yes
rm starship.sh

# kind
go install sigs.k8s.io/kind@v0.27.0

# k9s
curl -LO https://github.com/derailed/k9s/releases/download/v0.50.6/k9s_Linux_amd64.tar.gz
tar -C ~/.local/bin -xf k9s_Linux_amd64.tar.gz k9s
rm -f k9s_Linux_amd64.tar.gz

cat >> ~/.bash_profile << EOF
# Make profile auto source zshrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
EOF
