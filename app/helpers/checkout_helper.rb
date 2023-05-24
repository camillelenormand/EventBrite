module CheckoutHelper
  def is_event_attendee?(event_id, current_user)
    return false if event_id.nil?

    Attendance.exists?(user_id: current_user.id, event_id: event_id)
  end

  def is_event_admin?(event_id, current_user)
    return false if event_id.nil?

    Event.exists?(admin_id: current_user.id, id: event_id)
  end

  def create_attendee(user_id, event_id)
    Attendance.create(user_id: user_id, event_id: event_id)
  end
end
