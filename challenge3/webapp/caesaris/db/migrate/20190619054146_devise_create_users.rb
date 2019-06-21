# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :jti,                null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # User Infos
      t.string  :name,              null: false, default: ""
      t.string  :img_url,           null: false, default: ""
      t.integer :roles_code,        null: false, default: 0

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
    add_index :users, :jti,                  unique: true
    add_index :users, :name
    add_index :users, :roles_code

    # create User `Admin`
    ActiveRecord::Base.transaction do
      EasySettings.load!
      email = EasySettings.default_user.email
      password = EasySettings.default_user.password
      if email.present? && password.present?
        User.create!(
          email: email, password: password, password_confirmation: password,
          # jti: SecureRandom.uuid,
          roles: [EasySettings.user_roles.keys.first]
        )
      end
    end
  end

  def down
    drop_table :users
    # remove_index :users, name: :email
    # remove_index :users, name: :reset_password_token
  end
end
