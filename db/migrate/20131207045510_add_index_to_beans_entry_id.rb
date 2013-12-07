class AddIndexToBeansEntryId < ActiveRecord::Migration
  def change
    add_index :beans, :entry_id
  end
end
