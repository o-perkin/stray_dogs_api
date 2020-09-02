class ChangeSubscriptions < ActiveRecord::Migration[6.0]
  def change
    change_column :subscriptions, :age_from, :integer, null: false
    change_column :subscriptions, :age_to, :integer, null: false
  end
end
