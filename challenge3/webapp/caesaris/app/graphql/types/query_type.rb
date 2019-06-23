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
      argument :q, BaseScalar, required: false
    end
    def houses(q: nil, city: nil)
      if q.present?
        # when search on `has_child`, use `{hasChildEq: false}`
        @q = House.includes(:datasets, :city).joins(:city, :datasets)
          .ransack(Util.form_ransack_params(q))
        @q.sorts = 'id asc' if @q.sorts.blank?
        @q.result.distinct
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
      argument :q, BaseScalar, required: false
    end
    def cities(q: nil)
      if q.present?
        @q = City.includes(:houses, :datasets).joins(:houses, :datasets)
          .ransack(Util.form_ransack_params(q))
        @q.sorts = 'id asc' if @q.sorts.blank?
        @q.result(distinct: true)
      else
        City.all.order(:id)
      end
    end

    field :datasets, [DatasetType], null: true do
      argument :q, BaseScalar, required: false
      argument :page, Integer, required: false
      argument :per, Integer, required: false
    end
    def datasets(q: nil, page: nil, per: nil)
      if q.present?
        # when search at `cities`, use `{house_city_name_cont: "London"}`
        @q = Dataset.includes(house: :city).joins(house: :city)
          .ransack(Util.form_ransack_params(q))
        @q.sorts = 'id asc' if @q.sorts.blank?
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
    end
    def data_series
      DataSeriesService.new
    end

  end
end
