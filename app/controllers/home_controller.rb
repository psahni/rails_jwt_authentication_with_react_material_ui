class HomeController < ApplicationController
  respond_to :json, :html

  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { 
        render status: 200,
        json: {
          success: 'true',
          message: 'Home Page',
        }
      }
    end
  end
end
