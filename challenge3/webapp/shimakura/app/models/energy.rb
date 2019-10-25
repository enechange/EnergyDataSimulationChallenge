class Energy < ApplicationRecord
    belongs_to :house
    validates :house_id, presence: { message: 'は必須入力です。'}
    validates :label, presence: { message: 'は必須入力です。'}
    validates :year, presence: { message: 'は必須入力です。'}
    validates :month, presence: { message: 'は必須入力です。'}
    validates :temperature, presence: { message: 'は必須入力です。'}
    validates :daylight, presence: { message: 'は必須入力です。'}
    validates :energy_production, presence: { message: 'は必須入力です。'}
end
