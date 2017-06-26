class CreateEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :entries do |t|
      t.integer :brother_id
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
