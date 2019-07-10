class Coupon < ApplicationRecord
	validates :condition,:coupon_name,:per_off,:type_of_coupon, presence: true
	validates :coupon_name, uniqueness: true
end
