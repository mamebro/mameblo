class AddRememberTokenToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :remember_token, :string
    add_index  :brothers, :remember_token
  end
end
