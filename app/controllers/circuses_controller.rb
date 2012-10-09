# -*- coding: utf-8 -*-
class CircusesController < ApplicationController
  def index
    participation = []
    circuses = Circus.find(:all)
    # circuses.each do |circus|
    #   participation << Brother.find_by_id(circus[:brother_id])
    # end
    # # 重複している要素は取り除き、参加ボタンを押したブラザーをArrayで返す
    # @participation = participation.uniq!
    @count = circuses.count # サーカス見たいボタンが押された数
  end

  def create
    circus = Circus.new(brother_id: current_brother.id, participation: true)
    circus.save
    flash[:notice] = "サーカス楽しみだね!!!"
    redirect_to root_path
  end
end
