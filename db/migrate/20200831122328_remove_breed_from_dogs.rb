class RemoveBreedFromDogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :dogs, :breed, :integer
    remove_column :dogs, :city, :integer
    remove_column :dogs, :age, :integer
  end
end
