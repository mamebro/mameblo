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
    content.gsub(/:bro_goodbye:/, image_tag('stamps/goodbye.svg'))
    .gsub(/:bro_jump:/, image_tag('stamps/jump.svg'))
    .gsub(/:bro_nobita:/, image_tag('stamps/nobita.svg'))
    .gsub(/:bro_serious:/, image_tag('stamps/serious.svg'))
    .gsub(/:bro_sisters:/, image_tag('stamps/sisters.svg'))
    .gsub(/:bro_sorry:/, image_tag('stamps/sorry.svg'))
    .gsub(/:bro_congratulations:/, image_tag('stamps/congratulations.svg'))
    .gsub(/:bro_eyes:/, image_tag('stamps/eyes.svg'))
    .gsub(/:bro_heart:/, image_tag('stamps/heart.svg'))
    .gsub(/:bro_lonely:/, image_tag('stamps/lonely.svg'))
    .gsub(/:bro_ok:/, image_tag('stamps/ok.svg'))
    .gsub(/:bro_singing:/, image_tag('stamps/singing.svg'))
    .gsub(/:bro_smile:/, image_tag('stamps/smile.svg'))
    .gsub(/:bro_cry:/, image_tag('stamps/cry.svg'))
    .gsub(/:bro_cheers:/, image_tag('stamps/cheers.svg'))
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
