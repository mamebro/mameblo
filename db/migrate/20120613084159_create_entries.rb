class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :brother_id
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
