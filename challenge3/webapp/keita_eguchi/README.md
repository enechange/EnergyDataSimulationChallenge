# Challenge 3 - Web Application 成果物
## 使用技術
| 種別 | 名称 |
|-----|:---:|
| 開発言語 | Ruby(ver 2.5.1) |
| フレームワーク | Ruby on Rails(ver 5.2.3) |
| フロントエンド | JavaScript(jQuery) |
| グラフ描画 | amCharts |

## グラフ説明
### <1>都市エリア別の気温/光量/エネルギー生産量のグラフ

(ⅰ)都市エリア:"全て" , データ種別："全て"
<br>　　→全都市エリアの"気温","光量","エネルギー生産量"の平均のグラフが3本描画されます
[![Image from Gyazo](https://i.gyazo.com/03d6106d0a6fca2a2f6c4bbcdb95df00.png)](https://gyazo.com/03d6106d0a6fca2a2f6c4bbcdb95df00)

(ⅱ)都市エリア:"全て" , データ種別："全て"以外
<br>　　→選択したデータ種別の平均のグラフが各都市分、3本描画されます
[![Image from Gyazo](https://i.gyazo.com/655b62bddefdcec96dc625a17c33a2a7.png)](https://gyazo.com/655b62bddefdcec96dc625a17c33a2a7)

(ⅲ)都市エリア:"全て"以外 , データ種別："全て"
<br>　　→選択した都市エリアの"気温","光量","エネルギー生産量"のグラフの3本が描画されます
[![Image from Gyazo](https://i.gyazo.com/7d21f5bd20e009999b000634dbb37e0d.png)](https://gyazo.com/7d21f5bd20e009999b000634dbb37e0d)

(ⅳ)都市エリア:"全て"以外 , データ種別："全て"以外
<br>　　→選択した都市エリアの選択したデータ種別のグラフと全ての都市の選択したデータ種別の平均のグラフ、2本が描画されます
[![Image from Gyazo](https://i.gyazo.com/b5018a44d3058974af13bee42556924f.png)](https://gyazo.com/b5018a44d3058974af13bee42556924f)

### <2>家庭と選択した家庭と同条件の家庭の比較グラフ
(ⅰ)家庭選択:任意の家庭, データ種別："全て"以外
<br>　　→選択した家庭のデータ種別に沿ったグラフと同条件の家庭のデータ種別(平均)に沿ったグラフの2本が描画されます
[![Image from Gyazo](https://i.gyazo.com/506de58f44cd851a3a85530abd4de5b9.png)](https://gyazo.com/506de58f44cd851a3a85530abd4de5b9)

(ⅱ)家庭選択:任意の家庭, データ種別："全て"
<br>　　→選択した家庭の"気温","光量","エネルギー生産量"のグラフの3本が描画されます
[![Image from Gyazo](https://i.gyazo.com/e0b9948cfd1212f0a3a8cd7305aa1248.png)](https://gyazo.com/e0b9948cfd1212f0a3a8cd7305aa1248)