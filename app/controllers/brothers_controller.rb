class BrothersController < ApplicationController
include Ikachan
  before_action :signed_in_brother, only: [:index, :destroy, :following, :followers]
  before_action :load_brother,      only: [:show, :destroy, :following, :followers]
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

  def admin_brother
    redirect_to(root_path) unless current_brother.admin?
  end
end
