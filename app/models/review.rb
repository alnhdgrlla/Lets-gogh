class Review < ApplicationRecord
  belongs_to :user
  belongs_to :supply
  validates :content, presence: true, length: { minimum: 20 }
end
