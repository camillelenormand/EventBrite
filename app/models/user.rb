class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send

  # Associations
  has_many :attendances
  has_many :events, through: :attendances
  has_many :events, foreign_key: 'admin_id', class_name: 'Event'
  has_one_attached :avatar, dependent: :destroy # Active Storage

  # Validations

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
