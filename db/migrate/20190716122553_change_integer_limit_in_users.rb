class ChangeIntegerLimitInUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :contact, :integer, limit: 8
  end
end
