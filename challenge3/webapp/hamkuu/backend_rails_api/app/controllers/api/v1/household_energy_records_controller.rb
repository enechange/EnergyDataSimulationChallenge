class Api::V1::HouseholdEnergyRecordsController < ApplicationController
  def index
    # For singleton resource
    unless api_params[:id].nil?
      energy_record = HouseholdEnergyRecord.find_by_id(api_params[:id])

      if energy_record.nil?
        render json: { message: 'Requested energy record not found' }, status: :not_found
      else
        render json: { house: energy_record }, status: :ok
      end

      return
    end

    # For collection resource
    records_count = HouseholdEnergyRecord.count
    page_index = api_params[:page].to_i
    offset = page_index * @page_size

    if offset >= records_count
      render json: { message: 'Invalid page parameter.' }, status: :bad_request
    else
      has_next_page = offset + @page_size < records_count

      energy_records = HouseholdEnergyRecord.limit(@page_size).offset(offset)

      render json: { page: page_index, next_page: has_next_page, energy_records: energy_records }, status: :ok
    end
  end
end
