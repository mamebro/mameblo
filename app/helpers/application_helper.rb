module ApplicationHelper
  #Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "まめぶろ"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # HTMLで書けない文字の実体参照と改行コードのHTMLへの置換を行う
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end

  # ランダムに一人称を表示する
  def random_myself
    myself_labels = ['わたし', 'あたし', 'ぼく', 'おれ', 'じぶん', 'あちき']
    myself_labels.sample
  end
end
