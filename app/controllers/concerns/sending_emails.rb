module SendingEmails
  extend ActiveSupport::Concern

  def send_email_after_adding_dog(user, dog, subscriptions)
    if subscriptions == []
      UserMailer.new_dog_email(user).deliver      
    else
      (UserMailer.available_subscription_email(user, subscriptions).deliver &&
      UserMailer.send_notification_to_subscriber(subscriptions, dog).deliver)
    end
  end

  def send_email_after_subscribing(user, params_of_subscribed_dogs, needed_dogs)
    UserMailer.subscription_email(user, params_of_subscribed_dogs, needed_dogs).deliver
  end
end