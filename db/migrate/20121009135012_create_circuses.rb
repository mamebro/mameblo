class CreateCircuses < ActiveRecord::Migration
  def change
    create_table :circuses do |t|
      t.integer :brother_id
      t.boolean :participation

      t.timestamps
    end
  end
end
