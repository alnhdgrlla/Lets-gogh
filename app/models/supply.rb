class Supply < ApplicationRecord
  CATEGORY = ['paintbrushes', 'paints', 'drawing tablet', 'digital pen', 'pencils', 'markers', 'pens', 'easel', 'sculpting tools', 'palette', 'lightbox']
  belongs_to :user
  has_many :bookings
  validates :title, presence: true
  validates :price, presence: true
  validates :category, presence: true
end