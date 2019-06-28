class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :user_type
  after_commit :action_after_commit
  devise :database_authenticatable, :registerable,
		 		 :recoverable, :rememberable, :validatable
  validates	:name,:contact,:city, 					presence: 		 true
	validates :contact,            		   		 	numericality: true
	validates :gender,											 	inclusion: {in:["Male","Female"],message: " should select"}
	has_many :addresses, as: :addressable
  has_many :restaurants
  has_many :favourite_restaurants, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_one :vehicle, dependent: :destroy

  def action_after_commit
    @role = User.last.roles.build
    @role.user_type = self.user_type
    @role.save
    if User.last.roles.first.user_type == "user"
      User.last.create_cart
    end
  end
end
