module CheckoutHelper

  def is_event_attendee?(event_id, current_user)
    if event_id.nil?
      return false
    else
      Attendance.where(user_id: current_user.id, event_id: event_id).exists?
    end
  end

  def is_event_admin?(event_id, current_user)
    if event_id.nil?
      return false
    else
      Event.where(admin_id: current_user.id, id: event_id).exists?
    end
  end

  def create_attendee(user_id, event_id)
    Attendance.create(user_id: current_user.id, event_id: params[:event_id])
  end

end
