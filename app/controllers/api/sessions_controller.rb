class Api::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, :require_no_authentication
  before_action :check_request_format, only:[:create]
  respond_to :json

  # POST /api/login
  def create
    warden.authenticate!(auth_options)
    resource = warden.authenticate!(auth_options)

    if resource.blank?
      render status: 401, json: { response: "Access denied." } and return
    end

    # sign_out_and_respond(resource) and return unless resource.allow_api_access?

    sign_in('ApiUser', resource)
    respond_with resource, location: after_sign_in_path_for(resource) do |format|
      format.json { render status: 200,
                             json: { success: 'true', jwt: current_token(resource),
                                  message: "Authentication successful" } }
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
    render status: 401, json: { success: 'false', message: "No API access allowed." }
  end

  def current_token(resource)
    request.env['warden-jwt_auth.token']
  end
end