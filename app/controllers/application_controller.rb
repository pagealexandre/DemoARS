class ApplicationController < ActionController::Base
	alias_method :devise_current_user, :current_user
	include Response
	
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

	def render_unprocessable_entity_response(exception)
		render json: exception.record.errors, status: :unprocessable_entity
	end

	def render_not_found_response(exception)
		render json: { error: exception.message }, status: :not_found
	end

	def current_user
    	return @current_user = User.find_by(auth_token: cookies['Authorization'].split(' ').last) if cookies["Authorization"].present?
    	return @current_user = User.find(auth_token[:user_id]) if user_id_in_token?
  	end

	protected
		
	  def authenticate_request!
	  	if cookies["Authorization"].present?
	  		@current_user = User.find_by(auth_token: cookies['Authorization'].split(' ').last)
	  		return
	  	end
	    unless user_id_in_token?
	      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
	      return
	    end
	    @current_user = User.find(auth_token[:user_id])
	  rescue JWT::VerificationError, JWT::DecodeError, ActiveRecord::RecordNotFound
	   	render json: { errors: ['Not Authenticated'] }, status: :unauthorized
	  end

	  private
	  def http_token
	      @http_token ||= if request.headers['Authorization'].present?
	        request.headers['Authorization'].split(' ').last
	      end
	  end

	  def auth_token
	    @auth_token ||= JsonWebToken.decode(http_token)
	  end

	  def user_id_in_token?
	    http_token && auth_token && auth_token[:user_id].to_i
	  end


end
