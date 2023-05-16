class Event < ApplicationRecord
  # Associations
  has_many :attendances
  has_many :users, through: :attendances

  # Validations
  validates :start_date, presence: true, comparison: { greater_than: DateTime.now }
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, divisible_by: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
  validates :location, presence: true


  def divisible_by?(duration)
    duration % 5 == 0
    self.errors.add(:attribute, "is not divisible by 3")
  end

end
