class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :restaurant_item
	validates :quantity, presence: true,numericality: true
end
