class UserMailer < ApplicationMailer
  def invitation_email(invitation)
    @invitation = invitation
    @url = accept_invitation_url(@invitation.invitation_token, host: 'localhost:3000') 
    mail(to: @invitation.email, subject: 'Welcome to our Application')
  end
end
