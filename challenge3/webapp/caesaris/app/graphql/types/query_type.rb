module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: Fix vulnerability of circular reference
    # Eg: `house(id: 1) { datasets { house { datasets { house { id } } } } }`
    field :house, Types::HouseType, null: true do
      description "Find a house by ID"
      argument :id, ID, required: true
    end
    def house(id:)
      House.find(id)
    end

    field :houses, [HouseType], null: true do
      description "Find a houses ransack"
      argument :city, String, required: false
      argument :query_json, String, required: false
    end
    def houses(city: nil, query_json: nil)
      if query_json.present?
        # when search on `has_child`, use `{"hasChildEq": false}`
        House.includes(:datasets).joins(:city)
          .ransack(Util.form_ransack_params(query_json))
          .result.order(:id).distinct
      elsif city.present?
        House.joins(:city).where(cities: {name: city.capitalize}).order(:id)
      else
        House.all.order(:id)
      end
    end

    field :city, CityType, null: true do
      argument :name, String, required: true
    end
    def city(name:)
      City.find_by(name: name.capitalize)
    end

    field :cities, [CityType], null: true do
      argument :query_json, String, required: false
    end
    def cities(query_json: nil)
      if query_json.present?
        City.includes(:houses, :datasets)
          .ransack(Util.form_ransack_params(query_json))
          .result.order(:id).distinct
      else
        City.all.order(:id)
      end
    end

    field :datasets, [DatasetType], null: true do
      argument :query_json, String, required: false
    end
    def datasets(query_json: nil)
      if query_json.present?
        # when search at `cities`, use `{house_city_name_cont: "London"}`
        Dataset.includes(house: :city)
          .ransack(Util.form_ransack_params(query_json))
          .result.order(:id).distinct
      else
        Dataset.all.order(:id)
      end
    end
  end
end
