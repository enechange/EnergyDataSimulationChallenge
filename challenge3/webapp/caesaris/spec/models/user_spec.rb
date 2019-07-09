require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = User.first
  end

  it "Should create a user" do
    email = "test@example.org"
    pass = "12345678"
    @user = User.create!({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ["admin"]
    })
    expect(@user).to be_truthy
  end

  it "Should has roles" do
    expect(@user.roles).to include "admin"
  end

  it "Should update roles" do
    @user.roles = ["admin", "editor"]
    roles_code = EasySettings.user_roles.admin | EasySettings.user_roles.editor
    @user.save!
    expect(@user.roles).to include "editor"
    expect(@user.roles_code).to eq roles_code
  end

  it "Should find by roles" do
    @users = User.has_role("editor")
    expect(@users.size).to be > 0
    expect(@users.first.roles).to include "editor"
  end

  it "Should find by roles use scope" do
    @users = User.admin
    expect(@users.size).to be > 0
    expect(@users.first.admin?).to be_truthy
  end

  it "Should set default roles" do
    email = "test-2@example.org"
    pass = "12345678"
    @user = User.create!({
      email: email, password: pass,
      password_confirmation: pass
    })
    expect(@user.roles).to eq [EasySettings.user_roles.keys.last]
  end
end
