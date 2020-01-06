class Api::V1::HousesController < ApplicationController
  def index
    # For singleton resource
    unless api_params[:id].nil?
      house = House.find_by_id(api_params[:id])

      if house.nil?
        render json: { message: 'Requested house not found' }, status: :not_found
      else
        render json: { house: house }, status: :ok
      end

      return
    end

    # For collection resource
    houses_count = House.count
    page_index = api_params[:page].to_i
    offset = page_index * @page_size

    if offset >= houses_count
      render json: { message: 'Invalid page parameter.' }, status: :bad_request
    else
      has_next_page = offset + @page_size < houses_count

      house_owners = House.limit(@page_size).offset(offset)

      render json: { page: page_index, next_page: has_next_page, house_owners: house_owners }, status: :ok
    end
  end
end
