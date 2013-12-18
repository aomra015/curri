class InvitationMailer < ActionMailer::Base
  default from: "hi@curriapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation.invite.subject
  #
  def invite(invitation)
    @token = invitation.token
    @classroom = invitation.classroom
    mail to: invitation.email, subject: "Invitation to Curri"
  end
end
