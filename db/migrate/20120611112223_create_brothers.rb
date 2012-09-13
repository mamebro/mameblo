class CreateBrothers < ActiveRecord::Migration
  def change
    create_table :brothers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
