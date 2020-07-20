## URL
https://enechange-goi.herokuapp.com/

## SetUp
1. docker-compose build
2. docker-compose up -d
3. docker-compose run --rm api bundle exec rake db:create db:migrate csv_import:houses csv_import:energies

## Skills
- API
  - Ruby
  - Ruby on Rails
    - DHH Routing
    - Original Rake Command(CSV import script)
- Front
  - React
    - Rechart
- DB
  - MySQL
- Virtual Environment
  - Docker
- Infrastructure Environment
  - Heroku

## MEMO
### Total Time
- Docker 8〜12h
- API : 5.5h
  - Script : 2.5h
  - Response : 3h
- Front : 7.5h
  - Rechart : 6.5h
  - Design : 1h
- Infra : 15h
  - Heroku : 10h (.gitignore : 2h)
  - Dir change : 2h

- Total : 40h

## Do
求められていることはWebエンジニアとしての部分だと考え、データ周りの作成は特に意識せず年月ごとの各都市の生産エネルギー(平均値)を表示するだけに絞った。必要最低限のデータをReactでRechartを使って表示しているだけ。

## Point
- CSV取り込みのrakeコマンドを作成
- Rails APIモード初挑戦
- Rechart初挑戦
- DHHルーティング導入(必要なかった)
- 変にevalを使ってみた

## Want
### Backend
- 違うデータの組み合わせを試したかった
  - e.g. データ周りは詳しい人に聞いて実装したかった
- 各テーブルごとのデータ一覧ページを用意したい(Routeに一応用意)
### Frontend
- デザインをもっと懲りたかった
  - material-uiを駆使したかった
  - チャートのグラフを表示/非表示を切り替えたかった
  - 違うグラフを表示したかった
- ディレクトリを大工事したので抜けが存在している
  - package.json, yarn.lockをルートに置いてるけど、front配下にaliasすべきだった
  - いらない記述を削除したかった
  - そもそも構成を失敗していた
### Infra
- AWSを使いたかった
  - Copilotが熱いとのことで挑戦したかった
  - Docker ECSでdocker-composeを投げられるみたいだが、まだリリースされてなかった
  - Codepipelineとか使って自動化したかった

...etc
