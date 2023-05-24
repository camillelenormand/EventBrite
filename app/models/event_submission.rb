class EventSubmission < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, uniqueness: { scope: :user_id }
  validates :user_id, uniqueness: { scope: :event_id }
end
