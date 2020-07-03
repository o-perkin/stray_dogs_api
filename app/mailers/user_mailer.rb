class UserMailer < ApplicationMailer

  default from: ENV['gmail_username']
 
  def subscription_email(user, parameters_of_dogs, needed_dogs)
    @user = user
    @parameters_of_dogs = parameters_of_dogs
    @needed_dogs = needed_dogs
    mail(to: @user.email, subject: 'Ви підписались!')
  end

  def available_subscription_email(user, subscriptions)
    @user = user
    @subscriptions = subscriptions
    mail(to: @user.email, subject: 'Ви додали собаку!')
  end

  def new_dog_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ви додали собаку!')
  end
end 
