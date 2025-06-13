# ubuntuをベースイメージとして使用する
FROM ubuntu:latest

# パッケージの更新、必要なパッケージのインストール
RUN apt update && apt -y install --no-install-recommends \
    apache2 \
    php \
    php-mysql \
 && rm -rf /var/lib/apt/lists/*

# index.htmlというファイルをドキュメントルートディレクトリに追加
ADD index.html /var/www/html/
# index.phpというファイルをドキュメントルートディレクトリに追加
ADD index.php /var/www/html/

# 必要なポート（httpの80番）を開く
EXPOSE 80

# コンテナ起動時にApacheをフォアグラウンドで起動する
CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]

