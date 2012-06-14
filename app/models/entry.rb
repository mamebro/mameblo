class Entry < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  belongs_to :user
end
