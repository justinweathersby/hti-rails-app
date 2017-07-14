class Users::SessionsController < DeviseTokenAuth::RegistrationsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |resource|
      resource.device_token = params[:device_token] if params[:device_token]
      resource.device_type = params[:device_type]  if params[:device_type]
      resource.save!
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:device_token, :device_type])
  end
end
