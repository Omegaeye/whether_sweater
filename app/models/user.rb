require 'ostruct'

class User < ApplicationRecord
  has_secure_password

  has_many :api_keys, as: :bearer
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.user_info(user_id)
    user = User.find(user_id)
    api_key = user.api_keys.create! token: SecureRandom.hex
    info = OpenStruct.new({ 
      id: user_id, 
      email: user.email,
      api_key: api_key[:token]
     })
  end

  def self.user_log_in(user_id)
    user = User.find(user_id)
    
    info = OpenStruct.new({ 
      id: user_id, 
      email: user.email,
      api_key: user.api_keys.first.token
     })
  end
  
end
