class AttendanceMailer < ApplicationMailer

  def attendance_email(user)
    @user = user

    @url = 'http://monsite.fr/login'

    @event = Attendance.find_by(user_id: @user.id).event.title  

    mail(to: @user.email, subject: 'Vous êtes inscrit!') 

  end
end
