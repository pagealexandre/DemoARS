class Reservation < ApplicationRecord

	def self.perform_async
		@requests = Reservation.where("created_at < ?", Time.now - 24.hours)
		@requests.each do |request|
			ArsMailer.expire_notification(request.host, request.guest).deliver_now
		end
		@requests.destroy_all
	end

	def self.possible?(request)
		requests = Reservation.where(:house_id => request[:house_id])
		if requests.count == 0
			return true
		else
			r = requests.where(:status => 3)
			if r.count == 0
				return true
			end
		end
		return false
	end

	validates_presence_of :guest, :host, :house_id
end
