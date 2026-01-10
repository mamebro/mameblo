# まめぶろ
![GitHub Actions](https://github.com/mamebro/mameblo/actions/workflows/ruby.yml/badge.svg)
[![Coverage Status](https://coveralls.io/repos/mamebro/mameblo/badge.svg)](https://coveralls.io/r/mamebro/mameblo)

https://mameblo.com/
日本の豊かなブログサービスです。

## 開発
### 開発環境構築
```
docker-compose build
docker-compose run --rm web bundle install
docker-compose run --rm web rails db:setup
docker-compose up
```

### テスト
```
docker-compose run --rm web bundle exec rspec
```

## CAPTCHA (Cap.js)

ログイン・新規登録にProof-of-Work型のCAPTCHAを導入しています。
https://capjs.js.org/

### Cap.jsサーバーのデプロイ (Fly.io)

設定ファイル: `capjs-server/fly.toml`

1. Fly.io CLIをインストール
```bash
# macOS
brew install flyctl

# Linux
curl -L https://fly.io/install.sh | sh

# ログイン
fly auth login
```

2. デプロイ
```bash
cd capjs-server

# アプリ作成
fly apps create mameblo-capjs

# ボリューム作成（データ永続化用）
fly volumes create cap_data --region nrt --size 1 --app mameblo-capjs

# ADMIN_KEY設定（30文字以上必要、メモしておくこと）
ADMIN_KEY=$(openssl rand -hex 20)
echo "ADMIN_KEY: $ADMIN_KEY"
fly secrets set ADMIN_KEY="$ADMIN_KEY" --app mameblo-capjs

# デプロイ
fly deploy --app mameblo-capjs
```

3. サイトキーの取得
```bash
fly open --app mameblo-capjs
```
ダッシュボードにADMIN_KEYでログインし、「Create Key」でサイトキーを作成。
`Site Key` と `Secret Key` をコピー。

### Rails側の環境変数設定

#### 本番環境
```bash
CAPTCHA_ENABLED=true
CAPTCHA_SERVER_URL=https://mameblo-capjs.fly.dev
CAPTCHA_SITE_KEY=<作成したサイトキー>
CAPTCHA_SECRET_KEY=<作成したシークレットキー>
```

#### 開発環境
開発環境ではCAPTCHAはデフォルトで無効（`CAPTCHA_ENABLED=false`）です。
ウィジェットは表示されず、認証もスキップされます。

## Twitter 公式アカウント
https://twitter.com/mameblo

## Facebookページ
https://www.facebook.com/mameblo

## minne
https://minne.com/mameblo

## SUZURI
https://suzuri.jp/mameblo

