# シミュレーターの使用方法

`Simulator`クラスを使用することで，各プランの電気料金のシミュレーションを行うことができます。

`Simulator`クラスのインスタンス生成時には，第一引数に契約アンペア数[A]を，第二引数に1ヶ月の使用量[kWh]を指定する必要があります。

```ruby
simulator = Simulator.new(40,　280)
```

シミュレーションを実行するには，`Simulator`クラスのインスタンスメソッド`simulate`を実行します。

```ruby
result = simulator.simulate
puts result
#=> {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>7766}
#   {:provider_name=>"Looopでんき", :plan_name=>"おうちプラン", :price=>7392}
#   {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気1", :price=>7801}
#   {:provider_name=>"JXTGでんき", :plan_name=>"従量電灯B たっぷりプラン", :price=>7766}
```

`main.rb`には上記と同様の処理が記述されているため，実行することで同じ出力を得ることができます。
```sh
ruby main.rb
```

※各プランの料金は`providers.yaml`に則って計算されています。