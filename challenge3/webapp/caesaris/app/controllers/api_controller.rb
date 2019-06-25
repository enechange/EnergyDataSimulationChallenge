require 'nokogiri'

class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:default_user]
  # before_action :set_authenticity_token, only: [:default_user]

  def default_user
    if EasySettings.default_user.show
      render json: EasySettings.default_user
    else
      render json: {}
    end
  end

  def app_config
    result = {}
    %i(challenge_2 challenge_3).each do |key|
      result[key] = AppConfig.send(key)
    end
    render json: result
  end

  def user_info
    user = current_user
    render json: {
      roles: user.roles,
      avatar: user.img_url,
      name: user.name
    }
  end

  def load_csv
    if params[:house_data_url].blank? || params[:dataset_url].blank?
      render json: { error: 'url not found' }, status: 400 and return
    end

    case params[:key]
    when "challenge-3"
      begin
        ActiveRecord::Base.transaction do
          ActiveRecord::Base.connection.execute("TRUNCATE TABLE houses")
          ActiveRecord::Base.connection.execute("TRUNCATE TABLE cities")
          ActiveRecord::Base.connection.execute("TRUNCATE TABLE datasets")
          DataLoader.load_houses(params[:house_data_url])
          DataLoader.load_cities
          DataLoader.sync_cities_houses
          DataLoader.load_dataset(params[:dataset_url])
          render json: { result: 'ok' }
        end
      rescue => e
        render json: { error: e.message }, status: 500
      end
    else
      render json: { error: 'key not found' }, status: 400
    end
  end

  def create_user
    unless current_user.roles.include?('admin')
      render json: { error: 'Only Admin User Are Allowed.' }, status: 400 and return
    end

    begin
      ActiveRecord::Base.transaction do
        user = User.new(
          email: params[:email],
          password: params[:password],
          password_confirmation: params[:password],
          roles: params[:roles]
        )
        user.save!
        render json: {
          id: user.id,
          roles: user.roles,
          avatar: user.img_url,
          name: user.name
        }
      end
    rescue => e
      render json: { error: e.message }, status: 500
    end
  end

  private

  # def generate_form_meta
  #   form_tag = view_context.form_tag '/' do
  #   end
  #   doc = Nokogiri::HTML.parse(form_tag, nil, 'utf-8')
  #   result = {}
  #   %w(utf8 authenticity_token).each do |attr|
  #     val = doc.css("form [name=#{attr}]").first&.attribute('value')&.value
  #     result[attr] = val if val.present?
  #   end
  #   result
  # end

  # def set_authenticity_token
  #   auth_token = generate_form_meta['authenticity_token']
  #   response.set_header('x-authenticity-token', auth_token) if auth_token.present?
  # end

end
