class Api::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user
  before_action :require_no_authentication, only:[:create, :new]
  before_action :authenticate_user!, only:[:destroy]
  before_action :check_request_format, only:[:create]

  respond_to :json

  # POST /api/login
  def create
    resource = ApiUser.find_by_email(sign_in_params[:email])   

    if resource.blank?
      render status: 401, json: { response: "Access denied." } and return
    end
    
    sign_in('ApiUser', resource, { store: false })
    
    respond_with resource, location: after_sign_in_path_for(resource) do |format|
      format.json { 
        render status: 200,
          json: { 
            success: 'true', 
            token: current_token(resource),
            message: "Authentication successful" 
          } 
        }
    end
  end

  def destroy
    if (current_user)
      sign_out_and_respond(current_user)
      render status: 204, json: {
        message: 'Logged out'
      } and return
    end
  end

  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

  def revoke_token(user)
    user.update_column(:jti, SecureRandom.uuid)
  end

  def check_request_format
    unless request.format == :json
      sign_out
      render status: 406, json: { success: 'false', message: "JSON requests only." } and return
    end
  end

  def sign_out_and_respond(resource)
    revoke_token(resource)
    sign_out(resource)
    #render status: 401, json: { success: 'false', message: "No API access allowed." }
  end

  def current_token(resource)
    token = request.env['warden-jwt_auth.token']
    p token
    token = resource.token if token.nil?
    token
  end
end