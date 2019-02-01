class User < ActiveRecord::Base
  has_secure_password
  has_many :portfolios
  validates :email, :uniqueness => true
end
