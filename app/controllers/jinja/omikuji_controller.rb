class Jinja::OmikujiController < ApplicationController
  def index
    fortunes = ['大吉', '中吉', '小吉', '吉', '末吉']
    beans = ['大豆', '小豆', '空豆', '仙豆', 'ひよこ豆', 'コーヒー豆', 'いんげん豆']
    @bean = beans.sample
    @fortune = fortunes.sample
  end
end
