class AddRememberTokenToBrothers < ActiveRecord::Migration[4.2]
  def change
    add_column :brothers, :remember_token, :string
    add_index  :brothers, :remember_token
  end
end
