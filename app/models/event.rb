class Event < ApplicationRecord
  # Associations
  has_many :attendances
  has_many :users, through: :attendances

  # Validations
  validates :start_date, presence: true, date: { on_or_after: -> { DateTime.today } }
end
