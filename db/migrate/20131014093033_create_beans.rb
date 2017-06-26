class CreateBeans < ActiveRecord::Migration[4.2]
  def change
    create_table :beans do |t|
      t.integer :kind, default: 0
      t.integer :entry_id
      t.integer :throw_brother_id

      t.timestamps
    end
  end
end
