# -*- coding: utf-8 -*-
class SessionsController < ApplicationController

  def create
    user = User.find_by_name(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "!!!!!!!! ブラザーよ !!!!!!!!"
      redirect_back_or root_path
    else
      flash[:error] = "あちゃー、もう一回お願いします!!!"
      render'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
