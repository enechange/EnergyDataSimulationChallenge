## Challenge A
### 実装概要
ユーザーが契約アンペア数(A)と使用量(kWh)を入力することで、各プラン名およびそのプランの電気料金を返すSimulatorクラスを実装しました。

### 注意点
- 使用量(kWh)は小数点第一位で四捨五入
- トータルの電気料金は小数点以下切り捨て

### テスト内容
プラン名とそのプランの電気料金が配列で出力される
- 10A, 20A, 30A, 60A時の配列の中身
- 120kwH ~ 351kWh時の電気料金

実行コマンド: ruby simulator.rb

### 使用言語とそのバージョン
- Ruby 2.6.5
- RSpec 3.10
(minitestの方が効率が良さそうでしたが、Ruby単体でRSpecを使用したことがなかったためRSpecを採用しました)

### 使用したgemやツール
- pry-byebug
- Rubocop
- EditorConfig

### こだわったポイント
- RubocopとEditorConfigで統一感のあるコードを心がけたこと

- テストコードの期待値をベタ書きで1つ1つ確かめたこと（DRYを取るか迷いましたが、「対象のコードの仕様がひと目でわかること」を優先し、ベタ書きを採用しました）

## 今回の実装を通して学習になったポイント
- Ruby単体でのRSpecの使用方法
- requireとrequire_relativeの違い
- eq, match, match_array, contain_exactlyマッチャの違い
- nil?とempty?はRuby標準のメソッドで、blank?とpresent?はRailsで拡張されたメソッドであること
- Rubocopの規約では、expand_path('../../config/environment', __FILE__)の代わりにexpand_path('../config/environment', __dir__)を使うことが推奨されている

### 参考
- https://qiita.com/jnchito/items/eb3cfa9f7db752dcb796#%E3%83%99%E3%82%BF%E6%9B%B8%E3%81%8D%E3%81%AB%E3%81%AF%E5%A3%8A%E3%82%8C%E3%82%84%E3%81%99%E3%81%8F%E3%81%AA%E3%82%8B%E3%81%A8%E3%81%84%E3%81%86%E3%83%87%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88%E3%82%82%E3%81%82%E3%82%8B
