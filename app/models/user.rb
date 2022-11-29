class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_movies, through: :favourites, source: :movie
  
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\S+@\S+/ },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :username, presence: true,
                       format: { with: /\A[A-Z0-9]+\z/i },
                       uniqueness: { case_sensitive: false }
  before_save :format_username, :format_email_address
  
  scope :by_name, -> { order(:name) }
  
  scope :not_admins, -> { by_name.where(admin: false) }
  
  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
  
  def format_username
    self.username = username.downcase
  end
  
  def format_email_address
    self.email = email.downcase
  end
end
