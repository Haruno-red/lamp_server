#!/bin/bash

# 環境変数が設定されているか確認
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ];
then
  echo "Error: 環境変数 MYSQL_ROOT_PASSWORD, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE が設定されていません。"
  exit 1
fi

# MySQLに接続する
mysql --user=root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
if [ $? -eq 0 ];
then
  echo "データベース '$MYSQL_DATABASE' が正常に作成されました。"
else
  echo "データベース '$MYSQL_DATABASE' の作成に失敗しました。"
fi

