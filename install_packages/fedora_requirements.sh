function installDocker {
  sudo dnf -y install dnf-plugins-core

  sudo tee /etc/yum.repos.d/docker-ce.repo<<EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/31/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF

  sudo dnf makecache
  sudo dnf install -y docker-ce docker-ce-cli containerd.io

  sudo systemctl enable --now docker

  sudo usermod -aG docker $(whoami)
  newgrp docker
}

function installDevelopmentTools {
  sudo dnf -y groupinstall "Development Tools"
}

function installNodeJS {
  sudo dnf install -y nodejs
}

function installListPackages {
  cur_path=$(pwd)"/install_packages"
  input=$cur_path"/list"

  while IFS= read -r line
  do
    sudo dnf install -y "$line"
  done < "$input"
}

function updatePackages {
  sudo dnf update -y
}

function main {
  updatePackages

  installGolang

  installListPackages
}

source $(pwd)"/install_packages/common.sh"

main
