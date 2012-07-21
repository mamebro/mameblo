# -*- coding: utf-8 -*-
class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "!!!!!!!! Welcome to the mameblog !!!!!!!!"
      redirect_back_or user
    else
      flash[:error] = "sorry! please try again!!!"
      render'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
