class BrothersController < ApplicationController
include Ikachan
  before_action :signed_in_brother, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :load_brother,      only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_brother,   only: [:edit, :update]
  before_action :admin_brother,     only: :destroy

  respond_to :html, :json

  def index
    @brothers = Brother.order(:name).page params[:page]
    respond_with(@brothers, :only => [:id, :name, :created_at])
  end

  def show
    @entries = @brother.entries.page params[:page]
    @entries.each_with_index do |entry, index|
      @entries[index].content = entry.content_as_markdown
    end
  end

  def new
    @brother = Brother.new
  end

  def create
    @brother = Brother.new brother_params
    if @brother.save
      sign_in @brother
      ikachan_post "おめでとう! #{@brother.name} がブラザーになったよ。 #{@brother.name} は #{@brother.id} 番目の弟です。" if Rails.env.production?
      flash[:success] = "!!! まめぶろにようこそ !!!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    unless @brother.authenticate(params[:brother][:current_password])
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

  def deliver_alter_email
    unless current_brother.authenticate(params[:brother][:current_password])
      redirect_to edit_brother_path, notice: "!!! パスワードが間違ってます !!!"
    else
      alter_email = params[:brother][:alter_email]
      token = SecureRandom.urlsafe_base64
      current_brother.update_columns(alter_email: alter_email,
                                     alter_email_token: token)
      BrotherMailer.verify_alter_email(current_brother).deliver
      redirect_to edit_brother_path, notice: "!!! 変更後のメールアドレスに確認メールを送信しました !!!"
    end
  end

  def verify_email
    @brother = Brother.find_by!(alter_email_token: params[:id])
    current_brother.update_columns(email: @brother.alter_email,
                                   alter_email: nil,
                                   alter_email_token: nil)
    redirect_to edit_brother_path(current_brother), notice: "!!! メールアドレス変更しました !!!"
  end

  def cancel_alter_email
    current_brother.update_columns(alter_email: nil, alter_email_token: nil)
    redirect_to edit_brother_path, notice: "!!! メールアドレス変更キャンセルしました !!!"
  end

  def following
    @title = "ブラザー"
    @brothers = @brother.followed_brothers.order(:name).page params[:page]
    render 'show_follow'
  end

  def followers
    @title = "見守っているブラザー"
    @brothers = @brother.followers.order(:name).page params[:page]
    render 'show_follow'
  end

  private

  def brother_params
    params.require(:brother).permit(:name,
                                    :email,
                                    :password,
                                    :password_confirmation)
  end

  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "!!! サインインしてちょ !!!" unless signed_in?
    end
  end

  def load_brother
    @brother = Brother.find_by_name_or_id(params[:id])
  end

  def correct_brother
    @brother = Brother.find_by_name_or_id(params[:id])
    redirect_to(root_path) unless current_brother?(@brother)
  end

  def admin_brother
    redirect_to(root_path) unless current_brother.admin?
  end
end
