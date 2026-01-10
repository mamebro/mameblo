class SessionsController < ApplicationController
  def create
    unless verify_captcha
      flash[:error] = "CAPTCHA認証に失敗しました。もう一回お願いします!!!"
      render 'new'
      return
    end

    brother = Brother.find_by_name(params[:session][:name])
    if brother && brother.authenticate(params[:session][:password])
      sign_in brother
      flash[:success] = "!!!!!!!! ブラザーよ !!!!!!!!"
      redirect_back_or root_path
    else
      flash[:error] = "あちゃー、もう一回お願いします!!!"
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "!!!!!!!! またあおう !!!!!!!!"
    redirect_to root_path
  end

  private

  def verify_captcha
    CaptchaService.validate(params[:captcha_token])
  end
end
