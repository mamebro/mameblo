class Jinja::OmikujiController < ApplicationController
  def index
    fortunes = ['大豆', '最高豆', '高豆', '大安豆日', '大豆吉日']
    beans = ['最高', '最強', 'やったー！', 'MAX', 'good', '良し', '大安']
    @bean = beans.sample
    @fortune = fortunes.sample
  end
end
