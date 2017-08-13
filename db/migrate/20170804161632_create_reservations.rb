class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :guest
      t.string :host
      t.integer :status, :default => 0
      t.integer :house_id

      t.timestamps
    end
  end
end
