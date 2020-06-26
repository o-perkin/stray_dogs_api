class Subscribe < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :delete_all
  accepts_nested_attributes_for :subscriptions, reject_if: :all_blank, allow_destroy: true
  validates :subscriptions, presence: true
end
