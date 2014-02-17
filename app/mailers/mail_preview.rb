class MailPreview < MailView
  def password_reset
    user = User.first
    user.generate_token(:password_reset_token)
    user.save
    UserMailer.password_reset(user.id)
  end

  def invite
    InvitationMailer.invite(Invitation.first)
  end
end