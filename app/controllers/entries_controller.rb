# -*- coding: utf-8 -*-
class EntriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: [:destroy, :update]

  def index
  end

  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def create
    @entry = current_user.entries.build(params[:entry])
    if @entry.save
      flash[:success] = "!!! ぶろぐ投稿できたね !!!"
      redirect_to @entry.user
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to root_path, notice: '!!! 編集完了したね !!!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry.destroy
    redirect_to root_path
  end

  private

  def correct_user
    @entry = current_user.entries.find_by_id(params[:id])
    redirect_to root_path if @entry.nil?
  end
end
