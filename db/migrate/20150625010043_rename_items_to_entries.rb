class RenameItemsToEntries < ActiveRecord::Migration
  def change
    rename_table :items, :entries
  end
end
