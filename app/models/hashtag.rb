class Hashtag < ActiveRecord::Base
  has_many :entry_has_hashtags
  has_many :entries, through: :entry_has_hashtags
end
