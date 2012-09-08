class AddIndexToBrothersEmail < ActiveRecord::Migration
  def change
    add_index :brothers, :email, unique: true
  end
end
