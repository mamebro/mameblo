class PasswordResetsController < ApplicationController
  def new
  end

  def create
    brother = Brother.find_by(email: params[:email])
    if brother
      brother.send_password_reset
      redirect_to root_url, notice: "!!! パスワード変更のためのメールを送信しました !!!"
    else
      redirect_to new_password_reset_url, notice: "!!! メールアドレスが登録されてません !!!"
    end
  end

  def edit
    @brother = Brother.find_by!(password_reset_token: params[:id])
  end

  def update
    @brother = Brother.find_by!(password_reset_token: params[:id])
    if @brother.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "!!! 有効期限切れです !!!"
    elsif @brother.update(brother_params)
      sign_out
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
