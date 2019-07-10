class Delivery < ApplicationRecord
	belongs_to :order
	belongs_to :vehicle
	validates :status, presence: true
end
