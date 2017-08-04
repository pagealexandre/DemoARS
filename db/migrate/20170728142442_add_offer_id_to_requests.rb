class AddOfferIdToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :offer_id, :integer
  end
end
