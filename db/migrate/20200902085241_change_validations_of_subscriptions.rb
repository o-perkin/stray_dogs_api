class ChangeValidationsOfSubscriptions < ActiveRecord::Migration[6.0]
  def change
    change_column :subscriptions, :breed, :integer, null: false
    change_column :subscriptions, :city, :integer, null: false
    change_column :subscriptions, :subscribe_id, :integer, null: false
  end
end
