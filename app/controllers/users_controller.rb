class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def create
    @user = User.new(params[:user])
    if @user.save
      response = { :result => "success" }
      respond_to do |format|
        format.json { render :json => response }
        sign_in @user
      end
    else
      response = { :result => "failure" }
      respond_to do |format|
        format.json { render :json => response }
      end
    end
  end

  private

  def signed_in_user
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
