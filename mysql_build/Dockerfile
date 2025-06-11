# ubuntuをベースイメージとして使用する
FROM ubuntu:latest

# パッケージの更新
RUN apt update && apt -y upgrade

# MySQLサーバのインストール
RUN apt-get install -y mysql-server

# 必要なポート（mysqlの3306番）を開く
EXPOSE 3306

# コンテナ起動時にMySQLをフォアグラウンドで起動する
CMD ["mysqld"]

