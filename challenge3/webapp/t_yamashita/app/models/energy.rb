class Energy < ApplicationRecord
  # association
  belongs_to :user

  # validation
  validates :user_id,
            :year,
            :month,
            :temperature,
            :daylight,
            :energy_production, presence: true
  
  # ユーザーのこれまでの発電量を合計するメソッド
  def self.total_energy(user)
    array = []
    energies = Energy.where(user_id: user)
    energies.each do |e|
      array << e.energy_production
    end

    return array.inject(:+)
  end

  # ユーザーの最新データの年・月を取得するメソッド
  def self.recently_year(user)
    energy = Energy.where(user_id: user).order(year: :desc, month: :desc).limit(1)[0]
    return energy.year
  end

  def self.recently_month(user)
    energy = Energy.where(user_id: user).order(year: :desc, month: :desc).limit(1)[0]
    return energy.month
  end
end
