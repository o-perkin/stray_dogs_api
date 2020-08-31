class AddBreedToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :breed, :integer
    add_column :subscriptions, :city, :integer
  end
end
