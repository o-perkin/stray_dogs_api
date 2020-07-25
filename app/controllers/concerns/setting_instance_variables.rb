module SettingInstanceVariables
  extend ActiveSupport::Concern

  included do 
    before_action :set_subscriptions, only: [:create]
  end

  def set_subscriptions      
    @subscriptions = Subscription.find(params[:dog])
  end
end