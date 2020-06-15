class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :city
  belongs_to :age
  belongs_to :user
  has_many :favorites, dependent: :delete_all
end
