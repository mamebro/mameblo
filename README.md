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

## Twitter 公式アカウント
https://twitter.com/mameblo

## Facebookページ
https://www.facebook.com/mameblo

## minne
https://minne.com/mameblo

## SUZURI
https://suzuri.jp/mameblo

