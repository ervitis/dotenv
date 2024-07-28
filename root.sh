#!/bin/env bash

CUR_PATH=$(pwd)
INSTALL_PACKAGES_FOLDER_NAME="install_packages"
REQUIREMENTS_FILE="_requirements"
DISTRO=""
OS_TYPE=""

function getOSInfo {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macOS"
    DISTRO=$(sw_vers -productVersion)
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="Linux"
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      DISTRO=$NAME
    elif [ -f /etc/lsb-release ]; then
      . /etc/lsb-release
      DISTRO=$DISTRIB_ID
    else
      DISTRO=$(uname -s)
    fi
  else
    OS_TYPE="unknown"
    DISTRO="unknown"
  fi
}

getOSInfo

case ${OS_TYPE} in
Linux)
  case $DISTRO in
  [fF]edora)
    REQUIREMENTS_FILE="fedora${REQUIREMENTS_FILE}.sh"
    ;;
  *)
    echo "Not supported ${OS_TYPE}"
    exit 1
    ;;
  esac
  ;;
macOS)
  case $DISTRO in
  14.*)
    REQUIREMENTS_FILE="macos${REQUIREMENTS_FILE}.sh"
    ;;
  *)
    echo "Not supported ${DISTRO}"
    exit 1
    ;;
  esac
  ;;
esac

source "${CUR_PATH}/${INSTALL_PACKAGES_FOLDER_NAME}/common.sh"
source "${CUR_PATH}/${INSTALL_PACKAGES_FOLDER_NAME}/${REQUIREMENTS_FILE}"

if [[ "$OS_TYPE" == "Linux" ]]; then
  installLinuxPackages
else
  installMacOsPackages
fi

exit 0

