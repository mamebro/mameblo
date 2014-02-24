class RenameApiAuthenticationToAuthentication < ActiveRecord::Migration
  def change
    rename_table :api_authentications, :authentications
  end
end
