# CHALENGE A

Challenge A のスクリプトです。

契約アンペアと月の電力使用量(kWh)の入力に応じて、各プラン名とその料金を格納した配列を返すSimulatorクラスを用いて、簡単なシミュレーションを行うスクリプトを作成しています。

## シミュレーション実行

```sh
ruby main.rb
```

## 環境構築

### データの準備

csv形式で`/data`のディレクトリに格納しています。会社名とプラン名を管理する`provider.csv`、契約アンペアに対する料金を管理する`basic.csv`、従量料金を管理する`energy.csv`をそれぞれ格納しています。プランの追加の際はこれらのデータを修正することで対応できるように実装しています。

データの取り込みは`/lib/importer`以下で定義した`****Importer`クラスにおいて行います。
データのカラムに変更があった場合はこちらのファイルを修正することで対応できるように実装しています。

### 依存ライブラリのインストール

```sh
gem install bundler
bundle install
```

## コード解析

```sh
bundle exec rubocop -A
```

## テスト

```sh
bundle exec rspec
```