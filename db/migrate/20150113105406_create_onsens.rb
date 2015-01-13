class CreateOnsens < ActiveRecord::Migration
  def change
    create_table :onsens do |t|
      t.integer :brother_id
      t.integer :bathing

      t.timestamps null: false
    end
  end
end
