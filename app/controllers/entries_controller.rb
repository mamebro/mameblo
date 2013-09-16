# -*- coding: utf-8 -*-
class EntriesController < ApplicationController
include Ikachan
  before_action :signed_in_brother, only: [:create, :destroy]
  before_action :correct_brother, only: [:destroy, :update]

  respond_to :html

  def show
    @entry = Entry.find(params[:id])
    @entry.content = @entry.content_as_markdown
    respond_with @entry
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    @entry = current_brother.entries.build entry_params
    if @entry.save
      flash[:success] = "!!! ぶろぐ投稿できたね !!!"
      ikachan_post "#{current_brother.name} が投稿したよ! #{request.url}/#{@entry.id.to_s}"
      redirect_to @entry.brother
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes entry_params
        format.html { redirect_to @entry.brother, notice: '!!! 編集完了したね !!!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "!!! 日記を消したぜブラザー !!!"
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:content, :title)
  end

  def correct_brother
    @entry = current_brother.entries.find_by_id(params[:id])
    redirect_to root_path if @entry.nil?
  end
end
