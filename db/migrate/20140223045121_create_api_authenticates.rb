class CreateApiAuthenticates < ActiveRecord::Migration
  def change
    create_table :api_authenticates do |t|
      t.integer :user_id
      t.string  :token

      t.timestamps
    end

    add_index :api_authenticates, :user_id
    add_index :api_authenticates, :token
  end
end
