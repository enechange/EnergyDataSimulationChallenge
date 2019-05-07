class CreateHouseData < ActiveRecord::Migration[5.2]
  def change
    create_table :house_data do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :city, null: false
      t.integer :num_of_people, default: 1, null: false
      t.boolean :has_child, default: false, null: false

      t.timestamps
    end
  end
end

__END__
ID  Firstname  Lastname  City       num_of_people  has_child
1   Carolyn    Flores    London     2              Yes
2   Jennifer   Martinez  Cambridge  3              No
3   Larry      Robinson  London     4              Yes
4   Paul       Wright    Oxford     3              No
5   Frances    Ramirez   London     3              Yes
6   Pamela     Lee       Oxford     3              Yes
7   Patricia   Taylor    London     3              Yes
8   Denise     Lewis     Oxford     4              Yes
9   Kelly      Clark     Cambridge  4              No
