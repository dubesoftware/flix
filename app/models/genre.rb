class Genre < ApplicationRecord
  has_many :characterisations, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
