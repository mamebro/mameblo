class AddAlterEmailToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :alter_email, :string
  end
end
