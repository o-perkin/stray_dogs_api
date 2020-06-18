class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :city
  belongs_to :age
  belongs_to :user
  has_many :favorites, dependent: :delete_all

  def self.search(search)
    if search 
      where('name LIKE ?', "%#{search}%")
    else 
      all
    end
  end
end
