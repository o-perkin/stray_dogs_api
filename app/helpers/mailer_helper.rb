module MailerHelper
  def check_subscription_exist(num, params_of_subscribed_dogs)
    Breed.where(id: params_of_subscribed_dogs[:breed].values[num]).first ? true : false
  end
end