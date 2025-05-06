@echo off
setlocal enabledelayedexpansion

REM ===================================================
REM 【ここだけ書き換えてください】（サンプル値です）
REM ===================================================
set "REMOTE_USER=your_user"
set "REMOTE_HOST=your.server.com"
set "SSH_KEY_PATH=C:\path\to\your_private_key.pem"
set "SSH_PORT=22"
set "LOCAL_OUTPUT_DIR=%~dp0"    REM バックアップファイルを置くローカルフォルダ（デフォルト：この .bat と同じ場所）
REM ===================================================

REM --- 引数チェック ---
if "%~1"=="" (
  echo 使用法: %~n0 ^<リモートのファイル_or_ディレクトリ_パス^>
  echo 例: %~n0 /path/to/remote/item
  goto :EOF
)

REM --- 引数からアイテム名（最後の要素）を抽出 ---
set "REMOTE_PATH=%~1"
for %%F in ("%REMOTE_PATH%") do (
  set "ITEM_NAME=%%~nxF"
)
set "REMOTE_DIR=!REMOTE_PATH:%ITEM_NAME%=!"

REM --- ローカル出力先ファイル名 ---
set "OUTPUT_FILE=%LOCAL_OUTPUT_DIR%\!ITEM_NAME!.tar.gz"

echo.
echo Backing up "!REMOTE_PATH!" from %REMOTE_USER%@%REMOTE_HOST%...
echo   -> remote dir: !REMOTE_DIR!
echo   -> item name : !ITEM_NAME!
echo   -> saving to: !OUTPUT_FILE!
echo.

REM --- 実行 ---
ssh -p %SSH_PORT% %REMOTE_USER%@%REMOTE_HOST% -i "%SSH_KEY_PATH%" ^
    "tar czf - -C !REMOTE_DIR! !ITEM_NAME!" > "!OUTPUT_FILE!"

if errorlevel 1 (
  echo.
  echo [ERROR] バックアップに失敗しました。
  exit /b 1
) else (
  echo.
  echo [OK] バックアップ完了: "!OUTPUT_FILE!"
)

endlocal
