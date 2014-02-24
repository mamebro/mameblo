class RenameApiAuthenticateToApiAuthentication < ActiveRecord::Migration
  def change
    rename_table :api_authenticates, :api_authentications
  end
end
