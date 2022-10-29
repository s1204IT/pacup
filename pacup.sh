#!/usr/bin/env bash


# ヘルプ
function usage() {
  cat <<EOM
使用方法: $(basename $0) [オプション]...
    -a          APTのみ実行
    -y		'y'の入力をスキップします
    -h          ヘルプを表示します
EOM
}

# オプションの読み取り
while (($#>0)); do
  case $1 in
    a|-a|--apt)
      PACUP_MOD="apt"
      ;;
    y|-y|--yes)
      PACUP_YES=" -y"
      ;;
    h|-h|--help)
      usage
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
  # $1が無くなるまで繰り返す
  shift
done

function PACUP_SYS() {
  # install_pacup.sh から書込
  : #SYS
}

function PACUP_APT() {
  echo -e "\napt update を実行します"
  sudo apt update
  echo -e "\napt dull-upgrade$PACUP_YES を実行します"
  sudo apt full-upgrade$PACUP_YES
  echo -e "\napt autoremove$PACUP_YES を実行します"
  sudo apt autoremove$PACUP_YES
}

# APTでの更新のみ実行
if [ "$PACUP_MOD" == "apt" ]; then
   PACUP_APT
  # Root要求が失敗した際にリトライ
  if [ $? != 0 ]; then
    echo -e "\nAPTコマンドの実行はRoot(管理者)権限を要求します｡\nもう一度お試しください｡\n"
    PACUP_APT
    # リトライも失敗した際にエラーで終了
    if [ $? != 0 ]; then
      echo -e "\n権限の昇格に失敗したため､ 実行を終了しました｡"
      exit 1
    fi
  fi
  exit 0
fi

# APTでの更新
PACUP_APT
if [ $? != 0 ]; then
  echo -e "\nRoot(管理者)権限を要求しています｡\nもう一度お試しください｡\n"
  PACUP_SYS
  if [ $? != 0 ]; then
    echo -e "\n権限の昇格に失敗したため､ 実行を終了しました｡"
    exit 1
  fi
fi

# Flatpakコマンドが存在する場合に install_pacup.sh より書込
#FPK
# RootユーザーでのSnapとFlatpakの更新
PACUP_SYS
echo -e "\n完了しました！"
exit 0
