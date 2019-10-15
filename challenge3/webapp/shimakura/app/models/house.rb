class House < ApplicationRecord
    has_many :energies, dependent: :destroy
    validates :firstname, presence: { message: 'は必須入力です。'}
    validates :lastname, presence: { message: 'は必須入力です。'}
    validates :city, presence: { message: 'は必須入力です。'}
    validates :num_of_people, presence: { message: 'は必須入力です。'}
    validates :has_child, presence: { message: 'は必須入力です。'}
end
