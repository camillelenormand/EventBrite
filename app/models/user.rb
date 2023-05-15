class User < ApplicationRecord
  # Associations
  has_many :attendances
  has_many :events, through: :attendances
  has_many :events, foreign_key: 'admin_id', class_name: 'Event'

  # Validations

end
