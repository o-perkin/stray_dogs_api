class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :city
  belongs_to :age
end
