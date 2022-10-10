# require 'bcrypt'
class User < ApplicationRecord

	# bcrypt
	has_secure_password

	validates :username, :password_digest, presence: true
	validates :username, length: {minimum: 4} 
	validates :username, uniqueness: true

	has_many :tweets, dependent: :destroy
	has_many :followers, dependent: :destroy


end
