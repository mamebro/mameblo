class RenameApiAuthenticationToAuthentication < ActiveRecord::Migration[4.2]
  def change
    rename_table :api_authentications, :authentications
  end
end
