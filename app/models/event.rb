class Event < ApplicationRecord
  
  # Associations
  has_many :attendances
  has_many :users, through: :attendances
  belongs_to :user, foreign_key: 'admin_id', class_name: 'User'
  has_one_attached :event_picture, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: "10x10", :quality => 100
  end

  # Validations
  validates :start_date, presence: true, comparison: { greater_than: DateTime.now }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
  validates :location, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :event_picture, presence: true


  def divisible_by?(duration)
    duration % 5 == 0
    self.errors.add(:attribute, "is not divisible by 3")
  end

end
