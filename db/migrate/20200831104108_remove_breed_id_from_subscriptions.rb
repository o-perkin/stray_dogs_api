class RemoveBreedIdFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :subscriptions, :breed_id, :integer
    remove_column :subscriptions, :city_id, :integer
  end
end
