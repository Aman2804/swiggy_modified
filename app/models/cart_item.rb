class CartItem < ApplicationRecord
	belongs_to :cart
	belongs_to :restaurant_item
	validates :num_of_item, presence: true, numericality: true
end
