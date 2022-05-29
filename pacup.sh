#!/bin/bash
if [ `whoami` != 'root' ]; then
  echo "管理者権限で実行してください"
  exit
fi

function apt_ () {
  sudo apt update

  while getopts ":y" optKey; do
    case "$optKey" in
      y)
        sudo apt -y upgrade
        exit
        ;;
    esac
  done

  sudo apt upgrade

  exit
}

apt_
