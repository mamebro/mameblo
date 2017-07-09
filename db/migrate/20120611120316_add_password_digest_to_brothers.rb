class AddPasswordDigestToBrothers < ActiveRecord::Migration[4.2]
  def change
    add_column :brothers, :password_digest, :string
  end
end
