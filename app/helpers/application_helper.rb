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
  # もっと良い感じに書きたい
  def convert_bro(content)
    content.gsub!(/:bro_cheers:/, image_tag('stamps/cheers.svg'))
    content.gsub!(/:bro_cry:/, image_tag('stamps/cry.svg'))
    content.gsub!(/:bro_goodbye:/, image_tag('stamps/goodbye.svg'))
    content.gsub!(/:bro_jump:/, image_tag('stamps/jump.svg'))
    content.gsub!(/:bro_nobita:/, image_tag('stamps/nobita.svg'))
    content.gsub!(/:bro_serious:/, image_tag('stamps/serious.svg'))
    content.gsub!(/:bro_sisters:/, image_tag('stamps/sisters.svg'))
    content.gsub!(/:bro_sorry:/, image_tag('stamps/sorry.svg'))
    content.gsub!(/:bro_congratulations:/, image_tag('stamps/congratulations.svg'))
    content.gsub!(/:bro_eyes:/, image_tag('stamps/eyes.svg'))
    content.gsub!(/:bro_heart:/, image_tag('stamps/heart.svg'))
    content.gsub!(/:bro_lonely:/, image_tag('stamps/lonely.svg'))
    content.gsub!(/:bro_ok:/, image_tag('stamps/ok.svg'))
    content.gsub!(/:bro_singing:/, image_tag('stamps/singing.svg'))
    content.gsub!(/:bro_smile:/, image_tag('stamps/smile.svg'))
  end
end
