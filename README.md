# ssh-tar-backup

## Overview
A simple Windows batch script to back up a remote Linux file or directory by streaming a `tar.gz` archive over SSH, without creating any intermediate files on the Linux host.

## Installation
```bash
# 1. Clone this repository
git clone https://github.com/daishir0/ssh-tar-backup.git

# 2. Change into the repo directory
cd ssh-tar-backup

# 3. Edit the configuration at the top of linuxbackup.bat:
#    - REMOTE_USER
#    - REMOTE_HOST
#    - SSH_KEY_PATH
#    - SSH_PORT
#    - LOCAL_OUTPUT_DIR
````

## Usage

From a Windows Command Prompt, run:

```bat
cd ssh-tar-backup
linuxbackup.bat /path/to/remote/item
```

This will connect to your Linux host over SSH, stream-compress `/path/to/remote/item` as a `tar.gz`, and save it locally as `item.tar.gz` in the script’s folder (or the directory you set in `LOCAL_OUTPUT_DIR`).

## Notes

* Make sure your SSH key file (`SSH_KEY_PATH`) has the correct permissions and that the Windows user running the script can read it.
* This script is designed for CMD; PowerShell users may need to adjust redirection syntax.
* For long transfers on unreliable networks, consider enabling `ServerAliveInterval` in your SSH config.
* To leverage multi-core compression on the Linux side, install `pigz` and replace the `tar czf -` command with:

  ```bash
  tar c --use-compress-program="pigz -p4" -f - -C !REMOTE_DIR! !ITEM_NAME!
  ```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

# ssh-tar-backup

## 概要

Windows のバッチスクリプトで、Linux 側に一時ファイルを残さずに SSH 経由でディレクトリやファイルを `tar.gz` 圧縮しつつバックアップするツールです。

## インストール方法

1. リポジトリをクローンします。

   ```bash
   git clone https://github.com/daishir0/ssh-tar-backup.git
   ```
2. クローンしたディレクトリに移動します。

   ```bash
   cd ssh-tar-backup
   ```
3. `linuxbackup.bat` の先頭にある設定値を編集します。

   * `REMOTE_USER`
   * `REMOTE_HOST`
   * `SSH_KEY_PATH`
   * `SSH_PORT`
   * `LOCAL_OUTPUT_DIR`

## 使い方

コマンドプロンプトから以下を実行します。

```bat
cd ssh-tar-backup
linuxbackup.bat /path/to/remote/item
```

指定したリモートパス（ファイルまたはディレクトリ）を `tar.gz` としてストリーミング圧縮し、ローカルに `item.tar.gz` という名前で保存します。

## 注意点

* SSH 鍵ファイル（`SSH_KEY_PATH`）のパーミッションを適切に設定し、Windows ユーザーが読み取り可能にしてください。
* CMD 向けに書かれています。PowerShell で利用する場合、リダイレクト等の構文を調整してください。
* 長時間の転送や不安定な回線では、SSH の `ServerAliveInterval` を設定すると再接続に強くなります。
* Linux 側でマルチコア圧縮を行う場合は `pigz` をインストールし、`tar czf -` の部分を以下のように置き換えてください：

  ```bash
  tar c --use-compress-program="pigz -p4" -f - -C !REMOTE_DIR! !ITEM_NAME!
  ```

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。詳細は LICENSE ファイルを参照してください。

