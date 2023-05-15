class Attendance < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :event

  # Validations
  validates :stripe_customer_id, presence: true
end
