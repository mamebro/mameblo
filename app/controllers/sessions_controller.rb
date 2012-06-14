# -*- coding: utf-8 -*-
class SessionsController < ApplicationController

  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "!!!!!!!! Welcome to the mameblog !!!!!!!!"
      redirect_to root_path
    else
      flash[:error] = "sorry! please try again!!!"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
