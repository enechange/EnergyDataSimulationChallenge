module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: Fix vulnerability of circular reference
    # Eg: `house(id: 1) { datasets { house { datasets { house { id } } } } }`
    field :house, Types::HouseType, null: true do
      description "Find a house by ID"
      argument :id, ID, required: true,
        description: "House ID"
    end
    def house(id:)
      House.find(id)
    end

    field :houses, [HouseType], null: true do
      description "Find houses by ransack"
      argument :city, String, required: false,
        description: "City name for house"
      argument :q, BaseScalar, required: false,
        description: "Ransack params"
    end
    def houses(q: nil, city: nil)
      if q.present?
        # when search on `has_child`, use `{hasChildEq: false}`
        @q = House.includes(:datasets, :city).joins(:city, :datasets)
          .ransack(Util.form_ransack_params(q))
        @q.sorts = "id asc" if @q.sorts.blank?
        @q.result.distinct
      elsif city.present?
        House.joins(:city).where(cities: { name: city.capitalize }).order(:id)
      else
        House.all.order(:id)
      end
    end

    field :city, CityType, null: true do
      description "Get city by city name"
      argument :name, String, required: true,
        description: "City name"
    end
    def city(name:)
      City.find_by(name: name.capitalize)
    end

    field :cities, [CityType], null: true do
      description "Find cities by ransack"
      argument :q, BaseScalar, required: false,
        description: "Ransack params"
    end
    def cities(q: nil)
      if q.present?
        @q = City.includes(:houses, :datasets).joins(:houses, :datasets)
          .ransack(Util.form_ransack_params(q))
        @q.sorts = "id asc" if @q.sorts.blank?
        @q.result(distinct: true)
      else
        City.all.order(:id)
      end
    end

    field :datasets, [DatasetType], null: true do
      description "Find datasets by ransack"
      argument :q, BaseScalar, required: false,
        description: "Ransack params"
      argument :page, Integer, required: false,
        description: "Page number"
      argument :per, Integer, required: false,
        description: "Items per page"
    end
    def datasets(q: nil, page: nil, per: nil)
      if q.present?
        # when search at `cities`, use `{house_city_name_cont: "London"}`
        @q = Dataset.includes(house: :city).joins(house: :city)
          .ransack(Util.form_ransack_params(q))
        @q.sorts = "id asc" if @q.sorts.blank?
        if per.nil? && page.nil?
          @q.result(distinct: true)
        else
          @q.result(distinct: true).page(page).per(per)
        end
      else
        Dataset.all.order(:id)
      end
    end

    field :data_series, DataSeriesType, null: true do
      description "Get Data Series"
    end
    def data_series
      DataSeriesService.new
    end

    field :app_configs, AppConfigType, null: true do
      description "Get Application Configs"
    end
    def app_configs
      AppConfig
    end

    field :users, [UserType], null: true do
      description "Find users by ransack"
      argument :q, BaseScalar, required: false,
        description: "Ransack params"
    end
    def users(q: nil)
      Util.auth_user_graphql(context[:current_user])
      if q.present?
        @q = User.ransack(Util.form_ransack_params(q))
        @q.sorts = "id asc" if @q.sorts.blank?
        @q.result(distinct: true)
      else
        User.all.order(:id)
      end
    end

  end
end
