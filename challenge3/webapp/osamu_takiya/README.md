# Challenge 3 - Web Application について

## 実行方法

### MySQL
```
mysql> CREATE DATABASE enechange_development DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

### Rails Application

```bash
$ git clone THIS_REPOSITORY
$ cd THIS_REPOSITORY/challenge3/webapp/osamu_takiya
$ bundle install --path vendor/bundle
$ cp .env.sample
$ vim .env
$ bundle exec unicorn -c config/unicorn.rb
```

### Itamae

```bash
$ cd itamae
$ cp .env.sample .env
$ vim .env
$ bundle exec itamae ssh -h HOSTNAME -u root conoha.rb -l debug
```

### Embulk

```bash
$ cd embulk
$ embulk gem install embulk-filter-ruby_proc
$ embulk gem install embulk-filter-column
$ embulk run house_datasets_development.yml
$ embulk run energy_production_datasets_development.yml
```

## Ruby および Rails のバージョン
- Ruby
  - 2.5.5
- Rails
  - 5.2.2.1

## デプロイ
- 以下の場所（[ConoHa](https://www.conoha.jp/)）にデプロイしました
  - https://enechange-takiya.etheria.tokyo/
- `Capistrano` を書きましたが、`challenge3/webapp/osamu_takiya` にアプリケーションが存在するために一手間かかりそうであり、時間の都合もあって断念しました

## プロビジョニング
- [Itamae](https://itamae.kitchen/) で ConoHa にプロビジョニングしました
  - `itamae/` 配下
- デプロイに必要なもの一式を入れました
  - `itamae/recipes`
    - `Java 8`
    - `MySQL`
    - `nginx`
    - `Embulk` とプラグイン
- ログインのためにパスワードを用いてしまっています

## CSVデータのインポート
- [Embulk](https://www.embulk.org/) を用いました
  - `embulk/` 配下

### Embulk を用いるメリット
- 高速
- トランザクションが可能
- Rails とは独立できます（これはデメリットにもなり得る）
- データのフォーマットや量の変化に柔軟に対応できます

### Embulk を用いるデメリット
- 環境構築が必要です
  - Java 8
- 設定のための YAML ファイルを書く必要があります
- 細かな処理はプラグインを用いる必要があり、その選定と使用方法を理解する必要があります
- Rails 上のバリデーションやテストの意義が薄れてしまいます
  - CSVに出力した時点で、どの程度バリデートされているかを考慮する必要があるでしょう

## Model
- `scope` の定義があまり DRY でないような気がします
- `%w(Oxford Cambridge London)` をハードコーディングしてしまっています
  - データベースから候補を取得するべきでしょう

## View
- テンプレートエンジンには `Slim` を用いました
- CSSフレームワークには [Bulma](https://bulma.io/) を用いました

## Controller
- データ取得のためのプライベートメソッド（2つ）がやや読みにくいと思います
  - `values[0]` はとてもよろしくないかと思います

## できていないこと（「やりたい」と思いついたものも含めて）
- デプロイは development環境 で動かしてしまっています
  - エラーページが丸見えになっています
  - production環境 では `5xx` ページなどもちゃんと作りたいです
- テストが全く書けていません
  - カバレッジについても同様です
- CIも雛形ファイルを置いてあるだけです
- [Echarts](https://ecomfe.github.io/echarts-doc/public/en/index.html) を使ってみたかったです（興味本位な部分あり）
  - おそらく `gon` 経由で書くことになるでしょう
- どのカラムにインデックスやDEFAULTを付けるか（付けないか）の検討をすること
- Mackerel や Uptime Robot や Bugsnag などの監視ツールの導入すること
- `energy_production` の `production` という単語が、`production環境` という単語の `production` と重複するので命名に気を配る必要がありそうです
- その他、全般に命名がまだ甘い気がしています
- MySQL のレプリケーションをすること
- RuboCop の設定が「差し当たっての警告をとりあえず避けるために `false` にしている」部分があります
