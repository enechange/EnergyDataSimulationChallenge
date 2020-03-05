require 'rails_helper'

describe HousesController, type: :controller do
  let(:house) { create(:house) }

  describe 'GET #index' do
    it "populates an array of houses" do
      houses = create_list(:house, 50)
      get :index
      expect(assigns(:houses)).to match(houses)
    end
    
    it "assigns the requested daylight_energy_data to @daylight_energy_data" do
      create_list(:datum, 50)
      daylight_energy_data = Datum.pluck(:daylight, :energy_production)
      get :index
      expect(assigns(:daylight_energy_data)).to eq daylight_energy_data
    end

    it "assigns the requested city_energy_production to @city_energy_production" do
      create_list(:datum, 50)
      city_energy_production = Datum.city_energy_production
      get :index
      expect(assigns(:city_energy_production)).to eq city_energy_production
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "assigns the requested house to @house" do
      get :show, params: { id: house }
      expect(assigns(:house)).to eq house
    end

    it "assigns the requested house_data to @house_data" do
      house_data = create_list(:datum, 10, house: house)
      get :show, params: { id: house }
      expect(assigns(:house_data)).to match(house_data)
    end

    it "assigns the requested house_monthly_data to @house_monthly_data " do
      house_monthly_data = house.monthly_data
      get :show, params: { id: house }
      expect(assigns(:house_monthly_data)).to match(house_monthly_data)
    end

    it "renders the :show template" do
      get :show, params: { id: house }
      expect(response).to render_template :show
    end
 
  end
end