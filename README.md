# pacup
Simplify package updates

Ubuntu/Debian系のディストリで、パッケージのアップデートをする際に
```sudo apt update && sudo apt upgrade```　と入力するのを
```sudo pacup```　といった風に短縮するためのコマンドです.

```-y```　オプションをつけることで途中のy入力をスキップできます
```-f```　オプションをつけることでfull-upgradeを実行します

## インストール方法
```
git clone https://github.com/PengiNN/pacup
sudo bash ./pacup/install_pacup.sh
```
