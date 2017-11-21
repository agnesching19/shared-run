class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: @user.first_name, subject: "Welcome to Shared.Run!")
  end
end
