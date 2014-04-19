class PasswordResetsController < ApplicationController
  def new
  end

  def create
    brother = Brother.find_by_email(params[:email])
    brother.send_password_reset if brother
    redirect_to root_url, notice: "パスワード変更のためのメールを送信しました !!!"
  end

  def edit
    @brother = Brother.find_by!(password_reset_token: params[:id])
  end

  def update
    @brother = Brother.find_by!(password_reset_token: params[:id])
    if @brother.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "!!! 有効期限切れです !!!"
    elsif @brother.update(brother_params)
      redirect_to root_url, notice: "!!! パスワード再設定できました !!!"
    else
      render :edit
    end
  end

  private

  def brother_params
    params.require(:brother).permit(:name,
                                    :email,
                                    :password,
                                    :password_confirmation)
  end
end
