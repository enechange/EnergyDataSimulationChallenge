# frozen_string_literal: true

class CitiesController < ApplicationController
  before_action :set_city, only: %i[show for_scatter]
  def index
    @cities = City.all
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

  def set_city
    @city = City.find(params[:id])
  end
end
