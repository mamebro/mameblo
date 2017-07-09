class CreateApiAuthenticates < ActiveRecord::Migration[4.2]
  def change
    create_table :api_authenticates do |t|
      t.integer :brother_id
      t.string  :token

      t.timestamps
    end

    add_index :api_authenticates, :brother_id
    add_index :api_authenticates, :token
  end
end
