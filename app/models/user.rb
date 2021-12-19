class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,  password_length: 6..12

  validates :email, presence: true

  validates :password, confirmation: true

  validates :password, length: { minimum: 6 }, if: ->{  password.blank? }
end
