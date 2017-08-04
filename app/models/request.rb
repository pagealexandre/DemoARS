class Request < ApplicationRecord

	def self.check_expiration
		thirty_sec_ago = Time.now - 30.seconds
		@request = Request.where("created_at < ?", thirty_sec_ago)
		@request.each do |request|
			ArsMailer.request_notification_host(request.host, request.guest).deliver_now
		end
		@request.destroy_all
	end

	def self.update_request
		@requests = Request.where.not(:status => 0)
		@requests.each do |request|
			case request.status
				when 1
					ArsMailer.guest_has_cancel_request(request).deliver_now
				when 2
					ArsMailer.host_has_decline_request(request).deliver_now
				when 3
					ArsMailer.host_has_accepted_request(request).deliver_now
			end
		end
		@requests.destroy_all
	end

	def self.possible?(request)
		requests = Request.where(:offer_id => request[:offer_id])
		if requests.count == 0
			return true
		else
			r = requests.where(:status => 3)
			if r.count != 0
				return true
			end
		end
		return false
	end

	validates_presence_of :guest, :host, :offer_id
end
