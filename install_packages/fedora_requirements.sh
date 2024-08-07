function installDocker {
  sudo dnf -y install dnf-plugins-core

  sudo tee /etc/yum.repos.d/docker-ce.repo <<EOF
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

  while IFS= read -r line; do
    sudo dnf install -y "$line"
  done <"$input"
}

function installButtercup {
  curl -o /tmp/buttercup.rpm -L https://github.com/buttercup/buttercup-desktop/releases/download/v1.20.5/buttercup-desktop-1.20.5.x86_64.rpm
  sudo rpm -i /tmp/buttercup.rpm
}

function updatePackages {
  sudo dnf update -y
}

function installRootPackages {
  updatePackages

  installGolang
  installDevelopmentTools
  installNodeJS
  installDocker

  installListPackages
}
