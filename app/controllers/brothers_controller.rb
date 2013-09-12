# -*- coding: utf-8 -*-
class BrothersController < ApplicationController
include Ikachan
  before_filter :signed_in_brother, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :load_brother,      only: [:show, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_brother,   only: [:edit, :update]
  before_filter :admin_brother,     only: :destroy

  respond_to :html, :json

  def index
    @brothers = Brother.page params[:page]
    respond_with(@brothers, :only => [:id, :name, :created_at])
  end

  def show
    @entries = @brother.entries.page params[:page]
    @entries.each_with_index do |entry, index|
      @entries[index].content = entry.content_as_markdown
    end
  end

  def new
    @brother = Brother.new
  end

  def create
    @brother = Brother.new brother_params
    if @brother.save
      sign_in @brother
      ikachan_post "おめでとう! #{@brother.name} がブラザーになったよ。 #{@brother.name} は #{@brother.id} 番目の弟です。"
      flash[:success] = "!!! まめぶろにようこそ !!!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @brother.destroy
    flash[:success] = "ユーザーを削除しました."
    redirect_to brothers_path
  end

  def edit
  end

  def update
    if @brother.update_attributes brother_params
      flash[:success] = "!!! プロフィール更新しました !!!"
      sign_in @brother
      redirect_to @brother
    else
      render 'edit'
    end
  end

  def following
    @title = "ブラザー"
    @brothers = @brother.followed_brothers.page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "見守っているブラザー"
    @brothers = @brother.followers.page params[:page]
    render 'show_follow'
  end

  private

  def brother_params
    params.require(:brother).permit(:name,
                                    :email,
                                    :password,
                                    :password_confirmation)
  end

  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "!!! サインインしてちょ !!!" unless signed_in?
    end
  end

  def load_brother
    @brother = Brother.find_by_name_or_id(params[:id])
  end

  def correct_brother
    @brother = Brother.find_by_name_or_id(params[:id])
    redirect_to(root_path) unless current_brother?(@brother)
  end

  def admin_brother
    redirect_to(root_path) unless current_brother.admin?
  end
end
