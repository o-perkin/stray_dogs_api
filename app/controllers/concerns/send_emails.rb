module SendEmails
  extend ActiveSupport::Concern

  def send_emails(user, subscriptions)
    if subscriptions == []
      UserMailer.email_after_creating_dog(user).deliver      
    else
      UserMailer.email_if_dog_already_wanted(user, subscriptions).deliver
      UserMailer.email_if_dog_appeared(user, subscriptions).deliver
    end
  end
end

 
 
