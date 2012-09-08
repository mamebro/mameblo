# -*- coding: utf-8 -*-
module SessionsHelper

  def sign_in(brother)
    cookies.permanent[:remember_token] = brother.remember_token
    self.current_brother = brother
  end

  def signed_in?
    !current_brother.nil?
  end

  def current_brother=(brother)
    @current_brother = brother
  end

  def current_brother
    return unless cookies[:remember_token]
    @current_brother ||= Brother.find_by_remember_token(cookies[:remember_token])
  end

  def current_brother?(brother)
    brother == current_brother
  end

  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "サインインしてください、お願いします!"
    end
  end

  def sign_out
    current_brother = nil
    cookies.delete(:remember_token)
  end
 
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
