# frozen_string_literal: true

class HousesController < ApplicationController
  before_action :set_house, only: %i[show for_scatter]
  def index
    @houses = House.all
    @houses = @houses.where(house_id: params[:house_id]) if params[:house_id].present?
    @calcs = [
      {
        friendly_name: I18n.t('calc.maximum'),
        method_name_prefix: 'maximum'
      },
      {
        friendly_name: I18n.t('calc.mode'),
        method_name_prefix: 'mode'
      },
      {
        friendly_name: I18n.t('calc.average'),
        method_name_prefix: 'average'
      },
      {
        friendly_name: I18n.t('calc.median'),
        method_name_prefix: 'median'
      },
      {
        friendly_name: I18n.t('calc.minimum'),
        method_name_prefix: 'minimum'
      }
    ]
  end

  def show; end

  def for_scatter; end

  private

  def set_house
    @house = House.find(params[:id])
  end
end
