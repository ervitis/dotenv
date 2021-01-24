function installGolang {
  sudo curl -L https://raw.githubusercontent.com/udhos/update-golang/master/update-golang.sh | bash
}

function installCommon {
  installGolang
}