class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :artwork


  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date
  validates :status, inclusion: { in: ['Pending', 'Confirmed', 'Cancelled'] }

  # Exemple de méthode de validation pour s'assurer que la date de fin est après la date de début
  private
  def end_date_after_start_date
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
