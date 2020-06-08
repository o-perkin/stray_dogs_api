class AddBreedIdToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :breed_id, :integer
  end
end
