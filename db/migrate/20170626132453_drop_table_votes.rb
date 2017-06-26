class DropTableVotes < ActiveRecord::Migration[5.1]
  def change
    drop_table :votes
  end
end
