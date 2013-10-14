class CreateBeans < ActiveRecord::Migration
  def change
    create_table :beans do |t|
      t.integer :type
      t.integer :entry_id
      t.integer :throw_brother_id

      t.timestamps
    end
  end
end
