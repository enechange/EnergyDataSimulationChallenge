# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    if request.xhr?
      opts = auth_options
      opts[:recall] = "#{controller_path}#xhr_failure"
      self.resource = warden.authenticate!(opts)
      sign_in(resource_name, resource)
      xhr_success
    else
      super
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def xhr_success
    render json: { result: true, code: 20000 }
  end

  def xhr_failure
    render json: { result: false, code: 50008, errors: ["Login failed."] }
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
