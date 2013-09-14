class VotesController < ApplicationController
  def index
  end

  def create
    redirect_to votes_path
  end
end
