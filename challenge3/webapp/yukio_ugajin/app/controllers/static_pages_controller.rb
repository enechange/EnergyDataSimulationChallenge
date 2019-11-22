class StaticPagesController < ApplicationController
  def top; end

  def all
    data = []
    EnergyDetail.all.each do |e|
      data << e.scatter_position
    end
    @all_energy = scatter_params('All Data', '#ffea00', '#ffbb00', data)
  end

  private

    def scatter_params(label, background, border, data)
      [{
        label: label,
        backgroundColor: background,
        borderColor: border,
        data: data
      }]
    end
end
