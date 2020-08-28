module SendEmails
  extend ActiveSupport::Concern

  def send_emails(user, subscriptions)
    if subscriptions == []
      UserMailer.email_confirmation_of_created_dog(user).deliver      
    else
      UserMailer.email_that_dog_is_wanted(user, subscriptions).deliver
      UserMailer.email_that_dog_appeared(user, subscriptions).deliver
    end
  end
end