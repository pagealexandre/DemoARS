class AddStatusToRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :status, :integer, :default => 0
  end
end
