# README

## 基本的な情報

```
$ ruby -v
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]

$ rails -v 
Rails 5.2.4.2

$ nginx -v
nginx version: nginx/1.12.2

$ mysql --version
mysql  Ver 14.14 Distrib 5.7.29, for Linux (x86_64) using  EditLine wrapper
```

http://52.193.17.22/datasets

## インフラ

VPC / EC2 (RDSは使っていません)

## 開発環境確認方法

```
$ docker-compose build
$ docker-compose run web rails db:create db:migrate db:seed
$ docker-compose up
```

## 工夫点

- DB設計で正規化を意識
- select,groupメソッドなどを用いたデータ抽出
- scopeメソッドによるリファクタリング
- Viewの部品化

# 改善点

- データそれぞれに標準偏差を入れたかった
- Viewの保守性がひどい
- github actionsが作動していない(リポジトリのルートに置かないと駄目だと思われます)
- root pathを定義するのを忘れてました