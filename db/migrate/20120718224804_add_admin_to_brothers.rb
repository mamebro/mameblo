class AddAdminToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :admin, :boolean
  end
end
