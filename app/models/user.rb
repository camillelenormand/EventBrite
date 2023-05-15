class User < ApplicationRecord
  after_create :welcome_send

  # Associations
  has_many :attendances
  has_many :events, through: :attendances
  has_many :events, foreign_key: 'admin_id', class_name: 'Event'

  # Validations

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
