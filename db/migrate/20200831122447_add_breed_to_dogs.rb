class AddBreedToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :breed, :integer, null: false
    add_column :dogs, :city, :integer, null: false
    add_column :dogs, :age, :integer, null: false
  end
end
