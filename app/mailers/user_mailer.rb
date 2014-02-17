class UserMailer < ActionMailer::Base
  default from: "hi@curriapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(id)
    @user = User.find(id)
    mail :to => @user.email, :subject => "Password Reset Instructions"
  end
end
