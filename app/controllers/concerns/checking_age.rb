module CheckingAge
  extend ActiveSupport::Concern

  included do 
    before_action :check_age, only: [:create, :update]
  end

  def check_age
    params[:subscribe][:subscriptions_attributes].each do |k, v| 
      v[:age_from].to_i > v[:age_to].to_i ? @age = false : @age = true
    end
  end 
end

