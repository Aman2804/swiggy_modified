class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :condition
      t.string :coupon_name
      t.integer :per_off
      t.string :type_of_coupon

      t.timestamps
    end
  end
end
