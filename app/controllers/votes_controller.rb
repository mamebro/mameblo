class VotesController < ApplicationController
  include Ikachan
  before_action :signed_in_brother, only: [:index]

  def index
  end

  private
  def signed_in_brother
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "!!! サインインしてちょ !!!" unless signed_in?
    end
  end
end
