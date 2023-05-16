class AttendanceMailer < ApplicationMailer

  def attendance_confirmation(user)
    @user = user

    @event = Event.find(params[:event_id])

    @url = 'http://event-brite.fly.dev/login'

    mail(to: @user.email, subject: 'Vous êtes inscrit à l\'évènement !') 

  end
end
