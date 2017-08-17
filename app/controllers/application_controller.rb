class ApplicationController < ActionController::API
	attr_reader :current_user
	include Response
	
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

	def render_unprocessable_entity_response(exception)
		render json: exception.record.errors, status: :unprocessable_entity
	end

	def render_not_found_response(exception)
		render json: { error: exception.message }, status: :not_found
	end

	protected
		
	  def authenticate_request!
	    unless user_id_in_token?
	      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
	      return
	    end
	    @current_user = User.find(auth_token[:user_id])
	  rescue JWT::VerificationError, JWT::DecodeError
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
