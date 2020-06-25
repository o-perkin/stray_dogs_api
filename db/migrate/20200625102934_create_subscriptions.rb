class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :subscribe, foreign_key: true
      t.references :breed, foreign_key: true
      t.references :city, foreign_key: true
      t.integer :age_from
      t.integer :age_to

      t.timestamps
    end
  end
end
