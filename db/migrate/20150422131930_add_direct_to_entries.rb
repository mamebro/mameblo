class AddDirectToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :direct, :integer
  end
end
