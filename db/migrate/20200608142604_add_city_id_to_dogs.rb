class AddCityIdToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :city_id, :integer
  end
end
