class Subscribe < ApplicationRecord
  has_many :subscriptions, dependent: :delete_all
  belongs_to :user
  accepts_nested_attributes_for :subscriptions, reject_if: :all_blank, allow_destroy: true
  validates :subscriptions, presence: true
end
