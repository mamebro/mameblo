class AddIndexToBrothersEmail < ActiveRecord::Migration[4.2]
  def change
    add_index :brothers, :email, unique: true
  end
end
