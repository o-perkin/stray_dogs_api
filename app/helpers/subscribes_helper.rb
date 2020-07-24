module SubscribesHelper
  def send_letters_after_subscribing(user, parameters_of_dogs, needed_dogs)
    UserMailer.subscription_email(user, parameters_of_dogs, needed_dogs).deliver
  end
end
