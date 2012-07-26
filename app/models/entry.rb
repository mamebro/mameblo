require 'rdiscount'

class Entry < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :user

  validates :title, presence: true, length: { maximum: 20000 }
  validates :content, presence: true, length: { maximum: 20000 }
  validates :user_id, presence: true

  default_scope order: 'entries.created_at DESC'

  # https://github.com/rtomayko/rdiscount
  def content_as_markdown
    markdown = RDiscount.new(content.to_s, :filter_html, :autolink)
    markdown.to_html
  end

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)   
  end
end
