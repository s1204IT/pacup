# pacup
***Simplify package updates***

Debian系 もしくは Debian派生系のディストリビューションで､ パッケージのアップデートをする際に  
`sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo snap refresh && flatpak update`  
と入力するのを `pacup` として**大幅に短縮する**コマンドです｡

### オプション
- `-y`: 続行を確認をスキップします
- `-a`: APTのみ実行します

## インストール方法
```
sudo apt install -y git
git clone https://github.com/s1204IT/pacup
sudo ./pacup/install_pacup.sh
```
コピー＆ペーストで実行して下さい｡  
更新を適用する場合は､ `install_pacup.sh`を実行すると自動で処理されます｡  
※通常､ クローンされたフォルダが削除されていない場合に限りますが､ 上記と同じコマンドを実行しても処理されます｡
