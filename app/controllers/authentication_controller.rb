class AuthenticationController < ApplicationController

	def index
	end

	def authenticate_user
		user = User.find_for_database_authentication(email: params[:email])
		if user and user.valid_password?(params[:password])
		render json: payload(user)
		else
			render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
		end
	end

	def create
		user = User.update_or_create(request.env["omniauth.auth"])
		cookies["Authorization"] = "Bearer #{request.env["omniauth.auth"]["credentials"]["token"]}"
		redirect_to '/'
	end

	def destroy
		cookies.delete :Authorization
		render :json => { :message => "Done" }
	end

	private

		def payload(user)
			return nil unless user and user.id
			{
				auth_token: JsonWebToken.encode({user_id: user.id}),
				user: {id: user.id, email: user.email}
			}
		end
end
