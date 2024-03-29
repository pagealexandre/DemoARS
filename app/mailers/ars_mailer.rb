class ArsMailer < ApplicationMailer
	default from: "ars@sandbox12a29364aa7240a1aef32848731dc954.mailgun.org"

	def reservation_notification_host(host, guest)
		@host = host
		@guest = guest
		mail to: @host, subject: "Someone is interested in your house"
	end

	def reservation_notification_guest(host, guest)
		@host = host
		@guest = guest
		mail to: @guest, subject: "Request confirmation"
	end

	def guest_has_cancel_reservation(request)
		@host = request.host
		@guest = request.guest
		mail to: @host, subject: "The guest has cancel his request"
	end

	def expire_notification(host, guest)
		@host = host
		@guest = guest
		mail to: [@guest, @host], subject: "Your reservation has expired"
	end

	def host_has_decline_reservation(request)
		@host = request.host
		@guest = request.guest
		mail to: @guest, subject: "The host has decline your request reservation"
	end

	def host_has_accepted_reservation(request)
		@host = request.host
		@guest = request.guest
		mail to: [@guest, @host], subject: "Confirmation reservation"
	end
	
end
