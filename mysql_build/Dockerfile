# ubuntuをベースイメージとして使用する
FROM ubuntu:latest

# パッケージの更新、必要なパッケージのインストール
RUN apt update && apt install -y --no-install-recommends mysql-server \
 && rm -rf /var/lib/apt/lists/*

# 必要なポート（mysqlの3306番）を開く
EXPOSE 3306

# コンテナ起動時にMySQLをフォアグラウンドで起動する
CMD ["mysqld"]

