class VotesController < ApplicationController
  include Ikachan
  before_action :signed_in_brother, only: [:index]

  def index
    votes = Vote.group(:brother_id).select(:brother_id).map {|vote| p vote.brother_id}
    @brothers = Brother.select(:id, :name).find(votes)
  end

  private
  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "!!! サインインしてちょ !!!" unless signed_in?
    end
  end
end
