class Api::V1::HouseOwnersController < ApplicationController
  def index
    # For singleton resource
    unless api_params[:id].nil?
      house_owner = HouseOwner.find_by_id(api_params[:id])

      if house_owner.nil?
        render json: { message: 'Requested house_owner not found' }, status: :not_found
      else
        render json: { house_owner: house_owner }, status: :ok
      end

      return
    end

    # For collection resource
    house_owners_count = HouseOwner.count
    page_index = api_params[:page].to_i
    offset = page_index * @page_size

    if offset >= house_owners_count
      render json: { message: 'Invalid page parameter.' }, status: :bad_request
    else
      has_next_page = offset + @page_size < house_owners_count

      house_owners = HouseOwner.limit(@page_size).offset(offset)

      render json: { page: page_index, next_page: has_next_page, house_owners: house_owners }, status: :ok
    end
  end
end
