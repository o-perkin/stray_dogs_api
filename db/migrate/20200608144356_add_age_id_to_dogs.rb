class AddAgeIdToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :age_id, :integer
  end
end
