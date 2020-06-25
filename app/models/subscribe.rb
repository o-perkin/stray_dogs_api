class Subscribe < ApplicationRecord
  belongs_to :user
  has_many :subscriptions
  accepts_nested_attributes_for :subscriptions, 
                                reject_if: lambda { |attrs|
                                  attrs['breed_id'].blank? &&
                                  attrs['city_id'].blank? &&
                                  attrs['age_from'].blank? &&
                                  attrs['age_to'].blank?
                                }
end
