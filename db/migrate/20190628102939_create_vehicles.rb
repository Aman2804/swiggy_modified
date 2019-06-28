class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
    	t.belongs_to :user, index: true
    	t.string :vehicle
    	t.string :vehicle_name
      t.timestamps
    end
  end
end
