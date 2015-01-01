class EntryHasHashtag < ActiveRecord::Base
  belongs_to :entry
  belongs_to :hashtag
end
