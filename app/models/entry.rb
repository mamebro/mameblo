require 'redcarpet'

class Entry < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :brother
  has_many :beans, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20000 }
  validates :content, presence: true, length: { maximum: 20000 }
  validates :brother_id, presence: true

  default_scope { order('created_at DESC') }
  paginates_per 5

  before_validation :set_title_date

  # http://rubygems.org/gems/github-markdown
  # GitHub-Markdownで出力
  def content_as_markdown
    GitHub::Markdown.render_gfm(content)
  end

  def self.from_brothers_followed_by(brother)
    followed_brother_ids = brother.followed_brother_ids
    where("brother_id IN (:followed_brother_ids) OR brother_id = :brother_id",
          followed_brother_ids: followed_brother_ids, brother_id: brother)   
  end

  def set_title_date
    self.title = Date.today.strftime("%Y/%m/%d") if self.title.blank?
  end
end
