class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :flat_no, :location, :city, presence: true
  validates :flat_no, numericality: true
end
