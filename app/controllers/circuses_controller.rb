class CircusesController < ApplicationController
include Ikachan
  def index
    # 最低一回はサーカス見たい!!ボタンを押したブラザーを表示する
    participate_brother = []
    circuses = Circus.select(:brother_id).uniq
    circuses.each do |circus|
      participate_brother << circus.brother_id
    end
    @participate_brother = Brother.where(id: participate_brother)
  end

  def create
    circus = Circus.new(brother_id: current_brother.id, participation: true)
    circus.save
    Ikachan.notice 'サーカスみたい!' if Rails.env.production?
    flash[:notice] = "サーカス楽しみだね!!!"
    redirect_to root_path
  end
end
