class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  scope :roles_equal, ->(role_list){ where(roles_code: role_list_to_code(role_list)) }
  scope :has_role, lambda { |role|
    role_code = EasySettings.user_roles[role].to_i
    where('roles_code & ? = ?', role_code, role_code)
  }
  # attr_accessor :roles
  @roles

  def roles
    @roles = []
    EasySettings.user_roles.each do |role, mask|
      if Util.auth_binary(roles_code.to_i, mask.to_i)
        @roles << role
      end
    end
    @roles
  end

  def roles=(role_list)
    self.roles_code = User.role_list_to_code(role_list)
  end

  EasySettings.user_roles.keys.each do |role_name|
    method_name = role_name + "?"
    define_method(method_name.to_sym) {
      self.roles.include?(role_name.to_s)
    }
    scope role_name.to_sym, lambda {
      role_code = EasySettings.user_roles[role_name].to_i
      where('roles_code & ? = ?', role_code, role_code)
    }
  end

  private

  def self.role_list_to_code(role_list)
    role_ids = role_list.map do |role|
      EasySettings.user_roles[role].to_i
    end
    Util.set_binary_codes(role_ids)
  end
end
