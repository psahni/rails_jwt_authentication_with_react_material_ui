class ApiUser < User
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :jwt_authenticatable, jwt_revocation_strategy: self

  validates :jti, presence: true

  attr_accessor :token

  def generate_jwt
    JWT.encode({ id: id,
                exp: 5.days.from_now.to_i },
                Rails.env.devise.jwt.secret_key)
  end


  def jwt_subject
    id
  end

  def jwt_payload
    super.merge('secret key' => Rails.application.credentials.fetch(:secret_key_base))
  end

  def on_jwt_dispatch(token, payload)
    self.token = token
  end


  # def encode_token
  #   payload = { id: id }
  #   @token ||= Warden::JWTAuth::TokenEncoder.new.call(payload)
  # end

  # def token
  #   @token
  # end

  # def decode_token(token)
  #   Warden::JWTAuth::TokenDecoder.new.call(token)
  # end
end