class Supply < ApplicationRecord
  CATEGORY = ['paintbrushes', 'paints', 'drawing tablet', 'digital pen', 'pencils', 'markers', 'pens', 'easel', 'sculpting tools', 'palette', 'lightbox']
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :title, presence: true, length: { maximum: 140 }
  validates :price, presence: true
  validates :category, presence: true
  mount_uploader :photo, PhotoUploader
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :search_by_category_title_desc,
    against: [:category, :title, :description],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_by_category, 
    against: [:category], 
    using: {
      tsearch: {any_word: true}
    }
    
  acts_as_taggable_on :tags
end
