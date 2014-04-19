class PasswordResetsController < ApplicationController
  def new
  end

  def create
    brother = Brother.find_by_email(params[:email])
    brother.send_password_reset if brother
    redirect_to root_url, notice: "パスワード変更のためのメールを送信しました !!!"
  end
end
