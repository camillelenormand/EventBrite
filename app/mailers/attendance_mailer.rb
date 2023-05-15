class AttendanceMailer < ApplicationMailer

  def attendance_email(user)
    @user = user

    @url = 'http://monsite.fr/login'

    mail(to: @user.email, subject: 'Vous êtes inscrit à l\'évènement !') 

  end
end
