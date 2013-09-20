class VotesController < ApplicationController
  include Ikachan
  before_action :signed_in_brother, only: [:index, :create]

  def index
    sleep 0.9
    @num = rand(12) + 1
    @voted = if Vote.exists?(brother_id: current_brother.id, tshirt_id: @num)
               true
             else
               false
             end

    vote_results = Vote.group(:tshirt_id).count
    tshirt_id    = vote_results.keys.map {|i| "tshirt No." + i.to_s}
    vote_scores  = vote_results.values

    @bar = LazyHighCharts::HighChart.new('column') do |f|
      f.title(text: '投票結果')
      f.series(name: '投票数', data: vote_scores)
      f.xAxis(categories: tshirt_id)
      f.options[:chart][:defaultSeriesType] = "column"
    end
  end

  def create
    sleep 0.8
    if Vote.exists?(brother_id: current_brother.id, tshirt_id: params[:tshirt_id])
      redirect_to votes_path
    else
      Vote.create(brother_id: current_brother.id, tshirt_id: params[:tshirt_id], score: 1)
      ikachan_post "誰かが #{params[:tshirt_id]} のTシャツに投票したよ!!!" if Rails.env.production?
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
