# テストで一旦データを入れる
names = %w(oshin aso oshin aso oshin)

names.each do |name|
    # ランダム値(1～5)取得
    random_number = [*1..5].sample
    House.create! first_name: name, last_name: name, city: name, num_of_people: random_number, has_child: name
end