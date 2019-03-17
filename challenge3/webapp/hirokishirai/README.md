# Challange3 Hirokishirai

Deployed to: https://enedatasimulation-hirokishirai.herokuapp.com

# 画面一覧

- [都市(City)一覧](https://enedatasimulation-hirokishirai.herokuapp.com/cities)
- [都市(City)ごとのサマリページ](https://enedatasimulation-hirokishirai.herokuapp.com/cities/1)
- [都市(City)ごとの住居一覧](https://enedatasimulation-hirokishirai.herokuapp.com/houses?city_id=1)
- [住居(House)ごとのサマリページ](https://enedatasimulation-hirokishirai.herokuapp.com/houses/1)

# TODO LIST
- classつける __TODO__ [app/views/shared/_monthly_house_energy_productions_table.html.slim](app/views/shared/_monthly_house_energy_productions_table.html.slim)
- define_method系ほとんど同じような内容なのでリファクタする __TODO__ [app/models/city.rb](app/models/city.rb)
- https://github.com/rails/rails/issues/35452#issuecomment-469224956 __FIXME__ [config/application.rb](config/application.rb)
- labelはidと同じ値だが、違う可能性もあるので要確認 __REVIEW__ [db/migrate/20190316072616_create_monthly_house_energy_productions.rb](db/migrate/20190316072616_create_monthly_house_energy_productions.rb)
- ユニットテスト書く __TODO__ [app/models/city.rb](app/models/city.rb)
- 月の平均？　最大？　最小？ 中央値？ __REVIEW__ [db/migrate/20190316072616_create_monthly_house_energy_productions.rb](db/migrate/20190316072616_create_monthly_house_energy_productions.rb)
- 月の平均？　最大？　最小？ 中央値？ __REVIEW__ [db/migrate/20190316072616_create_monthly_house_energy_productions.rb](db/migrate/20190316072616_create_monthly_house_energy_productions.rb)
- 月の平均？　最大？　最小？ 中央値？ __REVIEW__ [db/migrate/20190316072616_create_monthly_house_energy_productions.rb](db/migrate/20190316072616_create_monthly_house_energy_productions.rb)
- 好きな組み合わせでGETできるように __TODO__ [app/javascript/packs/c3_charts.js](app/javascript/packs/c3_charts.js)
- 世帯情報など単体でも有益の可能性があるので dependent: :nullify __NOTE__ [app/models/city.rb](app/models/city.rb)
- 日照量と発電量など単体でも有益の可能性があるので dependent: :nullify __NOTE__ [app/models/house.rb](app/models/house.rb)
- 日照量と発電量など単体でも有益の可能性があるので dependent: :nullify __NOTE__ [app/models/house.rb](app/models/house.rb)
- テスト書く __TODO__ [test](test)
