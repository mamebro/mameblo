class SettingsController < ApplicationController
  before_action :signed_in_brother

  def edit_password
  end

  def update_password
    unless @brother.authenticate(params[:brother][:present_password])
      return redirect_to edit_brother_path, notice: "!!! 現在のパスワードが間違ってます !!!"
    end

    if @brother.update(brother_params)
      flash[:success] = "!!! パスワード変更しました !!!"
      sign_in @brother
      redirect_to edit_brother_path
    else
      @entry  = current_brother.entries.build
      render 'edit'
    end
  end

  def email
    @brother = current_brother
  end

  def deliver_alter_email
    unless current_brother.authenticate(params[:brother][:current_password])
      redirect_to email_settings_path, notice: "!!! パスワードが間違ってます !!!"
    else
      alter_email = params[:brother][:alter_email]
      token = SecureRandom.urlsafe_base64
      current_brother.update_columns(alter_email: alter_email, alter_email_token: token)
      BrotherMailer.verify_alter_email(current_brother).deliver
      redirect_to email_settings_path, notice: "!!! 変更後のメールアドレスに確認メールを送信しました !!!"
    end
  end

  def verify_email
    @brother = Brother.find_by!(alter_email_token: params[:id])
    current_brother.update_columns(email: @brother.alter_email, alter_email: nil, alter_email_token: nil)
    redirect_to email_settings_path, notice: "!!! メールアドレス変更しました !!!"
  end

  def cancel_alter_email
    current_brother.update_columns(alter_email: nil, alter_email_token: nil)
    redirect_to email_settings_path, notice: "!!! メールアドレス変更キャンセルしました !!!"
  end

  private

  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "!!! サインインしてちょ !!!" unless signed_in?
    end
  end

end
