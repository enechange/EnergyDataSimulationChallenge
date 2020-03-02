class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # associations
  belongs_to :city
  has_many :energies, dependent: :destroy
  has_many :power_consumptions, dependent: :destroy

  # validations
  validates :firstname,
            :lastname,
            :email, 
            :city_id, presence: true

  validates :email, uniqueness:true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i , message: "が不正です"}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,20}+\z/i, message: "は英数字の両方が必要です"}
  validates :password_confirmation, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,20}+\z/i, message: "は英数字の両方が必要です"}
end