#!/bin/bash
if [ `whoami` != 'root' ]; then
  echo "管理者権限で実行してください"
  exit 0
fi

. /etc/os-release

if [ ${ID} != "debian" ]; then
    echo ""
    exit 0
fi

script_path="$(dirname "$(readlink -f "$0")")"

cd ${script_path}
sudo cp ./pacup.sh /usr/bin/pacup
sudo chmod +x /usr/bin/pacup
echo "Success!"

exit
