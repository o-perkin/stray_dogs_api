module SendEmails
  extend ActiveSupport::Concern

  def send_emails(user, subscriptions, dog)
    if subscriptions == []
      UserMailer.email_after_creating_dog(user).deliver      
    else
      UserMailer.email_if_dog_already_wanted(user, subscriptions).deliver
      UserMailer.email_if_dog_appeared(subscriptions, dog).deliver
    end
  end
end



