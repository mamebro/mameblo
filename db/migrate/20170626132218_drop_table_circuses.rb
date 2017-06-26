class DropTableCircuses < ActiveRecord::Migration[5.1]
  def change
    drop_table :circuses
  end
end
