#!/bin/bash
function usage() {
    cat <<EOM
Usage: $(basename "$0") [OPTION]...
    -h 		Display help
    -y		Skip input 'y'
    -f      Run full-upgrade
EOM

    exit 2
}

function update_y() {
    apt update && apt -y upgrade
    exit 0
}

function update_full() {
    apt update && apt full-upgrade -y
    exit 0
}

if [ `whoami` != 'root' ]; then
    echo "管理者権限で実行してください"
    exit 0
fi

while getopts ":h:y:f" optKey; do
    case "$optKey" in
    	y)
    	  update_y
          ;;    	
        f)
          upgrade_full
          ;;
    	'-h'|'--help'|* )
    	  usage
    	  ;;
    esac
done
apt update && apt upgrade
exit 0
