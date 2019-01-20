class HousesController < ApplicationController
  def index
    render json: response_as_json(House.all.to_a)
  end

  private

    def response_as_json(houses)
      House.serializer(
        houses,
        options: {
          meta: {
            cities: houses.map(&:city).uniq.compact,
            num_of_peoples: houses.map(&:num_of_people).uniq.compact,
          },
        },
      ).serializable_hash
    end
end
