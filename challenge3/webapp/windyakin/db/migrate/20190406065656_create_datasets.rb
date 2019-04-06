class CreateDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :datasets do |t|
      t.integer :label, null: false
      t.integer :house, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, null: false
      t.float :daylight, null: false
      t.integer :energy_production, null: false

      t.timestamps
    end
  end
end

__END__
ID  Label  House  Year  Month  Temperature  Daylight  EnergyProduction
1   0      1      2011  7      26.2         178.9     740
2   1      1      2011  8      25.8         169.7     731
3   2      1      2011  9      22.8         170.2     694
4   3      1      2011  10     16.4         169.1     688
5   4      1      2011  11     11.4         169.1     650
6   5      1      2011  12     4.2          199.5     763
7   6      1      2012  1      1.8          203.1     765
8   7      1      2012  2      2.8          178.2     706
9   8      1      2012  3      6.7          172.7     788
