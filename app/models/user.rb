class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :supplies
  has_many :bookings # as customer
  has_many :bookings_as_supplier, through: :supplies, source: :bookings
  has_many :reviews
end
