class BrothersController < ApplicationController
  before_action :signed_in_brother, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :load_brother,      only: [:show, :edit, :update, :destroy, :following, :followers, :rss]
  before_action :correct_brother,   only: [:edit, :update]
  before_action :admin_brother,     only: :destroy

  respond_to :html, :json

  def index
    @brothers = Brother.order(:name).page params[:page]
    respond_with(@brothers, :only => [:id, :name, :created_at])
  end

  def discover
    followed_brother_ids = Relationship.where(follower_id: current_brother.id).pluck(:followed_id)
    @brothers = Brother.where.not(id: followed_brother_ids).sample(6)
    respond_with(@brothers, :only => [:id, :name, :created_at])
  end

  def show
    @entries = @brother.entries.page params[:page]
    @beans = Bean.where(entry_id: @brother.entries)
  end

  def rss
    @entries = @brother.entries.page params[:page]
    respond_to do |format|
      format.rss
      format.atom
    end
  end

  def new
    @brother = Brother.new
  end

  def create
    unless verify_captcha
      flash.now[:error] = "CAPTCHA認証に失敗しました。もう一回お願いします!!!"
      @brother = Brother.new brother_params
      render 'new'
      return
    end

    @brother = Brother.new brother_params
    if @brother.save
      sign_in @brother
      flash[:success] = "!!! まめぶろにようこそ !!!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @brother.update brother_params
      flash[:success] = "!!! パスワード変更しました !!!"
      sign_in @brother
      redirect_to edit_brother_path
    else
      @entry  = current_brother.entries.build
      render 'edit'
    end
  end

  def following
    @title = "ブラザー"
    @brothers = @brother.followed_brothers.order(:name).page params[:page]
    @beans = Bean.where(entry_id: @brother.entries)
    render 'show_follow'
  end

  def followers
    @title = "見守っているブラザー"
    @brothers = @brother.followers.order(:name).page params[:page]
    @beans = Bean.where(entry_id: @brother.entries)
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
    if params[:id].present?
      @brother = Brother.find_by_name_or_id(params[:id])
    elsif params[:name].present?
      @brother = Brother.find_by(name: params[:name])
      redirect_to root_path if @brother.nil?
    else
    end
  end

  def correct_brother
    @brother = Brother.find_by_name_or_id(params[:id])
    redirect_to(root_path) unless current_brother?(@brother)
  end

  def admin_brother
    redirect_to(root_path) unless current_brother.admin?
  end

  def verify_captcha
    CaptchaService.validate(params[:captcha_token])
  end
end
