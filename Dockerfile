FROM ruby:3.3.3

# Node.jsとYarnをインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

RUN npm install --global yarn

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    default-mysql-client \
    default-libmysqlclient-dev \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# アプリケーションディレクトリを作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerをインストールしてgemをインストール
RUN bundle install

# package.jsonとyarn.lockをコピー
COPY package.json yarn.lock ./

# Node.jsの依存関係をインストール
RUN yarn install

# アプリケーションのコードをコピー
COPY . .

# アセットをプリコンパイル
RUN bundle exec rails assets:precompile

# ポート3000を公開
EXPOSE 3000

# サーバーを起動
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
