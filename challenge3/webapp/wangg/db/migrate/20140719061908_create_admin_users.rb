class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.string "username", limit:25
      t.string "password_digest"
      t.timestamps
    end
  end
end
