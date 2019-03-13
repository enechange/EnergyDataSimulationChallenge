module HousesHelper
  def avg_energy_production(show_energies, all_energies)
    avg = []
    i = 0
    show_energies.length.times do
      array = all_energies.map{|t| t.energyproduction if t.label == i }.compact
      avg << array.sum / array.length
      i += 1
    end
    return avg
  end
end
