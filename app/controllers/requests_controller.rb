class RequestsController < ApplicationController
	before_action :set_request, only: [:show, :update, :destroy]

	# GET /requests
	def index
		@request = Request.all
		json_response(@request)
	end

	# GET /requests/:id
	def show
		render json: @request
	end

	# POST /requests
	def create
		if Request.possible?(request_params)
			@request = Request.create!(request_params)
			json_response(@request, :created)
			host = params[:host]
			guest = params[:guest]
			#ArsMailer.request_notification_host(host, guest).deliver_now
			#ArsMailer.request_notification_guest(host, guest).deliver_now
		else
			render :json => { :errors => "This offer has already been taken by another client and accepted by the host" }, status: 422
		end
	end

	# PUT /requests/:id
	def update
	    if @request.update(put_params)
	      render json: @request
	    else
	      render json: @request.errors, status: :unprocessable_entity
	    end
	end

	# DELETE /requests/:id
	def destroy
		@request.destroy
	end

	private

	def set_request
		@request = Request.find(params[:id])
	end

	def request_params
		params.permit(:host, :guest, :status, :offer_id)
	end

	def put_params
		params.permit(:status)
	end

end
