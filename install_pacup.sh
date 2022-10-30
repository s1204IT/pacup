#!/usr/bin/env bash


# Bashであるかどうかの検証
if [ ! "$BASH_VERSION" ]; then
  echo "Bashで実行して下さい"
  exit 1
fi

# Debian系であるかどうかの検証
if [ ! -f /etc/debian_version ];then
  echo -e "このディストリビューションには､ \"pacup\" をインストール出来ません｡\n\nDebian系 もしくは Debian派生系のみ対応しています｡"
  exit 1
fi

# スクリプトのパスを取得
PACUP_SET=$(dirname $(readlink -f $0))

# 同じパスで実行されているかどうか
if [ ! -f ./pacup.sh ]; then
  cd $PACUP_SET
  if [ ! -f ./pacup.sh ]; then
    echo -e "同じパスに \"pacup\" ファイルが見つかりませんでした\n"
    exit 1
  fi
fi

# Rootに成る前に現在のユーザー情報を取得
if [ `id -u` != 0 ]; then
  echo USR_ID=$(id -u)>id
  echo USR_GRP=$(id -g)>>id
fi

# Rootを要求
if [ `id -u` != 0 ]; then
  sudo $PACUP_SET/$(basename $0)
  # 失敗した際にエラーで終了
  if [ $? != 0 ]; then
    echo "Root(管理者)権限で実行してください"
    exit 1
  fi
  exit 0
fi

# 再セットアップする際に最新版に書換
if [ -f /usr/local/bin/pacup ] && [ -d ./.git ]; then
  git fetch origin
  git reset --hard &>/dev/null
fi

# Snapd の確認
command -v snap &>/dev/null
# WSLはスキップ
if [ $? == 0 ] && [ ! -f /usr/bin/wslsys ]; then
   sed -i -e "/^  : #SYS$/a \ \ echo -e \"\\\nsnap refresh を実行します\"\n\ \ sudo snap refresh" ./pacup.sh
fi
# Flatpak の確認
command -v flatpak &>/dev/null
if [ $? == 0 ]; then
   sed -i -e "s/#FPK/echo -e \"\\\nflatpak update\$PACUP_YES を実行します\"\nflatpak update\$PACUP_YES/g" ./pacup.sh
   sed -i -e "/^  : #SYS$/a \ \ echo -e \"\\\nflatpak update\$PACUP_YES を実行します\"\n\ \ sudo flatpak update\$PACUP_YES" ./pacup.sh
fi

# ファイルを強制コピー
cp -f ./pacup.sh /usr/local/bin/pacup
# 読取/実行 権限を付与
chmod +rx /usr/local/bin/pacup

# 書き加えた変更を戻す
if [ -d ./.git ]; then
  git checkout ./pacup.sh &>/dev/null
fi
if [ -f ./id ]; then
  . ./id
  chown $USR_ID:$USR_GRP ./pacup.sh
  rm -f ./id
fi

echo "完了しました！"
exit 0
