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

  # 一人称
  def myself
    I18n.t(:myself)
  end

  # 結婚式
  def wedding_party
    I18n.t(:wedding_party)
  end

  # カウントダウン
  def countdown(year, month, day)
    target = Time.mktime(year, month, day, 0, 0, 0)
    ((target - Time.now) / (60 * 60 * 24) + 1).floor
  end
end
