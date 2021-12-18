class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :json_request?
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end
end