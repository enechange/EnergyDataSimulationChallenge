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

  before_create :set_default_role, :set_default_img, :set_default_name

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

  def set_default_role
    if roles.blank?
      self.roles = [EasySettings.user_roles.keys.last]
    end
  end

  def set_default_img
    if img_url.blank?
      self.img_url = EasySettings.default_user.img_url_tmp.gsub(/\<@email@\>/, email)
    end
  end

  def set_default_name
    if name.blank?
      self.name = email.split(/@/).map do |str|
        "#{str.first(3)}.".upcase_first
      end.join(' ')
    end
  end

  def self.role_list_to_code(role_list)
    role_ids = role_list.map do |role|
      EasySettings.user_roles[role].to_i
    end
    Util.set_binary_codes(role_ids)
  end
end
