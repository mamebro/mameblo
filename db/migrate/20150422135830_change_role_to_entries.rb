class ChangeRoleToEntries < ActiveRecord::Migration
  def up
    change_column :entries, :role, :integer, null: false, default: 0
  end

  def down
    change_column :entries, :role, :integer, null: true, default: 0
  end
end
