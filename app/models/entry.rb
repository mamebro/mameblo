require 'rdiscount'

class Entry < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  belongs_to :user

  def content_as_markdown
    markdown = RDiscount.new(content.to_s, :filter_html, :autolink)
    markdown.to_html
  end

end
