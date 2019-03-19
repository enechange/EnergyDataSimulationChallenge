# Challenge 3 - Web Application について

## デプロイ
- 以下の場所（[ConoHa](https://www.conoha.jp/)）にデプロイしました
  - https://enechange-takiya.etheria.tokyo/
- `Capistrano` を書きましたが、`challenge3/webapp/osamu_takiya` にアプリケーションが存在するために一手間が必要そうであり、時間の都合で断念しました

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
  - CSVに出力した時点でどの程度の正確性が保証されているか？

## Model
- `scope` の定義があまり DRY でないような気がします
- `%w(Oxford Cambridge London)` をハードコーディングしてしまっています
  - データベースから候補を取得するべきでしょう

## View
- テンプレートエンジンには `Slim` を用いました
- CSSフレームワークには [Bluma](https://bulma.io/) を用いました

## Controller
- データ取得のためのプライベートメソッド（2つ）が読みにくいと思います
  - `values[0]` はよろしくないかと

## できていないこと（「やりたい」と思いついたものも含めて）
- デプロイは development環境 で動かしてしまっています
  - エラーページが丸見えになっています
  - production環境 では `5xx` ページなどもちゃんと作りたいです
- テストが全く書けていません
  - カバレッジについても同様です
- CIも雛形ファイルを置いてあるだけです
- Echarts を使ってみたかったです（興味本位）
  - おそらく gon 経由で書くことになるでしょう
- どのカラムにインデックスやDEFAULTを付けるか（付けないか）？
- Mackerel や Uptime Robot や Bugsnag などの監視ツールの導入
- `energy_production` の `production` という単語が、`production環境` という単語の `production` と重複するので命名に気を配る必要がありそうです
- その他、全般に命名がまだ甘い気がしています
- MySQL のレプリケーション
- RuboCop の設定が「とりあえず警告を避けるために `false` いしている部分があります
