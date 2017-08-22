class ReservationsController < ApplicationController
	before_action :set_reservation, only: [:show, :update, :destroy]
	before_action :authenticate_request!

	# GET /reservations
	def index
		@reservation = Reservation.all
		json_response(@reservation)
	end

	# GET /reservations/:id
	def show
		render json: @reservation
	end

	# POST /reservations
	def create
		if Reservation.possible?(reservation_params)
			@reservation = Reservation.create!(reservation_params)
			json_response(@reservation, :created)
			host = params[:host]
			guest = params[:guest]
			ArsMailer.reservation_notification_host(host, guest).deliver_now
			ArsMailer.reservation_notification_guest(host, guest).deliver_now
		else
			render :json => { 
				:errors => "This offer has already been taken by another client and accepted by the host" 
				}, status: 422
		end
	end

	# PUT /reservations/:id
	def update
	    if @reservation.update(put_params)
			case @reservation.status
				when 1
					ArsMailer.guest_has_cancel_reservation(@reservation).deliver_now
				when 2
					ArsMailer.host_has_decline_reservation(@reservation).deliver_now
				when 3
					ArsMailer.host_has_accepted_reservation(@reservation).deliver_now
			end
	      	render json: @reservation
	    else
	      	render json: @reservation.errors, status: :unprocessable_entity
	    end
	end

	# DELETE /reservations/:id
	def destroy
		@reservation.destroy
	end

	private

	def set_reservation
		@reservation = Reservation.find(params[:id])
	end

	def reservation_params
		params.permit(:host, :guest, :status, :house_id)
	end

	def put_params
		params.permit(:status)
	end

end
