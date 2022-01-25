require 'redcarpet'

class Entry < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :brother
  has_many :beans, dependent: :destroy
  has_many :entry_has_hashtags
  has_many :hashtags, through: :entry_has_hashtags

  validates :title, presence: true, length: { maximum: 20000 }
  validates :content, presence: true, length: { maximum: 20000 }
  validates :brother_id, presence: true

  default_scope { order('created_at DESC') }
  paginates_per 5

  before_validation :set_title_date

  def content_as_markdown
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})

    markdown.render(content).html_safe
  end

  def self.from_brothers_followed_by(brother)
    followed_brother_ids = brother.followed_brother_ids
    where("brother_id IN (:followed_brother_ids) OR brother_id = :brother_id",
          followed_brother_ids: followed_brother_ids, brother_id: brother)
  end

  def hashtag_names
    self.content.scan(/[#][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/).map(&:strip).map{|c| c.slice(1..-1)}
  end

  private
  def set_title_date
    self.title = Date.today.strftime("%Y/%m/%d") if self.title.blank?
  end

  def options
    {
      filter_html:     true,     # htmlを出力しない
      hard_wrap:       true,     # マークダウン中の空行をhtmlに置き換え
      space_after_headers: true, # # と文字の間にスペースを要求
    }
  end

  def extensions
    {
      autolink:           true,  # <>で囲まれてなくてもリンクを認識
      no_intra_emphasis:  true,  # 単語中の強調を認識しない
      fenced_code_blocks: true,  # フェンスのあるコードブロックを認識
      strikethrough:      true,  # ~ 2つで取り消し線
      superscript:        true,  # ^ の後ろが上付き文字
      tables:             true,  # テーブルを認識
      underline:          true,  # 斜線(* *)
      highlight:          true,  # ハイライト(== ==)
      quote:              true,  # 引用符(" ")
      footnotes:          true,  # 脚注( ^[1] )
    }
  end
end
