class Item < ApplicationRecord
	has_many :restaurant_items, dependent: :destroy
	has_many :restaurants, through: :restaurant_items
end
