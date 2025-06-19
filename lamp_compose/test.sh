#!/bin/bash -eu

# 環境変数が設定されているか確認
function check_env() {
  output=""
  success="Succeeded: 環境変数が設定されています。"
  if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    output="${output}Error: 環境変数 MYSQL_ROOT_PASSWORD が設定されていません。\n"
  fi
  if [ -z "$MYSQL_USER" ]; then
    output="${output}Error: 環境変数 MYSQL_USER が設定されていません。\n"
  fi
  if [ -z "$MYSQL_PASSWORD" ]; then
    output="${output}Error: 環境変数 MYSQL_PASSWORD が設定されていません。\n"
  fi
  if [ -z "$MYSQL_DATABASE" ]; then
    output="${output}Error: 環境変数 MYSQL_DATABASE が設定されていません。\n"
  fi
  if [ -z "${output}" ]; then
    output="$success"
    echo "$output"
  else
    echo -e "$output"
    exit 1    
  fi
  return 0
}


# MySQLに接続して、auth_testというデータベースを作成
function create_database(){
  mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
  if [ $? -eq 0 ]; then
    echo "データベース '$MYSQL_DATABASE' が正常に作成されました。"
  else
    echo "データベース '$MYSQL_DATABASE' の作成に失敗しました。"
  fi
}

function main(){
  check_env
  create_database
}

main

