class InvitationMailer < ActionMailer::Base
  default from: "curry@fakemail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation.invite.subject
  #
  def invite(invitation)
    @token = invitation.token
    mail to: invitation.email, subject: "Invitation to Curry"
  end
end
