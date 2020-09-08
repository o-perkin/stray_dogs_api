module MailerHelper
  def find_needed_dogs(subscriptions)
    subscriptions.map do |subscription|
      Dog.where(breed: subscription[:breed], city: subscription[:city], age: subscription[:age_from]..subscription[:age_to])
    end
  end
end