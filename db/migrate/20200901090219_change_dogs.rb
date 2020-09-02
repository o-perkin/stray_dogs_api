class ChangeDogs < ActiveRecord::Migration[6.0]
  def change
    change_column :dogs, :name, :string, null: false
    change_column :dogs, :user_id, :integer, null: false
  end
end
