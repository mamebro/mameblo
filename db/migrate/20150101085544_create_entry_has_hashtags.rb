class CreateEntryHasHashtags < ActiveRecord::Migration
  def change
    create_table :entry_has_hashtags do |t|
      t.references :entry, index: true
      t.references :hashtag, index: true

      t.timestamps null: false
    end
    add_foreign_key :entry_has_hashtags, :entries
    add_foreign_key :entry_has_hashtags, :hashtags
  end
end
