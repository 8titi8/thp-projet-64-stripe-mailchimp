class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
     mail(to: @user.email, subject: "Petit message de bienvenue")
   end
end


