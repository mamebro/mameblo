# -*- coding: utf-8 -*-
require 'rdiscount'

class Entry < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :brother

  validates :title, presence: true, length: { maximum: 20000 }
  validates :content, presence: true, length: { maximum: 20000 }
  validates :brother_id, presence: true

  default_scope order: 'created_at DESC'
  paginates_per 5

  # https://github.com/rtomayko/rdiscount
  # Markdownで出力する
  def content_as_markdown
    markdown = RDiscount.new(content.to_s, :filter_html, :autolink)
    markdown.to_html
  end

  def self.from_brothers_followed_by(brother)
    followed_brother_ids = brother.followed_brother_ids
    where("brother_id IN (:followed_brother_ids) OR brother_id = :brother_id",
          followed_brother_ids: followed_brother_ids, brother_id: brother)   
  end
end
