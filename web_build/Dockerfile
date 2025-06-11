# ubuntuをベースイメージとして使用する
FROM ubuntu:latest

# パッケージの更新
RUN apt update && apt -y upgrade

# Apacheのインストール
RUN apt-get install -y apache2

# PHPのインストール
RUN apt-get install -y php php-mysql

# index.htmlというファイルをドキュメントルートディレクトリに追加
ADD index.html /var/www/html/

# index.phpというファイルをドキュメントルートディレクトリに追加
ADD index.php /var/www/html/

# 必要なポート（httpの80番）を開く
EXPOSE 80

# コンテナ起動時にApacheをフォアグラウンドで起動する
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]

