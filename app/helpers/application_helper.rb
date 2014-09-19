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

  # ブラザー絵文字に変換する
  def convert_bro(content)
    content.gsub(/:brogoodbye:/, image_tag('stamps/goodbye.svg'))
    .gsub(/:brojump:/, image_tag('stamps/jump.svg'))
    .gsub(/:bronobita:/, image_tag('stamps/nobita.svg'))
    .gsub(/:broserious:/, image_tag('stamps/serious.svg'))
    .gsub(/:brosisters:/, image_tag('stamps/sisters.svg'))
    .gsub(/:brosorry:/, image_tag('stamps/sorry.svg'))
    .gsub(/:brocongratulations:/, image_tag('stamps/congratulations.svg'))
    .gsub(/:broeyes:/, image_tag('stamps/eyes.svg'))
    .gsub(/:broheart:/, image_tag('stamps/heart.svg'))
    .gsub(/:brolonely:/, image_tag('stamps/lonely.svg'))
    .gsub(/:brook:/, image_tag('stamps/ok.svg'))
    .gsub(/:brosinging:/, image_tag('stamps/singing.svg'))
    .gsub(/:brosmile:/, image_tag('stamps/smile.svg'))
    .gsub(/:brocry:/, image_tag('stamps/cry.svg'))
    .gsub(/:brocheers:/, image_tag('stamps/cheers.svg'))
  end

  # 結婚式
  def wedding_party
    I18n.t(:wedding_party)
  end

  # カウントダウン
  def countdown(date)
    (date - Date.current).to_i
  end
end
