class RestaurantItem < ApplicationRecord
	belongs_to :restaurant
	belongs_to :item
	has_many :cart_items, dependent: :destroy
	has_many :carts, through: :cart_items
	has_many :order_items, dependent: :destroy
	has_many :restaurant_items, through: :order_items
end
