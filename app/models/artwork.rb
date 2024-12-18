class Artwork < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  has_one_attached :image
  # Validations
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
