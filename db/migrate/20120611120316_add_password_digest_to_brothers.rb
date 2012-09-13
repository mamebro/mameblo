class AddPasswordDigestToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :password_digest, :string
  end
end
