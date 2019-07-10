class Item < ApplicationRecord
	has_many :restaurant_items, dependent: :destroy
	has_many :restaurants, through: :restaurant_items
	validates :name,:category,:type_of_dish, presence: true
	validates :name, uniqueness: true
end
