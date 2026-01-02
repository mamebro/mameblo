class HashtagController < ApplicationController
  def show
    if hashtag = Hashtag.find_by(name: params[:id])
      @hashtag_name = hashtag.name
      @entries = hashtag.entries.page params[:page]
    else
      redirect_to root_url
    end
  end
end
