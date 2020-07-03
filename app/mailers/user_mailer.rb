class UserMailer < ApplicationMailer

  default from: ENV['gmail_username']
 
  def welcome_email(user, parameters_of_dogs, needed_dogs)
    @user = user
    @parameters_of_dogs = parameters_of_dogs
    @needed_dogs = needed_dogs
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end 
