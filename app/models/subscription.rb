class Subscription < ApplicationRecord
  belongs_to :subscribe
  belongs_to :breed, optional: true
  belongs_to :city, optional: true
end
