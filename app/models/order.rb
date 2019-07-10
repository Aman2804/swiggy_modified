class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items, dependent: :destroy
	has_many :restaurant_items, through: :order_items
	has_one :payment, dependent: :destroy
	belongs_to :restaurant
	has_one :role, dependent: :destroy
	has_one  :delivery, dependent: :destroy
	validates :status, presence: true
end
