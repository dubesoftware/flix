class Movie < ApplicationRecord
  
  has_many :reviews, dependent: :destroy
  has_many :critics, through: :reviews, source: :user
  
  has_many :favourites, dependent: :destroy
  has_many :fans, through: :favourites, source: :user
  
  has_many :characterisations, dependent: :destroy
  has_many :genres, through: :characterisations
  
  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS }
  
  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  
  scope :recent, ->(max = 5) { released.limit(max) }
  
  def self.hits
    where("total_gross >= 300000000").order(total_gross: :desc)
  end
  
  def self.flops
    where("total_gross < 22500000").order(total_gross: :asc)
  end
  
  def self.recently_added
    order("created_at desc").limit(3)
  end
  
  def flop?
    total_gross.blank? || total_gross < 225_000_000 unless
      reviews.size > 50 and reviews.average(:stars) >= 4
  end
  
  def average_stars
    reviews.average(:stars) || 0.0
  end
  
  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end
end
