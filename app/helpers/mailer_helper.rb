module MailerHelper
  def set_needed_dogs(subscriptions)
    dogs = []
    subscriptions.each do |subscription|
      dogs << Dog.where(breed_id: subscription[:breed_id], city_id: subscription[:city_id], age_id: subscription[:age_from]..subscription[:age_to])
    end
    dogs
  end
end 