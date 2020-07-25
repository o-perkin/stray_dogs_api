module SetSubscriptions
  extend ActiveSupport::Concern

  included do 
    before_action :set_subscriptions, only: [:create]
  end

  def set_subscriptions      
    @subscriptions = Subscription.find_by_dog_params(params[:dog])
  end
end