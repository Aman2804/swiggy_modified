class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
			t.belongs_to :order, index: true
      t.belongs_to :vehicle, index: true
      t.string 		 :status
      t.timestamps
    end
  end
end
