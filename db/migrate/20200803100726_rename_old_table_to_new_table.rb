class RenameOldTableToNewTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :jwt_blacklists, :jwt_denylists
  end
end
