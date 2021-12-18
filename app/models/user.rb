class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  attr_accessor :current_token

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  def generate_jwt
    JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
                Rails.application.secrets.secret_key_base)
  end


  def jwt_payload
    super.merge('mistd-testing' => 'devise-jwt and rails')
  end

  def on_jwt_dispatch(token, _payload)
    # Token send with json
    self.current_token = token
    # do somthings
  end
end
