class AddIndexToBeansEntryId < ActiveRecord::Migration[4.2]
  def change
    add_index :beans, :entry_id
  end
end
