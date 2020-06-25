class Subscription < ApplicationRecord
  belongs_to :subscribe
  belongs_to :breed
  belongs_to :city
  belongs_to :subscribe
end
