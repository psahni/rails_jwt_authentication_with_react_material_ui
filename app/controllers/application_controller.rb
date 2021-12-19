class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :json_request?
  protect_from_forgery with: :null_session, if: :json_request?

  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_auth_token
  
  
  def json_request?
    request.format.json?
  end


  def invalid_auth_token
    respond_to do |format|
      format.html { 
        redirect_to sign_in_path, 
        error: 'Login invalid or expired' 
      }
      format.json { head 401 }
    end
  end
  
  def set_current_user(id)
    @current_user ||= ApiUser.find_by_id(id)  # @current_user ||= warden.authenticate(scope: :api_user) #
  end

  def current_user
    @current_user
  end

  def after_sign_in_path_for(_resource)
    flash[:success] = 'Signed in successfully!' if flash.blank?
    stored_location_for(_resource) || home_path
  end

  def authenticate_user!(*args)
    super and return unless args.blank?
    json_request? ? authenticate_api_user! : super
  end


  def authenticate_api_user!
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = Warden::JWTAuth::TokenDecoder.new.call(token)
          @current_user_id = jwt_payload['id']
          set_current_user(@current_user_id)
          validate_token(jwt_payload)
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          render json: { error: 'Invalid Token'}, status: 401 and return
        end
      end
    else
      render json: { error: 'Token Missing' }, status: 401 and return
    end
  end

  def validate_token(payload)
    jti = payload['jti']
    if current_user.jti != jti
      raise JWT::ExpiredSignature
    end
  end
end