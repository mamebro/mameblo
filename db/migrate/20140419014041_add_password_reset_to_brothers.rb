class AddPasswordResetToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :password_reset_token, :string
    add_column :brothers, :password_reset_sent_at, :datetime
  end
end
