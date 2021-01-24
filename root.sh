#!/bin/env bash

CUR_PATH=$(pwd)
INSTALL_PACKAGES_FOLDER_NAME="install_packages"
REQUIREMENTS_FILE="_requirements"
DISTRO=""

function getDistroName {
  if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
  # Otherwise, use release info file
  else
      DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1 | head -n1)
  fi
}

getDistroName

case $DISTRO in
  [fF]edora )
    REQUIREMENTS_FILE="fedora${REQUIREMENTS_FILE}.sh"
    ;;

  *)
    echo "Not supported ${DISTRO}"
    exit 1
    ;;
esac

source "${CUR_PATH}/${INSTALL_PACKAGES_FOLDER_NAME}/common.sh"
source "${CUR_PATH}/${INSTALL_PACKAGES_FOLDER_NAME}/${REQUIREMENTS_FILE}"

installRootPackages

exit 0