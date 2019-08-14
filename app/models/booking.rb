class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :supply
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :supply_id, presence: true
end
