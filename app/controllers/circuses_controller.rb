# -*- coding: utf-8 -*-
class CircusesController < ApplicationController
  def index
    # 最低一回はサーカス見たい!!ボタンを押したブラザーを表示する
    participation = []
    circuses = Circus.find(:all, select: 'brother_id')
    # サーカス見たい!!ボタンを押したブラザーをArrayに入れる
    circuses.each do |circus|
      participation << circus[:brother_id]
    end
    # 重複している要素を取り除いて、サーカス見たいブラザー達のArrayを作る
    @participate_brother = []
    participation.uniq.each do |id|
      @participate_brother << Brother.find(id)
    end
    @participate_brother
    @count = circuses.count # サーカス見たいボタンが押された数
  end

  def create
    circus = Circus.new(brother_id: current_brother.id, participation: true)
    circus.save
    flash[:notice] = "サーカス楽しみだね!!!"
    redirect_to root_path
  end
end
