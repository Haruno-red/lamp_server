#!/bin/bash -eu

readonly SUCCESS="0"
readonly FAILURE="1"

# 環境変数が設定されているか確認
function check_env(){
  local error_message=""
  if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_ROOT_PASSWORD が設定されていません。\n"
  fi
  if [ -z "${MYSQL_USER}" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_USER が設定されていません。\n"
  fi
  if [ -z "${MYSQL_PASSWORD}" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_PASSWORD が設定されていません。\n"
  fi
  if [ -z "${MYSQL_DATABASE}" ]; then
    error_message="${error_message}Error: 環境変数 MYSQL_DATABASE が設定されていません。\n"
  fi
  local success=""
  if [ -z "${error_message}" ]; then
    echo "Succeeded: 環境変数が設定されています。"
    return ${SUCCESS}
  else
    echo -e "${error_message}"
    return ${FAILURE}
  fi
}

# MySQL実行関数（第一引数：SQL文、第二引数：データベース名）
function exec_mysql(){
  if [ $# -eq 1 ]; then
    mysql --user=root --password=${MYSQL_ROOT_PASSWORD} -e "$1"
    return ${SUCCESS}
  elif [ $# -eq 2 ]; then
    mysql --user=root --password=${MYSQL_ROOT_PASSWORD} -D $2 -e "$1"
    return ${SUCCESS}
  else
    echo "引数の数が正しくありません。"
    return ${FAILURE}
  fi
}

# auth_testというデータベースを作成
function create_database(){
  exec_mysql "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
  if [ $? -eq 0 ]; then
    echo "データベース '${MYSQL_DATABASE}' が正常に作成されました。"
    return ${SUCCESS}
  else
    echo "データベース '${MYSQL_DATABASE}' の作成に失敗しました。"
    return ${FAILURE}
  fi
}

# auth_testデータベース内にtestテーブルを作成し、サンプルデータを格納
function setup_table(){
  exec_mysql "CREATE TABLE IF NOT EXISTS test (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(20), age INT);" "${MYSQL_DATABASE}"
  if [ $? -eq ${SUCCESS} ]; then
    echo "テーブル 'test' が正常に作成されました。"
    exec_mysql "INSERT INTO test (name, age) VALUES ('abc', '25'), ('def', '26'), ('ghi', '27');" "${MYSQL_DATABASE}"
    if [ $? -eq ${SUCCESS} ]; then
      echo "テーブル 'test' のデータが更新されました。"
      return ${SUCCESS}
    else
      echo "テーブル 'test' のデータが更新できませんでした。"
      return ${FAILURE}
    fi
  else
    echo "テーブル 'test' の作成に失敗しました。"
    return ${FAILURE}
  fi
}

# 外部からの接続を許可したsample_userというユーザを作成
function create_user(){
  exec_mysql "CREATE USER '${MYSQL_USER}' identified by '${MYSQL_PASSWORD}';"
  exec_mysql "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.test TO '${MYSQL_USER}'@'%' WITH GRANT OPTION;"
  if [ $? -eq ${SUCCESS} ]; then
    echo "ユーザ '${MYSQL_USER}' が正常に作成されました。"
    return ${SUCCESS}
  else
    echo "ユーザ '${MYSQL_USER}' の作成に失敗しました。"
    return ${FAILURE}
  fi
}


function main(){
  check_env
  create_database
  setup_table
  create_user
}

main

