class Subscribe < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :subscriptions, allow_destroy: true, limit: 3  
  validates :subscriptions, presence: true
  validates :user_id, uniqueness: { scope: :user_id, message: "You've already subscribed!" }
end