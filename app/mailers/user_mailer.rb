class UserMailer < ApplicationMailer
  helper :mailer
  default from: ENV['gmail_username']
 
  def email_subscription_confirmation(user, subscriptions)
    @user = user
    @subscriptions = subscriptions
    mail(to: @user.email, subject: 'Ви підписались!')
  end

  def email_that_dog_is_wanted(user, subscriptions)
    @user = user
    @subscriptions = subscriptions
    mail(to: @user.email, subject: 'На сайті вже шукають вашу собаку!')  do |format|
      format.html(content_transfer_encoding: "quoted-printable")
    end
  end

  def email_confirmation_of_created_dog(user)
    @user = user
    mail(to: @user.email, subject: 'Ви додали собаку!')
  end

  def email_that_dog_appeared(user, subscriptions)
    subscriptions.each do |subscription|
      @user = subscription.subscribe.user
      @dog = user.dogs.last
      mail(to: @user.email, subject: "На сайті з'явилась потрібна вам собака!")  
    end 
  end 
end