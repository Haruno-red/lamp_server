#!/bin/bash -eu

# 環境変数が設定されているか確認
function check_env() {
  local error_message=""
  if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_ROOT_PASSWORD が設定されていません。\n"
  fi
  if [ -z "$MYSQL_USER" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_USER が設定されていません。\n"
  fi
  if [ -z "$MYSQL_PASSWORD" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_PASSWORD が設定されていません。\n"
  fi
  if [ -z "$MYSQL_DATABASE" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_DATABASE が設定されていません。\n"
  fi
  local success=""
  if [ -z "${error_message}" ]; then
    echo "Succeeded: 環境変数が設定されています。"
    return 0
  else
    echo -e "$error_message"
    return 1    
  fi
}

# auth_testというデータベースを作成
function create_database(){
  mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
  if [ $? -eq 0 ]; then
    echo "データベース '$MYSQL_DATABASE' が正常に作成されました。"
    return 0
  else
    echo "データベース '$MYSQL_DATABASE' の作成に失敗しました。"
    return 1
  fi
}

# auth_testデータベース内にtestテーブルを作成し、サンプルデータを格納
function setup_table(){
  mysql --user=root --password=$MYSQL_ROOT_PASSWORD -D "$MYSQL_DATABASE" -e "CREATE TABLE IF NOT EXISTS test (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(20), age INT);"
  if [ $? -eq 0 ]; then
    echo "テーブル 'test' が正常に作成されました。"
    mysql --user=root --password=$MYSQL_ROOT_PASSWORD -D "$MYSQL_DATABASE" -e "INSERT INTO test (name, age) VALUES ('abc', '25'), ('def', '26'), ('ghi', '27');"
    if [ $? -eq 0 ]; then
      echo "テーブル 'test' のデータが更新されました。"
      return 0
    else
      echo "テーブル 'test' のデータが更新できませんでした。"
      return 1
    fi
  else
    echo "テーブル 'test' の作成に失敗しました。"
    return 1
  fi
}

# 外部からの接続を許可したsample_userというユーザを作成
function create_user(){
  mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER 'sample_user' identified by '$MYSQL_PASSWORD';"
  mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON auth_test.test TO 'sample_user'@'%' WITH GRANT OPTION;"
}


function main(){
  check_env
  create_database
  setup_table
  create_user
}

main

