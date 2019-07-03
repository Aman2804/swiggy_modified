class Restaurant < ApplicationRecord
	belongs_to :user
	has_many :restaurant_items, dependent: :destroy
	has_many :items, through: :restaurant_items
	has_many :orders, dependent: :destroy
	has_many :favourite_restaurants, dependent: :destroy
end
