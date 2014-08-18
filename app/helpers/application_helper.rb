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

  # 一人称
  def myself
    I18n.t(:myself)
  end
end
