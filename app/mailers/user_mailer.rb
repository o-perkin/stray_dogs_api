class UserMailer < ApplicationMailer
  default from: ENV['gmail_username']
 
  def welcome_email(user, parameters_of_dogs)
    @user = user
    @breed = parameters_of_dogs[:breed]
    @city = parameters_of_dogs[:city]
    @age = parameters_of_dogs[:age]
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    puts parameters_of_dogs
  end
end 
