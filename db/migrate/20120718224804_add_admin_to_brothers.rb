class AddAdminToBrothers < ActiveRecord::Migration[4.2]
  def change
    add_column :brothers, :admin, :boolean
  end
end
