class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise  :database_authenticatable, :registerable,
         	:recoverable, :rememberable, :trackable, :validatable

	def self.update_or_create(auth)
		user = User.find_by(email: auth[:info][:email]) || User.new
		user.attributes = {
		    #provider: auth[:provider],
		    #uid: auth[:uid],
		    email: auth[:info][:email],
		    #first_name: auth[:info][:first_name],
		    #last_name: auth[:info][:last_name],
		    #token: auth[:credentials][:token],
		    #refresh_token: auth[:credentials][:refresh_token],
		    #oauth_expires_at: auth[:credentials][:expires_at],
		    auth_token: auth[:credentials][:token]
		  }
		user.save(:validate => false)
		user
	end
end
