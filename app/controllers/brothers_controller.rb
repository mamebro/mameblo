# -*- coding: utf-8 -*-
class BrothersController < ApplicationController
  before_filter :signed_in_brother, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_brother,   only: [:edit, :update]
  before_filter :admin_brother,     only: :destroy

  respond_to :html, :json

  def index
    @brothers = Brother.page params[:page]
    respond_with(@brothers, :only => [:id, :name])
  end

  def show
    @brother = Brother.find(params[:id])
    @entries = @brother.entries.page params[:page]
  end

  def new
    @brother = Brother.new
  end

  def create
    @brother = Brother.new brother_params
    if @brother.save
      sign_in @brother
      flash[:success] = "!!! まめぶろにようこそ !!!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    Brother.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました."
    redirect_to brothers_path
  end

  def edit
    @brother = Brother.find(params[:id])
  end

  def update
    @brother = Brother.find(params[:id])
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
    @brother = Brother.find(params[:id])
    @brothers = @brother.followed_brothers.page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "見守っているブラザー"
    @brother = Brother.find(params[:id])
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

  def correct_brother
    @brother = Brother.find(params[:id])
    redirect_to(root_path) unless current_brother?(@brother)
  end

  def admin_brother
    redirect_to(root_path) unless current_brother.admin?
  end
end
