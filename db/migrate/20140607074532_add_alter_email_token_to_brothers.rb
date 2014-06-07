class AddAlterEmailTokenToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :alter_email_token, :string
  end
end
