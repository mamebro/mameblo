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
    content.gsub(/:brogoodbye:/, image_tag('stamps/goodbye.svg', class: 'stamp'))
    .gsub(/:brojump:/, image_tag('stamps/jump.svg', class: 'stamp'))
    .gsub(/:bronobita:/, image_tag('stamps/nobita.svg', class: 'stamp'))
    .gsub(/:broserious:/, image_tag('stamps/serious.svg', class: 'stamp'))
    .gsub(/:brosisters:/, image_tag('stamps/sisters.svg', class: 'stamp'))
    .gsub(/:brosorry:/, image_tag('stamps/sorry.svg', class: 'stamp'))
    .gsub(/:brocongratulations:/, image_tag('stamps/congratulations.svg', class: 'stamp'))
    .gsub(/:broeyes:/, image_tag('stamps/eyes.svg', class: 'stamp'))
    .gsub(/:broheart:/, image_tag('stamps/heart.svg', class: 'stamp'))
    .gsub(/:brolonely:/, image_tag('stamps/lonely.svg', class: 'stamp'))
    .gsub(/:brook:/, image_tag('stamps/ok.svg', class: 'stamp'))
    .gsub(/:brosinging:/, image_tag('stamps/singing.svg', class: 'stamp'))
    .gsub(/:brosmile:/, image_tag('stamps/smile.svg', class: 'stamp'))
    .gsub(/:brocry:/, image_tag('stamps/cry.svg', class: 'stamp'))
    .gsub(/:brocheers:/, image_tag('stamps/cheers.svg', class: 'stamp'))
    .gsub(/[#＃]([Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+)/, link_to('#\1', '/hashtag/\1'))
  end

  # まめぶろ広告
  def ad
    I18n.t(:ad)
  end

  # 結婚式
  def wedding_party
    I18n.t(:wedding_party)
  end

  # カウントダウン
  def countdown(date)
    (date - Date.current).to_i
  end

  # イニシャル
  def initial(name)
    name[0,1].upcase + '.'
  end
end
