module MailerHelper
  def set_needed_dogs(subscriptions)
    dogs = []
    subscriptions.each do |subscription|
      dogs << Dog.where(breed: subscription[:breed], city: subscription[:city], age: subscription[:age_from]..subscription[:age_to])
    end
    dogs
  end
end