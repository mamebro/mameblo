class RenameApiAuthenticateToApiAuthentication < ActiveRecord::Migration[4.2]
  def change
    rename_table :api_authenticates, :api_authentications
  end
end
