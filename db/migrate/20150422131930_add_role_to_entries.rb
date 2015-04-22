class AddRoleToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :role, :integer
  end
end
