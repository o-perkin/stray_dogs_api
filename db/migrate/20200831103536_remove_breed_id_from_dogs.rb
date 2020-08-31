class RemoveBreedIdFromDogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :dogs, :breed_id, :integer
    remove_column :dogs, :city_id, :integer
    remove_column :dogs, :age_id, :integer
  end
end
