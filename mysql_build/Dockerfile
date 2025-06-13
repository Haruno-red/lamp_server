# ubuntuをベースイメージとして使用する
FROM ubuntu:latest

# パッケージの更新、必要なパッケージのインストール
RUN apt update && apt -y install mysql-server --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# 必要なポート（mysqlの3306番）を開く
EXPOSE 3306

# コンテナ起動時にMySQLをフォアグラウンドで起動する
CMD ["mysqld"]

