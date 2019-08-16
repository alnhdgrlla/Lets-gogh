class Supply < ApplicationRecord
  CATEGORY = ['paintbrushes', 'paints', 'drawing tablet', 'digital pen', 'pencils', 'markers', 'pens', 'easel', 'sculpting tools', 'palette', 'lightbox']
  belongs_to :user
  has_many :bookings
  validates :title, presence: true
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

  def current_bookings_for_supply
    current_bookings_array = []
    bookings.each do |booking|
      current_bookings_array << booking if booking.start_date < Date.today && Date.today < booking.end_date
    end
  end

  def booked?
    bookings.each do |booking|
      return true if booking.start_date <= Date.today && Date.today <= booking.end_date
    end
    false
  end
end
