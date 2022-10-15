#!/bin/bash
function usage() {
    cat <<EOM
Usage: $(basename "$0") [OPTION]...
    -h 		Display help
    -y		Skip input 'y'
    -f		Run full-upgrade
EOM

    exit 2
}

function update_y() {
    echo 'Skip input "y"'
    apt update && apt -y upgrade
    exit 0
}

function update_full() {
    echo 'Run full-upgrade'
    apt update && apt -y full-upgrade
    exit 0
}

if [ `whoami` != 'root' ]; then
    echo "管理者権限で実行してください"
    exit 0
fi

while getopts :hyf optKey; do
    case "$optKey" in
	y) update_y ;;
	f) update_full ;;
    '-h'|'--help'|* ) usage ;;
    esac
done
apt update && apt upgrade
exit 0
