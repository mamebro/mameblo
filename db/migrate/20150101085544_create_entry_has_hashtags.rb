class CreateEntryHasHashtags < ActiveRecord::Migration[4.2]
  def change
    create_table :entry_has_hashtags, id: false do |t|
      t.references :entry, index: true
      t.references :hashtag, index: true

      t.timestamps null: false
    end
    add_foreign_key :entry_has_hashtags, :entries
    add_foreign_key :entry_has_hashtags, :hashtags

    add_index :entry_has_hashtags, [:entry_id, :hashtag_id], unique: true
  end
end
