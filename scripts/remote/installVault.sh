#!/bin/bash -e

VAULTVERSION=0.6.0
VAULTDOWNLOAD=https://releases.hashicorp.com/vault/${VAULTVERSION}/vault_${VAULTVERSION}_linux_amd64.zip
VAULTCONFIGDIR=/etc/vault.d

check_vault() {
  {
    type vault &> /dev/null && echo "Vault already installed, skipping" && exit 0
  }
}

download_vault() {
  sudo apt-get install -y zip
  echo "Fetching Vault..."
  curl -L $VAULTDOWNLOAD > vault.zip
}

install_vault() {
  echo "Installing Vault..."
  unzip vault.zip -d /usr/local/bin
  chmod 0755 /usr/local/bin/vault
  chown root:root /usr/local/bin/vault
}

create_config_dirs() {
  echo "Creating Vault configuration..."
  sudo mkdir -p $VAULTCONFIGDIR
  sudo chmod 755 $VAULTCONFIGDIR

}

main() {
  {
    type vault &> /dev/null && echo "Vault already installed, skipping" && return
  }
  pushd /tmp
  check_vault
  download_vault
  install_vault
  create_config_dirs
  popd
}

main
