class Subscribe < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :delete_all
  accepts_nested_attributes_for :subscriptions
end
