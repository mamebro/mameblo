class VotesController < ApplicationController
  before_action :signed_in_brother, only: [:index, :create]

  def index
    sleep 0.8
    @num = rand(12) + 1
    @voted = if Vote.exists?(brother_id: current_brother.id, tshirt_id: @num)
               true
             else
               false
             end
  end

  def create
    sleep 0.8
    if Vote.exists?(brother_id: current_brother.id, tshirt_id: params[:tshirt_id])
      redirect_to votes_path
    else
      Vote.create(brother_id: current_brother.id, tshirt_id: params[:tshirt_id], score: 1)
      redirect_to votes_path
    end
  end

  private
  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "!!! サインインしてちょ !!!" unless signed_in?
    end
  end
end
