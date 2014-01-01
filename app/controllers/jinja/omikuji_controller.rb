class Jinja::OmikujiController < ApplicationController
  def index
    fortunes = ['大豆', '中豆', '小豆', '豆', '末豆']
    beans = ['大豆', '小豆', '空豆', '仙豆', 'ひよこ豆', 'コーヒー豆', 'いんげん豆']
    @bean = beans.sample
    @fortune = fortunes.sample
  end
end
