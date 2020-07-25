class UserMailer < ApplicationMailer

  default from: ENV['gmail_username']
 
  def subscription_email(user, params_of_subscribed_dogs, needed_dogs)
    @user = user
    @params_of_subscribed_dogs = params_of_subscribed_dogs
    @needed_dogs = needed_dogs
    mail(to: @user.email, subject: 'Ви підписались!')
  end

  def available_subscription_email(user, subscriptions)
    @user = user
    @subscriptions = subscriptions
    mail(to: @user.email, subject: 'На сайті вже шукають вашу собаку!')  do |format|
      format.html(content_transfer_encoding: "quoted-printable")
    end
  end

  def new_dog_email(user)
    @user = user
    mail(to: @user.email, subject: 'Ви додали собаку!')
  end

  def send_notification_to_subscriber(subscriptions, dog)
    subscriptions.each do |subscription|
      @user = subscription.subscribe.user
      @dog = dog
      mail(to: @user.email, subject: "На сайті з'явилась потрібна вам собака!")  
    end 
  end 
end 
